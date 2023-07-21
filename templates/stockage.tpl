<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/general.css">
    <link rel="stylesheet" href="styles/stockage.css">

    <title>Gestion des stockages</title>
</head>

<body>

    <head>
        <div class="conteneur">
            <h1>Gestion des stockages</h1>
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
            <p>Liste des stockages présents : </p>
            <input type="search" name="chercheur" id="chercheur" placeholder="saisissez le nom">
            <div id="liste_aut"></div>
            <section class="SectionAjout">
                <!-- Affichage du forumulaire ajout auteur-->
                <p>Ajouter une étagère</p>
                <form action="stockage.php" method="post">
                    <p><label for="nom">Référence étagère : </label><input type="text" name="nom" id="nom"></p>
                    <p><input type="submit" value="Ajouter"></p>
                </form>
            </section>
        </div>
    </main>
    <script src="scripts/stockage.js"></script>