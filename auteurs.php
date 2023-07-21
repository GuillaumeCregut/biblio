<?php
    /* * * * * * * * * * * * * * * * * * * * * * * */
    /* Gestion Biblio v0.1A                        */
    /* Date création : 11/09/2021                  */
    /* Dernière modification : 11/09/2021          */
    /* * * * * * * * * * * * * * * * * * * * * * * */
    //Inclusion des fichiers nécessaires
    include "include/config.inc.php";
    include "include/smarty.class.php";
    include "include/db.inc.php";
    include "include/sql.inc.php";
    //On initialise le moteur de template
    $moteur=new Smarty();
    //Connexion àla base de données
    $Conn=new connect_base($DataBaseServeur,$DataBaseName,$DataBaseUser,$DataBasePass);
    if(!empty($_POST))
    {
        $ok=true;
        //on récupère les valeurs
        if(isset($_POST['nom']))
        {
            $Nom_Auteur=htmlspecialchars($_POST['nom'],ENT_NOQUOTES,'UTF-8');
        }
        else
            $ok=false;
        if(isset($_POST['prenom']))
        {
            $Prenom_Auteur=htmlspecialchars($_POST['prenom'],ENT_NOQUOTES,'UTF-8');
        }
        else
            $ok=false;
        //On ajoute l'auteur
        if($ok)
        {
            $SQLS=$SQL_Add_Auteur;
            $tabVal=array(':nom'=>$Nom_Auteur,':prenom'=>$Prenom_Auteur);
            $Conn->ExecProc($tabVal,$SQLS);
        }
    }
    //Afficher la page
    $moteur->display($CheminTpl.'auteurs.tpl');
    $moteur->display($CheminTpl.'footer.tpl');
?>