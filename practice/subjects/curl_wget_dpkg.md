## 🏋️‍♂️ Exercices Pratiques

Pour bien ancrer ces notions, ouvre ton terminal et réalise ces trois missions.

### Mission 1 : L'espion (Curl)
1.  Utilise `curl` pour récupérer **uniquement les en-têtes** (headers) du site `www.google.com`.
2.  Essaie de faire la même chose avec `http://google.com` (sans le www) :
    * Une fois sans option spécifique.
    * Une fois avec l'option qui permet de suivre la redirection.
    * *Observe bien la différence de code HTTP (la première ligne du résultat).*

### Mission 2 : Le téléchargeur (Wget)
1.  Trouve une image sur internet (par exemple le logo de 42 ou Google).
2.  Télécharge-la avec `wget` en obligeant le fichier de sortie à s'appeler `mon_image_test.jpg`.

### Mission 3 : L'archéologue (Dpkg)
1.  Utilise `dpkg` pour lister tous les paquets. Combine cette commande avec un **pipe** `|` et `wc` pour compter combien de paquets sont installés sur ta machine.
2.  Utilise `dpkg` pour découvrir quel paquet précis a installé la commande `/bin/cat`.

<br>

<br>

---

<br>

<br>

### ✅ Correction des exercices


#### Correction Mission 1
1.  `curl -I https://www.google.com`
    * *Le flag `-I` (i majuscule) affiche les Headers.*
2.  Comparaison :
    * `curl -I http://google.com` -> Affiche **HTTP/1.1 301 Moved Permanently**. (Le serveur te dit : "Je ne suis pas là, va voir ailleurs").
    * `curl -I -L http://google.com` -> Affiche **HTTP/1.1 200 OK**. (Le flag `-L` a suivi la redirection vers www.google.com).

#### Correction Mission 2
* `wget -O mon_image_test.jpg https://upload.wikimedia.org/wikipedia/commons/8/8d/42_Logo.svg`
    * *Le flag `-O` (O majuscule) permet de définir le nom du fichier de sortie (Output).*

#### Correction Mission 3
1.  `dpkg -l | wc -l`
    * *Note : Cela compte aussi les quelques lignes d'en-tête du tableau, mais c'est une bonne estimation.*
    * *Version puriste : `dpkg -l | grep "^ii" | wc -l` (compte uniquement les paquets installés).*
2.  `dpkg -S /bin/cat`
    * *Réponse : `coreutils` (C'est le paquet qui contient les utilitaires de base du système).*