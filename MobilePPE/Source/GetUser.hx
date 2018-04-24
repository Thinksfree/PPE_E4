package;


import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;

typedef User = {
	var idUser : String;
	var lastname : String; 
	var firstname : String; 
	var email : String;
	var phone : String; 
	var login : String; 
	var password : String;
}

class GetUser extends Sprite {
	var main : VBox;
	var list : ListView<User>;
	
	public function new () {
		super ();
		main = new VBox();
		
		main.pack(new TextButton(onClick, "Afficher les utilisateurs", 320));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 320));
		
		Toolkit.init(main);
	}
	
	function onClick(w: Control) {
		var r = new Http("http://www.sio-savary.fr/covoit_bet/covoit_bet_ws/?user/all");
		r.onData=function(data: String){
			var users : Array<User>=Json.parse(data);
			list = new ListView(renderUser);
			list.source = users;
			main.pack(list);
		}
		r.request();
	}

	function renderUser(u : User) : Widget {
		return new Label(u.lastname + " " + u.firstname + " " + u.email + " " + u.phone + " " + u.login);
	}
	
	function onClickAccueil(w: Control) {
		new Main();
	}
}
