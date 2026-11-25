import {Pool,types} from 'pg';
// Stored amounts are bounded integers; convert pg BIGINT/NUMERIC values for shared domain calculations.
types.setTypeParser(20,v=>{const n=Number(v);if(!Number.isSafeInteger(n))throw Error('Amount exceeds safe integer precision');return n});
types.setTypeParser(1700,v=>Number(v));
const globalDb=globalThis as typeof globalThis & {agriosPool?:Pool};
export function pool(){if(!process.env.DATABASE_URL)throw Error('DATABASE_URL is not configured. Run npm run setup.');return globalDb.agriosPool??=new Pool({connectionString:process.env.DATABASE_URL,max:8})}
export function translateSQL(sql:string){let n=0;let text=sql.replace(/INSERT OR IGNORE INTO/gi,'INSERT INTO').replace(/CAST\(([^;]*?) AS INTEGER\)/gi,'CAST($1 AS BIGINT)');text=text.replace(/\?/g,()=>'$'+(++n));if(/INSERT OR IGNORE INTO/i.test(sql)&&!text.includes('ON CONFLICT'))text+=' ON CONFLICT DO NOTHING';return text}
class Query {constructor(public sql:string,public values:any[]=[]){ }bind(...values:any[]){return new Query(this.sql,values)}async first<T=Record<string,any>>():Promise<T|null>{return (await pool().query(translateSQL(this.sql),this.values)).rows[0]??null}}
export const database={prepare:(sql:string)=>new Query(sql),batch:async(queries:Query[])=>{for(let attempt=0;attempt<4;attempt++){const client=await pool().connect();try{await client.query('BEGIN ISOLATION LEVEL SERIALIZABLE');const results=[];for(const q of queries){const r=await client.query(translateSQL(q.sql),q.values);results.push({results:r.rows,meta:{changes:r.rowCount??0}})}await client.query('COMMIT');return results}catch(e:any){await client.query('ROLLBACK');if(e.code==='40001'&&attempt<3)continue;throw e}finally{client.release()}}throw Error('Concurrent change could not be applied. Retry.')}};
