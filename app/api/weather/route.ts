import {FARM_PROFILE as farm} from '../../../lib/farm-profile';
export const dynamic='force-dynamic';
export async function GET(){
 const location=`${farm.address} · office reference, not a growing-plot observation`;
 const url=new URL('https://api.open-meteo.com/v1/forecast');url.search=new URLSearchParams({latitude:String(farm.latitude),longitude:String(farm.longitude),current:'temperature_2m,relative_humidity_2m,wind_speed_10m',daily:'temperature_2m_max,temperature_2m_min,precipitation_probability_max',timezone:farm.timezone,forecast_days:'7'}).toString();
 try{const r=await fetch(url,{signal:AbortSignal.timeout(5000)});if(!r.ok)throw Error('Provider unavailable');const data:any=await r.json();if(!data.current||!data.daily?.time)throw Error('Incomplete forecast');return Response.json({...data,live:true,source:'Open-Meteo forecast model',location,fetched:new Date().toISOString()},{headers:{'Cache-Control':'private, max-age=600'}})}catch{return Response.json({live:false,source:'Illustrative fallback · provider unavailable',location,fetched:new Date().toISOString(),current:{temperature_2m:22,relative_humidity_2m:64,wind_speed_10m:8},daily:{time:Array.from({length:7},(_,i)=>new Date(Date.now()+i*86400000).toISOString().slice(0,10)),temperature_2m_max:[22,23,21,20,22,24,23],temperature_2m_min:[13,14,12,12,13,14,14],precipitation_probability_max:[10,5,30,45,20,5,10]}})}
}
