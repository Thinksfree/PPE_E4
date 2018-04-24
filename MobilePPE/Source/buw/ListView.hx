package buw;

import openfl.events.MouseEvent;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

/**
 * list view (to display collections of items)
 * <table style="border:1px dashed; border-collapse:collapse">
 * <tr><td style="border:1px dashed">&nbsp;Item 1&nbsp;</td></tr>
 * <tr><td style="border:1px dashed">&nbsp;Item 2&nbsp;</td></tr>
 * <tr><td>&nbsp;Item 3&nbsp;</td></tr>
 * </table>
 */
class ListView<T> extends Widget {
	/**
	 * the ListView data source (Array or List)
	 */
	public var source(default, set) : Iterable<T>;
	var vbox : VBox;
	var renderer : T -> Widget;
	var listener : T -> Void;

	/**
	 * @param renderer how to display an item
	 * @param listener what to do with the clicked item; defaults to null
	 * @param relativeWidth the widget relative width; defaults to 1
	 * @param align the widgets alignement (-1=left, 0=centered, 1=right); defaults to 0
	 * @throws String if relativeWidth not in [0..1] or if align not in [-1, 0, 1]
	 */
	public function new(renderer : T -> Widget, ?listener : T -> Void, ?relativeWidth : Float = 1, ?align : Int = 0) {
		super();
		if (relativeWidth >= 0 && relativeWidth <= 1) {
			this.relativeWidth = relativeWidth;
		} else {
			throw "invalid relativeWidth value: should be [0..1], given: " + Std.string(relativeWidth);
		}
		if (align < -1 || align > 1) {
			throw "invalid align value: should be -1, 0 or 1, given: " + Std.string(align);
		}
		vbox = new VBox(1, align);
		this.renderer = renderer;
		this.listener = listener;
		vbox.addEventListener(MouseEvent.MOUSE_OVER, function(e : MouseEvent) {
			Mouse.cursor = MouseCursor.BUTTON;
		});
		vbox.addEventListener(MouseEvent.MOUSE_OUT, function(e : MouseEvent) {
			Mouse.cursor = MouseCursor.AUTO;
		});
		addChild(vbox);
	}

	override function draw() {
		vbox.draw();
	}

	/**
	 * adds an item to the data source
	 * @param item the item to add / display
	 * @return the ListView instance
	 * @throws String if source is not an Array nor a List (null for example)
	 */
	public function push(item : T) : ListView<T> {
		IterableHelper.add(source, item);
		displayItem(item);
		return this;
	}

	function set_source(source : Iterable<T>) : Iterable<T> {
		this.source = source;
		vbox.clear();
		if (source != null) {
			for (item in source) {
				displayItem(item);
			}
		}
		return this.source;
	}

	function displayItem(item : T) {
		var w : Widget = renderer(item);
		w.addEventListener(MouseEvent.CLICK, function (e : MouseEvent) { onItemClick(w); });
		vbox.pack(w);
	}

	function onItemClick(w : Widget) {
		if (listener != null) {
			listener(IterableHelper.get(source, vbox.getChildIndex(w)));
		}
	}
}
