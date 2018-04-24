import controller.Listener;
import controller.Request;
import sys.db.TableCreate;
import sys.db.Manager;
import php.db.PDO;
import haxe.web.Dispatch;
import models.*;
import controllers.*;

class Index {
    
    var request : Request;

    function new(r:Request){
        request = r;
    }

    function doOffer(?id : String = null){
        OfferController.dispatch(request, id);
    }

    function doUser(?id : String = null){
        UserController.dispatch(request, id);
    }

    function doAuth(){
        AuthController.dispatch(request);
    }

    public static function main(){
        Listener.boot();
    } 

    public static function dispatch(request : Request){ //point d'entrée de traitement d'une requete
        try {
            Manager.initialize();
            Manager.cnx = PDO.open("mysql:host=localhost;dbname=covoit_bet", "sqlbtebbani", "savary");
            if(! TableCreate.exists(Offer.manager)){
                TableCreate.create(Offer.manager);
            };

            if(! TableCreate.exists(User.manager)){
                TableCreate.create(User.manager);
            };

        } catch( unknown : Dynamic ) {
            request.setReturnCode(503, "Database error\n" + Std.string(unknown));
            return;
        }
        
        try {
            Dispatch.run(request.query, null, new Index(request));
        } catch( e : DispatchError ) {
            request.setReturnCode(406, "Not Acceptable\nNo route for " + request.query);
        } catch( unknown : Dynamic ) {
            request.setReturnCode(500, Std.string(unknown));
        }

        Manager.cleanup();
    }
}