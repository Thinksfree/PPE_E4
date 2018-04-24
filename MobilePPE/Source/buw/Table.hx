package buw;

import openfl.events.MouseEvent;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;

/**
 * table (to display collections of items)
 * <table style="border:1px dashed; border-collapse:collapse">
 * <tr><th style="border:1px dashed">&nbsp;Col 1 title&nbsp;</th>
 * <th style="border:1px dashed">&nbsp;Col 2 title&nbsp;</th>
 * <th style="border:1px dashed">&nbsp;Col 3 title&nbsp;</th></tr>
 * <tr><td style="border:1px dashed">&nbsp;Item_1.field_1&nbsp;</td>
 * <td style="border:1px dashed">&nbsp;Item_1.field_2&nbsp;</td>
 * <td style="border:1px dashed">&nbsp;Item_1.field_3&nbsp;</td></tr>
 * <tr><td style="border:1px dashed">&nbsp;Item_2.field_1&nbsp;</td>
 * <td style="border:1px dashed">&nbsp;Item_2.field_2&nbsp;</td>
 * <td style="border:1px dashed">&nbsp;Item_2.field_3&nbsp;</td></tr>
 * </table>
 */
class Table<T> extends Widget {
	/**
	 * the Table data source (Array or List)
	 */
	public var source(null, set) : Iterable<T>;
	var columns : Array<TableColumn<T>>;
	var listener : T -> Void;
	var vbox : VBox;

	/**
	 * @param listener what to do with the clicked item; defaults to null
	 * @param relativeWidth the widget relative width; defaults to 1
	 * @param columns the columns relative widths, alignements, titles, item field names and renderers<br/>
	 * [new TableColumn(0.33, "Col 1 title", "field_1"), ...] for example
	 * @throws String if relativeWidth not in [0..1]
	 */
	public function new(?listener : T -> Void, ?relativeWidth : Float = 1, columns : Array<TableColumn<T>>) {
		super();
		if (relativeWidth >= 0 && relativeWidth <= 1) {
			this.relativeWidth = relativeWidth;
		} else {
			throw "invalid relativeWidth value: should be [0..1], given: " + Std.string(relativeWidth);
		}
		this.listener = listener;
		this.columns = columns;
		vbox = new VBox(1, 0);
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

	function set_source(source : Iterable<T>) : Iterable<T> {
		this.source = source;
		vbox.clear();
		var hbox = new HBox(1, cast columns);
		for (c in columns) {
			hbox.pack(new Title(c.title));
		}
		vbox.pack(hbox);
		if (source != null) {
			for (item in source) {
				displayItem(item);
			}
		}
		return this.source;
	}

	/**
	 * adds an item to the data source
	 * @param item the item to add / display
	 * @return the Table instance
	 * @throws String if source is not an Array nor a List (null for example)
	 */
	public function push(item : T) : Table<T> {
		IterableHelper.add(source, item);
		displayItem(item);
		return this;
	}

	function displayItem(item : T) {
		var hbox = new HBox(1, cast columns);
		for (c in columns) {
			if (c.renderer != null) {
				hbox.pack(c.renderer(item));
			} else {
				hbox.pack(new Label(Std.string(Reflect.field(item, c.fieldName))));
			}
		}
		hbox.addEventListener(MouseEvent.CLICK, function (e : MouseEvent) { onItemClick(hbox); });
		vbox.pack(hbox);
	}

	function onItemClick(w : Widget) {
		if (listener != null) {
			listener(IterableHelper.get(source, vbox.getChildIndex(w) - 1)); //-1 because of title line
		}
	}
}
