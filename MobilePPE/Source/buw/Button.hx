package buw;

import openfl.events.MouseEvent;

class Button extends Control {
	function new(listener : Button -> Void) {
		super(cast listener);
		addEventListener(MouseEvent.CLICK, onClick);
	}

	function onClick(e : MouseEvent) {
		if (listener != null) {
			listener(this);
		}
	}
}
