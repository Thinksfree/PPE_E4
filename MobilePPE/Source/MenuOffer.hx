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
		
		main.pack(new TextButton(onClickCreateOfferPonc, "Créer une offre ponctuelle", 1));
		main.pack(new TextButton(onClickCreateOfferPerm, "Créer une offre permanente", 1));
		main.pack(new TextButton(onClickGetOffer, "Consulter les offres", 1));
		
		main.pack(new Separator());
		main.pack(new TextButton(onClickAccueil, "Accueil", 1));
		
		Screen.display(main);
	}
	
	function onClickCreateOfferPonc(w: Control) {
		new CreateOfferPonc();
	}

	function onClickCreateOfferPerm(w: Control) {
		new CreateOfferPerm();
	}
	
	function onClickGetOffer(w: Control) {
		new GetOffer();
	}
	
	function onClickAccueil(w: Control) {
		new Accueil();
	}
}
