package buw;
import haxe.Timer;
import openfl.Lib;
import openfl.display.DisplayObjectContainer;
import openfl.events.MouseEvent;

class Toolkit {
	static var rootWidget : Widget = null;
	static var downPos : Float = -1;
	static var currentPos : Float;
	static var downTime : Float;
	
	public static function init(w : Widget) {
		if (rootWidget != null) {
			Lib.current.stage.removeChild(rootWidget);
		}
		rootWidget = w;
		Lib.current.stage.addChild(rootWidget);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
	}
	
	static function mouseWheel(e : MouseEvent) {
		doMove(e.delta * 32);
	}
	
	static function mouseDown(e : MouseEvent) {
		downPos = e.localY;
		currentPos = downPos;
		downTime = Timer.stamp();
	}
	
	static function mouseMove(e : MouseEvent) {
		if (downPos != -1) {
			var move = e.localY - currentPos;
			currentPos = e.localY;
			doMove(move);
		}
	}
	
	static function mouseUp(e : MouseEvent) {
		var upTime = Timer.stamp();
		var pressTime = upTime - downTime;
		if (pressTime < 0.5) {
			var speed = (e.localY - downPos) / pressTime;
			autoScroll(speed);
		}
		downPos = -1;
	}
	
	static function autoScroll(speed : Float) {
		doMove(speed / 10);
		if (Math.abs(speed) > 10) {
			Timer.delay(function() { autoScroll(speed * 0.85); }, 10);   
		}
	}
	
	static function doMove(move : Float) {
		rootWidget.y += move;
		if (move < 0 && rootWidget.y + rootWidget.height < Lib.current.stage.stageHeight) {
			var pos = Lib.current.stage.stageHeight - rootWidget.height;
			if (pos > 0) {
				rootWidget.y = 0;
			} else {
				rootWidget.y = pos;
			}
		}
		if (move > 0 && rootWidget.y >= 0) { 
			rootWidget.y = 0;
		}
	}
}

