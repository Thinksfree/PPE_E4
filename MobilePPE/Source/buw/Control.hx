package buw;

class Control extends Widget {
	@:allow(buw.RadioBox)
	var listener : Control -> Void;

	function new(listener : Control -> Void) {
		super();
		this.listener = listener;
	}
}
