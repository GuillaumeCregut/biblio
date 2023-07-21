var Id = 1;
var titreISBN = '';
//Ajax
function getXhr() {
    var xhr = null;
    if (window.XMLHttpRequest) // Firefox et autres
        xhr = new XMLHttpRequest();
    else if (window.ActiveXObject) { // Internet Explorer 
        try {
            xhr = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            xhr = new ActiveXObject("Microsoft.XMLHTTP");
        }
    } else { // XMLHttpRequest non supporté par le navigateur 
        alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest...");
        xhr = false;
    }
    return xhr;
}

function purgeDiv(leDiv) {
    while (leDiv.hasChildNodes()) {
        leDiv.removeChild(leDiv.firstChild);
    }
}

function chercheBase() {
    let searchedText = document.getElementById('chercheur').value;
    var xhr = getXhr();
    xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                //Fonction de traitement de l'information
                //On utilise xhr.responseText
                reponse = xhr.responseText;
                //Purge du div
                let divAuteur = document.getElementById('liste_aut');
                purgeDiv(divAuteur);
                //On traduit le json
                tabRetour = JSON.parse(reponse);
                //a continuer
                for (i = 0; i < tabRetour.length; i++) {
                    Resultat = tabRetour[i];
                    let paraph = document.createElement('p');
                    let texte = document.createTextNode(Resultat);
                    paraph.appendChild(texte);
                    divAuteur.appendChild(paraph);
                    //console.log(Resultat);
                }
                if (tabRetour.length == 0) {
                    let paraph = document.createElement('p');
                    let texte = document.createTextNode('Aucun résultat');
                    paraph.appendChild(texte);
                    divAuteur.appendChild(paraph);
                }
                //fin
            }
        }
        //On envoie la requete
    if (searchedText != '') {
        xhr.open("POST", "ajax/ajax_livres.php", true); //on appelle la page avec la méthode post en asychrone
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send("SearchedText=" + searchedText); //ID post sera le $_POST[''] et ValuePost sa valeur
    } else {
        let divAuteur = document.getElementById('liste_aut');
        purgeDiv(divAuteur);
    }
}
//Bascule les infos dans la colonne nouveau
function bascule() {
    let champTitre = document.getElementById('titre');
    champTitre.value = titreISBN;
}
//Recherche ISBN sur l'API google
function chercheISBN() {
    var xhr = getXhr();
    xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                //Fonction de traitement de l'information
                //On utilise xhr.responseText
                reponse = xhr.responseText;
                //Purge du div
                let divAuteur = document.getElementById('cont');
                purgeDiv(divAuteur);
                //On traduit le json
                tabRetour = JSON.parse(reponse);
                let item = tabRetour.items[0].volumeInfo;
                let publisher = item.publisher;
                if (publisher === undefined) {
                    publisher = '-';
                }
                let paraphPublisher = document.createElement('p');
                let textePublisher = document.createTextNode('Editeur : ' + publisher);
                paraphPublisher.appendChild(textePublisher);
                titreISBN = item.title;
                let paraph = document.createElement('p');
                let texte = document.createTextNode('Titre : ' + titreISBN);
                paraph.appendChild(texte);
                divAuteur.appendChild(paraph);
                let auteurs = item.authors;
                for (i = 0; i < auteurs.length; i++) {
                    let paraph = document.createElement('p');
                    let texte = document.createTextNode('Auteur : ' + auteurs[i]);
                    paraph.appendChild(texte);
                    divAuteur.appendChild(paraph);
                }
                divAuteur.appendChild(paraphPublisher);
                let texteDescription = item.description;
                if (texteDescription === undefined) {
                    texteDescription = '-';
                }
                let paraphDesc = document.createElement('p');
                paraphDesc.appendChild(document.createTextNode('Description : '));
                paraphDesc.appendChild(document.createElement('br'));
                paraphDesc.appendChild(document.createTextNode(texteDescription));
                divAuteur.appendChild(paraphDesc);
                //fin
            }
        }
        //On envoie la requete
    let lIsbn = document.getElementById('isbn').value;
    //let Requete = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + lIsbn;
    let Requete = "tempo.php";
    xhr.open("GET", Requete, true); //on appelle la page avec la méthode post en asychrone
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.send(); //ID post sera le $_POST[''] et ValuePost sa valeur
}
//Ajoute l'auteur et mets à jour les champs auteur
function addAndUpdateAuteur() {
    //Récupère les champs nom et prenom
    let newNom = document.getElementById('nomAuteur').value;
    let newPrenom = document.getElementById('prenomAuteur').value;
    if ((newNom != '') & (newPrenom != '')) {
        //Envoie la requete ajax
        var xhr = getXhr();
        xhr.onreadystatechange = function() {
            //Récupère les données ajax
            if (xhr.readyState == 4 && xhr.status == 200) {
                let reponse = xhr.responseText;
                let tabRetour = JSON.parse(reponse);
                Resultat = tabRetour[0].Retour;
                if (Resultat > 0) {
                    //Ajoute l'option aux champs
                    let champAuteur = document.getElementsByClassName('selectAuteur');
                    let nom = "Germain toto";
                    for (i = 0; i < champAuteur.length; i++) {
                        let newOption = document.createElement('option');
                        newOption.value = Resultat;
                        newOption.innerHTML = newNom + ' ' + newPrenom;
                        champAuteur[i].appendChild(newOption);
                    }
                }
            }
        }
        xhr.open("POST", "ajax/ajax_add_auteur.php", true); //on appelle la page avec la méthode post en asychrone
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send('nom=' + newNom + '&prenom=' + newPrenom);
    }

}
//Ajoute un champ auteur au formulaire
function addChampAuteur() {
    //récupération du select
    let leSelectSource = document.getElementById('auteur');
    let leNewSelect = leSelectSource.cloneNode(true);
    let IdNew = leSelectSource.id + Id;
    let parapNew = document.createElement('p');
    parapNew.appendChild(leNewSelect);
    Id++;
    leNewSelect.setAttribute('id', IdNew);
    //Récupération du formulaire
    let leFormulaire = document.forms[0];
    //Récupération du champ "frontière"
    let lastField = document.getElementById('editeur').parentNode;
    leFormulaire.insertBefore(parapNew, lastField);
}

