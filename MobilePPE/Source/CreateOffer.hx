package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;

class CreateOffer extends Sprite {
	var main : VBox;
	var dte : Input;
	var day : Input;
	var isFrom : Input; 
	var hour : Input;
	var city : Input; 
	var km : Input;
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Offre"));
		main.pack(new Separator());
		
		var g : Grid = new Grid([160, 160]);
		dte = new Input("", 20, 150);
		day = new Input("", 20, 150);
		isFrom = new Input("", 20, 150);
		hour = new Input("", 20, 150);
		city = new Input("", 20, 150);
		km = new Input("", 20, 150);

		g.pack(new Label("Date :"));
		g.pack(dte);
		g.pack(new Label("Jour :"));
		g.pack(day);
		g.pack(new Label("Lieu de depart :"));
		g.pack(isFrom);
		g.pack(new Label("Heure :"));
		g.pack(hour);
		g.pack(new Label("Ville :"));
		g.pack(city);
		g.pack(new Label("Nombre de km :"));
		g.pack(km);
		
		main.pack(g);
		
		main.pack(new TextButton(onClick, "Ajouter une offre", 320));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 320));
		
		Toolkit.init(main);
	}
	
	function onClick(w: Control) {
		var req = new Http("http://www.sio-savary.fr/covoit_bet/covoit_bet_ws/?offer/");
		var idUser : String = "5823f09f-045a-4745-b460-329af78e9273";
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify({dte : dte, day: Std.parseInt(day.value), isFrom: Std.parseInt(isFrom.value), hour: hour, city : city, km : Std.parseInt(km.value), idUser : idUser}));
        req.request(true);
		new Main();
	}
	
	function onClickAccueil(w: Control) {
		new Main();
	}
}
