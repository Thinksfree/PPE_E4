package;


import openfl.display.Sprite;
import buw.*;

class Main extends Sprite {
	var main : VBox;
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Menu"));
		main.pack(new Separator());
		
		main.pack(new TextButton(onClickOffer, "Offres", 320));
		main.pack(new TextButton(onClickUser, "Utilisateurs", 320));
		
		Toolkit.init(main);
	}
	
	function onClickOffer(w: Control) {
		new MenuOffer();
	}
	
	function onClickUser(w: Control) {
		new MenuUser();
	}
}
