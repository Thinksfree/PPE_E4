package;


import openfl.display.Sprite;
import buw.*;

class MenuOffer extends Sprite {
	var main : VBox;
	
	public function new () {
		super ();
		main = new VBox();
		main.pack(new Title("Menu des offres"));
		main.pack(new Separator());
		
		main.pack(new TextButton(onClickCreateOffer, "Créer une offre", 320));
		main.pack(new TextButton(onClickGetOffer, "Consulter les offres", 320));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 320));
		
		Toolkit.init(main);
	}
	
	function onClickCreateOffer(w: Control) {
		new CreateOffer();
	}
	
	function onClickGetOffer(w: Control) {
		new GetOffer();
	}
	
	function onClickAccueil(w: Control) {
		new Main();
	}
}
