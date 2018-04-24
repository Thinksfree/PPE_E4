import haxe.unit.TestCase;
import haxe.Http;
import haxe.Json;
import sys.db.Manager;
import haxe.io.BytesOutput;
import models.*;
import api.*;


class TestWsOffer extends TestCase {
    var wsuri : String;
    var collection : String;
    var loginTest : String = "admin";
    var passwordTest : String = "admin";

    public function new (wsuri : String){
        super();
        this.wsuri = wsuri;
    }

    function extractErrorCode(msg : String):Int{
        return(Std.parseInt(msg.substr(msg.indexOf("#")+1)));
    }

    function getStatus(msg : String) : Int {
        return Std.parseInt(msg.substr(msg.indexOf("#") + 1));
    }

    function test01BadURI(){
        var req = new Http(wsuri + "?/baduri");
        req.onData = function (data : String){
            assertFalse(true);
        }
        req.onError = function (msg : String){
            assertEquals(406, extractErrorCode(msg));
        }
        req.request(false /*GET*/);
    }

    function test02NoDefaultRoute(){
        var req = new Http(wsuri + "?/");
        req.onData = function (data : String){
            trace(data);
            assertFalse(true);
        }
        req.onError = function (msg : String){
            //trace(msg);
            assertEquals(406, extractErrorCode(msg));
        }
        req.request(false /*GET*/);
    }

    function test03RetrieveOffers(){
        var req = new Http(wsuri + "?/offer/all");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function(data : String){
            var retrieveOffers : Array<GETOffer> = Json.parse(data);
            var offersInDB : Array<Offer> = Lambda.array(Offer.manager.all());
            assertEquals(offersInDB.length, retrieveOffers.length);
            for(i in 0...retrieveOffers.length) {
                assertEquals(offersInDB[i].idOffer, retrieveOffers[i].idOffer);
                assertEquals(offersInDB[i].dte, retrieveOffers[i].dte);
                assertEquals(offersInDB[i].day, retrieveOffers[i].day);
                assertEquals(offersInDB[i].isFrom, retrieveOffers[i].isFrom);
                assertEquals(offersInDB[i].hour, retrieveOffers[i].hour);
                assertEquals(offersInDB[i].city, retrieveOffers[i].city);
                assertEquals(offersInDB[i].km, retrieveOffers[i].km);
            }
        }
        req.onError = function (msg : String){
            trace(msg);
            assertTrue(false);
        }
        req.request(false /*GET*/);
    }

    function test0303OGetOneOffer() {
        var offer : GETOffer = cast Offer.manager.all().first();
        var req = new Http(wsuri + "?/offer/" + offer.idOffer);
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function (data : String) {
            var retrieveOffers : GETOffer = cast Json.parse(data);
            var offerInDB = offer;
            assertEquals(offerInDB.idOffer, retrieveOffers.idOffer);
            assertEquals(offerInDB.isFrom, retrieveOffers.isFrom);
            assertEquals(offerInDB.city, retrieveOffers.city);
            assertEquals(offerInDB.hour, retrieveOffers.hour);
            assertEquals(offerInDB.day, retrieveOffers.day);
            assertEquals(offerInDB.dte, retrieveOffers.dte);
            assertEquals(offerInDB.km, retrieveOffers.km);
        }
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        }
        req.request(false);
    }

    /*function test05CreateOfferNoDate(){
        var idOffer = genUI
        var testOffer : POSTOffer = {typetrajet : 0, day : 2, isFrom :"Lycee SdM", hour : "08:00:00", city : "Les Sables", km : 10};
        var req = new Http(wsuri + "?/offer");
        req.onError = function (msg : String) {
            trace(msg);
            assertEquals(400, extractErrorCode(msg));
        }
        req.onData = function (data : String) {
            assertEquals(offerInDB.id, retrieveOffers.id);
            assertEquals(offerInDB.typeTrajet, retrieveOffers.typeTrajet);
            assertEquals(offerInDB.isFrom, retrieveOffers.isFrom);
            assertEquals(offerInDB.city, retrieveOffers.city);
            assertEquals(offerInDB.hour, retrieveOffers.hour);
            assertEquals(offerInDB.day, retrieveOffers.day);
            assertEquals(offerInDB.dte, retrieveOffers.dte);
            assertEquals(offerInDB.km, retrieveOffers.km);
            assertEquals(offerInDB.user.id, retrieveOffers.id_User);
            assertFalse(true);
        }
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify(testOffer));
        req.request(true); //POST
    }*/

    function test06CreateOffer() {
        var user = User.manager.all().first();
        var testOffer : POSTOffer = {"dte":DateTools.format(Date.now(), "%Y-%m-%d").toString(), "isFrom":false, "hour":"16:00:00", "city":"Les Sables", "km":10, "idUser": user.idUser};
        var req = new Http(wsuri + "?/offer/");
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onData = function (data : String) {
            var offer = Offer.manager.all().first();//get(data);
            assertEquals(testOffer.dte, offer.dte);
            assertEquals(testOffer.isFrom, offer.isFrom);
            assertEquals(testOffer.hour, offer.hour);
            assertEquals(testOffer.city, offer.city);
            assertEquals(testOffer.km, offer.km);
            //article.delete();
        }
        req.onError = function (msg : String) {
            trace(msg);
            assertTrue(false);
        } 
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify(testOffer));
        req.request(true); //POST
    }

    function test07DELETEOffer() {
        var offer : GETOffer = cast Offer.manager.all().last();
        var idOffer = offer.idOffer;
        var req = new Http(wsuri + "?/offer/" + idOffer);
        req.addHeader("Cookie","login="+loginTest+"; password="+passwordTest);
        req.onStatus = function (status : Int) {
            assertEquals(200, status);
            Manager.cleanup();
            var newOffer : GETOffer = cast Offer.manager.all().last();
            var idOfferAfter = newOffer.idOffer;
            if(idOffer != idOfferAfter){
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