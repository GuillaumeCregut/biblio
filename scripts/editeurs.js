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
        xhr.open("POST", "ajax/ajax_editeurs.php", true); //on appelle la page avec la méthode post en asychrone
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send("SearchedText=" + searchedText); //ID post sera le $_POST[''] et ValuePost sa valeur
    } else {
        let divAuteur = document.getElementById('liste_aut');
        purgeDiv(divAuteur);
    }
}
//Affectation des évenements
let textSearch = document.getElementById('chercheur');
textSearch.addEventListener('keyup', chercheBase);

let formAddAuteur = document.forms[0];
formAddAuteur.addEventListener('submit', function(event) {
    let nomAuteur = document.getElementById('nom').value;
    if (nomAuteur == '') {
        event.preventDefault();
        alert('Veuillez remplir tous les éléments !');
    }
});