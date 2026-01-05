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

- **-F** "," : Définit le séparateur de colonne (ici une virgule).

'{print $1}' : Affiche la première colonne.

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
tr 'a-z' 'A-Z' : Transforme tout en majuscules.

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

chmod [options] droits fichier
+x : Rend exécutable.

755 : Droits standards (rwx pour proprio, rx pour les autres).

-R : Applique récursivement au dossier.

## chown

Changer le propriétaire d'un fichier (Change Owner).

chown [options] user:group fichier
-R : Récursif.

## sudo

Exécuter une commande en tant que Super-Utilisateur (Root).

sudo commande
## su

Changer d'utilisateur (Switch User).

su [nom_user]
- : Charge aussi les variables d'environnement de l'utilisateur.

## useradd / adduser

Créer un nouvel utilisateur.

sudo adduser nom_user
adduser : Plus convivial (pose des questions).

useradd : Plus bas niveau (pour les scripts).

## userdel

Supprimer un utilisateur.

sudo userdel [options] nom_user
-r : Supprime aussi son dossier personnel (/home).

## passwd

Changer le mot de passe.

passwd [user]
## groups

Voir les groupes d'un utilisateur.

groups [user]
## id

Afficher les IDs (UID, GID) de l'utilisateur.

id
## whoami

Afficher qui je suis actuellement.

whoami
</details>

<details> <summary><h2>5. Processus et Système</h2></summary>

## ps

Afficher les processus en cours (instantané).

ps [options]
aux : Affiche TOUS les processus de TOUS les utilisateurs.

## top / htop

Afficher les processus en temps réel (Gestionnaire de tâches).

htop
## kill

Envoyer un signal à un processus (pour l'arrêter).

kill [options] PID
-9 : Force l'arrêt immédiat (SIGKILL).

## pkill

Tuer des processus par leur nom.

pkill nom_processus
## bg / fg

Gérer les tâches de fond.

bg  # Met la tâche en arrière-plan (Background)
fg  # Ramène la tâche au premier plan (Foreground)
## jobs

Lister les tâches lancées dans le terminal actuel.

jobs
## systemctl

Contrôler les services (Systemd).

sudo systemctl [action] [service]
start, stop, restart, status.

enable : Active au démarrage.

## uname

Afficher les informations système.

uname [options]
-a : Affiche tout (Kernel, version, architecture).

## uptime

Afficher depuis combien de temps la machine tourne.

uptime
## history

Afficher l'historique des commandes tapées.

history
!n : Relance la commande numéro n.

</details>

<details> <summary><h2>6. Disques et Stockage</h2></summary>

## df

Afficher l'espace disque utilisé (Disk Free).

df [options]
-h : Format lisible (Human readable).

## du

Afficher la taille d'un dossier (Disk Usage).

du [options] [chemin]
-sh : Taille totale du dossier en format lisible (Summary Human).

## free

Afficher l'utilisation de la mémoire RAM.

free [options]
-h : Format lisible.

-m : En mégaoctets.

## lsblk

Lister les périphériques de stockage (blocs).

lsblk
## mount / umount

Monter ou démonter une partition/clé USB.

sudo mount /dev/sdX /mnt/dossier
sudo umount /mnt/dossier
</details>

<details> <summary><h2>7. Réseau</h2></summary>

## ip

La commande moderne pour gérer le réseau.

ip [objet] [commande]
ip a (addr) : Affiche les adresses IP.

ip r (route) : Affiche les tables de routage (passerelle).

## ping

Tester la connexion vers une machine.

ping [adresse]
-c 4 : Envoie seulement 4 paquets puis s'arrête.

## ssh

Se connecter à une machine distante sécurisée.

ssh user@machine
-p : Spécifier un port (ex: -p 4242).

## scp

Copier des fichiers via SSH (Secure Copy).

scp [options] source destination
scp fichier user@ip:/dossier : Envoie vers le serveur.

-P : Spécifier le port (Attention P majuscule ici !).

## curl

Récupérer du contenu web ou tester une API.

curl [options] url
-I : Affiche seulement les en-têtes (Headers).

-O : Télécharge le fichier.

## wget

Télécharger des fichiers depuis le web.

wget [url]
## netstat / ss

Afficher les ports ouverts et connexions.

ss [options]
-tulpn : Affiche les ports en écoute (TCP/UDP) et les processus associés.

</details>

<details> <summary><h2>8. Archives et Compression</h2></summary>

## tar

Archiver des dossiers.

tar [options] archive.tar.gz dossier
-c : Créer.

-x : Extraire.

-z : Compresser avec Gzip.

-v : Verbose (voir ce qui se passe).

-f : Fichier (toujours mettre f en dernier).

Mémotechnique extraction : tar -xzvf

## gzip / gunzip

Compresser / Décompresser des fichiers (.gz).

gzip fichier
gunzip fichier.gz
## zip / unzip

Gérer les fichiers .zip.

zip -r archive.zip dossier
unzip archive.zip
</details>

<details> <summary><h2>9. Gestion de Paquets (Debian/Ubuntu)</h2></summary>

## apt update

Mettre à jour la liste des paquets disponibles.

sudo apt update
## apt upgrade

Mettre à jour les logiciels installés.

sudo apt upgrade
## apt install

Installer un logiciel.

sudo apt install [paquet]
## apt remove

Désinstaller un logiciel.

sudo apt remove [paquet]
purge : Désinstalle ET supprime les fichiers de config.

## apt autoremove

Nettoyer les dépendances inutiles.

sudo apt autoremove
</details>