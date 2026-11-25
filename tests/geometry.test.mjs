import test from 'node:test';import assert from 'node:assert/strict';import {validateGeometry} from '../lib/geometry.mjs';
const polygon={type:'Polygon',coordinates:[[[35.7,34.1],[35.701,34.1],[35.701,34.101],[35.7,34.1]]]};
test('accepts closed Lebanon polygon',()=>assert.deepEqual(validateGeometry(polygon),polygon));
test('rejects unclosed ring and non-finite or outside coordinates',()=>{assert.throws(()=>validateGeometry({...polygon,coordinates:[polygon.coordinates[0].slice(0,3)]}));assert.throws(()=>validateGeometry({type:'Polygon',coordinates:[[[0,0],[1,0],[1,1],[0,0]]]}));assert.throws(()=>validateGeometry({type:'Polygon',coordinates:[[[35.7,NaN],[35.7,34],[35.8,34],[35.7,NaN]]]}))});
test('rejects feature wrapper and wrong geometry',()=>{assert.throws(()=>validateGeometry({type:'Feature',geometry:polygon}));assert.throws(()=>validateGeometry({type:'Point',coordinates:[35.7,34.1]}))});
