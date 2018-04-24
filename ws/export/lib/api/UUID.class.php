<?php

// Generated by Haxe 3.4.2
class api_UUID {
	public function __construct(){}
	static function genUUID() {
		$uid = new StringBuf();
		$a = 8;
		$uid->add(StringTools::hex(Std::int(Date::now()->getTime()), 8));
		while(true) {
			$a = $a + 1;
			if(!($a - 1 < 36)) {
				break;
			}
			$tmp = null;
			if(($a * 51 & 52) !== 0) {
				$tmp1 = null;
				if(($a ^ 15) !== 0) {
					$tmp2 = Math::random();
					$tmp3 = null;
					if(($a ^ 20) !== 0) {
						$tmp3 = 16;
					} else {
						$tmp3 = 4;
					}
					$tmp1 = 8 ^ Std::int($tmp2 * $tmp3);
					unset($tmp3,$tmp2);
				} else {
					$tmp1 = 4;
				}
				$tmp = StringTools::hex($tmp1, null);
				unset($tmp1);
			} else {
				$tmp = "-";
			}
			$uid->add($tmp);
			unset($tmp);
		}
		return strtolower($uid->b);
	}
	function __toString() { return 'api.UUID'; }
}