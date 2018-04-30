package;


import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;
import api.*;

class GetUser extends Sprite {
	var main : VBox;
	var list : ListView<GETUser>;
	
	public function new () {
		super ();
		main = new VBox();
		
		main.pack(new TextButton(onClick, "Afficher les utilisateurs", 1));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClick(w: Control) {
		var r = new Http("http://www.sio-savary.fr/covoit_bet/covoit_bet_ws/?/user/all");
		r.addHeader("Cookie",Main.ckString);
		r.onData=function(data: String){
			var users : Array<GETUser>=Json.parse(data);
			list = new ListView(renderUser);
			list.source = users;
			main.pack(list);
		}
		r.request();
	}

	function renderUser(u : GETUser) : Widget {
		return new Label(u.lastname + " " + u.firstname + " " + u.email + " " + u.phone + " " + u.login);
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
