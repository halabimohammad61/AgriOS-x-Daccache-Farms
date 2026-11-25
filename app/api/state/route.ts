import {getChatGPTUser} from '../../../lib/auth';
import {snapshot,previewSnapshot} from '../../../lib/server';
export const dynamic='force-dynamic';
export async function GET(){try{const user=await getChatGPTUser();const data=user?await snapshot(user.userId,user.displayName):previewSnapshot();return Response.json(data,{headers:{'Cache-Control':'private, no-store'}});}catch(e){console.error('State load failed',e);return Response.json({error:'Your workspace could not be loaded. Please retry.'},{status:503});}}
