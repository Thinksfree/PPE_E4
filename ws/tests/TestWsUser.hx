import api.*;
import models.*;
import haxe.unit.TestCase;
import haxe.Http;
import haxe.Json;
import haxe.io.BytesOutput;
import sys.db.Manager;

class TestWsUser extends TestCase {
    var wsuri : String;
    public var loginTest : String = "admin";
    public var passwordTest : String = "admin";

    public function new(wsuri : String) {
        super();
        this.wsuri = wsuri;
    }

    function getStatus(msg : String) : Int {
        var code = Std.parseInt(msg.substr(msg.indexOf("#")+1));
        return code;
    }

    function test0101BadURI() {
        var req = new Http(wsuri + "?/baduri");

        req.onError = function(msg : String) {
            assertEquals(406, getStatus(msg));
        }

        req.onData = function(data : String) {
            assertFalse(true);
        }

        req.request(false); //GET
    }

    function test0102Root() {
        var req = new Http(wsuri + "?/");

        req.onError = function(msg : String) {
            assertEquals(406, getStatus(msg));
        }

        req.onData = function(data : String) {
            assertFalse(true);
        }

        req.request(false);
    }

    public function test02Auth(){
        var req = new Http(wsuri + "?/auth");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function(data : String){
            var retrieveUser : GETUser = Json.parse(data);
            assertEquals(retrieveUser.login, loginTest);
            assertEquals(retrieveUser.password, passwordTest);
        }
        req.onError = function(msg : String) {
            assertTrue(false);
        }
        req.request(false);
    }

    function test0201RetrieveUsers() {
        var req = new Http(wsuri + "?/user/all");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function(data : String) {
            var retrievedUsers : Array<GETUser> = Json.parse(data);
            var usersInDB : Array<User> = Lambda.array(User.manager.all());
            assertEquals(usersInDB.length, retrievedUsers.length);
            for(i in 0...retrievedUsers.length) {
                assertEquals(retrievedUsers[i].idUser,usersInDB[i].idUser);
                assertEquals(retrievedUsers[i].lastname,usersInDB[i].lastname);
                assertEquals(retrievedUsers[i].firstname,usersInDB[i].firstname);
                assertEquals(retrievedUsers[i].login,usersInDB[i].login);
            }
        }
        req.onError = function(msg : String) {
            trace(msg);
            assertTrue(false);
        }
        req.request(false);
    }

    function test0202GetUser() {
        var user = User.manager.all().first();
        var req = new Http(wsuri + "?/user/" + user.idUser);
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        }
        req.onData = function (data : String) {
            var retrievedUsers : GETUser = Json.parse(data);
            var usersInDB = user;
            assertEquals(retrievedUsers.lastname, usersInDB.lastname);
            assertEquals(retrievedUsers.firstname, usersInDB.firstname);
            assertEquals(retrievedUsers.email, usersInDB.email);
            assertEquals(retrievedUsers.phone, usersInDB.phone);
            assertEquals(retrievedUsers.login, usersInDB.login);
            assertEquals(retrievedUsers.password, usersInDB.password);
        }
        req.request(false);
    }

    function test0203GetUserNotfound() {
        var user = User.manager.all().last();
        var req = new Http(wsuri + "?/user/" + user.idUser + "notfound");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onError = function (msg : String) {
            assertEquals(404, getStatus(msg));
        }
        req.onData = function (data : String) {
            assertFalse(true);
        }
        req.request(false);
    }

    function test03CreateUser() {
        var testUser : POSTUser = {"lastname" : "test03", "firstname" : "test03", "email" : "test03@gmail.buw", "phone" :"0654878956", "login" : "test03", "password" : "test03"};
        var req = new Http(wsuri + "?/user/");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function (data : String) {
            var user = User.manager.all().first();
            assertEquals(testUser.lastname, user.lastname);
            assertEquals(testUser.firstname, user.firstname);
            assertEquals(testUser.email, user.email);
            assertEquals(testUser.phone, user.phone);
            assertEquals(testUser.login, user.login);
            assertEquals(testUser.password, user.password);
        }
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        } 
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify(testUser));
        req.request(true); //POST
    }

    function test04PUTUser() {
        var user = User.manager.all().last();
        var testUser : PUTUser = {"lastname" : "modifPUT", "firstname" : "modifPUT", "email" : "modifPUT@gmail.buw", "phone" :"0654878956", "login" : "modifPUT", "password" : "modifPUT"};
        var req = new Http(wsuri + "?/user/" + user.idUser);
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onStatus = function (status : Int) {
            assertEquals(200, status);
            Manager.cleanup();
            var user = User.manager.get(user.idUser);          
            assertEquals(testUser.lastname, user.lastname);
            assertEquals(testUser.firstname, user.firstname);
            assertEquals(testUser.email, user.email);
            assertEquals(testUser.phone, user.phone);
            assertEquals(testUser.login, user.login);
            assertEquals(testUser.password, user.password);
        }
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        } 
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify(testUser));
        req.customRequest(false, new BytesOutput(), "PUT");
    }

    function test05DELETEUser() {
        var user = User.manager.all().first();
        var idUser = user.idUser;
        var req = new Http(wsuri + "?/user/" + idUser);
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onStatus = function (status : Int) {
            assertEquals(200, status);
            Manager.cleanup();
            var user = User.manager.all().first();
            var idUserAfter = user.idUser;
            if(idUser != idUserAfter){
                assertTrue(true);
            } else {
                assertTrue(false);
            }
        }
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        } 
        req.customRequest(false, new BytesOutput(), "DELETE");
    }

}