<?php

// Generated by Haxe 3.4.2
class controller_Listener {
	public function __construct(){}
	static function boot() {
		try {
			Index::dispatch(new controller_Request());
		}catch(Exception $__hx__e) {
			$_ex_ = ($__hx__e instanceof HException) && $__hx__e->getCode() == null ? $__hx__e->e : $__hx__e;
			$e = $_ex_;
			{
				php_Web::setReturnCode(400);
				Sys::hprint("Bad Request");
			}
		}
	}
	function __toString() { return 'controller.Listener'; }
}
