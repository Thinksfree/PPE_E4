package buw;
import openfl.events.MouseEvent;

class ColorButton extends Button {
	var h : Float;
	var w : Float;
	
	public function new(listener : Control -> Void, color : Int, width : Float, height : Float) {
		super(listener);
		graphics.beginFill(color);
		graphics.lineStyle(Widget.borderWidth, Widget.borderColor);
		w = width;
		h = height;
		graphics.drawRect(Widget.borderWidth,Widget.borderWidth, w - Widget.borderWidth, h - Widget.borderWidth);
		graphics.endFill();
		alpha = 0.5;
		addEventListener(MouseEvent.MOUSE_OVER, eventMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, eventMouseOut);
	}
	
	function eventMouseOver(event : MouseEvent) {
		alpha = 1;
	}
	
	function eventMouseOut(event : MouseEvent) {
		alpha = 0.5;
	}
}
