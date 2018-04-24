package buw;

/**
 * grid box (for widgets vertical alignement)
 * <table style="border:1px dashed; border-collapse:collapse">
 * <tr><td style="border:1px dashed">&nbsp;Widget 1&nbsp;</td><td style="border:1px dashed">&nbsp;Widget 2&nbsp;</td><td>&nbsp;Widget 3&nbsp;</td></tr>
 * <tr><td style="border:1px dashed">&nbsp;Widget 4&nbsp;</td><td>&nbsp;Widget 5&nbsp;</td><td style="border:1px dashed">&nbsp;Widget 6&nbsp;</td></tr>
 * </table>
 */
class Grid extends VBox {
	var widgetsCount : Int;
	var columns : Array<HBoxColumn>;

	/**
	 * @param relativeWidth the widget relative width; defaults to 1
	 * @param columns the columns relative widths and alignements; defaults to null<br/>[new HBoxColumn(0.2, -1), new HBoxColumn(0.4, -1), ...] for example
	 * @throws String if relativeWidth not in [0..1]
     */
	public function new(?relativeWidth : Float = 1, columns : Array<HBoxColumn>) {
		widgetsCount = 0;
		super(relativeWidth, -1);
		this.columns = columns;
	}

	/**
	 * adds a widget to display in the grid
     * @param widget, the widget to add / display
     * @return the box instance
     * @throws String if widget is null
     */
	override public function pack(widget : Widget) : Box {
		var hbox : HBox;
		if (widgetsCount % columns.length == 0) {
			hbox = new HBox(relativeWidth, cast columns);
		} else {
			hbox = cast (widgetsList.pop(), HBox);
		}
		widgetsCount++;
		hbox.pack(widget);
		return super.pack(hbox);
	}

	override function clear() : Box {
		widgetsCount = 0;
		return super.clear();
	}
}
