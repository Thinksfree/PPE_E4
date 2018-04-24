package buw;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

class Widget extends Sprite {
	public static var boldTitle : Bool = true;
	public static var borderColor : Int = 0x888888;
	public static var borderWidth : Int = 1;
	public static var controlsBackground1 : Int = 0xdddddd;
	public static var controlsBackground2 : Int = 0xaaaaaa;
	public static var controlsFontSize : Int = 16;
	public static var controlsTextColor : Int = 0x111111;
	public static var font : String = null;
	public static var horizontalPadding : Int = 4;
	public static var inputBackground : Int = 0xeeeeee;
	public static var stageBackground : Int = 0xffffff;
	public static var titleColor : Int = 0x222222;
	public static var titleFontSize : Int = 18;
	public static var underlineTitle : Bool = true;
	public static var verticalPadding : Int = 4;

	function new() {
		super();
		relativeWidth = 0;
		addEventListener(MouseEvent.MOUSE_MOVE, function (e : MouseEvent) {
			e.stopPropagation(); //for scrolling
		});
	}

	@:allow(buw.Screen)
	function draw() {}

	var relativeWidth : Float;
	function getWidth() : Float {
		var widgetWidth : Float;
		if (Screen.isRootWidget(this) || parent == null) {
			if (relativeWidth != 0) {
				widgetWidth = Lib.current.stage.stageWidth * relativeWidth;
			} else {
				widgetWidth = Lib.current.stage.stageWidth;
			}
		} else {
			if (relativeWidth != 0) {
				widgetWidth = cast(parent, Widget).getWidth() * relativeWidth;
			} else {
				widgetWidth = this.width;
			}
		}
		return widgetWidth;
	}
}
