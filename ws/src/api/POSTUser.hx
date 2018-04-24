package api;

typedef POSTUser = {
    @:optional public var idUser : String;
    public var lastname : String;
    public var firstname : String;
    public var email : String;
    public var phone : String;
    public var login : String;    
    public var password : String;
}
