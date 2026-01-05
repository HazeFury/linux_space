# Module 3 : L'Art du Shell et la Manipulation de Texte

Si le Kernel est le moteur, le Shell est le volant et le levier de vitesse. Mais sous Linux, ce levier permet de faire des choses impossibles avec une interface graphique.

## 1. L'Environnement Shell

Quand tu ouvres un terminal, tu entres dans une "session". Cette session possède une mémoire : ce sont les **Variables d'Environnement**. Ce sont des post-it que le système garde en mémoire pour savoir comment se comporter.

### Les variables clés à connaître
Pour voir toutes les variables actuelles, tape la commande `env`.

* **`HOME`** : Le chemin vers ton dossier personnel (`/home/marco`).
* **`USER`** : Ton nom d'utilisateur.
* **`PWD`** : (Print Working Directory) Où tu es actuellement.
* **`PATH`** : **La plus importante.** C'est une liste de dossiers séparés par des `:`.
    * *Le concept :* Quand tu tapes une commande (ex: `ls`), le shell ne sait pas où est le programme `ls`. Il va chercher dans le premier dossier du `PATH`, puis le 2ème, etc.
    * *Le piège classique :* Si tu crées un script dans ton dossier actuel, tu dois taper `./mon_script` et pas juste `mon_script`. Pourquoi ? Parce que le dossier actuel (`.`) n'est pas dans le `PATH` par défaut pour des raisons de sécurité.

### La Configuration (`.bashrc` / `.zshrc`)
Ces fichiers (cachés dans ton HOME) sont des scripts qui s'exécutent **automatiquement** à chaque fois que tu ouvres un terminal.
* C'est là qu'on crée des **alias** (raccourcis).
* *Exemple :* `alias ll='ls -l'`
* C'est là qu'on personnalise le prompt (la ligne de commande colorée).

## 2. Les 3 Flux (Streams)

Sous Linux, chaque programme est une usine : on y fait entrer de la matière première, et il en ressort un produit fini (et parfois des déchets).

Ces "tuyaux" ont des numéros standardisés :

1.  **STDIN (0) - Standard Input :** L'entrée. Par défaut, c'est ton **clavier**.
2.  **STDOUT (1) - Standard Output :** La sortie normale. Par défaut, c'est ton **écran**.
3.  **STDERR (2) - Standard Error :** La sortie des erreurs. Par défaut, c'est aussi ton **écran** (mais c'est un canal séparé !).

## 3. Redirections et Pipelines (La Plomberie)

C'est ici que réside la vraie puissance de Linux. On peut débrancher ces tuyaux pour les brancher ailleurs.

### Les Redirections (`>`, `>>`, `<`)
On redirige la sortie vers un **fichier** au lieu de l'écran.

