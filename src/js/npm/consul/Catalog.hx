package js.npm.consul;
import haxe.extern.EitherType;
import haxe.DynamicAccess;
import js.npm.Consul;

extern class Catalog {
  public var node(default, never):CatalogNode;
  public var service(default, never):CatalogService;

  /**
    Lists known datacenters.
   **/
  public function datacenters(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<Array<String>>):Void;
}

extern class CatalogNode {
  /**
    Lists nodes in a given datacenter.

    Options

    dc (String, optional): datacenter (defaults to local for agent)
   **/
  public function list(opt:{ > ConsulCommonOptions, ?dc:String }, callback:ConsulCallback<Array<{ Node:String,
    Address:String }>>):Void;

  /**
    Lists the services provided by a node.

    Options

    node (String): node ID
   **/
  public function services(opt:{ > ConsulCommonOptions, node:String }, callback:ConsulCallback<{
   Node: {
    Address: String,
    Node: String
   },
   Services: DynamicAccess<{
     Service: String,
     ID: String,
     Port: Int,
     Tags: Array<String>
    }>
  }>):Void;
}

extern class CatalogService {
  /**
    Lists the nodes in a given service.

    Options

    service (String): service name
    dc (String, optional): datacenter (defaults to local for agent)
    tag (String, optional): filter by tag
   **/
  public function list(opt:{ > ConsulCommonOptions, service:String, ?dc:String, ?tag:String }, callback:ConsulCallback<Array<{
     ServiceID: String,
     Address: String,
     ServiceName: String,
     ServicePort: Int,
     ServiceTags: Array<String>,
     Node: String
    }>
  >):Void;

  public function nodes(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<{}>):Void;
}
