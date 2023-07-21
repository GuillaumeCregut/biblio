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
    //Si on a reçu un ajout
    if(!empty($_POST))
    {
        $Ok=true;
        //Gestion des auteurs
        if(isset($_POST['auteur']))
        {
            $TabAuteurs=array();
            //On traite les auteurs
            foreach($_POST['auteur'] as $IdAuteur)
            {
                $IdAuteur=intval($IdAuteur);
                
                if($IdAuteur>0)
                {
                    if(!in_array($IdAuteur,$TabAuteurs))
                    {
                        array_push($TabAuteurs,$IdAuteur);
                    }
                }
                //Vérifier si au moins 1 auteur est supérieur à 0
                $tailleAuteurs=sizeof($TabAuteurs);
                if($tailleAuteurs==0)
                {
                    $Ok=false;
                }
            }
        }
        else
            $Ok=false;
        //Gestion editeur
        if(isset($_POST['editeur']))
        {
            $Editeur=intval($_POST['editeur']);
        }
        else
            $Ok=false;   
        //Gestion stockage
        if(isset($_POST['stockage']))
        {
            $Stockage=intval($_POST['stockage']);
        }
        else
            $Ok=false; 
        //Gestion ISBN  
        if(isset($_POST['reference']))
        {
            $Reference=htmlspecialchars($_POST['reference'],ENT_NOQUOTES,'UTF-8');
        }
        else
            $Reference='';
        //gestion titre
        if(isset($_POST['titre']))
        {
            $Titre=htmlspecialchars($_POST['titre'],ENT_NOQUOTES,'UTF-8');
            if( $Titre=='')
            {
                $Ok=false;
            }
        }   
        else
            $Ok=false;
        //Si tout est OK on peut continuer
        if($Ok)
        {
            //Ajout du livre
            $SQLS=$SQL_Add_Book;
            $TabVal=array(':editeur'=>$Editeur,':stockage'=>$Stockage,':titre'=>$Titre,':ref'=>$Reference);
            $res=$Conn->ExecProc($TabVal,$SQLS);
            if($res==1)
            {
                //Récupération de l'ID livre
                $SQLS=$SQL_Get_Last_Id;
                $Conn->sql_query($SQLS);
                $row=$Conn->sql_fetchrow();
                $Id_Livre=$row['id'];
                //Ajout des auteurs
                $SQLS=$SQL_Add_Auteur_Livre;
                foreach($TabAuteurs as $newAuteur)
                {
                    $tabVal2=array(':id_livre'=>$Id_Livre,':id_auteur'=>$newAuteur);
                    $res=$Conn->ExecProc($tabVal2,$SQLS);
                }
            }
            

        }   
}
    //Récupération des auteurs
    $TabAuteur=array();
    $SQLS=$SQL_Get_Auteur;
    $Conn->sql_query($SQLS);
    while($row=$Conn->sql_fetchrow())
    {
        $Nom=$row['nom_auteur'];
        $Prenom=$row['prenom_auteur'];
        $key=$row['pk_auteur'];
        $Nom_Prenom=$Nom.' '.$Prenom;
        $tabtemp=array('nom'=>$Nom_Prenom,'cle'=>$key);
        array_push( $TabAuteur,$tabtemp);
    }
    //Récupération des éditeurs
    $TabEditeur=array();
    $SQLS=$SQLS_Get_Editeur;
    $Conn->sql_query($SQLS);
    while($row=$Conn->sql_fetchrow())
    {
        $Nom=$row['nom_editeur'];
        $key=$row['pk_editeur'];
        $tabtemp=array('nom'=>$Nom,'cle'=>$key);
        array_push( $TabEditeur,$tabtemp);
    }
    //Récupération des stockages
    $TabStockage=array();
    $SQLS=$SQL_Get_Stockage;
    $Conn->sql_query($SQLS);
    while($row=$Conn->sql_fetchrow())
    {
        $Nom=$row['nom_etagere'];
        $key=$row['pk_etagere'];
        $tabtemp=array('nom'=>$Nom,'cle'=>$key);
        array_push( $TabStockage,$tabtemp);
    }
    if(!empty($TabAuteur))
    {
        $moteur->assign('Auteurs',$TabAuteur);
    }
    if(!empty($TabEditeur))
    {
        $moteur->assign('Editeurs',$TabEditeur);
    }
    if(!empty($TabStockage))
    {
        $moteur->assign('Stockage',$TabStockage);
    }
    $moteur->display($CheminTpl.'livres.tpl');
    $moteur->display($CheminTpl.'footer.tpl'); 
?>