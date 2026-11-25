import {cookies} from 'next/headers';
import {createHmac,timingSafeEqual,scryptSync,randomBytes} from 'node:crypto';
const cookie='agrios-owner';
function secret(){const s=process.env.AGRIOS_SESSION_SECRET;if(!s||s.length<32)throw Error('Run npm run setup before starting.');return s}
function sign(value:string){return createHmac('sha256',secret()).update(value).digest('base64url')}
export async function getChatGPTUser(){const token=(await cookies()).get(cookie)?.value;if(!token)return null;const [exp,nonce,sig]=token.split('.');const body=exp+'.'+nonce;if(!sig||sig.length!==sign(body).length||!timingSafeEqual(Buffer.from(sig),Buffer.from(sign(body)))||Number(exp)<Date.now())return null;return {userId:'daccache-local-owner',displayName:'Daccache Farms owner',email:'',fullName:null}}
export function passwordMatches(password:string){const config=process.env.AGRIOS_PASSWORD_HASH;if(!config)throw Error('Run npm run setup first.');const [salt,hex]=config.split(':');const expected=Buffer.from(hex,'hex'),got=scryptSync(password,salt,64);return expected.length===got.length&&timingSafeEqual(expected,got)}
export async function setSession(){const body=String(Date.now()+12*60*60*1000)+'.'+randomBytes(16).toString('base64url');(await cookies()).set(cookie,body+'.'+sign(body),{httpOnly:true,sameSite:'strict',secure:process.env.AGRIOS_SECURE_COOKIE==='true',path:'/',maxAge:12*60*60})}
export async function clearSession(){(await cookies()).set(cookie,'',{path:'/',maxAge:0})}
