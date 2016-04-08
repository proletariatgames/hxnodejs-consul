package js.npm.consul;
import haxe.extern.EitherType;
import js.npm.Consul;

extern class Acl {
  /**
    Creates a new token with policy.

    Options

    name (String, optional): human readable name for the token
    type (String, enum: client, management; default: client): type of token
    rules (String, optional): string encoded HCL or JSON
   **/
  public function create(opt:{ > ConsulCommonOptions, ?name:String, ?type:TokenType, ?rules:EitherType<String,{}> },
      callback:ConsulCallback<{ ID:String }>):Void;

  /**
    Update the policy of a token.

    Options

    id (String): token ID
    name (String, optional): human readable name for the token
    type (String, enum: client, management; default: client): type of token
    rules (String, optional): string encoded HCL or JSON
   **/
  public function update(opt:{ > ConsulCommonOptions, id:String, ?name:String, ?type:TokenType,
    ?rules:EitherType<String,{}> }, callback:VoidConsulCallback):Void;

  /**
    Destroys a given token.

    Options

    id (String): token ID
   **/
  public function destroy(opt:{ > ConsulCommonOptions, id:String }, callback:VoidConsulCallback):Void;

  /**
    Queries the policy of a given token.

    Options

    id (String): token ID
   **/
  public function get(opt:{ > ConsulCommonOptions, id:String }, callback:ConsulCallback<{
    CreateIndex:Int,
    ModifyIndex:Int,
    ID:String,
    Name:String,
    Type:TokenType,
    Rules:String
  }>):Void;

  /**
    Creates a new token by cloning an existing token.

    Options

    id (String): token ID
   **/
  public function clone(opt:{ > ConsulCommonOptions, id:String }, callback:ConsulCallback<{ ID:String }>):Void;

  /**
    Lists all the active tokens.
   **/
  public function list(opt:{ > ConsulCommonOptions, }, callback:ConsulCallback<
    Array<{
      CreateIndex:Int,
      ModifyIndex:Int,
      ID:String,
      Name:String,
      Type:TokenType,
      Rules:String
    }>
  >):Void;
}

@:enum abstract TokenType(String) from String {
  var Client = "client";
  var Management = "management";
}
