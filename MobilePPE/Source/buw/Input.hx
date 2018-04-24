package buw;

import openfl.text.TextFieldType;

class Input extends Text {
	var h : Float; //unneeded, see below (hack)
	public var value(get, set) : String;

	/**
	 * @param defaultValue default input value; defaults to ""
	 * @param maxLength the maximum number of chars
	 * @param relativeWidth the widget relative width; defaults to 1
	 * @throws String if relativeWidth not in [0..1]
	 */
	public function new(?defaultValue : String = "", maxLength : Int, ?relativeWidth : Float = 1) {
		super(defaultValue, Widget.controlsFontSize, Widget.controlsTextColor);
		if (relativeWidth >= 0 && relativeWidth <= 1) {
			this.relativeWidth = relativeWidth;
		} else {
			throw "invalid relativeWidth value: should be [0..1], given: " + Std.string(relativeWidth);
		}
		textField.type = TextFieldType.INPUT;
		textField.x = Widget.borderWidth + Widget.horizontalPadding;
		textField.y = Widget.borderWidth + Widget.verticalPadding;
		textField.maxChars = maxLength;
		h = this.height; //hack (OpenFL 7.1.2 bug): prevents changing height by the following instruction
		textField.autoSize = openfl.text.TextFieldAutoSize.NONE;
		mouseEnabled = true;
		draw();
	}

	override function draw() {
		graphics.clear();
		graphics.beginFill(Widget.inputBackground);
		graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		h = textField.textHeight + Widget.verticalPadding * 2;
		var w : Float;
		if (relativeWidth == 0) {
			w = fontSize * textField.maxChars * 3 / 4 + Widget.horizontalPadding * 2;
		} else {
			w = getWidth() - 2 * Widget.borderWidth;
		}
		graphics.drawRect(Widget.borderWidth, Widget.borderWidth, w, h);
		graphics.endFill();
		textField.width = w - 2 * (Widget.borderWidth + Widget.horizontalPadding);
	}

	function get_value() : String {
		return textField.text;
	}

	function set_value(text : String) : String {
		return textField.text = text;
	}
}
