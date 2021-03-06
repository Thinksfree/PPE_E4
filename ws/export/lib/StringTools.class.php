<?php

// Generated by Haxe 3.4.2
class StringTools {
	public function __construct(){}
	static function hex($n, $digits = null) {
		$s = dechex($n);
		$len = 8;
		$tmp = null;
		if(null === $digits) {
			$tmp = $len;
		} else {
			if($digits > $len) {
				$len = $digits;
			} else {
				$len = $len;
			}
			$tmp = $len;
		}
		if(strlen($s) > $tmp) {
			$s = _hx_substr($s, -$len, null);
		} else {
			if($digits !== null) {
				$s1 = null;
				if(strlen("0") !== 0) {
					$s1 = strlen($s) >= $digits;
				} else {
					$s1 = true;
				}
				if($s1) {
					$s = $s;
				} else {
					$s = str_pad($s, Math::ceil(($digits - strlen($s)) / strlen("0")) * strlen("0") + strlen($s), "0", STR_PAD_LEFT);
				}
			}
		}
		return strtoupper($s);
	}
	function __toString() { return 'StringTools'; }
}
