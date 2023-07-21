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
$moteur->display($CheminTpl.'index.tpl');
$moteur->display($CheminTpl.'footer.tpl');
?>