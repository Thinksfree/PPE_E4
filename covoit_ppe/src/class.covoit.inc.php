<?php

class PdoCovoit {   

      	private static $serveur='mysql:host=localhost';
      	private static $bdd='dbname=covoit_bet';   		
      	private static $user='sqltquemener' ;    		
      	private static $mdp='savary' ;	
        private static $monPdo;
        private static $monPdoCovoit=null;
        
	private function __construct(){
            
        try
         {
            PdoCovoit::$monPdo = new PDO(PdoCovoit::$serveur.';'.PdoCovoit::$bdd, PdoCovoit::$user, PdoCovoit::$mdp); 
            PdoCovoit::$monPdo->query("SET CHARACTER SET utf8");
            PdoCovoit::$monPdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
           }
        catch (PDOException $e)
        {
            die($e->getMessage());
        }   
    }
		
	public  static function getPdoCovoit(){
		if(PdoCovoit::$monPdoCovoit==null){
			PdoCovoit::$monPdoCovoit= new PdoCovoit();
		}
		return PdoCovoit::$monPdoCovoit;  
	}
        
    public function getOffers() {
        $req = "select * from Offer";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->execute();
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    public function getUsers() {
        $req = "select * from User";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->execute();
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    public function getOffersAndUsers() {
        $req = "select * from Offer,User where User.id=Offer.id_User";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->execute();
        $lesLignes = $res->fetchAll();
        return $lesLignes;
    }

    public function getUnUser($id) {
        $req = "select * from User where id=:id";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->bindParam(':id',$id,PDO::PARAM_STR);
        $res->execute();
        $ligne = $res->fetch();
        return $ligne;
    }
        
    public function creerUser($id,$nom,$prenom,$email,$tel,$login,$password){
        $req="Insert into User values (:id,:nom,:prenom,:email,:tel,:login,:password)";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->bindParam(':id',$id,PDO::PARAM_STR);
        $res->bindParam(':nom',$nom,PDO::PARAM_STR);
        $res->bindParam(':prenom',$prenom,PDO::PARAM_STR);
        $res->bindParam(':email',$email,PDO::PARAM_STR);
        $res->bindParam(':tel',$tel,PDO::PARAM_STR);
        $res->bindParam(':login',$login,PDO::PARAM_STR);
        $res->bindParam(':password',$password,PDO::PARAM_STR);
        $res->execute();
    }

    public function creerOffer($id,$date,$jour,$depart,$heure,$ville,$km,$idUser){
        $req="Insert into Offer values (:id,:date,:jour,:depart,:heure,:ville,:km,:idUser)";
        $res = PdoCovoit::$monPdo->prepare($req);
        $res->bindParam(':id',$id,PDO::PARAM_STR);
        $res->bindParam(':date',$date->format('Y-m-d'),PDO::PARAM_STR);
        $res->bindParam(':jour',$jour,PDO::PARAM_INT);
        $res->bindParam(':depart',$depart,PDO::PARAM_INT);
        $res->bindParam(':heure',$heure,PDO::PARAM_STR);
        $res->bindParam(':ville',$ville,PDO::PARAM_STR);
        $res->bindParam(':km',$km,PDO::PARAM_INT);
        $res->bindParam(':idUser',$idUser,PDO::PARAM_STR);
        $res->execute();
    }
}   