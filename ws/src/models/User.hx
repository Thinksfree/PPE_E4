package models;
import sys.db.Types;
import sys.db.Object;
import api.*;

@:id(idUser)
class User extends Object {
    public var idUser : SString<36>;
    public var lastname : SString<40>;
    public var firstname : SString<40>;
    public var email : SString<100>;
    public var phone : SString<10>;
    public var login : SString<40>;
    public var password : SString<64>;

    public function new(?idUser : String = null, lastname : String, firstname : String, email : String, phone : String, login : String, password : String) {
        super();
        this.lastname = lastname;
        this.firstname = firstname;
        this.email = email;
        this.phone = phone;
        this.login = login;
        this.password = password;
        if(idUser == null){
            this.idUser = UUID.genUUID();
        } else {
            this.idUser = idUser;
        }
    }
}


