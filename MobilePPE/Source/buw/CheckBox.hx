package buw;

class CheckBox extends Widget {
	public var checked(get, set): Bool;
	var hbox : HBox;
	@:allow(buw.RadioBox)
	var toggle : Toggle;

	function new(text : String, ?checked : Bool = false) {
		super();
		this.checked = checked;
		hbox = new HBox(0);
		hbox.pack(toggle);
		var label : Label = new Label(text);
		hbox.pack(label);
		addChild(hbox);
	}

	function get_checked() : Bool {
		return toggle.on;
	}

	function set_checked(checked : Bool): Bool {
		return toggle.on = checked;
	}
}
