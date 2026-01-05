# 🐧 La Bible des Commandes Linux (Cheatsheet)

<br>

<details> <summary><h2>1. Navigation et Fichiers</h2></summary>

## ls

Lister le contenu d'un répertoire.
```bash 
ls [options] [chemin]
```
- -**l** : Format liste (détails : permissions, taille, propriétaire).

- -**a** : Affiche tout (y compris les fichiers cachés commençant par .).

- -**h** : Affiche les tailles en format lisible (Ko, Mo, Go).

- -**R** : Récursif (liste les sous-dossiers).

<br>

## cd

Changer de répertoire (Change Directory).

```bash 
cd [chemin]

cd .. # Remonter au dossier parent.

cd - # Retourner au dossier précédent.

cd ~  # (ou juste cd) : Retourner au dossier personnel (Home).
```

<br>

## pwd

Afficher le chemin absolu du dossier actuel (Print Working Directory).

```bash 
pwd
```

<br>

## mkdir

Créer un répertoire (Make Directory).

```bash 
mkdir [options] [nom_dossier]
```

- -**p** : Crée les dossiers parents s'ils n'existent pas (ex: mkdir -p dossier/sous-dossier).

<br>

## touch

Créer un fichier vide ou mettre à jour la date de modification.

```bash 
touch [nom_fichier]
```

<br>

## cp

Copier des fichiers ou dossiers.

```bash 
cp [options] source destination
```

- -**r** : Récursif (obligatoire pour copier un dossier).

- -**i** : Demande confirmation avant d'écraser.

<br>

## mv

Déplacer ou renommer des fichiers/dossiers.

```bash 
mv source destination
```

<br>

## rm

Supprimer des fichiers ou dossiers (Remove). Danger !

```bash 
rm [options] cible
```
- -**r** : Récursif (pour supprimer un dossier).

- -**f** : Force la suppression sans confirmation.

- -**r**f : Le combo destructeur (supprime dossier et contenu sans poser de question).

<br>

## ln

Créer des liens (raccourcis).

```bash 
ln [options] <cible>  <nom_du_lien>
```

- -s : Créer un lien symbolique (soft link). Sans cette option, c'est un lien dur (hard link).

<br>

## find

Rechercher des fichiers dans l'arborescence.

```bash 
find [chemin] [critères]
```

- **-name "*.txt"** : Cherche par nom.

- **-type f** : Cherche uniquement des fichiers.

- **-type d** : Cherche uniquement des dossiers.

- **-size +10M** : Cherche les fichiers de plus de 10Mo.

<br>

## file

Déterminer le type d'un fichier (ne se fie pas à l'extension).

```bash 
file [nom_fichier]
```

<br>

<br>

---

</details>

<details> <summary><h2>2. Lecture et Édition de Fichiers</h2></summary>

## cat

Afficher tout le contenu d'un fichier (Concaténer).

```bash 
cat [options] fichier
```

- **-n** : Affiche les numéros de ligne.
- **-e** : Affiche un $ a la fin de la ligne. Affiche les caractères non-imprimables.

<br>

## xdg-open / eog (Eye of Gnome)

Ouvrir un fichier ou une URL avec l'application par défaut.

```bash
# ouvrir un site :
xdg-open http://askubuntu.com/

# ouvrir un fichier
xdg-open filename.png

eog filename.png
```

<br>

## less

Lire un fichier page par page (permet de scroller). Quitter avec q.

```bash 
less fichier
```

<br>

## head

Afficher les premières lignes d'un fichier.

```bash 
head [options] fichier
```

- **-n** 10 : Affiche les 10 premières lignes (défaut).
<br>


## tail

Afficher les dernières lignes d'un fichier.

```bash 
tail [options] fichier
```

- **-n** 10 : Affiche les 10 dernières lignes.

- **-f** : (Follow) Affiche les nouvelles lignes en temps réel (génial pour les logs).

<br>

## nano

Éditeur de texte simple dans le terminal.

```bash 
nano fichier
```

<br>

## vim

Éditeur de texte avancé et puissant.

```bash 
vim fichier
```

<br>

<br>

</details>

<details> <summary><h2>3. Manipulation de Texte (Les Outils Puissants)</h2></summary>

## grep

Rechercher du texte dans un fichier ou un flux.

```bash 
grep [options] "texte" fichier
```

- **-i** : Ignore la casse (majuscule/minuscule).

- **-v** : Inverse la recherche (affiche ce qui ne contient PAS le texte).

- **-r** : Recherche récursive dans les dossiers.

