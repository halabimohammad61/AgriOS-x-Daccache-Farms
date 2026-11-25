import {randomBytes,scryptSync} from 'node:crypto';
import {existsSync,writeFileSync} from 'node:fs';
if(existsSync('.env.local')||existsSync('.env')){console.log('Configuration already exists; no secrets changed.');process.exit(0)}
const password=randomBytes(18).toString('base64url'),salt=randomBytes(16).toString('hex'),dbPassword=randomBytes(24).toString('hex');
const hash=scryptSync(password,salt,64).toString('hex');
writeFileSync('.env.local',`DATABASE_URL=postgresql://agrios:${dbPassword}@127.0.0.1:5432/agrios\nAGRIOS_PASSWORD_HASH=${salt}:${hash}\nAGRIOS_SESSION_SECRET=${randomBytes(32).toString('hex')}\nAGRIOS_SECURE_COOKIE=false\n`,{mode:0o600});
writeFileSync('.env',`POSTGRES_PASSWORD=${dbPassword}\n`,{mode:0o600});
console.log('Daccache Farms local configuration created. Keep these files private.');
console.log('Your local owner password (save it in your password manager): '+password);
console.log('Next: npm run db:up, then npm run db:migrate, then npm run dev.');
