package buw;

class SpinBox extends Control {
	public var value(default, set) : Int;
	var digits : Int;
	var display : Label;
	var fontSize : Int;
	var maxVal : Int;
	var minVal : Int;
	var minus : Button;
	var plus : Button;
	var step : Int;

	function new(listener : SpinBox -> Void, text : String, value : Int, minVal : Int, maxVal : Int, step : Int, digits : Int) {
		super(cast listener);
		this.maxVal = maxVal;
		this.minVal = minVal;
		this.step = step;
		this.digits = digits;

		var hbox : HBox = new HBox(0);
		hbox.pack(minus);

		display = new Label("");
		display.y = (minus.height - display.height) / 2;
		this.value = value; //must be set after display has been instanciated
		hbox.pack(display);

		hbox.pack(plus);
		if (text != null) {
			var label : Label = new Label(text);
			hbox.pack(label);
		}
		addChild(hbox);
	}

	function set_value(val : Int) : Int {
		if (val < minVal || val > maxVal) {
			val = Std.int((minVal + maxVal) / 2);
		}
		value = val;
		display.textField.text = formatVal();
		return value;
	}

	function decVal(w : Control) {
		if (value - step >= minVal) {
			value -= step;
			display.textField.text = formatVal();
			if (listener != null) {
				listener(w);
			}
		}
	}

	function formatVal() : String {
		var str: String;

		str = Std.string(value);
		while (str.length < digits) {
			str = "0" + str;
		}
		return str;
	}

	function incVal(w : Control) {
		if (value + step <= maxVal) {
			value += step;
			display.textField.text = formatVal();
			if (listener != null) {
				listener(w);
			}
		}
	}
}
