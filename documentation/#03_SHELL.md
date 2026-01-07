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

## Point culture 

L'abréviation `TTY` vient de `T`ele`TY`pewriter (Téléscripteur). À l'époque des dinosaures de l'informatique (années 60-70), les utilisateurs n'avaient pas d'écran. Ils tapaient sur des machines à écrire électromécaniques reliées à l'ordinateur central par un câble. Ce qu'ils tapaient était envoyé au serveur, et la réponse du serveur s'imprimait sur du papier. C'était ça, un TTY physique.

**Aujourd'hui sous Linux** : Le terme est resté pour désigner un terminal virtuel. C'est l'interface texte qui permet de dialoguer avec le système.

**Les TTYs physiques (Virtuels)** : Sur ta VM Debian, si tu fais `Ctrl + Alt + F1` (ou F2, F3...), tu changes d'écran noir. Ce sont les différents terminaux disponibles directement connectés au noyau.

**Les Pseudo-TTYs (PTS)** : Quand tu ouvres une fenêtre de terminal dans une interface graphique (comme iTerm, VS Code ou GNOME Terminal), ou quand tu te connectes en SSH, tu utilises un "Pseudo-Terminal" (pts). C'est un terminal émulé par un logiciel.

La commande `tty` : Si tu tapes cette commande dans ton terminal, elle te dira exactement où tu es connecté (ex: `/dev/tty1` si tu es sur la console principale, ou `/dev/pts/0` si tu es en SSH).