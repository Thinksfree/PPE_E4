package api;

typedef GETOffer = {
    public var idOffer : String;
    @:optional public var dte : String; //Date
    @:optional public var day : Int;
    public var isFrom : Bool; 
    public var hour : String; 
    public var city : String;
    public var km : Int;
    public var idUser : String; 
}