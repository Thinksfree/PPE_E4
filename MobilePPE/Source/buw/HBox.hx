package buw;

/**
 * horizontal box
 * <table style="border:1px dashed; border-collapse:collapse"><tr><td style="border:1px dashed">&nbsp;Widget 1&nbsp;</td><td>&nbsp;Widget 2&nbsp;</td></table>
 */
class HBox extends Box {
	var columns : Array<HBoxColumn>;

	/**
	 * @param relativeWidth the widget relative width; defaults to 1
	 * @param columns the columns relative widths and alignements; defaults to null<br/>[new HBoxColumn(0.3), new HBoxColumn(0.7)] for example
	 * @throws String if relativeWidth not in [0..1]
	 */
	public function new (?relativeWidth : Float = 1, ?columns : Array<HBoxColumn>) {
		this.columns = columns;
		super(relativeWidth);
	}

	/**
	 * adds a widget to display in the horizontal box
     * @param widget the widget to add / display
     * @return the box instance
     * @throws String if widget is null or if widgets count > columns count
	 */
	override public function pack(widget : Widget) : Box {
		if (columns == null || widgetsList.length != columns.length) {
			if (columns != null && widget.relativeWidth == 1) {
				widget.relativeWidth = columns[widgetsList.length].relativeWidth * relativeWidth * 0.975;
			}
			return super.pack(widget);
		} else {
			throw "not enough column to pack widget";
		}
	}

	override function placeWidgets() {
		if (columns != null) {
			var x : Float = 0;
			for (i in 0...widgetsList.length) {
				var widthForWidget : Float = getWidth() * columns[i].relativeWidth;
				if (columns[i].align == -1) {
					widgetsList[i].x = x;
				} else if (columns[i].align == 0) {
					widgetsList[i].x = x + (widthForWidget - widgetsList[i].getWidth()) / 2;
				} else { //columns[i].align == 1
					widgetsList[i].x = x + widthForWidget - widgetsList[i].getWidth() - Widget.horizontalPadding;
				}
				x += widthForWidget + Widget.horizontalPadding;
			}
		} else {
			var x : Float = 0;
			var widthPerWidget = 0.0;
			if (relativeWidth == 1) {
				widthPerWidget = getWidth() / widgetsList.length;
			}
			for (w in widgetsList) {
				if (widthPerWidget == 0) {
					w.x = x;
					x += w.getWidth() + Widget.horizontalPadding;
				} else {
					w.x = x + (widthPerWidget - w.getWidth()) / 2;
					x += widthPerWidget;
				}
			}
		}
		for (w in widgetsList) { //vertical middle
			w.y = (this.height - w.height) / 2;
		}
	}
}
