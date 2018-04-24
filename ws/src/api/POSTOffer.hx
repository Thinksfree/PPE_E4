package api;

typedef POSTOffer = {
    @:optional public var dte : String;
    @:optional public var day : Int;
    public var isFrom : Bool; 
    public var hour : String; 
    public var city : String;
    public var km : Int;
    public var idUser : String;
}