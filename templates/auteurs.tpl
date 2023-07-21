<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/auteurs.css">
    <link rel="stylesheet" href="styles/general.css">
    <title>Gestion des auteurs</title>
</head>

<body>

    <head>
        <div class="conteneur">
            <h1>Gestion des auteurs</h1>
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
            <!-- Affichage des auteurs en liste : faire du pro active -->
            <p>Liste des auteurs présents : </p>
            <input type="search" name="chercheur" id="chercheur" placeholder="saisissez le nom ou le prenom">
            <div id="liste_aut"></div>
            <section class="SectionAjout">
                <!-- Affichage du forumulaire ajout auteur-->
                <p>Ajouter un auteur</p>
                <form action="auteurs.php" method="post">
                    <p><label for="prenom">Prénom de l'auteur : </label><input type="text" name="prenom" id="prenom"></p>
                    <p><label for="nom">Nom de l'auteur : </label><input type="text" name="nom" id="nom"></p>
                    <p><input type="submit" value="Ajouter"></p>
                </form>
            </section>
        </div>
    </main>
    <script src="scripts/auteurs.js"></script>