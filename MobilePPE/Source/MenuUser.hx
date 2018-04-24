package;


import openfl.display.Sprite;
import buw.*;


class MenuUser extends Sprite {
	var main : VBox;
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Menu des utilisateurs"));
		main.pack(new Separator());
		
		main.pack(new TextButton(onClickCreateUser, "Créer un utilisateur", 320));
		main.pack(new TextButton(onClickGetUser, "Consulter les utilisateurs", 320));

		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 320));
		
		Toolkit.init(main);
	}
	
	function onClickCreateUser(w: Control) {
		new CreateUser();
	}
	
	function onClickGetUser(w: Control) {
		new GetUser();
	}
	
	function onClickAccueil(w: Control) {
		new Main();
	}
}
