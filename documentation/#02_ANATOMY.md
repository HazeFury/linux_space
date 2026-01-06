# Module 2 : L'Anatomie du Système

Si le Module 1 était l'histoire de la construction de la maison, ce module est la visite des pièces et de la plomberie. C'est ici que l'on comprend pourquoi on ne range pas les fichiers n'importe où.

## 1. Le FHS (Filesystem Hierarchy Standard)

Contrairement à Windows (`C:\`, `D:\`), Linux utilise une arborescence unique qui part de la **Racine** (`/`). Tout périphérique (Disque dur, Clé USB) est "monté" (accroché) quelque part dans cet arbre.

Voici les dossiers vitaux à connaître (notamment pour l'examen Born2beRoot) :

| Dossier | Signification | Rôle et Contenu |
| :--- | :--- | :--- |
| **`/`** | **Root** | Le point de départ unique. |
| **`/bin`** | **Binaries** | Les commandes essentielles pour tous les utilisateurs (ls, cp, cat, bash). |
| **`/sbin`** | **System Binaries** | Les commandes d'administration réservées à root (`reboot`, `fdisk`, `iptables`). |
| **`/etc`** | **Et cetera** | **CRUCIAL.** Contient **tous** les fichiers de configuration du système et des logiciels. |
| **`/home`** | **Home** | Les dossiers personnels des utilisateurs (ex: `/home/hazefury`). C'est généralement le seul endroit où un utilisateur standard peut écrire. |
| **`/root`** | **Root's Home** | Le dossier personnel du super-utilisateur. Accessible uniquement par root. |
| **`/var`** | **Variable** | Contient les données qui changent souvent : les **logs** (`/var/log`), les sites web, les mails, les bases de données. |
| **`/usr`** | **Unix System Resources** | Contient les logiciels et bibliothèques installés par la suite (non-essentiels au boot minimal). C'est l'équivalent du "Program Files". |
| **`/tmp`** | **Temporary** | Fichiers temporaires. Son contenu est effacé à chaque redémarrage. |
| **`/dev`** | **Devices** | Contient les fichiers représentant le matériel (disques durs, terminaux, etc.). |

> **💡 Astuce mémotechnique :**
> * Tu veux lancer un programme ? -> `/bin`
> * Tu veux configurer un truc ? -> `/etc`
> * Tu veux voir pourquoi ça a planté ? -> `/var/log`

## 2. Le concept "Tout est fichier" (*Everything is a file*)

C'est le dogme central d'UNIX. Cela signifie que le noyau Linux traite la plupart des ressources (matériel, processus, communication) comme des fichiers texte.

**Le clavier :** C'est un fichier en lecture seule. (Quand tu tapes, tu écris dans le fichier).

**L'écran :** C'est un fichier en écriture. (Le système écrit des pixels dedans).

**Un disque dur :**  C'est un gros fichier dans /dev/sda.

Pourquoi c'est génial ? Parce qu'on peut utiliser les MÊMES outils pour tout ! Tu veux copier tout le contenu de ton disque dur vers une image de sauvegarde ? Pas besoin d'un logiciel spécial. Tu utilises la commande de copie `cp` ou `dd` (Data Duplicator) : `dd if=/dev/sda of=/home/marco/backup.img` *(Traduction : Copie le fichier "Disque Dur" vers le fichier "backup.img")*.


## 3. Chemins Absolus vs Relatifs

Deux manières de naviguer dans l'arborescence :

1.  **Chemin Absolu :** L'adresse complète depuis la racine. Commence toujours par `/`.
    * *Exemple :* `/home/hazefury/projets/born2beroot`
    * *Avantage :* Fonctionne peu importe le dossier actuel.
2.  **Chemin Relatif :** Le chemin par rapport à la position actuelle. Ne commence pas par `/`.
    * *Exemple :* `projets/born2beroot` (si on est déjà dans `/home/hazefury`).
    * **`.`** (point) : Désigne le dossier actuel.
    * **`..`** (point point) : Désigne le dossier parent.


## 4. Les Inodes (L'ADN du fichier)

Quand un fichier est créé (ex: `toto.txt`), le système sépare deux informations :
1.  **Le Nom :** Stocké dans le répertoire.
2.  **L'Inode (Index Node) :** Une fiche d'identité (numéro unique) contenant les métadonnées :
    * Propriétaire, permissions, taille.
    * **L'emplacement physique des données sur le disque.**

Cela permet de créer différents types de liens :

* **Hard Link (Lien Dur) :**
    * Crée un second nom pointant vers le **même inode**.
    * Si on supprime le fichier original, les données restent accessibles via le lien dur.
* **Soft Link / Symbolic Link (Lien Symbolique) :**
    * Crée un raccourci qui pointe vers le **chemin** de l'autre fichier.
    * Si on supprime le fichier original, le lien est cassé (il pointe dans le vide).

=> [Focus sur les hard links / soft links](./#09_FOCUS.md)