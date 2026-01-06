<details> <summary><h2>🔎 Focus : APT vs APTITUDE</h2></summary>

Si `dpkg` est le mécanicien qui installe les pièces, `apt` et `aptitude` sont les architectes qui décident quelles pièces sont nécessaires.

## 1. APT (Advanced Package Tool)
C'est la commande standard et moderne recommandée pour l'utilisation quotidienne.

* **Ce qu'il fait :** C'est une surcouche "intelligente" à `dpkg`. Il gère les dépôts (sources internet), télécharge les paquets et résout les dépendances simples.

* **Son histoire :** Avant, on utilisait `apt-get` (pour installer) et `apt-cache` (pour chercher). La commande `apt` a été créée pour fusionner les deux et offrir une interface plus jolie (barre de progression, couleurs).
* **Utilisation :** Simple, rapide, efficace.

```bash
sudo apt update && sudo apt upgrade
sudo apt install git
```

## 2. APTITUDE
C'est un gestionnaire de paquets de "haut niveau", souvent préféré par les administrateurs système chevronnés pour des tâches complexes.

- **La différence visuelle** : Si tu tapes juste `aptitude` sans argument, tu entres dans une interface graphique textuelle (Ncurses) avec des menus navigables à la souris et au clavier.

- **La différence technique** : `aptitude` possède un algorithme de résolution de dépendances plus "agressif" et intelligent qu'`apt`.

	- Si une installation bloque à cause d'un conflit de versions, `apt` va souvent abandonner.

	- `aptitude` va te proposer plusieurs scénarios (solutions) : "Je peux désinstaller X pour installer Y, ou alors garder l'ancienne version de Z..."

- **Le nettoyage** : Il est réputé pour mieux gérer la suppression des paquets orphelins (les dépendances qui ne servent plus à rien).

## ⚔️ Le verdict
Utilise `apt` pour 99% de tes besoins quotidiens et tes scripts. C'est le standard actuel.

Utilise `aptitude` uniquement si tu es coincé dans un "Dependency Hell" (conflit de paquets insoluble) et que tu as besoin qu'on te propose des solutions complexes.

</details>

<br>

---

<!-- ############################################################################### -->


<br>


<details> <summary><h2>🔎 Focus : Curl, Wget et Dpkg</h2></summary>

Ces trois commandes sont des piliers de l'administration système sous Debian. Si `curl` et `wget` semblent similaires, ils répondent à des philosophies différentes. Quant à `dpkg`, c'est le moteur caché sous le capot d'`apt`.

## 1. CURL vs WGET : Le Duel du Téléchargement

### 🌊 CURL (Client URL)
**Le Couteau Suisse des APIs et du transfert de données.**

`curl` est conçu pour transférer des données via une URL. Sa particularité est qu'il affiche par défaut le contenu sur la sortie standard (`stdout`), ce qui le rend parfait pour les scripts et les pipelines.

* **Point fort :** Supporte énormément de protocoles et permet d'envoyer des données (POST), vital pour tester des APIs.
* **Philosophie :** Outil de développement et de diagnostic.

**Commandes clés :**

```bash
# Voir le contenu d'une page (affiche le HTML dans le terminal)
curl [https://www.google.com](https://www.google.com)

# Télécharger un fichier (-o minuscule pour renommer, -O majuscule pour garder le nom)
curl -o mon_fichier.html [https://www.google.com](https://www.google.com)
curl -O [https://exemple.com/image.png](https://exemple.com/image.png)

# Voir les En-têtes HTTP (Headers) - GÉNIAL pour le debug
curl -I [https://www.42.fr](https://www.42.fr)

# Suivre les redirections (-L comme Location)
curl -L [http://google.com](http://google.com)
# Sans -L, on risque d'obtenir une erreur 301 (Moved Permanently).
```

### 🕷️ WGET (World Wide Web Get)

**Le Téléchargeur Robuste.**

`wget` est conçu pour télécharger des fichiers et les sauvegarder sur le disque. Il est robuste : si la connexion coupe, il peut reprendre là où il s'est arrêté.

**Point fort :** La stabilité et la récursivité (peut télécharger un site entier).

**Philosophie** : Aspirateur de fichiers.

Commandes clés :

