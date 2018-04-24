package buw;

import openfl.display.Sprite;

class TextCheckBox extends CheckBox {
	/**
	 * @param listener what to do when checkbox is clicked; defaults to null
	 * @param text the text associated to the checkbox
	 * @param checked the checkbox initial state; defaults to false (unchecked)
	 * @param circle true to draw a circle instead of a square (for radio buttons); defaults to false
	 */
	public function new(?listener : TextCheckBox -> Void, text : String, ?checked : Bool = false, ?circle : Bool = false) {
		var wh = new Label(" ").textField.height;
		var uncheckedSprite : Sprite = new Sprite();
		uncheckedSprite.graphics.beginFill(Widget.inputBackground);
		uncheckedSprite.graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		if (circle) {
			uncheckedSprite.graphics.drawCircle(wh / 2, wh / 2, (wh - Widget.borderWidth) / 2);
		} else {
			uncheckedSprite.graphics.drawRect(Widget.borderWidth, Widget.borderWidth, wh - Widget.borderWidth, wh - Widget.borderWidth);
		}
		uncheckedSprite.graphics.endFill();
		var checkedSprite : Sprite = new Sprite();
		checkedSprite.graphics.beginFill(Widget.inputBackground * 8);
		checkedSprite.graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		if (circle) {
			checkedSprite.graphics.drawCircle(wh / 2, wh / 2, (wh - Widget.borderWidth) / 2);
		} else {
			checkedSprite.graphics.drawRect(Widget.borderWidth, Widget.borderWidth, wh - Widget.borderWidth, wh - Widget.borderWidth);
		}
		checkedSprite.graphics.endFill();
		toggle = new Toggle(cast listener, checkedSprite, uncheckedSprite, checked);
		super(text, checked); //toggle must be set before
	}
}
