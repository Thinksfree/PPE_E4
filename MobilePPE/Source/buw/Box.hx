package buw;

import openfl.Lib;

class Box extends Widget {
	@:allow(buw.RadioBox)
	var widgetsList : Array<Widget>;

	function new(? relativeWidth : Float = 1) {
		super();
		if (relativeWidth >= 0 && relativeWidth <= 1) {
			this.relativeWidth = relativeWidth;
		} else {
			throw "invalid relativeWidth value: should be [0..1], given: " + Std.string(relativeWidth);
		}
		widgetsList = new Array();
	}

	/**
	 * removes all widget from the box
     * @return the box instance
     */
	public function clear() : Box {
		removeChildren();
		widgetsList = new Array();
		return this;
	}

	override function draw() {
		for (w in widgetsList) {
			w.draw();
		}
		placeWidgets();
	}

	/**
	 * adds a widget to display in the box
     * @param widget the widget to add / display
     * @return the Box instance
     * @throws String if widget is null
     */
	public function pack(widget : Widget) : Box {
		if (widget == null) {
			throw "'widget' parameter should not be null";
		}
		widgetsList.push(widget);
		addChild(widget);
		widget.draw();
		placeWidgets();
		return this;
	}

	function placeWidgets() {}
}
