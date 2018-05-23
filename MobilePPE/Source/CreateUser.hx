package;

import openfl.display.Sprite;
import buw.*;
import haxe.Http;
import haxe.Json;
import haxe.crypto.Sha256;

class CreateUser extends Sprite {
	var main : VBox;
	var lastname : Input;
	var firstname : Input;
	var email : Input;
	var phone : Input;
	var password : Input;

	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Utilisateur"));
		main.pack(new Separator());
		
		var g: Grid = new Grid (1, [new HBoxColumn(0.35),new HBoxColumn(0.65)]);
		lastname = new Input("", 20, 1);
		firstname = new Input("", 20, 1);
		email = new Input("", 20, 1);
		phone = new Input("", 20, 1);
		password = new Input("", 20, 1);
		
		g.pack(new Label("Prénom :"));
		g.pack(firstname);
		g.pack(new Label("Nom :"));
		g.pack(lastname);
		g.pack(new Label("E-mail :"));
		g.pack(email);
		g.pack(new Label("Téléphone :"));
		g.pack(phone);
		g.pack(new Label("Mot de passe :"));
		g.pack(password);
		
		main.pack(g);
		
		main.pack(new TextButton(onClick, "Ajouter un utilisateur", 1));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClick(w: Control) {
		var req = new Http("http://www.sio-savary.fr/btebbani/covoit_bet_ws/?user/");
		req.addHeader("Cookie",Main.ckString);

        //generation login
		var login : String = "";
		var valpren : String = firstname.value;
		var firstn : String = valpren.charAt(0);
		login = login + firstn;
		login = login + lastname.value;

		var password : String = Sha256.encode(password.value);
		
        req.setHeader("Content-Type", "application/json");
        req.setPostData(Json.stringify({lastname : lastname.value, firstname: firstname.value, email : email.value, phone : phone.value,login : login,password : password}));
        req.request(true);
		new Accueil();
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
