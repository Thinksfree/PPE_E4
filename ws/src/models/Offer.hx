package models;
import sys.db.Types;
import sys.db.Object;
import api.*;

@:id(idOffer)
class Offer extends Object {
    public var idOffer : SString<36>;
    public var dte : SString<10>;
    public var day : STinyInt;
    public var isFrom : SBool;
    public var hour : SString<8>;
    public var city : SString<100>;
    public var km : SUInt;
    @:relation(idUser) public var user : User;

    public function new(?dte : String, ?day : Int, isFrom : Bool, hour : String, city : String, km : Int, user : User) {
        super();
        this.idOffer = UUID.genUUID();
        this.dte = dte;
        this.day = day;
        this.isFrom = isFrom;
        this.hour = hour;
        this.city = city;
        this.km = km;
        this.user = user;
    }
}
