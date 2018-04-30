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
		
		main.pack(new TextButton(onClickCreateUser, "Créer un utilisateur", 1));
		main.pack(new TextButton(onClickGetUser, "Consulter les utilisateurs", 1));

		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClickCreateUser(w: Control) {
		new CreateUser();
	}
	
	function onClickGetUser(w: Control) {
		new GetUser();
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
