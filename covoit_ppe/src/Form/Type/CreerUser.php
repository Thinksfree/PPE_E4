<?php

namespace covoit_ppe\Form\Type;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class CreerUser extends AbstractType 
{
    public function buildForm (FormBuilderInterface $builder, array $options)
    {      
        $builder ->add('nom',TextType::class,array('attr'=>array('class'=>'form-control')))
                ->add('prenom',TextType::class,array('attr'=>array('class'=>'form-control')))
                ->add('email',TextType::class,array('attr'=>array('class'=>'form-control')))
                ->add('telephone',TextType::class,array('attr'=>array('class'=>'form-control')))
                ->add('motDePasse',PasswordType::class,array('attr'=>array('class'=>'form-control')))
                ->add('creerUnUtilisateur',SubmitType::class,array('attr'=>array('class'=>'btn btn-primary')));
    }
}