<?php
//Gestion des auteurs
    $SQL_Add_Auteur='CALL p_add_auteur(:nom,:prenom)';
    $SQL_Get_Auteur="SELECT nom_auteur, prenom_auteur, pk_auteur FROM t_auteur ORDER by nom_auteur";
    $SQL_Get_Auteur_NewID='SELECT pk_auteur FROM t_auteur WHERE (nom_auteur=:nom and prenom_auteur=:prenom)';
    $SQL_Sel_Auteur="SELECT DISTINCT pk_auteur,nom_auteur,prenom_auteur FROM t_auteur WHERE prenom_auteur like :rech1 or nom_auteur like :rech2 GROUP BY nom_auteur, prenom_auteur";
//Gestion des éditeurs
    $SQL_Add_Editeur='CALL p_add_editeur(:nom)';
    $SQLS_Get_Editeur="SELECT nom_editeur, pk_editeur FROM t_editeur ORDER BY nom_editeur";
    $SQL_Sel_Editeur='SELECT pk_editeur,nom_editeur FROM t_editeur WHERE nom_editeur LIKE :rech';
//Gestion du stockage
    $SQL_Get_Stockage='SELECT pk_etagere, nom_etagere FROM t_etagere ORDER BY nom_etagere';

//Gestion des livres
    $SQL_Add_Book='CALL p_add_book(:editeur,:stockage,:titre,:ref,@LID)';
    $SQL_Sel_Titre='SELECT pk_livre,titre_livre FROM t_livre WHERE titre_livre like :rech';  
    $SQL_Get_Last_Id='SELECT @LID as id';  
    //Insertion des auteurs pour un livre
    $SQL_Add_Auteur_Livre='CALL p_add_auteur_livre(:id_livre,:id_auteur)';
//Gestion des Etagères
    $SQL_Add_Stockage='CALL p_add_etagere(:nom)';
    $SQL_Sel_Etagere='SELECT pk_etagere,nom_etagere FROM t_etagere WHERE nom_etagere LIKE :rech';
?>