package buw;

@:allow(buw.HBox)
class HBoxColumn {
	/**
	 * [0..1]; 0 means the widget real width, 1 means 100% of parent width
	 */
	var relativeWidth : Float;
	var align : Int;

	/**
	 * @param relativeWidth the column relative width
	 * @param align the column alignement (-1=left, 0=centered, 1=right); defaults to 0
	 * @throws String if relativeWidth not in [0..1] or if align not in [-1, 0, 1]
	 */
	public function new(relativeWidth : Float, ?align : Int = 0) {
		if (relativeWidth >= 0 && relativeWidth <= 1) {
			this.relativeWidth = relativeWidth;
		} else {
			throw "invalid relativeWidth value: should be [0..1], given: " + Std.string(relativeWidth);
		}
		if (align >= -1 && align <= 1) {
			this.align = align;
		} else {
			throw "invalid align value: should be -1, 0 or 1, given: " + Std.string(align);
		}
	}
}
