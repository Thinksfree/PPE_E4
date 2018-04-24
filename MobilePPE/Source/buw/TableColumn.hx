package buw;

@:allow(buw.Table)
class TableColumn<T> extends HBoxColumn {
	var fieldName : String;
	var title : String;
	var renderer : T -> Widget;

	/**
	 * @param relativeWidth the column relative width
	 * @param align the column alignement (-1=left, 0=centered, 1=right); defaults to 0
	 * @param title the column title
	 * @param fieldName the item object fieldName
	 * @param renderer how to display an item; defaults to null (Label)
	 * @throws String if relativeWidth not in [0..1] or if align not in [-1, 0, 1] or if fieldName & renderer are null
	 */
	public function new(relativeWidth : Float, ?align : Int = 0, ?title : String = "", ?fieldName : String, ?renderer : T -> Widget) {
		super(relativeWidth, align);
		if (fieldName == null && renderer == null) {
			throw "unset fieldName nor renderer; cannot render TableColumn";
		}
		this.title = title;
		this.fieldName = fieldName;
		this.renderer = renderer;
	}
}
