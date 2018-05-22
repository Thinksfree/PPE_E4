import sys.db.TableCreate;
import sys.db.Manager;
import haxe.unit.TestRunner;
import models.*;
import api.*;

class TestWs {

    public static var offer : Offer; 
    public static var user : User;
    public static var admin : User;
    public static var WSURI : String = "http://www.sio-savary.fr/btebbani/covoit_bet_ws/";

    public static function setup(){
        Manager.initialize();
        Manager.cnx = sys.db.Mysql.connect({
            host : "www.sio-savary.fr",
            port : 3306,
            user : "sqlbtebbani",
            pass : "savary",
            socket : null,
            database : "bdbtebbani1"
        });
        if(! TableCreate.exists(User.manager)){
            TableCreate.create(User.manager);
            TableCreate.create(Offer.manager);
        };

        user = new User(null,"DUPONT", "Thierry", "tdupont@gmx.com", "0101010101", "tdupont", "$2y$10$KnR4WJbNaXm2ixjjECuu9ObUmsg1klwpYyzrAsksVIC/8mGrnxbH.");
        user.insert();
        admin = new User(null,"admin", "admin", "admin@admin.admin", "0101010101", "admin", "admin");
        admin.insert();
        offer = new Offer(DateTools.format(Date.now(), "%Y-%m-%d").toString(),null,false,"08:00:00","Les Sables dOlonne",1, user);
        offer.insert();
    } 

    public static function tearDown(){
        user.delete();
        admin.delete();
        offer.delete();
        Manager.cleanup();
    }

    public static function main(){
        var runner = new TestRunner();
        setup();
        runner.add(new TestWsUser(WSURI));
        runner.add(new TestWsOffer(WSURI));
        runner.run();
        tearDown();
    }

}

