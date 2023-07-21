<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/general.css">
    <link rel="stylesheet" href="styles/livres.css">
    <title>Gestion des livres</title>
</head>

<body>

    <head>
        <div class="conteneur">
            <h1>Gestion des livres</h1>
            <nav>
                <ul>
                    <li><a href="index.php">Retour à l'accueil</a></li>
                    <li><a href="gestion.php">Retour à la page gestion</a></li>
                </ul>
            </nav>
        </div>

    </head>
    <main>
        <div class="conteneur">
            <div class="bloc">
                <div class="bloc_gauche">
                    <section class="liste">
                        <p>Liste des titres présents : </p>
                        <input type="search" name="chercheur" id="chercheur" placeholder="saisissez le titre">
                        <div id="liste_aut"></div>

                    </section>
                    <section class="nouveau">
                        <p>Ajouter un livre</p>
                        <form action="livres.php" method="post">
                            <p class="pChamp"><label for="titre">Titre du livre : </label><input type="text" name="titre" id="titre"></p>
                            <p class="pChamp"><label for="auteur">Auteur : </label></p>
                            <p><input type="button" value="Auteur manquant ?" id="showAuteurBtn"></p>
                            <div class="addauteur invisible" id="divAddAuteur">
                                <label for="nomAuteur">Nom de l'auteur : </label><input type="text" name="nomAuteur" id="nomAuteur"><br>
                                <label for="prenomAuteur">Prenom de l'auteur : </label><input type="text" name="prenomAuteur" id="prenomAuteur"><br>
                                <input type="button" value="ajouter" id="addAuteurBtn">
                            </div>
                            <p><select name="auteur[]" id="auteur" class="selectAuteur">
                            <option value="0">--</option>
                            {if isset($Auteurs)}
                            {foreach from=$Auteurs item=auteur}
                            <option value="{$auteur.cle}">{$auteur.nom}</option>
                            {/foreach}
                            {/if}
                        </select> <input type="button" value="+" id="btnAddAuteur"></p>
                            <p class="pChamp"><label for="editeur">Editeur : </label>
                                <select name="editeur" id="editeur">
                            <option value="0">--</option>
                            {if isset($Editeurs)}
                            {foreach from=$Editeurs item=editeur}
                            <option value="{$editeur.cle}">{$editeur.nom}</option>
                            {/foreach}
                            {/if}
                        </select></p>
                            <p class="pChamp"><label for="stockage">Stockage : </label>
                                <select name="stockage" id="stockage">
                            <option value="0">--</option>
                            {if isset($Auteurs)}
                            {foreach from=$Stockage item=etagere}
                            <option value="{$etagere.cle}">{$etagere.nom}</option>
                            {/foreach}
                            {/if}
                        </select></p>
                            <p class="pChamp"><label for="reference">ISBN : </label><input type="text" name="reference" id="reference"></p>
                            <p class="pChamp"><input type="submit" value="ajouter"></p>
                        </form>
                    </section>
                </div>
                <div class="bloc_droit">
                    <p>Recherche par ISBN</p>
                    <label for="isbn">ISBN : </label><input type="text" name="isbn" id="isbn">
                    <input type="button" value="Rechercher" id="btnISBN">
                    <div id="cont"></div>
                    <input type="button" value="<-" onclick="bascule()">
                </div>
            </div>
        </div>
    </main>
    <script src="scripts/livres.js"></script>