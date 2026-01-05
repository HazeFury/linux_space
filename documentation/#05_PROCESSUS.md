# Module 5 : Processus, Services et Tâches Planifiées

Si le FHS est l'anatomie (le corps), les processus sont la physiologie (les organes qui bougent). Linux est un système **multi-tâches**. Même quand tu ne fais rien, des dizaines de programmes tournent en arrière-plan.

## 1. Qu'est-ce qu'un Processus ?

Un processus est simplement **un programme en train de s'exécuter**.
Chaque processus possède une carte d'identité unique : le **PID** (Process ID).

* **Le Père de tous (PID 1) :** Au démarrage du noyau, le premier processus lancé est **Systemd** (ou Init). C'est le Dieu du système. Tous les autres processus descendent de lui.
* **Le cycle de vie :** Un processus est créé, il vit, il meurt. S'il meurt mal (bug), il peut devenir un "Zombie" (il est mort mais occupe encore une ligne dans le tableau des processus).

### Observer la fourmilière
Comment voir ce qui se passe ?

* **`top`** : Le moniteur d'activité historique. Moche mais installé partout.
* **`htop`** : La version moderne et colorée (à installer souvent : `apt install htop`).
* **`ps`** (Process Status) : La photo instantanée.
    * La commande classique : `ps aux`
    * **a** : Tous les utilisateurs.
    * **u** : Affiche les détails (user, cpu, ram...).
    * **x** : Affiche aussi les processus qui n'ont pas de terminal (les services).

## 2. Tuer et Gérer les Processus

Parfois, un programme plante ou consomme trop de CPU. Il faut l'arrêter.
La commande est `kill`.

### Les Signaux (La méthode douce ou forte)
Quand tu fais `kill`, tu n'arrêtes pas le processus directement. Tu lui envoies un **Signal**.

    kill -SIGNAL PID

Les 3 signaux à connaître par cœur :

1.  **SIGTERM (Signal 15)** - *Par défaut* :
    "S'il te plaît, peux-tu t'arrêter ?"
    C'est la méthode douce. Le programme a le temps de sauvegarder ses fichiers et de fermer proprement.
    
    kill 1234  (Envoie SIGTERM au PID 1234)

2.  **SIGKILL (Signal 9)** - *L'arme atomique* :
    "Tu dégages. Tout de suite."
    Le noyau coupe l'alimentation du processus instantanément. Aucune sauvegarde possible. À utiliser seulement si le processus est planté total.
    
    kill -9 1234

3.  **SIGINT (Signal 2)** :
    C'est l'équivalent de faire **Ctrl+C** dans le terminal.

### Premier plan (Foreground) vs Arrière-plan (Background)
Tu lances une grosse copie ou une compilation qui dure 1h. Tu veux récupérer ton terminal ?

1.  **Ctrl+Z** : Met le processus en **Pause** (Stopped).
2.  **`bg`** (BackGround) : Relance le processus, mais en arrière-plan. Tu récupères la main.
3.  **`fg`** (ForeGround) : Ramène le processus au premier plan.
4.  **`jobs`** : Liste les tâches en cours dans ce terminal.

	### Astuce : Lancer directement en background avec "&"
    	sleep 100 &

## 3. Les Services (Daemons) et Systemd

Un **Service** (ou Démon/Daemon) est un processus qui tourne en arrière-plan sans interface utilisateur, souvent dès le démarrage du PC (Serveur Web, Serveur SSH, Cron...).

Sous Debian (Born2beRoot), c'est **Systemd** qui gère tout ça via la commande `systemctl`.

### Le vocabulaire est CRUCIAL :
Il y a une différence majeure entre **Démarrer** (maintenant) et **Activer** (au boot).

* **`systemctl start ssh`** : Allume le service SSH **tout de suite** (jusqu'au prochain redémarrage).
* **`systemctl enable ssh`** : Configure le service pour qu'il s'allume **automatiquement au prochain démarrage**.
* **`systemctl status ssh`** : Le plus important. Te dit si le service est "active (running)", "dead" ou "failed".

| Action | Commande |
| :--- | :--- |
| Voir l'état | `systemctl status <service>` |
| Démarrer | `sudo systemctl start <service>` |
| Arrêter | `sudo systemctl stop <service>` |
| Redémarrer | `sudo systemctl restart <service>` |
| Activer au boot | `sudo systemctl enable <service>` |
| Désactiver au boot | `sudo systemctl disable <service>` |

## 4. Cron & Crontab (Le Réveil Matin)

Cron permet d'executer des commandes et/ou des scripts automatiquement a un interval bien défini.

### Le fichier Crontab
Chaque utilisateur a sa propre table de planification.
* `crontab -e` : **E**diter ma table (ouvre vim/nano).
* `sudo crontab -e` : **E**diter la table de root (ouvre vim/nano).
* `crontab -l` : **L**ister ma table.

### La syntaxe infernale
Une ligne de cron ressemble à ça :

    # m h  dom mon dow   command
    30 08 * * 1  /home/marco/backup.sh

Il y a 5 étoiles (champs) :
1.  **m**inute (0-59)
2.  **h**eure (0-23)
3.  **d**ay **o**f **m**onth (jour du mois, 1-31)
4.  **mon**th (mois, 1-12)
5.  **d**ay **o**f **w**eek (jour de la semaine, 0=Dimanche, 1=Lundi...)

### Exemples pour s'entraîner
* `* * * * * command` : Toutes les minutes.
* `*/10 * * * * command` : Toutes les 10 minutes (Indispensable pour B2BR).
* `0 8 * * * command` : Tous les jours à 8h00.
* `0 0 * * 1 command` : Tous les lundis à minuit.
* `@reboot command` : Une seule fois au démarrage de la machine.

> **💡 Astuce :** Ne cherche pas à apprendre la syntaxe par cœur tout de suite. Utilise le site [crontab.guru](https://crontab.guru/) pour vérifier tes configs.


<br>

---

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
