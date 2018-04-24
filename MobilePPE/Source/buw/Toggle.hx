package buw;

import openfl.events.MouseEvent;
import openfl.display.Sprite;

class Toggle extends Button {
	public var on(default, set): Bool;
	var offSprite : Sprite;
	var onSprite : Sprite;

	function new(listener : Control -> Void, onSprite : Sprite, offSprite : Sprite, ?on : Bool = false) {
		super(listener);
		this.onSprite = onSprite;
		this.offSprite = offSprite;
		addChild(onSprite);
		addChild(offSprite);
		this.on = on;
	}

	function set_on(on : Bool) : Bool {
		this.on = on;
		onSprite.visible = this.on;
		offSprite.visible = !this.on;
		return this.on;
	}

	override function onClick(e : MouseEvent) {
		this.on = !this.on;
		if (listener != null) {
			listener(cast this.parent.parent); //CheckBox->HBox->Toggle
		}
	}
}
