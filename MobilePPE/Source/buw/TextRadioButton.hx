package buw;

class TextRadioButton extends TextCheckBox {
	public function new(text : String, ?checked : Bool = false) {
		super(null, text, checked, true);
	}
}
