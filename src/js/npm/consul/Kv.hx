package js.npm.consul;
import haxe.extern.EitherType;
import haxe.Constraints;
import haxe.DynamicAccess;
import js.node.Buffer;
import js.node.events.EventEmitter;
import js.npm.Consul;

extern class Kv {
  /**
    Return key/value (kv) pair(s).

    Options

    key (String): path to value
    dc (String, optional): datacenter (defaults to local for agent)
    recurse (Boolean, default: false): return all keys with given key prefix
    index (String, optional): used with ModifyIndex to block and wait for changes
    wait (String, optional): limit how long to wait for changes (ex: 5m), used with index
    raw (Boolean, optional): return raw value (can't be used with recursive, implies buffer)
    buffer (Boolean, default: false): decode value into Buffer instead of String
   **/
  @:overload(function (opt:{ > ConsulCommonOptions, key:String, ?dc:String, ?wait:String, raw:Bool },
      callback:ConsulCallback<KvReturn<Buffer>>):Void {})
  @:overload(function (opt:{ > ConsulCommonOptions, key:String, ?dc:String, recurse:Bool, ?wait:String, buffer:Bool },
      callback:ConsulCallback<Array<KvReturn<Buffer>>>):Void {})
  @:overload(function (opt:{ > ConsulCommonOptions, key:String, ?dc:String, ?wait:String, buffer:Bool },
      callback:ConsulCallback<KvReturn<Buffer>>):Void {})
  @:overload(function (opt:{ > ConsulCommonOptions, key:String, ?dc:String, recurse:Bool, ?wait:String },
      callback:ConsulCallback<Array<KvReturn<String>>>):Void {})
  public function get(opt:{ > ConsulCommonOptions, key:String, ?dc:String, ?wait:String },
      callback:ConsulCallback<KvReturn<String>>):Void;

  /**
    Return keys for a given prefix.

    Options

    key (String): path prefix
    dc (String, optional): datacenter (defaults to local for agent)
    separator (String, optional): list keys up to a given separator
   **/
  public function keys(opt:{ > ConsulCommonOptions, key:String, ?dc:String, ?separator:String },
      callback:ConsulCallback<Array<String>>):Void;

  /**
    Set key/value (kv) pair.

    Options

    key (String): key
    value (String|Buffer): value
    dc (String, optional): datacenter (defaults to local for agent)
    flags (Number, optional): unsigned integer opaque to user, can be used by application
    cas (String, optional): use with ModifyIndex to do a check-and-set operation
    acquire (String, optional): session ID, lock acquisition operation
    release (String, optional): session ID, lock release operation
   **/
  public function set(opt:{ > ConsulCommonOptions, key:String, value:EitherType<String,Buffer>, ?dc:String,
    ?flags:Float, ?cas:String, ?acquire:String, ?release:String }, callback:ConsulCallback<Bool>):Void;

  /**
    Delete key/value (kv) pair(s).

    Options

    key (String): key
    dc (String, optional): datacenter (defaults to local for agent)
    recurse (Boolean, default: false): delete all keys with given key prefix
    cas (String, optional): use with ModifyIndex to do a check-and-set operation (must be greater than 0)
   **/
  public function del(opt:{ > ConsulCommonOptions, key:String, ?dc:String, ?recurse:Bool, ?cas:String },
      callback:VoidConsulCallback):Void;

  /**
    Experimental

    Lock a key using the method described in the leader election guide.

    Options

    key (String): lock key
    value (String|Buffer, optional): lock value
    session (Object|String, optional): session options
   **/
  public function lock(opt:{ > ConsulCommonOptions, key:String, ?value:EitherType<String,Buffer>, ?session:String }):IEventEmitter;
}

@:enum abstract LockEvent<T:Function>(Event<T>) to Event<T> {
  /**
    lock successfully acquired
   **/
  var Acquire : LockEvent<Void->Void> = "acquire";

  /**
    lock retry attempt
   **/
  var Retry : LockEvent<Void->Void> = "retry";

  /**
    lock gracefully released (not always emitted)
   **/
  var Release : LockEvent<Void->Void> = "release";

  /**
    lock ended (always emitted)
   **/
  var End : LockEvent<Void->Void> = "end ";

  /**
    lock related error
   **/
  var Error : LockEvent<js.Error->Void> = "error";
}

typedef KvReturn<T> = {
  CreateIndex: Int,
  ModifyIndex: Int,
  LockIndex: Int,
  Key: String,
  Flags: Int,
  Value: T
}
