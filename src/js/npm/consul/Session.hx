package js.npm.consul;
import haxe.extern.EitherType;
import haxe.Constraints;
import haxe.DynamicAccess;
import js.node.Buffer;
import js.node.events.EventEmitter;
import js.npm.Consul;

extern class Session {
  /**
    Create a new session.

    Options

    dc (String, optional): datacenter (defaults to local for agent)
    lockdelay (String, range: 1s-60s, default: 15s): the time consul prevents locks held by the session from being
    acquired after a session has been invalidated
    name (String, optional): human readable name for the session
    node (String, optional): node with which to associate session (defaults to connected agent)
    checks (String[], optional): checks to associate with session
    behavior (String, enum: release, delete; default: release): controls the behavior when a session is invalidated
    ttl (String, optional, valid: 10s-3600s): interval session must be renewed
   **/
  public function create(opt:{ > ConsulCommonOptions, ?dc:String, ?lockDelay:String, ?name:String, ?node:String,
    ?checks:Array<String>, ?behavior:SessionBehavior, ?ttl:String }, callback:ConsulCallback<{ ID:String }>):Void;

  /**
    Destroy a given session.

    Options

    id (String): session ID
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function destroy(opt:{ > ConsulCommonOptions, id:String, ?dc:String }, callback:VoidConsulCallback):Void;

  /**
    Queries a given session.

    Options

    id (String): session ID
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function get(opt:{ > ConsulCommonOptions, id:String, ?dc:String }, callback:ConsulCallback<SessionReturn>):Void;

  /**
    Lists sessions belonging to a node.

    Options

    node (String): node
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function node(opt:{ > ConsulCommonOptions, node:String, ?dc:String },
      callback:ConsulCallback<Array<SessionReturn>>):Void;

  /**
    Lists all the active sessions.

    Options

    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function list(opt:{ > ConsulCommonOptions, ?dc:String }, callback:ConsulCallback<Array<SessionBehavior>>):Void;

  /**
    Renew a given session.

    Options

    id (String): session ID
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function renew(opt:{ > ConsulCommonOptions, id:String, ?dc:String },
      callback:ConsulCallback<Array<SessionBehavior>>):Void;
}

@:enum abstract SessionBehavior(String) from String {
  var Release = 'release';
  var Delete = 'delete';
}

typedef SessionReturn = {
  ID: String,
  Name: String,
  CreateIndex: Int,
  Checks: Array<String>,
  LockDelay: Float,
  Node: String
}
