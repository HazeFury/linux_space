# Exercice pratique

## GREP / SED / AWK

À partir du fichier `server.log`, trouve les commandes correspondantes à ce qui est demandé dans chaque exercice.
**=> La correction se trouve à la fin.**

### Partie 1 : GREP

1. Trouver les erreurs : Affiche toutes les lignes où le code statut est 500 (Erreur serveur) ou 404 (Non trouvé).

2. La sécurité avant tout : Affiche les tentatives d'accès par l'utilisateur "hacker" ou "admin".

3. Nettoyage : Affiche tout le contenu du fichier, mais sans les lignes de commentaires (celles qui commencent par #).

### Partie 2 : AWK

1. Lister les IPs : Affiche uniquement la première colonne (les adresses IP) de tout le fichier.

2. Surveillance : Affiche uniquement les lignes où la taille de la réponse (la dernière colonne) est supérieure à 5000 octets (gros téléchargements). Indice : $NF désigne la dernière colonne.

3. Extraction précise : Affiche uniquement le nom de l'utilisateur (3ème colonne) et la page demandée (7ème colonne) pour chaque ligne.

### Partie 3 : SED

1. Anonymisation : Remplace toutes les occurrences de "marco" par "USER_1". (Affiche juste le résultat à l'écran).

2. Suppression ciblée : Supprime toutes les lignes vides ou les lignes de commentaires.

### Partie 4 : Le BOSS FINAL (Combo Pipe |)

1. Le rapport d'incident : Je veux la liste des IPs uniques qui ont provoqué une erreur (code 500 ou 403 ou 404), triée proprement.

<br>

<br>

---

<br>


<br>


💡 Les Solutions (Cache-les si tu veux chercher !)

*N'oublie pas : il y a souvent plusieurs façons d'arriver au même résultat sous Linux.*

**Solution 1** (Erreurs 500/404)

	grep -E "500|404" server.log

**Solution 2** (Hacker/Admin)

	grep -E "hacker|admin" server.log

**Solution 3** (Pas de commentaires)

	grep -v "^#" server.log

*^# veut dire : "qui commence par "*

**Solution 4** (Juste les IPs)

	awk '{print $1}' server.log

**Solution 5** (Gros fichiers > 5000)

	awk '$NF > 5000' server.log

*Note : Cela va aussi afficher les commentaires car awk essaie d'interpréter le texte comme un nombre, ce qui peut donner des résultats bizarres sur les lignes de texte pur.
Version pro pour filtrer les lignes de log seulement :*

	grep "GET\|POST" server.log | awk '$NF > 5000'

**Solution 6** (User + Page)

	awk '{print $3, $7}' server.log

**Solution 7** (Anonymisation Marco)

	sed 's/marco/USER_1/g' server.log

**Solution 8** (Suppression vide et commentaires avec Sed)

	sed '/^#/d; /^$/d' server.log

*Explication : /^#/d supprime les commentaires, /^$/d supprime les lignes vides. Le point-virgule sépare les deux ordres.*

**Solution 9** (BOSS FINAL)

	grep -E "500|403|404" server.log | awk '{print $1}' | sort | uniq

1. On filtre les erreurs
2. On prend juste l'IP
3. On trie (nécessaire pour uniq)
4. On dédoublonne