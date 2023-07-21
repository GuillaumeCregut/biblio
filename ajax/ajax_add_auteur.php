<?php
    //Inclusion des fichiers nécessaires
   
    include "../include/config.inc.php";
    include "../include/db.inc.php";
    include "../include/sql.inc.php";
    $tabJSON=array();
    if(!empty($_POST))
    {
        $OK=true;
        if(isset($_POST['nom']))
        {
            $Nom=htmlspecialchars($_POST['nom'],ENT_NOQUOTES,'UTF-8');
        }
        else
            $OK=false;
        if(isset($_POST['prenom']))
        {
            $Prenom=htmlspecialchars($_POST['prenom'],ENT_NOQUOTES,'UTF-8');
        }
        else
            $OK=false;
        if($OK)
        {
             //Connexion àla base de données
            $Conn=new connect_base($DataBaseServeur,$DataBaseName,$DataBaseUser,$DataBasePass);
            $SQLS=$SQL_Add_Auteur;
            $tabVal=array(':nom'=>$Nom,':prenom'=>$Prenom);
            $ret=$Conn->ExecProc($tabVal,$SQLS);
            if($ret==1)
            {
                //Récupère l'ID ajouté
                $SQLS=$SQL_Get_Auteur_NewID;
                $row=$Conn->sql_fetch_all_prepared($tabVal,$SQLS);
                $Id=$row[0]['pk_auteur'];
                array_push($tabJSON,array('Retour'=>$Id));
            }
            else
                array_push($tabJSON,array('Retour'=>0));
        }
        else
            array_push($tabJSON,array('Retour'=>0));
    }
    echo json_encode($tabJSON);
?>