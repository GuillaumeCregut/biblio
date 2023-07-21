<?php
    /* * * * * * * * * * * * * * * * * * * * * * * */
    /* Gestion Biblio v0.1A                        */
    /* Date création : 11/09/2021                  */
    /* Dernière modification : 15/09/2021          */
    /* * * * * * * * * * * * * * * * * * * * * * * */
    //Inclusion des fichiers nécessaires
    include "include/config.inc.php";
    include "include/smarty.class.php";
    include "include/db.inc.php";
    include "include/sql.inc.php";
    //Démarrage de la session
    session_start();
    //On initialise le moteur de template
    $moteur=new Smarty();
    //Connexion àla base de données
    $Conn=new connect_base($DataBaseServeur,$DataBaseName,$DataBaseUser,$DataBasePass);
    if(!empty($_POST))
    {
        //on récupère les valeurs
        if(isset($_POST['nom']))
        {
            $Nom_Stockage=htmlspecialchars($_POST['nom'],ENT_NOQUOTES,'UTF-8');
            $SQLS=$SQL_Add_Stockage;
            $tabVal=array(':nom'=>$Nom_Stockage);
            $Conn->ExecProc($tabVal,$SQLS);
        }
    }
    $moteur->display($CheminTpl.'stockage.tpl');
    $moteur->display($CheminTpl.'footer.tpl');
?>