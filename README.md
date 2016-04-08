# Haxe/hxnodejs externs for the [consul](https://www.npmjs.com/package/consul) npm library

Tested using `consul` version **0.24.0**

Example:
```haxe
import js.npm.consul;

// Generate a v1 (time-based) id 
consul.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a' 
 
 // Generate a v4 (random) id 
consul.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1' 
```
