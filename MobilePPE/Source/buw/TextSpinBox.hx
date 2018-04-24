package buw;

import openfl.events.MouseEvent;

class TextSpinBox extends SpinBox {
	/**
	 * @param listener what to do when < / > are clicked; defaults to null
	 * @param text the text associated to the spin box
	 * @param value the initial value; defaults to 1
	 * @param minVal the minimum value; defaults to 1
	 * @param maxVal the maximum value; defaults to 99
	 * @param step the increase / decrease value; defaults to 1
	 * @param digits the number of digits to display; defaults to 2 (for 00..99)
	 */
	public function new(?listener : TextSpinBox -> Void, text : String, ?value : Int = 1, ?minVal : Int = 1,
			?maxVal : Int = 99, ?step : Int = 1, ?digits : Int = 2) {
		minus = new Button(decVal);
		drawGraphics(true, false);
		minus.addEventListener(MouseEvent.MOUSE_OVER, function(e : MouseEvent) { drawGraphics(true, true); });
		minus.addEventListener(MouseEvent.MOUSE_OUT, function(e : MouseEvent) { drawGraphics(true, false); });
		plus = new Button(incVal);
		drawGraphics(false, false);
		plus.addEventListener(MouseEvent.MOUSE_OVER, function(e : MouseEvent) { drawGraphics(false, true); });
		plus.addEventListener(MouseEvent.MOUSE_OUT, function(e : MouseEvent) { drawGraphics(false, false); });
		super(cast listener, text, value, minVal, maxVal, step, digits); //plus & minus must be set before
	}

	function drawGraphics(minusButton : Bool, over : Bool) {
		var wh = new Label(" ").textField.height;
		var color : Int;
		if (over) {
			color = Widget.controlsBackground2;
		} else {
			color = Widget.controlsBackground1;
		}
		if (minusButton) {
			minus.graphics.beginFill(color);
			minus.graphics.moveTo(0, wh / 2);
			minus.graphics.lineTo(wh, 0);
			minus.graphics.lineTo(wh, wh);
			minus.graphics.lineTo(0, wh / 2);
			minus.graphics.endFill();
		} else {
			plus.graphics.beginFill(color);
			plus.graphics.moveTo(wh, wh / 2);
			plus.graphics.lineTo(0, wh);
			plus.graphics.lineTo(0, 0);
			plus.graphics.lineTo(wh, wh / 2);
			plus.graphics.endFill();
		}
	}
}
