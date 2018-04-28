<?php

// Generated by Haxe 3.4.2 (git build master @ 890f8c7)
class php_db__PDO_PDOResultSet extends php_db__PDO_BaseResultSet {
	public function __construct($pdo, $typeStrategy) {
		if(!php_Boot::$skip_constructor) {
		parent::__construct($pdo,$typeStrategy);
	}}
	public $cache;
	public function getResult($index) {
		if(!$this->hasNext()) {
			return null;
		}
		return $this->cache[$index];
	}
	public function hasNext() {
		if((null === $this->cache)) {
			$this->cacheRow();
		}
		return $this->cache;
	}
	public function cacheRow() {
		$tmp = $this->pdo;
		$tmp1 = PDO::FETCH_NUM;
		$this->cache = $tmp->fetch($tmp1, PDO::FETCH_ORI_NEXT, null);
	}
	public function nextRow() {
		if(!$this->hasNext()) {
			return null;
		} else {
			$v = $this->cache;
			$this->cache = null;
			return $v;
		}
	}
	public function __call($m, $a) {
		if(isset($this->$m) && is_callable($this->$m))
			return call_user_func_array($this->$m, $a);
		else if(isset($this->__dynamics[$m]) && is_callable($this->__dynamics[$m]))
			return call_user_func_array($this->__dynamics[$m], $a);
		else if('toString' == $m)
			return $this->__toString();
		else
			throw new HException('Unable to call <'.$m.'>');
	}
	function __toString() { return 'php.db._PDO.PDOResultSet'; }
}
