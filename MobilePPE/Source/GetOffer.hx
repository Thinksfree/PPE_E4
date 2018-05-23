package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;
import api.*;

class GetOffer extends Sprite {
	var main : VBox;
	var list : ListView<GETOffer>;

	public function new () {
		super ();
		main = new VBox();
		main.pack(new TextButton(onClick, "Afficher les offres", 1));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClick(w: Control) {
		var r = new Http("http://www.sio-savary.fr/btebbani/covoit_bet_ws/?offer/all");
		r.addHeader("Cookie",Main.ckString);
		r.onData=function(data: String){
			var offers : Array<GETOffer>=Json.parse(data);
			list = new ListView(renderOffer);
			list.source = offers;
			main.pack(list);
		}
		r.request();
	}

	function renderOffer(o : GETOffer) : Widget {
		return new Label(o.dte + " " + Std.string(o.day) + " " + Std.string(o.isFrom) + " " + o.hour + " " + o.city + " " + Std.string(o.km));
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
