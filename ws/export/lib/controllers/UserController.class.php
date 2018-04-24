<?php

// Generated by Haxe 3.4.2
class controllers_UserController {
	public function __construct(){}
	static function dispatch($request, $id) {
		if(models_Connexion::auth($request) !== null) {
			$tmp = null;
			if($id === "all") {
				$tmp = $request->method === "GET";
			} else {
				$tmp = false;
			}
			if($tmp) {
				controllers_UserController::retrieveAll($request);
			} else {
				if($id === null) {
					$request->setReturnCode(406, "Not Acceptable\x0Amissing id");
				} else {
					switch($request->method) {
					case "DELETE":{
						controllers_UserController::deleteUser($request, $id);
					}break;
					case "GET":{
						controllers_UserController::retrieveOneUser($request, $id);
					}break;
					case "POST":{
						controllers_UserController::postUser($request, $id);
					}break;
					case "PUT":{
						controllers_UserController::putUser($request, $id);
					}break;
					default:{
						$request->setReturnCode(501, "Not implement");
					}break;
					}
				}
			}
		} else {
			$request->setReturnCode(406, "Bad Connexion");
		}
	}
	static function retrieveAll($request) {
		$request->setHeader("Content-Type", "application/json");
		$usersInDB = models_User::$manager->all(null);
		$first = true;
		$request->send("[");
		{
			$user = $usersInDB->iterator();
			while($user->hasNext()) {
				$user1 = $user->next();
				if(!$first) {
					$request->send(",");
				} else {
					$first = false;
				}
				Reflect::deleteField($user1, "_manager");
				Reflect::deleteField($user1, "_lock");
				Reflect::deleteField($user1, "__cache__");
				$request->send(haxe_Json::phpJsonEncode($user1, null, null));
				unset($user1);
			}
		}
		$request->send("]");
	}
	static function retrieveOneUser($request, $id) {
		$request->setHeader("Content-Type", "application/json");
		$u = models_User::$manager->unsafeGet($id, true);
		if($u === null) {
			$request->setReturnCode(404, "Not Found\x0ANo 'user/" . _hx_string_or_null($id) . "'");
			return;
		}
		$request->send("{\"idUser\":\"" . _hx_string_or_null($u->idUser) . "\",\"lastname\":\"" . _hx_string_or_null($u->lastname) . "\",\"firstname\":\"" . _hx_string_or_null($u->firstname) . "\",\"email\":\"" . _hx_string_or_null($u->email) . "\",\"phone\":\"" . _hx_string_or_null($u->phone) . "\",\"login\":\"" . _hx_string_or_null($u->login) . "\",\"password\":\"" . _hx_string_or_null($u->password) . "\"}");
	}
	static function postUser($request, $id) {
		if(models_Connexion::admin($request)) {
			$user = null;
			$data = $request->data;
			$user = new models_User(null, $data->lastname, $data->firstname, $data->email, $data->phone, $data->login, $data->password);
			$user->insert();
			$request->setHeader("Content-type", "application/json");
			$request->send("{\"id\":" . _hx_string_or_null($user->idUser) . "}");
		} else {
			$request->setReturnCode(404, "Operation not permitted");
			return;
		}
	}
	static function putUser($request, $id) {
		$request->setHeader("Content-Type", "application/json");
		$u = models_User::$manager->unsafeGet($id, true);
		$tmp = null;
		if(!models_Connexion::admin($request)) {
			$tmp = models_Connexion::himself($request, $u);
		} else {
			$tmp = true;
		}
		if($tmp) {
			if($u === null) {
				$request->setReturnCode(404, "Not Found\x0ANo 'user/" . _hx_string_or_null($id) . "'");
				return;
			}
			$data = $request->data;
			$u->firstname = $data->firstname;
			$u->lastname = $data->lastname;
			$u->email = $data->email;
			$u->phone = $data->phone;
			$u->login = $data->login;
			$u->password = $data->password;
			$u->update();
		} else {
			$request->setReturnCode(404, "Operation not permitted");
			return;
		}
	}
	static function deleteUser($request, $id) {
		if(models_Connexion::admin($request)) {
			$u = models_User::$manager->unsafeGet($id, true);
			if($u === null) {
				$request->setReturnCode(404, "Not Found\x0ANo 'user/" . _hx_string_or_null($id) . "'");
				return;
			}
			$u->delete();
		} else {
			$request->setReturnCode(404, "Operation not permitted");
			return;
		}
	}
	function __toString() { return 'controllers.UserController'; }
}