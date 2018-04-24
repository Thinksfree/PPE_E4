<?php
use Symfony\Component\HttpFoundation\Request;
use covoit_ppe\Form\Type\CreerUser;
use covoit_ppe\Form\Type\CreerOffer;

$app->get('/', function () use ($app) {
    require '../src/class.covoit.inc.php';
    $pdo = PdoCovoit::getPdoCovoit();
    return $app['twig']->render('v_accueil.html.twig');
})
->bind('homepage');

$app->get('/listeOffers/', function () use ($app) {
    require '../src/class.covoit.inc.php';
    $pdo = PdoCovoit::getPdoCovoit();
    $offers = $pdo->getOffersAndUsers();
    return $app['twig']->render('v_listeOffers.html.twig',array('offers'=>$offers));
})
->bind('listeOffers');

$app->get('/listeUsers/', function () use ($app) {
    require '../src/class.covoit.inc.php';
    $pdo = PdoCovoit::getPdoCovoit();
    $users = $pdo->getUsers();
    return $app['twig']->render('v_listeUsers.html.twig',array('users'=>$users));
})
->bind('listeUsers');

$app->match('/creerUser/', function (Request $request) use ($app) {
    require '../src/class.covoit.inc.php';
    $pdo = PdoCovoit::getPdoCovoit();
    $form=$app['form.factory']->create(CreerUser::class);
    $formView=$form->createView();
   if($request->getMethod()=='GET'){
        return $app['twig']->render('v_creerUser.html.twig',array('form'=>$formView));        
   }
    
    if($request->getMethod()=='POST'){
        $form->handleRequest($request);
        
        if($form->isValid()){
            $data=$form->getData();
            $nom=$data['nom'];
            $prenom=$data['prenom'];
            $email=$data['email'];
            $tel=$data['telephone'];
            $pwd=$data['motDePasse'];
            //generation id
            $caracteres = '0123456789abcdefghijklmnopqrstuvwxyz';
            $longueurMax = strlen($caracteres);
            $id = '80000000';
            $part1 = '-';
            $part2 = '-';
            $part3 = '-';
            $part4 = '-';
            for ($i = 0; $i < 4; $i++)
            {
            $part1.= $caracteres[rand(0, $longueurMax - 1)];
            $part2.= $caracteres[rand(0, $longueurMax - 1)];
            $part3.= $caracteres[rand(0, $longueurMax - 1)];
            }
            for ($i = 0; $i < 12; $i++)
            {
            $part4.= $caracteres[rand(0, $longueurMax - 1)];
            }
            $id.=$part1;
            $id.=$part2;
            $id.=$part3;
            $id.=$part4;
            //generation login
            $login='';
            $login.=$prenom[0];
            $login.=$nom;
            $login=strtolower($login);
            //hashage pwd
            $password=password_hash($pwd, PASSWORD_DEFAULT);

            $pdo->creerUser($id,$nom,$prenom,$email,$tel,$login,$password);
            echo '<script>alert("L\'utilisateur a bien été créé");</script>';
            return $app['twig']->render('v_accueil.html.twig',array('form'=>$formView));
        }
    }
})
->bind('creerUser');

$app->match('/creerOffer/', function (Request $request) use ($app) {
    require '../src/class.covoit.inc.php';
    $pdo = PdoCovoit::getPdoCovoit();
    $form=$app['form.factory']->create(CreerOffer::class);
    $formView=$form->createView();
   if($request->getMethod()=='GET'){
        return $app['twig']->render('v_creerOffer.html.twig',array('form'=>$formView));        
   }
    
    if($request->getMethod()=='POST'){
        $form->handleRequest($request);
        
        if($form->isValid()){
            $data=$form->getData();
            $date=$data['date'];
            $jour=$data['jour'];
            $depart=$data['depart'];
            $heure=$data['heure'];
            $ville=$data['ville'];
            $km=$data['nombreKilometres'];

            //generation id
            $caracteres = '0123456789abcdefghijklmnopqrstuvwxyz';
            $longueurMax = strlen($caracteres);
            $id = '80000000';
            $part1 = '-';
            $part2 = '-';
            $part3 = '-';
            $part4 = '-';
            for ($i = 0; $i < 4; $i++)
            {
            $part1.= $caracteres[rand(0, $longueurMax - 1)];
            $part2.= $caracteres[rand(0, $longueurMax - 1)];
            $part3.= $caracteres[rand(0, $longueurMax - 1)];
            }
            for ($i = 0; $i < 12; $i++)
            {
            $part4.= $caracteres[rand(0, $longueurMax - 1)];
            }
            $id.=$part1;
            $id.=$part2;
            $id.=$part3;
            $id.=$part4;

            $idUser="80000000-c773-wlt1-3kv0-1nzt5bdjz65r";

            $pdo->creerOffer($id,$date,$jour,$depart,$heure,$ville,$km,$idUser);
            echo '<script>alert("L\'offre a bien été créée");</script>';
            return $app['twig']->render('v_accueil.html.twig',array('form'=>$formView));
        }
    }
})
->bind('creerOffer');


