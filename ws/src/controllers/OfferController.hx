package controllers;
import controller.Request;
import haxe.web.Dispatch;
import haxe.Json;
import models.*;
import api.*;

class OfferController {

    public static function dispatch(request : Request, id : String) {
        if(Connexion.auth(request) != null){
            if (id == "all" && request.method == "GET") {
                retrieveAll(request);
            } else {
                if (id == null) {
                    request.setReturnCode(406, "Not Acceptable\nmissing id");
                }  else {
                    switch request.method {
                        case "GET" : retrieveOneOffer(request, id);
                        case "POST" : postOffer(request, id);
                        case "DELETE" : deleteOffer(request, id);
                        default : request.setReturnCode(501, "Not implement");
                    }
                }
            }
        } else {
            request.setReturnCode(406, "Bad Connexion");
        }
    }
    
    public static function retrieveAll(request : Request) : Void {
        request.setHeader("Content-Type", "application/json");
        var offersInDB : List<GETOffer> = cast Offer.manager.all();
        var first = true;
        request.send("[");
        for (offer in offersInDB) {
            if (! first) {
                request.send(",");
            } else {
                first = false;
            }
            Reflect.deleteField(offer, "_manager");
            Reflect.deleteField(offer, "_lock");
            Reflect.deleteField(offer, "__cache__");
            request.send(Json.stringify(offer));
        }
        request.send("]");
    }

    static function retrieveOneOffer(request : Request, id : String) {
        request.setHeader("Content-Type", "application/json");
        var a : GETOffer; 
        a = cast Offer.manager.get(id);
        if (a == null) {
            request.setReturnCode(404, "Not Found\nNo 'offer/" + id+ "'");
            return;
        }
            request.send("{\"idOffer\":\"" + a.idOffer + "\",\"isFrom\":" + a.isFrom + ",\"city\":\"" + a.city + "\",\"hour\":\"" + a.hour + "\",\"day\":"+ a.day + ",\"dte\":\"" + a.dte + "\",\"km\":"+ a.km + ",\"idUser\":\"" + a.idUser + "\"}");
    }

    static function postOffer(request : Request, id : String) {
		var offer : Offer;
        var data : POSTOffer = request.data;
        var user : User = User.manager.get(data.idUser);
        if(Connexion.admin(request) || Connexion.himself(request, user)){
            offer = new Offer(data.dte, data.day, data.isFrom, data.hour, data.city, data.km, user);
            offer.insert();
            request.send("{\"id\":\"" + offer.idOffer + "\"}");
        } else {
            request.setReturnCode(404, "Not Found\nNo 'offer/" + data.idUser+ "'");
            return;
        }
    }

    static function deleteOffer(request : Request, id : String) {
        var offer : Offer = Offer.manager.get(id);
        if(Connexion.admin(request) || Connexion.himself(request, offer.user)){
            if (offer == null) {
                request.setReturnCode(404, "Not Found\nNo 'offer/" + id + "'");
                return;
            }
            offer.delete();
        } else {
            request.setReturnCode(404, "Operation not permitted");
                return;
        }
    }
}