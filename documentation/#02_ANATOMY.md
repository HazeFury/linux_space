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






## 4.1 Focus : Hard Links vs Soft Links (Exemple)

Pour comprendre les liens, il faut revenir au concept d'**Inode**.
Sous Linux, un nom de fichier n'est qu'une étiquette collée sur un conteneur de données (l'Inode).

### 1. Le Hard Link (Lien Physique)

C'est l'association directe entre un **nom de fichier** et un **Inode**.
Par défaut, chaque fichier a au moins 1 hard link (son propre nom). Créer un hard link, c'est ajouter un deuxième nom pour le **même** inode.

### 🧠 L'analogie
Imagine une maison (les données).
* Cette maison a une adresse principale (le fichier original).
* Le Hard Link, c'est comme si tu installais une **deuxième porte d'entrée** à l'arrière de la maison avec une autre adresse.
* Si tu détruis la porte principale, la maison existe toujours et tu peux toujours entrer par la porte arrière.

### 🛠️ En pratique
La commande est `ln` (Link).

1. **Créons un fichier et regardons son Inode :**
   ```bash
   echo "Bonjour 42" > original.txt
   ls -i original.txt
    # Résultat : 123456 original.txt  (123456 est l'Inode)
   ```
2. **Créons un Hard Link :**
	```bash
	ln original.txt dur.txt
	ls -li
	# Résultat 	:
	# 123456 -rw-r--r-- 2 hazefury hazefury 11 ... dur.tx	t
	# 123456 -rw-r--r-- 2 hazefury hazefury 11 ... original.txt
	```
	- **Observation 1** : Ils ont le MÊME numéro d'Inode (123456). Ce sont physiquement les mêmes données sur le disque.
	- **Observation 2** : Le chiffre 2 (juste après les droits -rw-r--r--) indique le nombre de hard links. Il y a deux noms qui pointent vers ces données.

	Supprimons l'original :
	```bash
	rm original.txt
	cat dur.txt
	# Résultat : "Bonjour 42"
	```

	Les données sont toujours là ! Le système ne supprime réellement les données du disque que lorsque le compteur de liens tombe à 0.

	<br>

> ⚠️ Les limites du Hard Link <br> - Impossible de faire un hard link vers un dossier (pour éviter des boucles infinies dans l'arborescence). <br> - Impossible de faire un hard link entre deux partitions différentes (car les numéros d'inodes sont propres à chaque partition).



## 2. Le Soft Link (Lien Symbolique)

C'est un fichier spécial qui contient le chemin vers un autre fichier. C'est un simple raccourci.

**🧠 L'analogie**

Toujours la même maison.

- Le Soft Link, c'est un panneau indicateur au bout de la rue qui dit "La maison est au 12 rue des Peupliers".

- Si tu détruis la maison (le fichier original), le panneau existe toujours, mais il pointe vers un terrain vague (lien cassé).

**🛠️ En pratique**

La commande est `ln` avec l'option `-s` (Symbolic).

1. Créons un fichier :
	```bash
	echo "Salut Linux" > source.txt
	ls -i source.txt
	# Résultat : 987654 source.txt
	``` 
2. Créons un Soft Link et vérifions :
	```bash
	ln -s source.txt mou.txt
	ls -li
	# Résultat :
	# 111222 lrwxrwxrwx 1 marco marco 10 ... mou.txt -> source.txt
	# 987654 -rw-r--r-- 1 marco marco 12 ... source.txt
	```
	- **Observation 1** : Ils ont des Inodes DIFFÉRENTS. mou.txt est un fichier à part entière.
	- **Observation 2** : La taille de mou.txt est minuscule (10 octets), car il ne contient que le texte "source.txt".
	- **Observation 3** : Le type de fichier est `l` (link) au début de la ligne `(lrwxrwxrwx)`.
	- **Observation 4** : Une flèche -> indique la cible.
	
3. Supprimons l'original :
	```bash
	rm source.txt
	cat mou.txt
	# Résultat : "No such file or directory"
	```
	Le lien est cassé (souvent affiché en rouge dans le terminal). Il pointe vers quelque chose qui n'existe plus.
	
✅ Les avantages du Soft Link
- Peut pointer vers des dossiers.
- Peut traverser les systèmes de fichiers (tu peux faire un lien sur ton bureau vers un fichier situé sur une clé USB).

### 🆚 Résumé :

| Caractéristique | Hard Link | Soft Link (Symbolic) |
| :--- | :--- | :--- |
| Commande | `ln cible lien` | `ln -s cible lien` | 
|Inode | Identique à la cible | Différent (nouveau fichier) |
| Si cible supprimée | Données toujours accessibles | Lien cassé (inutilisable) |
| Taille | Taille du fichier original | Minuscule (taille du chemin) |
| Vitesse | Accès immédiat | Infime délai (résolution du chemin) | 
| Vers un dossier | ❌ Non | ✅ Oui |
| Entre partitions | ❌ Non | ✅ Oui |


<br>

<br>

## 5. Cas d'usage : Pourquoi et quand utiliser les Liens ?

Savoir créer des liens est une chose, savoir **quand** les utiliser en est une autre. Voici les cas concrets que l'on rencontre le plus souvent dans la vie d'un développeur ou d'un administrateur système.

### 1. Les Liens Symboliques (Soft Links) : Flexibilité et Organisation

On utilise les liens symboliques dans 95% des cas. Ils servent principalement de **raccourcis** intelligents.

### Cas A : Rendre un programme accessible partout (Le `PATH`)
* **Le problème :** Tu installes un logiciel manuellement dans un dossier spécifique, par exemple `/opt/mon_super_logiciel/bin/app.sh`. Pour le lancer, tu dois taper tout ce chemin, ce qui est pénible.
* **La solution :** Tu crées un lien symbolique vers un dossier standard du système (comme `/usr/local/bin`) qui est déjà connu par le terminal (variable `$PATH`).

	```bash
    # On crée un raccourci dans le dossier des exécutables système
    sudo ln -s /opt/mon_super_logiciel/bin/app.sh /usr/local/bin/super_app
    # Maintenant, tu peux juste taper "super_app" n'importe où !
    ```

### Cas B : Gérer les mises à jour sans douleur (Le lien "Current")
C'est une pratique standard en déploiement Web/DevOps.
* **Le contexte :** Tu as plusieurs versions de ton projet sur le serveur :
    * `/var/www/projet-v1.0`
    * `/var/www/projet-v1.1`
* **L'astuce :** Ton serveur web (Nginx/Apache) est configuré pour lire un dossier nommé `/var/www/current`. Ce dossier est en fait un lien symbolique.
* **Le déploiement :**
    1. Tu uploads la v1.2.
    2. Tu changes le lien symbolique pour qu'il pointe vers la v1.2.
    3. Le changement est instantané.
    4. **Rollback :** Si la v1.2 plante, tu changes le lien pour repointer vers la v1.1 en une seconde.

### Cas C : Activer/Désactiver des configurations
Sur Debian (et Ubuntu), c'est ainsi que fonctionnent les serveurs comme Nginx ou Apache.
Ils ont deux dossiers :
* `sites-available` : Stocke tous les fichiers de config possibles.
* `sites-enabled` : Stocke uniquement les liens symboliques vers les sites qu'on veut activer.
* **Intérêt :** Pour désactiver un site, on supprime le lien (le fichier original reste en sécurité). Pour le réactiver, on recrée le lien.

---

### 2. Les Hard Links : Optimisation et Sécurité

On les utilise pour économiser de l'espace disque ou créer des filets de sécurité.

### Cas A : Les sauvegardes incrémentales (Type "Time Machine")
C'est le cas d'usage roi pour les systèmes de backup (comme `rsync`).
* **Scénario :** Tu sauvegardes 100 Go de données tous les jours.
* **Jour 1 :** Copie complète (100 Go).
* **Jour 2 :** Tu n'as modifié qu'un fichier de 1 Mo.
* **L'astuce :** Le logiciel de backup va créer un nouveau dossier pour le Jour 2. Il va copier physiquement le fichier de 1 Mo modifié. Pour **tous les autres fichiers** qui n'ont pas bougé, il crée des **Hard Links** vers ceux du Jour 1.
* **Résultat :** Tu as deux dossiers complets accessibles indépendamment, mais sur le disque, tu ne consommes que 100 Go + 1 Mo (au lieu de 200 Go).

### Cas B : Protection contre la suppression accidentelle
* **Le problème :** Tu as un fichier critique (ex: une base de données fichier `data.db`). Tu as peur de faire un `rm` malheureux.
* **La solution :** Tu crées un hard link de ce fichier dans un dossier de backup caché.

    ln data.db /backup/hidden/data.db

* **Pourquoi ça aide ?** Si tu supprimes `data.db` par erreur, les données ne sont pas effacées du disque car le "compteur de liens" est encore à 1 (grâce au lien dans le backup). Tu peux restaurer le fichier instantanément.

### Cas C : Classer sans dupliquer
* **Le contexte :** Tu ranges tes fichiers multimédias. Tu as un film qui est à la fois "Science-Fiction" et "Action".
* **L'astuce :** Au lieu de copier le fichier (ce qui prend double place), tu fais un Hard Link dans le dossier `Science-Fiction` et un autre dans le dossier `Action`. Le fichier est accessible aux deux endroits, mais n'occupe l'espace qu'une seule fois.

---

### 📌 En Résumé

| Type | Règle d'or |
| :--- | :--- |
| **Soft Link** (Symlink) | Utilise-le par défaut pour faire des **raccourcis** pratiques ou gérer des versions. C'est le plus flexible. |
| **Hard Link** | Utilise-le pour des stratégies de **backup** ou pour classer des fichiers lourds sans consommer plus de place. |

<br>

---