```bash
# Télécharger un fichier simple
wget [https://exemple.com/fichier.zip](https://exemple.com/fichier.zip)

# Reprendre un téléchargement interrompu (-c comme Continue)
wget -c [https://exemple.com/gros_fichier.iso](https://exemple.com/gros_fichier.iso)

# Changer le nom de sortie (-O majuscule)
wget -O nouveau_nom.zip [https://exemple.com/fichier_bizarre.zip](https://exemple.com/fichier_bizarre.zip)

# Mode "Aspirateur" (Récursif - À utiliser avec prudence)
wget -r [https://petit-site-web.com](https://petit-site-web.com)
```

<br>

<div align="center">

**⚔️ Comparatif**

| Critère | 🌊 CURL  | 🕷️ WGET |
| :--- | :---: | ---: |
| Sortie par défaut | `stdout` (Écran) | Fichier sur disque |
| Usage principal | Dev, APIs, Debug | Téléchargement pur |
| Redirections | Manuel (`-L`) | Automatique |
| Fiabilité connexion | Standard | Excellent (Retry, Continue) |

</div>

### DPKG (Debian Package)

`apt` est une surcouche intelligente qui gère les dépendances (télécharge ce qu'il faut sur internet). `dpkg` est l'outil de bas niveau qui installe réellement le fichier `.deb` sur le disque. Il ne gère pas les dépendances (il ne va pas sur internet).

**Quand l'utiliser ?**
Pour installer des logiciels qui ne sont pas dans les dépôts officiels (ex: Discord, Chrome, VS Code) que tu as téléchargés manuellement en **.deb**.

Commandes clés :

```bash
# Installer un fichier .deb local (-i comme Install)
sudo dpkg -i paquet.deb

# Lister TOUS les paquets installés (-l comme List)
dpkg -l
# Astuce : dpkg -l | grep ssh

# Vérifier les infos d'un paquet (-s comme Status)
dpkg -s ufw

# Supprimer un paquet (-r comme Remove)
sudo dpkg -r nom_du_paquet

# Retrouver à quel paquet appartient un fichier
dpkg -S /bin/ls
# Résultat : coreutils
```

⚠️ Réparer une installation cassée

Si tu installes un .deb avec dpkg et qu'il manque des dépendances, l'installation va échouer.

Pour réparer :
```bash
sudo apt install -f
```

*(Option -f pour "Fix broken". Apt va télécharger les dépendances manquantes et finir le travail de dpkg).*

</details>

<br>

---

<!-- ############################################################################### -->

<br>

<details> <summary><h2>🔎 Focus : Grep, Sed, Awk</h2></summary>

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

</details>

<br>

---

<!-- ############################################################################### -->

<br>

<details> <summary><h2>🔎 Focus : Hard Links vs Soft Links</h2></summary>

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


</details>


<br>

---

<!-- ############################################################################### -->

<br>

<details> <summary><h2>🔎 Focus : Systemd & Systemctl</h2></summary>


# Focus : Systemd & Systemctl (Le Cœur du Système)

Pour réussir Born2beRoot, et plus largement pour administrer un Linux moderne (Debian, Ubuntu, CentOS, RedHat), il est impératif de comprendre ce couple.

## 1. Démystifions les Noms

* **`systemd`** : Vient de **System Daemon** (Le Démon du Système).
    * Le "d" à la fin des noms de programmes Linux signifie souvent "daemon" (un service qui tourne en fond).
    * C'est le programme qui gère le système entier.
* **`systemctl`** : Vient de **System Control**.
    * C'est la télécommande qui permet à l'humain de donner des ordres à `systemd`.

## 2. Le Rôle du PID 1 (Le "Dieu" du système)

Quand tu appuies sur le bouton Power de ton ordinateur :
1.  Le BIOS/UEFI se réveille.
2.  Il lance le Bootloader (Grub).
3.  Grub charge le **Noyau (Kernel)** Linux en mémoire.
4.  Le Noyau, une fois chargé, doit lancer le "reste" (l'interface, le réseau, les disques). Pour cela, il lance **UN SEUL** programme initial : **L'Init System**.

Ce programme reçoit le **PID 1** (Process ID 1).
Si le PID 1 meurt, le système crashe instantanément (Kernel Panic).

> **Avant (Le Vieux Monde) : SysVinit**
> Historiquement, Linux utilisait `SysVinit`. C'était une suite de scripts simples (`/etc/init.d/`) qui se lançaient **les uns après les autres**.
> * Problème : C'était lent. Si le réseau mettait 10 secondes à démarrer, tout le reste attendait.

> **Aujourd'hui : Systemd**
> Systemd a été créé pour remplacer SysVinit avec une philosophie moderne : **le Parallélisme**.
> Il lance tout ce qu'il peut en même temps pour démarrer le PC en quelques secondes.

## 3. L'Architecture de Systemd

Systemd ne gère pas que les services. C'est une pieuvre tentaculaire qui gère presque tout. Il fonctionne avec des **Unités** (Units).

### Les "Units" (Les briques de lego)
Tout objet géré par Systemd est défini dans un fichier de configuration appelé "Unit file" (généralement dans `/lib/systemd/system/` ou `/etc/systemd/system/`).

Il existe plusieurs types d'unités (reconnaissables à leur extension) :
* **.service** : Le plus courant. Décrit comment lancer un programme (ex: `ssh.service`, `nginx.service`).
* **.socket** : Pour la communication réseau.
* **.mount** : Pour gérer le montage des disques durs.
* **.target** : Un groupe d'unités (sert à définir des états, voir ci-dessous).
* **.timer** : Une alternative à Cron gérée directement par Systemd.

### Les Targets (Les niveaux de fonctionnement)
Au lieu des anciens "Runlevels" (0 à 6), Systemd utilise des Targets pour définir l'état du PC.
* `poweroff.target` : Le PC s'éteint.
* `reboot.target` : Le PC redémarre.
* `multi-user.target` : Mode normal (serveur), sans interface graphique (C'est ce que tu vises pour Born2beRoot).
* `graphical.target` : Mode normal avec interface graphique (GNOME, KDE...).

## 4. Systemctl : La Baguette du Chef d'Orchestre

C'est l'outil que tu vas utiliser au quotidien pour interagir avec Systemd.

### Commandes d'état (Observation)
    
    # Est-ce que le système a fini de démarrer et est-ce qu'il va bien ?
    systemctl is-system-running
    
    # Lister toutes les unités qui ont échoué (très utile pour débugger)
    systemctl --failed
    
    # Voir les logs d'un service précis (car systemd capture aussi les logs)
    journalctl -u ssh

### Commandes d'action (Pilotage)
La différence cruciale entre l'action immédiate et l'action au démarrage :

1.  **L'instant présent (Le Runtime) :**

```bash
sudo systemctl stop ssh     # Coupe le moteur maintenant
sudo systemctl start ssh    # Allume le moteur maintenant
sudo systemctl restart ssh  # Coupe et rallume
```

2.  **Le futur (Le Boot) :**
    C'est la création de liens symboliques (symlinks) dans les dossiers de démarrage.

```bash    
sudo systemctl enable ssh   # "Au prochain démarrage, lance-toi tout seul"
sudo systemctl disable ssh  # "Au prochain démarrage, reste éteint"
```

> **💡 Astuce :** Tu peux combiner les deux.
> `sudo systemctl enable --now ssh` (Active le service au boot ET le démarre tout de suite).

## 5. La controverse (Culture G)

Tu entendras peut-être des puristes d'UNIX critiquer Systemd.
**Pourquoi ?** La philosophie UNIX dit *"Fais une seule chose, et fais-la bien"*.
Systemd fait **tout** : il gère les services, les logs (journald), les noms de machine (hostname), l'heure (timedate), les sessions utilisateurs (logind)...
Certains trouvent qu'il est trop gros, trop complexe et qu'il viole la philosophie UNIX. Mais aujourd'hui, il est devenu le standard de facto sur 95% des distributions Linux majeures.

</details>


<br>

---

<!-- ############################################################################### -->

<br>

<details> <summary><h2>🔎 Focus : Debian vs Rocky Linux</h2></summary>

# Focus : Debian vs Rocky Linux (Le Choc des Cultures)

Dans le monde Linux, il y a deux "familles royales" : la famille **Debian** et la famille **Red Hat**. Le projet Born2beRoot te demande de choisir ton camp. Voici ce qui les différencie.

## 1. La Famille Debian (Le choix du Peuple)

* **Représentant :** Debian.
* **Descendants :** Ubuntu, Kali, Linux Mint.
* **Philosophie :** Communautaire, bénévole, stricte sur le logiciel libre.
* **Gestionnaire de paquets :** APT (commandes `apt`, `apt-get`).
* **Format de fichiers :** .deb

C'est le monde que tu connais probablement le mieux si tu as utilisé Ubuntu. C'est le choix de la stabilité absolue et de l'indépendance vis-à-vis des entreprises.

## 2. La Famille Red Hat (Le choix de l'Entreprise)

* **Représentant :** RHEL (Red Hat Enterprise Linux).
* **Clones gratuits :** Rocky Linux, AlmaLinux (et anciennement CentOS).
* **Philosophie :** Orientée Business, stabilité pour les entreprises, support payant (pour RHEL).
* **Gestionnaire de paquets :** DNF (remplace l'ancien YUM).
* **Format de fichiers :** .rpm (Red Hat Package Manager).

**L'histoire de Rocky Linux (Le drame CentOS) :**
Pendant des années, tout le monde utilisait **CentOS**. C'était une copie conforme de Red Hat, mais gratuite. C'était le standard absolu des serveurs web.
En 2020, Red Hat (racheté par IBM) a "tué" CentOS tel qu'on le connaissait pour en faire une version de test ("CentOS Stream").
La communauté a hurlé au scandale. Gregory Kurtzer, le fondateur original de CentOS, a alors créé **Rocky Linux** pour remplacer CentOS.
*Rocky Linux est donc le nouveau standard gratuit pour ceux qui veulent du Red Hat sans payer.*

## 3. Le Match Technique : APT vs DNF

C'est la différence la plus flagrante au quotidien. Les commandes ne sont pas les mêmes.

**Mise à jour des dépôts :**

    Debian : sudo apt update
    Rocky  : sudo dnf check-update

**Installation :**

    Debian : sudo apt install git
    Rocky  : sudo dnf install git

**Différence notable :** 
DNF est souvent considéré comme plus moderne et plus lisible qu'APT, mais aussi un peu plus lent. Il gère mieux les historiques de transactions (on peut "annuler" une installation plus facilement).

## 4. Sécurité : AppArmor vs SELinux

C'est là que la difficulté de Born2beRoot change.

**Debian utilise AppArmor :**
Un système de sécurité modulaire. Il est activé par défaut mais reste assez "silencieux". Il est relativement simple à configurer.

**Rocky Linux utilise SELinux (Security-Enhanced Linux) :**
Un système créé par la NSA. Il est extrêmement puissant mais **très complexe**.
* Le principe : "Tout ce qui n'est pas explicitement autorisé est interdit".
* Le problème : C'est la cause n°1 de bugs pour les débutants. Tu installes un serveur Web, tu changes le dossier du site, et ça ne marche pas car SELinux bloque l'accès au nouveau dossier.
* *Note :* Configurer SELinux correctement est une compétence très recherchée en entreprise.

## 5. Le verdict : Lequel choisir pour Born2beRoot ?

**Choisis Debian si :**
1. Tu débutes et tu ne veux pas te battre avec SELinux tout de suite.
2. Tu préfères la documentation d'Ubuntu/Debian (très abondante).
3. Tu veux suivre la majorité des étudiants (plus facile pour l'entraide).

**Choisis Rocky Linux si :**
1. Tu veux un défi supplémentaire.
2. Tu vises une carrière d'Admin Sys en entreprise (les banques et assurances utilisent souvent Red Hat).
3. Tu veux apprendre à maîtriser DNF et SELinux.

## 6. Tableau Récapitulatif

| Caractéristique | Debian | Rocky Linux |
| :--- | :--- | :--- |
| **Famille** | Debian | Red Hat (RHEL) |
| **Gestionnaire** | APT | DNF (ou YUM) |
| **Paquets** | .deb | .rpm |
| **Sécurité** | AppArmor | SELinux |
| **Philosophie** | Libre & Communautaire | Clone Entreprise |
| **Cycle de vie** | Très long (Stable) | Très long (10 ans) |
| **Difficulté** | Moyenne | Élevée (à cause de SELinux) |

</details>

<br>

---

<!-- ############################################################################### -->

<br>

<!-- <details> <summary><h2>🔎 Focus : Debian vs Rocky Linux</h2></summary> -->