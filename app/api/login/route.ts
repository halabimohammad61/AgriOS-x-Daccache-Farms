import {passwordMatches,setSession} from '../../../lib/auth';
import {pool} from '../../../lib/database';
export async function POST(request:Request){
 const origin=request.headers.get('origin');if(!origin||new URL(request.url).host!==new URL(origin).host)return Response.json({error:'Invalid origin.'},{status:403});
 if(Number(request.headers.get('content-length')||0)>2000)return Response.json({error:'Request too large.'},{status:413});
 const c=await pool().connect();try{const raw=await request.text();if(raw.length>2000)return Response.json({error:'Request too large.'},{status:413});const password=new URLSearchParams(raw).get('password')||'';
 await c.query('BEGIN');await c.query('SELECT pg_advisory_xact_lock(8060342)');const hits=await c.query("SELECT count(*)::int AS n FROM login_attempts WHERE attempted_at>now()-interval '15 minutes'");if(hits.rows[0].n>=10){await c.query('ROLLBACK');return Response.json({error:'Too many attempts. Wait 15 minutes.'},{status:429})}await c.query('INSERT INTO login_attempts DEFAULT VALUES');await c.query("DELETE FROM login_attempts WHERE attempted_at<now()-interval '1 day'");await c.query('COMMIT');
 if(!passwordMatches(password))return Response.redirect(new URL('/login?error=1',request.url),303);await setSession();return Response.redirect(new URL('/',request.url),303);
 }catch(e){await c.query('ROLLBACK');console.error('Local sign-in failed',e);return Response.json({error:'Sign-in unavailable. Check setup and database.'},{status:503})}finally{c.release()}
}
