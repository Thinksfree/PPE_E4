<?php

// Generated by Haxe 3.4.2
class php_db__PDO_PDOConnection implements sys_db_Connection{
	public function __construct($dsn, $user = null, $password = null, $options = null) {
		if(!php_Boot::$skip_constructor) {
		if(null === $options) {
			$this->pdo = new PDO($dsn, $user, $password);
		} else {
			$arr = array();
			{
				$_g = 0;
				$_g1 = Reflect::fields($options);
				while($_g < $_g1->length) {
					$key = $_g1[$_g];
					$_g = $_g + 1;
					$arr[$key] = Reflect::field($options, $key);
					unset($key);
				}
			}
			$this->pdo = new PDO($dsn, $user, $password, $arr);
		}
		$this->dbname = _hx_explode(":", $dsn)->shift();
		{
			$_g2 = strtolower($this->dbname);
			switch($_g2) {
			case "mysql":{
				$this->dbname = "MySQL";
			}break;
			case "sqlite":{
				$this->dbname = "SQLite";
			}break;
			}
		}
	}}
	public $pdo;
	public $dbname;
	public function request($s) {
		$result = $this->pdo;
		$result1 = $result->query($s, PDO::PARAM_STR);
		if(($result1 === false)) {
			$a = $this->pdo->errorInfo();
			$info = new _hx_array($a);
			throw new HException("Error while executing " . _hx_string_or_null($s) . " (" . Std::string($info[2]) . ")");
		}
		$db = strtolower($this->dbname);
		if($db === "sqlite") {
			return new php_db__PDO_AllResultSet($result1, new php_db__PDO_DBNativeStrategy($db));
		} else {
			return new php_db__PDO_PDOResultSet($result1, new php_db__PDO_PHPNativeStrategy());
		}
	}
	public function quote($s) {
		if(_hx_index_of($s, "\x00", null) >= 0) {
			return "x'" . _hx_string_or_null((_hx_string_or_null(bin2hex($s)) . "'"));
		}
		return $this->pdo->quote($s, null);
	}
	public function addValue($s, $v) {
		$tmp = null;
		if(!is_int($v)) {
			$tmp = is_null($v);
		} else {
			$tmp = true;
		}
		if($tmp) {
			$s->add($v);
		} else {
			if(is_bool($v)) {
				$tmp1 = null;
				if($v) {
					$tmp1 = 1;
				} else {
					$tmp1 = 0;
				}
				$s->add($tmp1);
			} else {
				$s->add($this->quote(Std::string($v)));
			}
		}
	}
	public function lastInsertId() {
		return _hx_cast(Std::parseInt($this->pdo->lastInsertId(null)), _hx_qtype("Int"));
	}
	public function dbName() {
		return $this->dbname;
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
	function __toString() { return 'php.db._PDO.PDOConnection'; }
}
