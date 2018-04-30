package;

import openfl.display.Sprite;
import buw.*;

class Accueil extends Sprite {
	var main : VBox;
	//static var idUser : String = "";
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Menu"));
		main.pack(new Separator());
		
		main.pack(new TextButton(onClickOffer, "Offres", 1));
		main.pack(new TextButton(onClickUser, "Utilisateurs", 1));
		main.pack(new TextButton(onClickLogout, "Deconnexion", 1));
		
		Screen.display(main);
	}
	
	function onClickOffer(w: Control) {
		new MenuOffer();
	}
	
	function onClickUser(w: Control) {
		new MenuUser();
	}

	function onClickLogout(w: Control) {
		new Main();
	}

	/*public static function getIdUser() : String{
		return idUser;
	}*/

}
