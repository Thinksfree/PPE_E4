package controllers;
import controller.Request;
import haxe.web.Dispatch;
import haxe.Json;
import models.*;
import api.*;

class UserController {

    public static function dispatch(request : Request, id : String) {
        if(Connexion.auth(request) != null){
            if (id == "all" && request.method == "GET") {
                retrieveAll(request);
            } else {
                if (id == null) {
                    request.setReturnCode(406, "Not Acceptable\nmissing id");
                }  else {
                switch request.method {
                    case "GET" : retrieveOneUser(request, id);
                    case "POST" : postUser(request, id);
                    case "PUT" : putUser(request, id);
                    case "DELETE" : deleteUser(request, id);
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
        var usersInDB : List<GETUser> = cast User.manager.all();
        var first = true;
        request.send("[");
        for (user in usersInDB) {
            if (! first) {
                request.send(",");
            } else {
                first = false;
            }
            Reflect.deleteField(user, "_manager");
            Reflect.deleteField(user, "_lock");
            Reflect.deleteField(user, "__cache__");
            request.send(Json.stringify(user));
        }
        request.send("]");
    }

    static function retrieveOneUser(request : Request, id : String) {
        request.setHeader("Content-Type", "application/json");
        var u : GETUser;
        u = User.manager.get(id);
        if (u == null) {
            request.setReturnCode(404, "Not Found\nNo 'user/" + id + "'");
            return;
        }
        request.send("{\"idUser\":\"" + u.idUser + "\",\"lastname\":\"" + u.lastname + 
            "\",\"firstname\":\"" + u.firstname + "\",\"email\":\"" + u.email + "\",\"phone\":\"" + u.phone + 
            "\",\"login\":\"" + u.login + "\",\"password\":\"" + u.password + "\"}");
    }

    static function postUser(request : Request, id : String){
        if(Connexion.admin(request)){
            var user : User;
            var data : POSTUser = request.data;
            var idData = null;
            user = new User(idData, data.lastname, data.firstname, data.email, data.phone, data.login, data.password);
            user.insert();
            request.setHeader("Content-type","application/json");
            request.send("{\"id\":" + user.idUser+ "}"); 
        } else {
            request.setReturnCode(404, "Operation not permitted");
                return;
        }
    }

    static function putUser(request : Request, id : String) {
        request.setHeader("Content-Type", "application/json");
        var u : User = User.manager.get(id);
        if(Connexion.admin(request) || Connexion.himself(request, u)){
            if (u == null) {
                request.setReturnCode(404, "Not Found\nNo 'user/" + id + "'");
                return;
            }
            var data : PUTUser = request.data;
            u.firstname = data.firstname;
            u.lastname = data.lastname;
            u.email = data.email;
            u.phone = data.phone;
            u.login = data.login;
            u.password = data.password;
            u.update();
        } else {
            request.setReturnCode(404, "Operation not permitted");
                return;
        }
    }

    static function deleteUser(request : Request, id : String) {
        if(Connexion.admin(request)){
            var u : User = User.manager.get(id);
            if (u == null) {
                request.setReturnCode(404, "Not Found\nNo 'user/" + id + "'");
                return;
            }
            u.delete();
        } else {
            request.setReturnCode(404, "Operation not permitted");
                return; 
        }
    }
}