function showAuteur() {
    let divDisplay = document.getElementById('divAddAuteur');
    divDisplay.classList.toggle('visible');
    divDisplay.classList.toggle('invisible');
}
//Affectation des évenements
let textSearch = document.getElementById('chercheur');
textSearch.addEventListener('keyup', chercheBase);

let formAddAuteur = document.forms[0];
formAddAuteur.addEventListener('submit', function(event) {
    let titreLivre = document.getElementById('titre').value;
    let Editeur = document.getElementById('editeur').value;
    let stockage = document.getElementById('stockage').value;
    let Auteurs = document.getElementsByClassName('selectAuteur')[0].value;
    if ((Auteurs == 0) | (titreLivre == '') | (Editeur == 0) | (stockage == 0)) {
        event.preventDefault();
        alert('Veuillez remplir tous les éléments !');
    }
});
//Bouton de recherche ISBN
let BtnIsbn = document.getElementById('btnISBN');
BtnIsbn.addEventListener('click', chercheISBN);
//Bouton d'ajout de champs auteur
let addAuteur = document.getElementById('btnAddAuteur');
addAuteur.addEventListener('click', addChampAuteur);
//Affichage du volet ajout d'auteur
let showBtn = document.getElementById('showAuteurBtn');
showBtn.addEventListener('click', showAuteur);
//envoi du nouvel auteur
let addAutBtn = document.getElementById('addAuteurBtn');
addAutBtn.addEventListener('click', addAndUpdateAuteur);