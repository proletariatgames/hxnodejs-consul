package js.npm.consul;
import haxe.extern.EitherType;
import haxe.DynamicAccess;
import js.node.Buffer;
import js.npm.Consul;

extern class Health {
  /**
    Returns the health info of a node.

    Options

    node (String): node
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function node(opt:{ > ConsulCommonOptions, node:String, ?dc:String },
      callback:ConsulCallback<Array<HealthCheck>>):Void;

  /**
    Returns the checks of a service.

    Options

    service (String): service name
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function checks(opt:{ > ConsulCommonOptions, service:String, ?dc:String },
      callback:ConsulCallback<HealthCheck>):Void;

  /**
    Returns the nodes and health info of a service.

    Options

    service (String): service name
    dc (String, optional): datacenter (defaults to local for agent)
    tag (String, optional): filter by tag
    passing (Boolean, optional): restrict to passing checks
   **/
  public function service(opt:{ > ConsulCommonOptions, service:String, ?dc:String, ?tag:String, ?passing:Bool}, callback:ConsulCallback<
      Array<{
        Service: {
          Service: String,
          ID: String,
          Port: Int,
          Tags: Array<Dynamic>
        },
        Checks: Array<HealthCheck>,
        Node: {
          Address: String,
          Node: String
        }
      }>
  >):Void;

  /**
    Returns the checks in a given state.

    Options

    state (String, enum: any, passing, warning, critical): state
    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function state(opt:{ > ConsulCommonOptions, state:HealthState, ?dc:String },
      callback:ConsulCallback<Array<HealthCheck>>):Void;
}

typedef HealthCheck = {
  Output: String,
  ServiceID: String,
  CheckID: String,
  ServiceName: String,
  Notes: String,
  Name: String,
  Node: String,
  Status: String
}

@:enum abstract HealthState(String) from String {
  var Any = 'any';
  var Passing = 'passing';
  var Warning = 'warning';
  var Critical = 'critical';
}
