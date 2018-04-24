package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;

typedef Offer = {
	var idOffer : String;
	var dte : String; 
	var day : Int;
	var isFrom : Bool; 
	var hour : String;
	var city : String; 
	var km : Int;
}

class GetOffer extends Sprite {
	var main : VBox;
	var list : ListView<Offer>;

	public function new () {
		super ();
		main = new VBox();
		main.pack(new TextButton(onClick, "Afficher les offres", 320));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 320));
		
		Toolkit.init(main);
	}
	
	function onClick(w: Control) {
		var r = new Http("http://www.sio-savary.fr/covoit_bet/covoit_bet_ws/?offer/all");
		r.onData=function(data: String){
			var offers : Array<Offer>=Json.parse(data);
			list = new ListView(renderOffer);
			list.source = offers;
			main.pack(list);
		}
		r.request();
	}

	function renderOffer(o : Offer) : Widget {
		return new Label(o.dte + " " + Std.string(o.day) + " " + Std.string(o.isFrom) + " " + o.hour + " " + o.city + " " + Std.string(o.km));
	}
	
	function onClickAccueil(w: Control) {
		new Main();
	}
}