* **`>` (Écraser) :**
    
    echo "Coucou" > fichier.txt
    
    *Crée le fichier (ou le vide s'il existe) et écrit dedans.*

* **`>>` (Ajouter) :**
    
    echo "Une autre ligne" >> fichier.txt
    
    *Ajoute à la fin du fichier sans effacer le reste.*

* **`2>` (Rediriger les erreurs) :**
    Très utile pour masquer les erreurs ou les logger à part.
    
    ls dossier_inexistant 2> erreurs.log
    
    *L'écran reste vide, le message d'erreur est dans le fichier.*

* **L'astuce du trou noir (`/dev/null`) :**
    Si tu veux exécuter une commande sans rien voir (ni résultat, ni erreur) :
    
    commande_bruyante > /dev/null 2>&1

### Le Pipe (`|`)
C'est le symbole de la barre verticale (Alt Gr + 6 sur PC, Shift + L sur Mac).
**Il connecte le STDOUT de la commande de gauche au STDIN de la commande de droite.**
C'est comme une course de relais.

    commande1 | commande2 | commande3

*Exemple concret :*
Je veux lister tous les fichiers, mais il y en a trop, je veux pouvoir scroller.

```bash
ls -la /etc | less
```

*(La sortie de `ls` n'est pas affichée, elle est envoyée à `less` qui l'affiche page par page).*

## 4. La Boîte à Outils de manipulation de texte

Pour Born2beRoot (surtout pour le script de monitoring), tu vas devoir extraire des infos précises (ex: "Combien de RAM est utilisée ?"). Tu ne peux pas juste afficher tout le texte, il faut le filtrer.

### `grep` (Global Regular Expression Print)
Sert à **trouver** des lignes qui contiennent un mot clé.
```bash
# Cherche "marco" dans le fichier /etc/passwd
grep "marco" /etc/passwd
```
### `wc` (Word Count)
Sert à **compter**.
```bash
wc -l fichier.txt

# L'option `-l` compte les Lignes (Lines).
```
### `head` et `tail`
Affiche le **début** ou la **fin** d'un fichier.
    
```bash	
# Affiche les 5 dernières lignes des logs système
tail -n 5 /var/log/syslog
```

### `cut`
Sert à découper une ligne en colonnes (très utile pour les fichiers CSV ou les logs).
    
```bash
# Coupe et garde seulement le 1er champ (délimité par :)
cut -d ":" -f 1 /etc/passwd
```
---

### 🎓 L'Exercice Combo (Pipeline)

Essaie de décrypter ce que fait cette commande (c'est le genre de logique qu'on attend à 42) :

```bash
ls -la /etc | grep ".conf" | wc -l
```

1.  `ls -la /etc` : Liste tous les fichiers de config.
2.  `|` : Envoie le résultat au suivant.
3.  `grep ".conf"` : Ne garde que les lignes qui contiennent ".conf".
4.  `|` : Envoie le résultat au suivant.
5.  `wc -l` : Compte le nombre de lignes restantes.

**Résultat :** Cette commande te donne le nombre exact de fichiers de configuration dans `/etc`.

<br>

# (Bonus) : La Sainte Trinité (Grep, Sed, Awk)

Dans le monde UNIX, traiter du texte est une religion. Nous avons trois divinités pour cela.

1.  **Grep** : Pour **Trouver** (Filtre).
2.  **Sed** : Pour **Modifier** (Éditeur).
3.  **Awk** : Pour **Analyser** et restructurer (Tableur).

---

## 1. GREP (Global Regular Expression Print)

Son job est simple : tu lui donnes du texte, il ne garde que les lignes qui correspondent à ta recherche.

### Syntaxe de base
    grep "recherche" fichier

### Les options vitales
* `-i` (**Insensitive**) : Ignore les majuscules/minuscules.
* `-v` (**Invert**) : Affiche tout SAUF ce que tu cherches (très utile pour filtrer).
* `-r` (**Recursive**) : Cherche dans tous les fichiers d'un dossier et de ses sous-dossiers.
* `-E` (**Extended**) : Permet d'utiliser des expressions régulières complexes (Regex).

### Exemples concrets
* **Chercher si l'utilisateur "marco" existe :**
```bash
grep "marco" /etc/passwd
```
* **Chercher "Error" dans les logs sans se soucier de la casse (error, ERROR...) :**

```bash    
grep -i "error" /var/log/syslog
```
* **Lister tous les processus SAUF ceux de root :**

```bash    
ps aux | grep -v "root"
```
---

## 2. SED (Stream EDitor)

Sed est un éditeur de texte destructif qui travaille ligne par ligne. Il ne "voit" pas le fichier entier, il voit un flux. Il est surtout utilisé pour faire des **Remplacements** automatiques.

### Syntaxe de base (Substitution)
La formule magique est `s/chercher/remplacer/`.

    sed 's/ancien/nouveau/' fichier

### Les subtilités
* Par défaut, sed affiche le résultat à l'écran mais **ne modifie pas** le fichier original.
* L'option `-i` (In-place) permet de modifier le fichier réellement (**Attention !**).
* Le flag `g` à la fin (`s///g`) signifie "Global". Sans lui, sed ne remplace que la première occurrence de chaque ligne.

### Exemples concrets
* **Remplacer "toto" par "tata" dans un flux (affichage seulement) :**

```bash    
echo "toto va à la plage" | sed 's/toto/tata/'
# Résultat : tata va à la plage
```
* **Supprimer des lignes (option `d`) :**
    Imagine tu veux lister les fichiers mais supprimer la première ligne (le total) :

```bash    
ls -l | sed '1d'
```
* **Supprimer les lignes vides d'un fichier :**

```bash    
sed '/^$/d' fichier.txt
# (^$ signifie : début de ligne collé à fin de ligne, donc vide)
```
---

## 3. AWK (Aho, Weinberger, Kernighan)

C'est le plus puissant des trois. En fait, `awk` est un véritable langage de programmation.
Il voit le texte comme un **tableau Excel** : des lignes et des colonnes.

* Chaque ligne est un **Record** (`NR` = Number of Records).
* Chaque mot est un **Champ** (Field) séparé par des espaces (par défaut).
* Les variables : `$1` (1ère colonne), `$2` (2ème colonne), `$0` (toute la ligne).

### Syntaxe de base
    awk '{print $1}' fichier

### L'option clé : le Séparateur (`-F`)
Par défaut, awk coupe aux espaces. Mais `/etc/passwd` utilise des deux-points `:`. On doit lui dire.

### Exemples concrets

* **Récupérer juste le nom des utilisateurs (1ère colonne de /etc/passwd) :**
```bash
awk -F ":" '{print $1}' /etc/passwd
```
* **Cas d'usage Monitoring : Récupérer la RAM utilisée**

    La commande `free -m` affiche ça :
```bash
                 total        used        free
    Mem:           7900         500        7400
```
Tu veux extraire juste le "500". C'est la 2ème ligne, 3ème colonne.
```bash
    free -m | awk 'NR==2 {print $3}'
    
    # Explication :
    # NR==2 : Travaille uniquement sur la ligne numéro 2
    # {print $3} : Affiche la 3ème colonne
```

* **Faire des conditions :**
    Afficher les processus qui utilisent plus de 50% de CPU (colonne 3 de `ps aux`).
```bash
ps aux | awk '$3 > 50.0 {print $0}'
```

---

## 🎯 Le Combo Ultime (Pipeline)

La vraie puissance de Linux, c'est de combiner les trois.

**Mission :** Trouver le PID (Process ID) du service `ssh`, mais sans récupérer la ligne de la commande `grep` elle-même (un problème classique).

```bash
ps aux | grep "sshd" | grep -v "grep" | awk '{print $2}'
```

1.  `ps aux` : Liste tout.
2.  `grep "sshd"` : Garde les lignes SSH.
3.  `grep -v "grep"` : Enlève la ligne de ta propre recherche.
4.  `awk '{print $2}'` : Affiche seulement la 2ème colonne (le PID).

Tu viens d'isoler une donnée pure à partir d'un flux d'informations complexe. C'est ça, l'administration système.
