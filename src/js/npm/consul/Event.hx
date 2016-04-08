package js.npm.consul;
import haxe.extern.EitherType;
import haxe.DynamicAccess;
import js.node.Buffer;
import js.npm.Consul;

extern class Event {
  /**
    Fires a new user event.

    Options

    name (String): event name
    payload (String|Buffer): payload
    node (String, optional): regular expression to filter by node
    service (String, optional): regular expression to filter by service
    tag (String, optional): regular expression to filter by tag
   **/
  public function fire(opt:{ > ConsulCommonOptions, name:String, ?payload:EitherType<String,Buffer>, ?node:String,
    ?service:String, ?tag:String }, callback:ConsulCallback<EventReturn>):Void;

  /**
    Lists the most recent events an agent has seen.

    Options

    name (String, optional): filter by event name
   **/
  public function list(opt:{ > ConsulCommonOptions, ?name:String }, callback:ConsulCallback<Array<EventReturn>>):Void;
}

typedef EventReturn = {
   ID: String,
   Name: String,
   Payload: String,
   NodeFilter: String,
   ServiceFilter: String,
   TagFilter: String,
   Version: Int,
   LTime: Int,
};
