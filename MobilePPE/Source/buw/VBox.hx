package buw;

/**
 * vertical box
 * <table style="border:1px dashed; border-collapse:collapse">
 * <tr><td style="border:1px dashed">&nbsp;Widget 1&nbsp;</td></tr><tr><td>&nbsp;Widget 2&nbsp;</td></tr>
 * </table>
 */
class VBox extends Box {
	var align : Int;

	/**
	 * @param relativeWidth the widget relative width; defaults to 1
     * @param align the widgets alignement (-1=left, 0=centered, 1=right); defaults to 0
	 * @throws String if relativeWidth not in [0..1] or if align not in [-1, 0, 1] 
     */
	public function new(?relativeWidth : Float = 1, ?align : Int = 0) {
		super(relativeWidth);
		if (align >= -1 && align <= 1) {
			this.align = align;
		} else {
			throw "invalid align value: should be -1, 0 or 1, given: " + Std.string(align);
		}
	}

	override function placeWidgets() {
		var y : Float = 0;
		for (w in widgetsList) {
			w.y = y;
			y += w.height + Widget.verticalPadding;
			if (align == 0) {
				w.x = (getWidth() - w.getWidth()) / 2;
			} else if (align == 1) {
				w.x = getWidth() - w.getWidth() - Widget.horizontalPadding;
			}
		}
	}
}
