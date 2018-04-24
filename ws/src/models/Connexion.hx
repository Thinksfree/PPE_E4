package models;
import controller.Request;
import models.*;
import haxe.ds.StringMap;

class Connexion {
    public static function auth(request : Request){
        var cookies : StringMap<String> = request.cookies;
        var login = cookies.get("login");
        var password = cookies.get("password");
        var users : Array<User> = cast Lambda.array(User.manager.all());
        for(u in users){
            if( u.login == login && u.password == password){
                return u;
            }
        }
        return null;
    }

    public static function admin(request : Request): Bool {
        var u : User = auth(request);
        if( u != null && u.login == "admin"){
            return true;
        } else {
            return false;
        } 
    }

    public static function himself(request : Request, user : User): Bool {
        var u : User = auth(request);
        if( u != null && u.idUser == user.idUser){
            return true;
        } else {
            return false;
        } 
    }
}
