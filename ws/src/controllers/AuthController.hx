package controllers;
import controller.Request;
import models.*;
import haxe.Json;

class AuthController {

    public static function dispatch(request : Request){
        if(request.method == "GET"){
            connection(request);
        } else {
            request.setReturnCode(406, "Not Acceptable\nmissing reference");
        }
    }

    public static function connection(request : Request){
        request.setHeader('Content-Type', 'application/json');
        var user : User = Connexion.auth(request);
        request.send(Json.stringify(user));
    }
}
