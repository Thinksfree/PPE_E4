package buw;

class RadioBox extends Control {
	public var selected(default, set) : Int;
	var box : Box;

	function new(?listener : RadioBox -> Void, ?vertical : Bool = true) {
		super(cast listener);
		if (vertical) {
			box = new VBox(0, -1);
		} else {
			box = new HBox(1);
			relativeWidth = 1;
		}
		addChild(box);
	}

	public function add(cb : CheckBox) : RadioBox {
		box.pack(cb);
		cb.toggle.listener = cast selectChoice;
		if (cb.checked || box.widgetsList.length == 1) {
			selected = box.widgetsList.length - 1;
		}
		return this;
	}

	override function draw() {
		box.draw();
	}

	function set_selected(idx : Int) : Int {
		if (idx < box.widgetsList.length) {
			selected = idx;
			for (i in 0...box.widgetsList.length) {
				var radio = cast (box.widgetsList[i], CheckBox);
				if (i == selected) {
					radio.checked = true;
				} else {
					radio.checked = false;
				}
			}
		}
		if (listener != null) {
			listener(this);
		}
		return selected;
	}

	function selectChoice (w : CheckBox) {
		selected = box.getChildIndex(w);
	}
}
