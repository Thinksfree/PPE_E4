package buw;

import haxe.Timer;
import openfl.Lib;
import openfl.display.DisplayObjectContainer;
import openfl.events.MouseEvent;
import openfl.events.Event;

class Screen {
	static var currentPos : Float;
	static var downPos : Float = -1;
	static var downTime : Float;
	static var rootWidget : Widget = null;
	static var scrollableWidget : Widget = null;

	/**
	 * displays a box on the stage, and make it scrollable
	 * @param rootWindow the box to display
	 */
	public static function display(rootWindow : Widget) {
		if (rootWindow != null) {
			if (rootWidget != null) {
				Lib.current.stage.removeChild(Screen.rootWidget);
			}
			Lib.current.stage.removeEventListener(Event.RESIZE, onResize);
			rootWidget = rootWindow;
			if (rootWidget != null) {
				Lib.current.stage.addChild(rootWidget);
				Lib.current.stage.addEventListener(Event.RESIZE, onResize);
			}
			setScrollable(rootWidget);
		}
	}

	/**
	 * enable scrolling on only a part of the screen
	 * @param scrollableWidget the widget to make scrollable
	 */
	public static function setScrollable(scrollablePart : Widget) { //FIXME: can only use whole screen height ATM
		scrollableWidget = scrollablePart;
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		Lib.current.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		if (scrollableWidget != null) {
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			Lib.current.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
	}

	static function doMove(move : Float) {
		scrollableWidget.y += move;
		if (move < 0 && scrollableWidget.y + scrollableWidget.height < Lib.current.stage.stageHeight) {
			var pos = Lib.current.stage.stageHeight - scrollableWidget.height;
			if (pos > 0) {
				scrollableWidget.y = 0;
			} else {
				scrollableWidget.y = pos;
			}
		}
		if (move > 0 && scrollableWidget.y >= 0) {
			scrollableWidget.y = 0;
		}
	}

	@:allow(buw.Widget)
	static function isRootWidget(w : Widget) : Bool {
		return w == rootWidget;
	}

	static function onMouseDown(e : MouseEvent) {
		downTime = Timer.stamp();
		downPos = e.localY;
		currentPos = downPos;
	}

	static function onMouseMove(e : MouseEvent) {
		if (downPos != -1) {
			e.stopImmediatePropagation();
			var move = e.localY - currentPos;
			currentPos = e.localY;
			doMove(move);
		}
	}

	static function onMouseUp(e : MouseEvent) {
		var upTime = Timer.stamp();
		var pressTime = upTime - downTime;
		if (pressTime < 0.5) {
			var speed = (e.localY - downPos) / pressTime;
			autoScroll(speed);
		}
		downPos = -1;
	}

	static function onMouseWheel(e : MouseEvent) {
		doMove(e.delta * 32);
	}

	static function onResize(e : Event) {
		rootWidget.draw();
	}

	static function autoScroll(speed : Float) {
		doMove(speed / 10);
		if (Math.abs(speed) > 10) {
			Timer.delay(function() { autoScroll(speed * 0.85); }, 10);
		}
	}
}
