<?php

// Generated by Haxe 3.4.2
class Lambda {
	public function __construct(){}
	static function harray($it) {
		$a = new _hx_array(array());
		{
			$i = $it->iterator();
			while($i->hasNext()) {
				$a->push($i->next());
			}
		}
		return $a;
	}
	static function map($it, $f) {
		$l = new HList();
		{
			$x = $it->iterator();
			while($x->hasNext()) {
				$l->add(call_user_func_array($f, array($x->next())));
			}
		}
		return $l;
	}
	function __toString() { return 'Lambda'; }
}
