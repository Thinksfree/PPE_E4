package buw;

import openfl.events.MouseEvent;

class TextButton extends Button {
	public var text(get, set) : String;
	var label : Label;
	var h : Float;
	var w : Float;

	/**
	 *  @param listener what to do when the button is clicked
	 *  @param text the text of the button
	 *  @param relativeWidth the widget relative width; defaults to 1
	 */
	public function new(listener : TextButton -> Void, text : String, ?relativeWidth : Float = 1) {
		super(cast listener);
		this.relativeWidth = relativeWidth;
		label = new Label("");
		h = label.textField.height + Widget.verticalPadding * 2;
		label.y = Widget.verticalPadding;
		this.text = text;
		label.mouseEnabled = true;
		label.textField.selectable = false;
		addChild(label);
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
	}

	override function draw() {
		if (relativeWidth == 0) {
			w = label.textField.width + Widget.horizontalPadding * 2;
		} else {
			w = getWidth() - 2 * Widget.borderWidth;
		}
		graphics.clear();
		graphics.beginFill(Widget.controlsBackground1);
		graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		graphics.drawRect(Widget.borderWidth, Widget.borderWidth, w, h);
		graphics.endFill();
		label.x = (w - label.getWidth()) / 2;
	}

	function get_text() : String {
		return label.textField.text;
	}

	function set_text(text : String) : String {
		label.textField.text = text;
		draw();
		return this.label.textField.text;
	}

	function onMouseOut(event : MouseEvent) {
		graphics.beginFill(Widget.controlsBackground1);
		graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		graphics.drawRect(Widget.borderWidth, Widget.borderWidth, w, h);
		graphics.endFill();
	}

	function onMouseOver(event : MouseEvent) {
		graphics.beginFill(Widget.controlsBackground2);
		graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		graphics.drawRect(Widget.borderWidth, Widget.borderWidth, w, h);
		graphics.endFill();
	}
}
