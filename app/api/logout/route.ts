import {clearSession} from '../../../lib/auth';
export async function POST(request:Request){const origin=request.headers.get('origin');if(!origin||new URL(request.url).host!==new URL(origin).host)return new Response('Invalid origin',{status:403});await clearSession();return Response.redirect(new URL('/login',request.url),303)}