- **-E** : Utilise des expressions régulières étendues.

<br>

## sed

Éditeur de flux (remplacement automatique).

```bash 
sed [options] 'commande' fichier

s/vieux/neuf/g : Remplace toutes les occurrences de "vieux" par "neuf".
```

- **-i** : Modifie le fichier directement (In-place).

<br>

## awk

Langage de traitement de texte par colonnes.

```bash 
awk [options] '{action}' fichier
```

- '{print $1}' : Affiche la première colonne.

- **-F** "," : Définit le séparateur de colonne (ici une virgule).

<br>

## cut

Couper des parties de lignes.

```bash 
cut [options] fichier
```

- **-d** ":" : Définit le délimiteur (ici deux-points).

- **-f** 1 : Garde le premier champ (Field).

<br>

## wc

Compter (Word Count).

```bash 
wc [options] fichier
```

- **-l** : Compte les lignes.

- **-w** : Compte les mots.

- **-m** : Compte les caractères.

- **-c** : Compte les octets.

<br>

## sort

Trier les lignes de texte.

```bash 
sort [options] fichier
```
- **-n** : Tri numérique (pour que 10 soit après 2).

- **-r** : Tri inverse (Reverse).

<br>

## uniq

Filtrer ou compter les lignes en doublon (nécessite d'être trié avant).

```bash 
uniq [options]
```
- **-c** : Compte les occurrences de chaque ligne.

- **-u** : Affiche seulement les lignes uniques.

<br>

## tr

Traduire ou supprimer des caractères.

```bash 
tr [options] set1 set2
```
- tr 'a-z' 'A-Z' : Transforme tout en majuscules.
- -d : Supprime les caractères du SET1. 

<br>

## echo

Afficher une ligne de texte.

```bash 
echo [options] "texte"
```
- **-e** : Interprète les caractères spéciaux (\n pour retour à la ligne).

<br>

## diff

Comparer deux fichiers ligne par ligne.

```bash 
diff fichier1 fichier2
```

<br>

<br>

</details>

<details> <summary><h2>4. Permissions et Utilisateurs</h2></summary>

## chmod

Changer les permissions d'un fichier (Change Mode).

```bash 
chmod [options] droits fichier
```

- **+x** : Rend exécutable.

- **755** : Droits standards (rwx pour proprio, rx pour les autres).

- **-R** : Applique récursivement au dossier.

Notation octale : 

* **R = 4**
* **W = 2**
* **X = 1**

<br>

## chown

Changer le propriétaire d'un fichier (Change Owner).

```bash
chown [options] user:group fichier
```

- **-R** : Récursif.

<br>

## sudo

Exécuter une commande en tant que Super-Utilisateur (Root).

```bash
sudo commande
```

<br>

## su

Changer d'utilisateur (Switch User).

```bash
su [nom_user]
```

- **\-** : Charge aussi les variables d'environnement de l'utilisateur.

<br>

## useradd / adduser

Créer un nouvel utilisateur.

```bash
sudo adduser nom_user
```

- **adduser** : Plus convivial (pose des questions).

- **useradd** : Plus bas niveau (pour les scripts).

<br>

## userdel

Supprimer un utilisateur.

```bash
sudo userdel [options] nom_user
```

- **-r** : Supprime aussi son dossier personnel (/home).

<br>

## passwd

Changer le mot de passe.

```bash
passwd [user]
```

<br>

## groups

Voir les groupes d'un utilisateur.

```bash
groups [user]
```

<br>

## id

Afficher les IDs (UID, GID) de l'utilisateur.

```bash
id
```

<br>

## whoami

Afficher qui je suis actuellement.

```bash
whoami
```

<br>

<br>

</details>

<details> <summary><h2>5. Processus et Système</h2></summary>

## ps

Afficher les processus en cours (instantané).

```bash
ps [options]
```

- aux : Affiche TOUS les processus de TOUS les utilisateurs.

<br>

## top / htop

Afficher les processus en temps réel (Gestionnaire de tâches).

```bash
htop
```

<br>

## kill

Envoyer un signal à un processus (pour l'arrêter).

```bash
kill [options] PID
```
- **-15** : (par défaut) arrêt en douceur (SIGTERM).

- **-9**: Force l'arrêt immédiat (SIGKILL).

- **-2**: Interronpt le processus(équivalent de faire Ctrl+C dans le terminal) (SIGINT)

<br>

## pkill

Tuer des processus par leur nom.

```bash
pkill nom_processus
```

<br>

## bg / fg

Gérer les tâches de fond.

```bash
bg  # Met la tâche en arrière-plan (Background)
fg  # Ramène la tâche au premier plan (Foreground)

sleep 120 & #rajouter un '&' pour lancer directement la commande en arrière plan.
```

<br>

## jobs

Lister les tâches lancées dans le terminal actuel.

```bash
jobs
```

<br>

## systemctl

Contrôler les services (Systemd).

```bash
sudo systemctl [action] [service]
```

- service = **start, stop, restart, status**.

- **enable / disable** : Active / désactive au démarrage.

<br>

## uname

Afficher les informations système.

```bash
uname [options]
```
- **-a** : Affiche tout (Kernel, version, architecture).

<br>

## uptime

Afficher depuis combien de temps la machine tourne.

```bash
uptime
```

<br>

## history

Afficher l'historique des commandes tapées.

```bash
history
```

- **!n** : Relance la commande numéro n.

<br>

<br>

</details>

<details> <summary><h2>6. Disques et Stockage</h2></summary>

<br>

## df

Afficher l'espace disque utilisé (Disk Free).

```bash
df [options]
```
- **-h** : Format lisible (Human readable).

<br>

<br>

## du

Afficher la taille d'un dossier (Disk Usage).

```bash
du [options] [chemin]
```

- **-sh** : Taille totale du dossier en format lisible (Summary Human).

<br>

## free

Afficher l'utilisation de la mémoire RAM.

```bash
free [options]
```

- **-h** : Format lisible.

- **-m** : En mégaoctets.

<br>

## lsblk

Lister les périphériques de stockage (blocs).

```bash
lsblk
```

<br>

## mount / umount

Monter ou démonter une partition/clé USB.

```bash
sudo mount /dev/sdX /mnt/dossier
sudo umount /mnt/dossier
```

<br>

<br>

</details>

<details> <summary><h2>7. Réseau</h2></summary>

## ip

La commande moderne pour gérer le réseau.

```bash
ip [objet] [commande]
```

- **ip a** *(addr)* : Affiche les adresses IP.

- **ip r** *(route)* : Affiche les tables de routage (passerelle).

<br>

## ping

Tester la connexion vers une machine.

```bash
ping [adresse]
```

- **-c 4** : Envoie seulement 4 paquets puis s'arrête.

<br>

## ssh

Se connecter à une machine distante sécurisée.

```bash
ssh user@ip
```

- **-p** : Spécifier un port (ex: -p 4242).

<br>

## scp

Copier des fichiers via SSH (Secure Copy).

```bash
scp [options] source destination

scp fichier user@ip:/dossier : Envoie vers le serveur.
```

- **-P** : Spécifier le port (Attention P majuscule ici !).

<br>

## curl

Récupérer du contenu web ou tester une API.

```bash
curl [options] url
```

- **-I** : Affiche seulement les en-têtes (Headers).
- **-O** : Télécharge le fichier.
- **-L** : Suis les redirections.

<br>

## wget

Télécharger des fichiers depuis le web.

```bash
wget [options] url
```

- **-c** : Reprendre un téléchargement interrompu (-c comme Continue).
- **-O** : Changer le nom de sortie
- **-r** : Récursif.

[Ressource pour télécharger un site en entier](https://jasonmkelly.com/jason-m-kelly/2024/6/22/a-short-tutorial-on-using-wget#:~:text=Wget%20uses%20a%20process%20known,will%20see%20in%20this%20tutorial.) 


<br>

## netstat / ss

Afficher les ports ouverts et connexions.

```bash
ss [options]
```

- **-tulpn** : Affiche les ports en écoute (TCP/UDP) et les processus associés.

<br>

<br>

</details>

<details> <summary><h2>8. Archives et Compression</h2></summary>

## tar

Archiver des dossiers.

```bash
tar [options] archive.tar dossier
```

- **-c** : Créer.

- **-x** : Extraire.

- **-z** : Compresser avec Gzip.

- **-v** : Verbose (voir ce qui se passe).

- **-f** : Fichier (toujours mettre f en dernier).

- Mémotechnique extraction : tar -xvf

<br>

## gzip / gunzip

Compresser / Décompresser des fichiers (.gz).

```bash
gzip fichier

gunzip fichier.gz
```

<br>

## zip / unzip

Gérer les fichiers .zip.

```bash
zip -r archive.zip dossier

unzip archive.zip
```

<br>

<br>

</details>

<details> <summary><h2>9. Gestion de Paquets (Debian/Ubuntu)</h2></summary>

## apt update

Mettre à jour la liste des paquets disponibles.

```bash
sudo apt update
```
<br>

## apt upgrade

Mettre à jour les logiciels installés.

```bash
sudo apt upgrade
```
<br>

## apt install

Installer un logiciel.

```bash
sudo apt install [paquet]
```
<br>

## apt-mark

Empêcher un paquet de se mettre à jour.

```bash
# pour exclure un paquet des MAJ :
sudo apt-mark hold <package_name>
# Pour voir la liste des paquet exclues des MAJ :
sudo dpkg --get-selections | grep "hold"
# Pour inclure un paquet dans les MAJ
sudo apt-mark unhold <package_name>
```

<br>

## apt remove

Désinstaller un logiciel.

```bash
sudo apt remove [paquet]
```

- purge : Désinstalle ET supprime les fichiers de config.

<br>

## apt autoremove

Nettoyer les dépendances inutiles.

```bash
sudo apt autoremove
```
<br>

<br>

</details>

<details> <summary><h2>10. Développement et Compilation (Spécial 42)</h2></summary>

## gcc

Le compilateur C standard (GNU Compiler Collection).

```bash
gcc [options] fichier.c -o executabl
```

- **-Wall -Wextra -Werror** : Active tous les avertissements (Flags 42 standards).

- **-g** : Ajoute les infos de debug (pour gdb/valgrind).

<br>

## make

Automatiser la compilation via un Makefile.

```bash
make [regle]
```
- **all** : générer les fichiers objets (*.o) et créer le binaire ou la librairie
- **clean** : supprimer les fichiers objets
- **fclean** : supprimer les fichiers objets + le binaire / la librairie
- **re** : Règle standard (souvent) pour "rebuild" (clean + all).

<br>

## gdb

Le débogueur GNU. Pour analyser pourquoi un programme crash (Segfault).

```bash
gdb ./executable
```

<br>

## valgrind

Outil d'analyse mémoire. Indispensable pour détecter les "Memory Leaks" à 42.

```bash
valgrind [options] ./executable
```

- **--leak-check=full** : Affiche les détails complets des fuites mémoires.

<br>

## nm

Lister les symboles (fonctions, variables) d'un fichier objet ou exécutable.

```bash
nm [fichier]
```

<br>

## ar

Créer, modifier ou extraire des archives (utilisé pour créer des bibliothèques statiques .a aka "libft").

```bash
ar [options] archive.a fichiers.o
```

- **-rcs** : Replace, Create, Sort index (Standard pour les libs).

<br>

## ldd

Afficher les bibliothèques partagées nécessaires à un programme.

```bash
ldd [executable]
```

<br>

<br>

</details>

<details> <summary><h2>11. Informations Système et Matériel</h2></summary>


## lscpu

Afficher les informations sur le processeur (CPU).

```bash
lscpu
```

<br>

## lsusb

Lister les périphériques USB connectés.

```bash
lsusb
```

<br>

## lspci

Lister les périphériques PCI (Carte graphique, carte réseau, etc.).

```bash
lspci
```

<br>

## lshw

Lister tout le matériel de manière détaillée (Hardware).

```bash
sudo lshw
```

- **-short** : Affiche un résumé plus lisible.

<br>

## dmesg


Afficher les messages du noyau (Kernel Ring Buffer). Utile pour voir les erreurs matérielles au démarrage.

```bash
dmesg
```

- **-w** : Affiche les nouveaux messages en temps réel (comme tail -f).

<br>

## dmidecode

Lire les tables DMI (infos BIOS, carte mère, RAM physique).

```bash
sudo dmidecode
```

<br>

<br>

</details>

<details> <summary><h2>12. Utilitaires Shell et Environnement</h2></summary>

## man

Afficher le manuel d'une commande.

```bash
man [commande]
```

## which

Localiser l'emplacement d'une commande exécutable.

```bash
which [commande]
```

## whereis

Localiser le binaire, la source et le manuel d'une commande.

```bash
whereis [commande]
```

## locate

Rechercher des fichiers dans une base de données indexée (beaucoup plus rapide que find).

```bash
locate [nom_fichier]
```

## alias


Créer un raccourci pour une commande (temporaire, sauf si mis dans .bashrc).

```bash
alias nom='commande'
```

## unalias


Supprimer un alias.

```bash
unalias [nom]
```


## export

Définir une variable d'environnement (accessible aux sous-processus).

```bash
export NOM="Valeur"
```

## env

Afficher toutes les variables d'environnement actuelles.

```bash
env
```

## source


Exécuter un fichier dans le shell actuel (souvent pour recharger le .bashrc).

```bash
source .bashrc
```

## reset

Réinitialiser complètement le terminal (si l'affichage est buggé).

```bash
reset
```

## history

Afficher l'historique des commandes.

```bash
history
```

- **-c** : Efface l'historique de la session.

## exit

Quitter le shell actuel.

```bash
exit
```

<br>

<br>

</details>

<details> <summary><h2>13. Date, Heure et Planification</h2></summary>

<br>

## date

Afficher ou régler la date et l'heure système.

```bash
date

date +"%A %d %B => %Y-%m-%d => %H:%M:%S"
# Monday 05 January => 2026-01-05 => 17:43:12
```

- **+"%Y-%m-%d"** : Formater la sortie (ex: 2023-12-25).
- -d : affiche une date donnée en paramètre.
- liste des flags [ici](https://www.malekal.com/la-commande-date-linux-utilisations-et-exemples/)

<br>

## cal

Afficher un calendrier.

```bash
cal
```

<br>

## uptime

Afficher depuis combien de temps le système tourne et la charge moyenne (load average).

```bash
uptime
```

<br>

## crontab

Gérer les tâches planifiées (Cron).

```bash
crontab [options]
```

- **-e** : Éditer la table cron.

- **-l** : Lister la table cron.

<br>

## at

Programmer une commande pour une exécution unique dans le futur.

```bash
echo "commande" | at 14:00
```

<br>

<br>

</details>

<details> <summary><h2>14. Monitoring Avancé et Logs</h2></summary>

## journalctl


Consulter les journaux de systemd (Logs système modernes).

```bash
journalctl [options]
```

- **-xe** : Affiche les erreurs récentes avec détails (souvent suggéré après un crash de service).

- **-u ssh** : Affiche uniquement les logs du service SSH.

- **-f** : Suit les logs en temps réel (Follow).

<br>

## watch

Exécuter une commande périodiquement et afficher le résultat en plein écran.

```bash
watch [commande]
```

- **-n 1** : Rafraîchir toutes les 1 secondes.

<br>

## vmstat

Afficher les statistiques de la mémoire virtuelle, des disques et du CPU.

```bash
vmstat [delai]
```

<br>

## iostat

Afficher les statistiques d'entrées/sorties (I/O) CPU et Disques (paquet sysstat).

```bash
iostat
```

<br>

<br>

</details>

<details> <summary><h2>15. Utilisateurs et Sessions (Avancé)</h2></summary>

## w / who

Afficher qui est connecté et ce qu'ils font.

```bash
w

who # (plus simple que w)
```

<br>

## last

Afficher l'historique des dernières connexions utilisateurs.

```bash
last
```

<br>

## lastb

Afficher les tentatives de connexions échouées (Bad logins).

```bash
sudo lastb
```

<br>

<br>

</details>

<details> <summary><h2>16. Réseau Avancé et DNS</h2></summary>

## dig

Interroger les serveurs DNS (Domain Information Groper). Plus précis que ping.

```bash
dig domaine.com
```

- **+short** : Affiche juste l'IP.

<br>

## nslookup

Interroger un serveur de nom (ancien outil, mais toujours utile).

```bash
nslookup domaine.com
```

<br>

## traceroute

Afficher le chemin (les routeurs) pris par un paquet pour atteindre une cible.

```bash
traceroute google.com
```

<br>

## hostnamectl

Voir ou changer le nom d'hôte de la machine (systemd).

```bash
hostnamectl
```

- set-hostname [nom] : Change le nom de la machine.

<br>

## nc

Netcat : Le couteau suisse du réseau (Lire/Écrire sur des ports TCP/UDP).

```bash
nc [options] host port
```

- **-l -p 1234** : Écoute sur le port 1234 (mode serveur).

- **-z -v** : Scanne un port pour voir s'il est ouvert (mode scanner).

<br>

## tcpdump

Capturer et analyser les paquets réseaux (Sniffer).

```bash
sudo tcpdump [options]
```

<br>

<br>

</details>

<details> <summary><h2>17. Flux Avancés (Pipes & redirections)</h2></summary>

## tee

Lire depuis l'entrée standard et écrire à la fois dans la sortie standard et dans un fichier (forme de T).

```bash
echo "test" | tee fichier.txt
```

- **-a** : Ajoute au fichier au lieu d'écraser (Append).

<br>

## xargs
Construire et exécuter des lignes de commandes à partir de l'entrée standard.

```bash
find . -name "*.bak" | xargs rm
```

- (Exemple : Trouve tous les .bak et passe-les à rm pour les supprimer).

<br>

<br>

</details>