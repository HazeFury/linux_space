# 🗺️ SOMMAIRE
## 🟢 Module 1 : Genèse et Philosophie (Les Fondations)

L'objectif : Ne plus voir Linux comme un OS "gratuit" mais comme un mouvement.

### 1. L'Histoire : De UNIX à MINIX, puis l'arrivée de Linus Torvalds.

### 2. La Philosophie : Le projet GNU (Richard Stallman), la licence GPL, et l'Open Source.

### 3. Kernel vs Shell : Comprendre la séparation entre le "noyau" (le cerveau) et la "coquille" (l'interface).

### 4. Les Distributions (Distros) : Pourquoi y en a-t-il autant ? Différence entre Debian (stabilité) et les autres (RedHat, Arch, etc.).

### 5. Pourquoi Linux ? Sa stabilité, sa sécurité et sa domination sur le marché serveur.

<br>

## 🟡 Module 2 : L'Anatomie du Système

L'objectif : Savoir se repérer dans l'arborescence du système.

### 1. Le FHS (Filesystem Hierarchy Standard) : Pourquoi /bin, /etc, /var, /usr ?

### 2. "Tout est fichier" : Le concept clé d'UNIX. Fichiers réguliers, répertoires, liens, périphériques (/dev).

### 3. Les Inodes (Hard links vs Soft links) : Comprendre comment le système stocke physiquement les données.

<br>

## 🟠 Module 3 : L'Art du Shell et la Manipulation de Texte

L'objectif : Savoir manipuler de la donnée textuelle.

### 1. L'environnement Shell : Variables d'environnement (PATH, HOME), alias, fichiers de conf (.bashrc, .zshrc).

### 2. Les Flux (Streams) : stdin, stdout, stderr. C'est la base de la communication entre programmes.

### 3. Redirections et Pipelines : La puissance du |, >, >>, 2>, tee.

### 4. La Sainte Trinité du traitement de texte :
- **grep** (filtrer)
- **sed** (éditer le flux)
- **awk** (traiter les colonnes/données)

<br>

## 🔴 Module 4 : Administration Utilisateurs et Permissions (Focus Sécurité)

L'objectif : Comprendre qui a le droit de faire quoi.

### 1. Utilisateurs et Groupes : /etc/passwd, /etc/shadow.

### 2. Les Permissions : chmod, le système octal (755, 644), chown.

### 3. Le Super-Utilisateur (Root) : Ses pouvoirs et ses dangers.

### 4. SUDO : "SuperUser DO". Comment ça marche, le fichier /etc/sudoers, et pourquoi on ne se log jamais en root directement.

<br>

## 🟣 Module 5 : Processus et Services (Le Moteur)

L'objectif : Gérer ce qui tourne sur la machine.

### 1. Les Processus : PID, PPID, cycle de vie (fork/exec), signaux (kill).

### 2. Gestion des tâches : Foreground, background (&, bg, fg), top/htop.

### 3. Le système d'Init (Systemd) : Comprendre systemctl, les services, les démons.

### 4. Les Logs : Où le système parle-t-il ? (/var/log, journalctl).

<br>

## 🔵 Module 6 : Disques et Partitionnement

L'objectif : Gérer l'espace de stockage de la machine. 

### 1. Partitionnement classique : MBR vs GPT.

### 2. LVM (Logical Volume Manager) : Concept de PV, VG, LV. C'est l'abstraction qui permet de redimensionner des partitions à chaud.

### 3. Le chiffrement : LUKS (Linux Unified Key Setup). Sécuriser ses données.

<br>

## 🟤 Module 7 : Réseau et Automatisation
L'objectif : Connecter la machine et la faire travailler toute seule.

### 1. Réseau de base : IP, Ports, SSH (Secure Shell) pour le contrôle à distance.

### 2. Firewall : UFW (Uncomplicated Firewall). Sécuriser les entrées/sorties.

### 3. Cron & Crontab : La planification de tâches (ex: script de monitoring toutes les 10 min).

### 4. Scripting Bash : Variables, boucles, conditions pour automatiser des tâches.

