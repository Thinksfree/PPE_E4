<?php

namespace covoit_ppe\Form\Type;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class CreerOffer extends AbstractType 
{
    public function buildForm (FormBuilderInterface $builder, array $options)
    {      
        $builder ->add('date',DateType::class,array('attr'=> array('class'=>'form-control'),'widget' => 'single_text','format' => 'yyyy-MM-dd'))
                ->add('jour',ChoiceType::class, array('choices'=>array(
                    'Lundi' => 0,
                    'Mardi' => 1,
                    'Mercredi' => 2,
                    'Jeudi' => 3,
                    'Vendredi' => 4)))
                ->add('depart',ChoiceType::class, array('choices'=>array(
                    'Lycée' => 0,
                    'Domicile' => 1)))
                ->add('heure',TextType::class,array('attr'=>array('class'=>'form-control','placeholder'=>'hh:mm:ss')))
                ->add('ville',TextType::class,array('attr'=>array('class'=>'form-control')))
                ->add('nombreKilometres',NumberType::class,array('attr'=>array('class'=>'form-control')))
                ->add('publierCetteOffre',SubmitType::class,array('attr'=>array('class'=>'btn btn-primary')));
    }
}