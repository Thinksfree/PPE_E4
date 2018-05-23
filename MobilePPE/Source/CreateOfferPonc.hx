package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;

class CreateOfferPonc extends Sprite {
	var main : VBox;
	var dte : Input;
	var isFrom : RadioBox; 
	var hour : Input;
	var city : Input; 
	var km : Input;
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Offre"));
		main.pack(new Separator());
		
		var g: Grid = new Grid (1, [new HBoxColumn(0.35),new HBoxColumn(0.65)]);
		dte = new Input("", 20, 0.20);
		isFrom = new RadioBox(false).add(new TextRadioButton("Domicile")).add(new TextRadioButton("Lycée"));
		hour = new Input("", 20, 0.20);
		city = new Input("", 20, 0.20);
		km = new Input("", 20, 0.20);

		g.pack(new Label("Date (aaaa/mm/jj) :"));
		g.pack(dte);
		g.pack(new Label("Heure (hh:mm:ss) :"));
		g.pack(hour);
		g.pack(new Label("Ville :"));
		g.pack(city);
		g.pack(new Label("Lieu de depart :"));
		g.pack(isFrom);
		g.pack(new Label("Nombre de km :"));
		g.pack(km);
		
		main.pack(g);
		
		main.pack(new TextButton(onClick, "Ajouter une offre", 1));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClick(w: Control) {
		var req = new Http("http://www.sio-savary.fr/btebbani/covoit_bet_ws/?offer/");
		req.addHeader("Cookie",Main.ckString);
		var day=null;
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify({dte : dte.value, day: day, isFrom: isFrom.selected, hour: hour.value, city : city.value, km : Std.parseInt(km.value), idUser : Main.idUser}));
        req.request(true);
		new Accueil();
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
