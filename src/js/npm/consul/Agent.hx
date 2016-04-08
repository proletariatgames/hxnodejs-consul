package js.npm.consul;
import haxe.extern.EitherType;
import haxe.DynamicAccess;
import js.npm.Consul;

extern class Agent {
  public var check(default, never):AgentCheck;

  public var service(default, never):AgentService;
  /**
    Returns the members as seen by the consul agent.

    Options

    wan (Boolean, default: false): return WAN members instead of LAN members
   **/
  public function members(opt:{ > ConsulCommonOptions, ?wan:Bool }, callback:ConsulCallback<Array<AgentReturn>>):Void;

  /**
    Returns the agent node configuration.
   **/
  public function self(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<SelfAgentReturn>):Void;

  /**
    Set node maintenance mode.

    Options

    enable (Boolean): maintenance mode enabled
    reason (String, optional): human readable reason for maintenance
   **/
  public function maintenance(opt:{ > ConsulCommonOptions, enable:Bool, ?reason:String }, callback:VoidConsulCallback):Void;

  /**
    Trigger agent to join a node.

    Options

    address (String): node IP address to join
    wan (Boolean, default false): attempt to join using the WAN pool
   **/
  public function join(opt:{ > ConsulCommonOptions, address:String, ?wan:Bool }, callback:VoidConsulCallback):Void;
  /**
    Force remove node.

    Options

    node (String): node name to remove
   **/
  public function forceLeave(opt:{ > ConsulCommonOptions, node:String }, callback:VoidConsulCallback):Void;
}

extern class AgentCheck {
  /**
    Returns the checks the agent is managing.
   **/
  public function list(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<DynamicAccess<DynamicAccess<String>>>):Void;

  /**
    Registers a new check.

    Options

    name (String): check name
    id (String, optional): check ID
    serviceid (String, optional): service ID, associate check with existing service
    http (String): url to test, 2xx passes, 429 warns, and all others fail
    script (String): path to check script, requires interval
    dockercontainerid (String, optional): Docker container ID to run script
    shell (String, optional): shell in which to run script (currently only supported with Docker)
    interval (String): interval to run check, requires script (ex: 15s)
    ttl (String): time to live before check must be updated, instead of script and interval (ex: 60s)
    notes (String, optional): human readable description of check
    status (String, optional): initial service status
   **/
  public function register(opt:{ > ConsulCommonOptions, name:String, ?id:String, ?serviceid:String, http:String,
    script:String, ?dockercontainerid:String, ?shell:String, interval:String, ttl:String, ?notes:String, ?status:String
  }, callback:VoidConsulCallback):Void;

  /**
    Deregister a check.

    Options

    id (String): check ID
   **/
  public function deregister(opt:{ > ConsulCommonOptions, id:String }, callback:VoidConsulCallback):Void;

  /**
    Mark a test as passing.

    Options

    id (String): check ID
    note (String, optional): human readable message
   **/
  public function pass(opt:{ > ConsulCommonOptions, id:String, ?note:String }, callback:VoidConsulCallback):Void;

  /**
    Mark a test as warning.

    Options

    id (String): check ID
    note (String, optional): human readable message
   **/
  public function warn(opt:{ > ConsulCommonOptions, id:String, ?note:String }, callback:VoidConsulCallback):Void;

  /**
    Mark a test as critical.

    Options

    id (String): check ID
    note (String, optional): human readable message
   **/
  public function fail(opt:{ > ConsulCommonOptions, id:String, ?note:String }, callback:VoidConsulCallback):Void;
}

extern class AgentService {
  /**
    Returns the services the agent is managing.
   **/
  public function list(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<DynamicAccess<{ ID:String,
    Service:String, Tags:Array<String>, Port:Int }>>):Void;

  /**
    Registers a new service.

    Options

    - name (String): service name
    - id (String, optional): service ID
    - tags (String[], optional): service tags
    - address (String, optional): service IP address
    - port (Integer, optional): service port
    - check (Object, optional): service check
    | - http (String): URL endpoint, requires interval
    | - script (String): path to check script, requires interval
    | - interval (String): interval to run check, requires script (ex: 15s)
    | - ttl (String): time to live before check must be updated, instead of http/script and interval (ex: 60s)
    | - notes (String, optional): human readable description of check
    | - status (String, optional): initial service status
    - checks (Object[], optional): service checks (see check above)
   **/
  public function register(opt:{ > ConsulCommonOptions, name:String, ?id:String, ?tags:Array<String>, ?port:Int,
    ?check:DynamicAccess<{ http:String, script:String, interval:String, ttl:String, ?notes:String, ?status:String }>,
    checks:Array<Dynamic> }, callback:VoidConsulCallback):Void;

  /**
    Deregister a service.

    Options

    id (String): service ID
   **/
  public function deregister(opt:{ > ConsulCommonOptions, id:String }, callback:VoidConsulCallback):Void;

  /**
    Set service maintenance mode.

    Options

    id (String): service ID
    enable (Boolean): maintenance mode enabled
    reason (String, optional): human readable reason for maintenance
   **/
  public function maintenance(opt:{ > ConsulCommonOptions, id:String, enable:Bool, ?reason:String },
      callback:VoidConsulCallback):Void;
}

typedef SelfAgentReturn = {
 Config: {
  CheckUpdateInterval: Float,
  Version: String,
  NodeName: String,
  VersionPrerelease: String,
  VerifyIncoming: Bool,
  Ports: {
   SerfLan: Int,
   SerfWan: Int,
   DNS: Int,
   RPC: Int,
   Server: Int,
   HTTP: Int
  },
  Protocol: Int,
  AdvertiseAddr: String,
  DataDir: String,
  Domain: String,
  EnableSyslog: Bool,
  CAFile: String,
  KeyFile: String,
  SkipLeaveOnInt: Bool,
  DNSConfig: {
   NodeTTL: Int,
   ServiceTTL: Dynamic,
   MaxStale: Float,
   AllowStale: Bool
  },
  CertFile: String,
  ServerName: String,
  SyslogFacility: String,
  LeaveOnTerm: Bool,
  VerifyOutgoing: Bool,
  EnableDebug: Bool,
  BindAddr: String,
  RejoinAfterLeave: Bool,
  StatsiteAddr: String,
  Bootstrap: Bool,
  ClientAddr: String,
  StartJoin: Array<Dynamic>,
  Server: Bool,
  Revision: String,
  DNSRecursor: String,
  Datacenter: String,
  UiDir: String,
  LogLevel: String,
  PidFile: String
 },
 Member: AgentReturn
};

typedef AgentReturn = {
  Name:String,
  Addr:String,
  Port:Int,
  Tags:DynamicAccess<String>,
  Status:Int,
  ProtocolMin:Int,
  ProtocolMax:Int,
  ProtocolCur:Int,
  DelegateMin:Int,
  DelegateMax:Int,
  DelegateCur:Int
}
