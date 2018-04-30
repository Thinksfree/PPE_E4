package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;
import api.*;

class Main extends Sprite {
	var main : VBox;
	var log : Input;
	var pwd : Input;
	public static var user : GETUser;
	public static var ckString : String;
	public static var idUser : String;

	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Connexion"));
		main.pack(new Separator());
		
		var g: Grid = new Grid (1, [new HBoxColumn(0.35),new HBoxColumn(0.65)]);
		log = new Input("", 20, 0.20);
		pwd = new Input("", 20, 0.20);

		g.pack(new Label("Login :"));
		g.pack(log);
		g.pack(new Label("Password :"));
		g.pack(pwd);
	
		main.pack(g);
		
		main.pack(new TextButton(onClick, "Connexion", 1));
		
		Screen.display(main);
	}

	function onClick(w: Control) {
		var req = new Http("http://www.sio-savary.fr/covoit_bet/covoit_bet_ws/?/auth/");
		ckString = "login=" + log.value + "; password=" + pwd.value;
		req.addHeader("Cookie",ckString);
		req.onData = function (data : String) {
			user=Json.parse(data);
			idUser=user.idUser;
			if (user != null) {
				new Accueil();
			} else {
				new Main();
				var msgErr : Text = new Text("Login or password incorrect",16,1);
				main.pack(msgErr);
			}
		}
		req.request(false);
	}
}

