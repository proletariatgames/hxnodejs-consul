package js.npm;
import haxe.Constraints;
import haxe.extern.EitherType;
import js.node.Buffer;
import js.node.http.IncomingMessage;
import js.node.events.EventEmitter;

@:jsRequire('consul')
extern class Consul {
  @:overload(function():Void {})
  public function new(opt:ConsulConfig):Void;

  public var acl(default, never):js.npm.consul.Acl;
  public var agent(default, never):js.npm.consul.Agent;
  public var catalog(default, never):js.npm.consul.Catalog;
  public var event(default, never):js.npm.consul.Event;
  public var health(default, never):js.npm.consul.Health;
  public var kv(default, never):js.npm.consul.Kv;
  public var session(default, never):js.npm.consul.Session;

  /**
    Watch an endpoint for changes.

    The watch relies on blocking queries, adding the index and wait parameters as per Consul's documentation

    If a blocking query is dropped due to a Consul crash or disconnect, watch will attempt to reinitiate the blocking
    query with logarithmic backoff.

    Upon reconnect, unlike the first call to watch() in which the latest x-consul-index is unknown, the last known
    x-consul-index will be reused, thus not emitting the change event unless it has been incremented since.

    Options

    method (Function): method to watch
    options (Object): method options
   **/
  public function watch(args:{ method:Function, options:Dynamic }):IEventEmitter;
}

@:enum abstract WatchEvent<T:Function>(Event<T>) to Event<T> {
  /**
    the value has changed
   **/
  var Change : WatchEvent<Dynamic->Void> = "change";

  var Error : WatchEvent<js.Error->Void> = "error";
}

typedef ConsulConfig = {
  /**
    (String, default: 127.0.0.1): agent address
   **/
  ?host:String,
  /**
    (String, default: 8500): agent HTTP(S) port
   **/
  ?port:Int,
  /**
    (Boolean, default: false): enable HTTPS
   **/
  ?secure:Bool,
  /**
    (String[], optional): array of strings or Buffers of trusted certificates in PEM format
   **/
  ?ca:Array<EitherType<String,Buffer>>,
  /**
    (Object, optional): default options for method calls
   **/
  ?defaults:Dynamic,
  /**
    (Boolean|Function, optional): convert callback methods to promises
   **/
  ?promisify:EitherType<Bool,Dynamic->Dynamic>,

}

typedef ConsulCallback<T> = Null<js.Error>->Null<T>->IncomingMessage->Void;

typedef VoidConsulCallback = Null<js.Error>->IncomingMessage->Void;

/**
  These options will be passed along with any method call, although only certain endpoints support them. See the HTTP
  API for more information.
 **/
typedef ConsulCommonOptions = {
  /**
    (String, optional): datacenter (defaults to local for agent)
   **/
  ?dc:String,
  /**
    (Boolean, default: false): return WAN members instead of LAN members
   **/
  ?wan:Bool,
  /**
    (Boolean, default: false): require strong consistency
   **/
  ?consistent:Bool,
  /**
    (Boolean, default: false): use whatever is available, can be arbitrarily stale
   **/
  ?stale:Bool,
  /**
    (String, optional): used with ModifyIndex to block and wait for changes
   **/
  ?index:String,
  /**
    (String, optional): limit how long to wait for changes (ex: 5m), used with index
   **/
  ?wait:String,
  /**
    (String, optional): ACL token
   **/
  ?token:String,

  // These work for all methos:

  /**
    (EventEmitter, optional): emit cancel to abort request
   **/
  ?ctx:IEventEmitter,
  /**
    (Number, optional): number of milliseconds before request is aborted
   **/
  ?timeout:Float,
}
