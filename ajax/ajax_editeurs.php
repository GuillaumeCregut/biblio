<?php
    //Inclusion des fichiers nécessaires
   
    include "../include/config.inc.php";
    include "../include/db.inc.php";
    include "../include/sql.inc.php";
    //On recoit une demande pour la liste des auteurs
    if(isset($_POST['SearchedText']))
    {
        $TabJson=array();
        $Recherche=htmlspecialchars($_POST['SearchedText'],ENT_NOQUOTES,'UTF-8');
        //Connexion àla base de données
        $Conn=new connect_base($DataBaseServeur,$DataBaseName,$DataBaseUser,$DataBasePass);
        $SQLS=$SQL_Sel_Editeur;
        $TabVal=array(':rech'=>"%$Recherche%");
        $rows=$Conn->sql_fetch_all_prepared($TabVal,$SQLS);
        foreach($rows as $row)
        {
            $Nom=$row['nom_editeur'];
            $id=$row['pk_editeur'];
            array_push($TabJson,"$Nom"); 
            
        }
        
        echo json_encode($TabJson);
    }
?>