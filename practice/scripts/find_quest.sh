#!/bin/bash

# --- CONFIGURATION ---
BASE_DIR="../playground/find_quest"
echo "🚧 Préparation de la scène de crime dans $BASE_DIR..."

# Nettoyage si jamais ça existe déjà
rm -rf $BASE_DIR
mkdir -p $BASE_DIR
cd $BASE_DIR

# --- GÉNÉRATION DU BRUIT (Le Bazar) ---
# On crée 50 dossiers avec des sous-dossiers et des fichiers bidons
echo "📦 Génération de milliers de fichiers inutiles..."
for i in {1..20}; do
    mkdir -p "sector_$i/sub_sector_$RANDOM"
    # Création de fichiers txt aléatoires
    for j in {1..10}; do
        echo "Ceci est du bruit. Rien à voir ici." > "sector_$i/noise_$j.txt"
        echo "Log error: timeout" > "sector_$i/system_$j.log"
    done
done

#############################################################################

# --- PLACEMENT DES INDICES (La Chasse) ---
echo "🔑 Dissimulation des indices..."

# Niveau 1 : Nom simple
echo "Indice 2 : Cherche un fichier qui finit par '.config' mais qui n'est pas dans le dossier courant." > "start_here.txt"

# Niveau 2 : Extension
mkdir -p "sector_7/backup"
echo "Indice 3 : Trouve le dossier nommé 'ARCHIVES_SECRETES' (C'est un dossier, pas un fichier !)." > "sector_7/backup/network.config"

# Niveau 3 : Type (Dossier)
mkdir -p "sector_12/hidden/ARCHIVES_SECRETES"
touch "sector_12/hidden/ARCHIVES_SECRETES/note.txt"
echo "Indice 4 : Cherche un fichier nommé 'evidence' peu importe s'il est en majuscule ou minuscule (Case Insensitive)." > "sector_12/hidden/ARCHIVES_SECRETES/note.txt"

# Niveau 4 : Insensible à la casse
mkdir -p "sector_3/deep"
echo "Indice 5 : Trouve un fichier qui pèse exactement 42 octets." > "sector_3/deep/EviDencE"

# Niveau 5 : Taille précise (42 bytes)
# On écrit exactement 41 char + 1 retour à la ligne = 42 octets
echo "Indice 6 : Cherche fichier > 10Mo." > "sector_9/size_matters.txt"
# On s'assure qu'il fait 42 octets (padding si besoin)
truncate -s 42 "sector_9/size_matters.txt"

# Niveau 6 : Taille > 10Mo
mkdir -p "sector_15/heavy"
dd if=/dev/zero of="sector_15/heavy/big_data.bin" bs=1M count=15 status=none
# On cache l'indice dans un fichier à côté car on ne peut pas lire le binaire facile
echo "Indice 7 : Trouve un fichier vide (0 octet)." > "sector_15/heavy/readme_big_data.txt"

# Niveau 7 : Fichier vide
touch "sector_2/void_sadness.tmp"
# L'indice est dans le nom du fichier suivant, car on ne peut pas lire un fichier vide ^^
# On met l'indice dans un fichier à côté
echo "Indice 8 : Trouve un fichier qui est EXÉCUTABLE par tout le monde." > "sector_2/next_step.info"

# Niveau 8 : Permissions (Executable)
echo "echo 'Indice 9 : Trouve un fichier en lecture seule (444)" > "sector_5/runner.sh"
chmod +x "sector_5/runner.sh"

# Niveau 9 : Permissions (Lecture seule 444)
echo "Indice 10 : Trouve un fichier modifié il y a plus de 10 ans." > "sector_18/locked.data"
chmod 444 "sector_18/locked.data"

# Niveau 10 : Time (Vieux fichier)
mkdir -p "sector_1/museum"
echo "Indice 11 : Trouve un fichier qui contient le mot 'P4SSW0RD' à l'intérieur." > "sector_1/museum/artifact.old"
touch -d "2010-01-01" "sector_1/museum/artifact.old"

# Niveau 11 : Contenu (Grep)
mkdir -p "sector_10/logs"
echo "Indice 12 : Trouve un lien symbolique nommé 'warp_zone'." > "sector_10/logs/app.log"
echo "Erreur critique. P4SSW0RD = 'BananaSplit'" > "sector_10/logs/auth_error.log"
echo "Connexion ok." > "sector_10/logs/access.log"

# Niveau 12 : Inode / Hard Link (Compliqué, on va faire plus simple pour l'instant : Lien Symbolique)
ln -s "../sector_1" "sector_4/warp_zone"
# On met l'indice dans un fichier texte dans le dossier pointé par le lien (sector_1)
echo "Indice 13 : Trouve un dossier qui contient "42"." > "sector_1/congrats.txt"

# Niveau 13 : Groupe (ou user) + Suppression
mkdir -p "sector_17/sub_sector_1258963242981452000019"
echo "Indice 14 : Le Boss Final. Trouve un fichier dans 'sector_13' qui n'est PAS un fichier .txt, et exécute 'cat' dessus automatiquement." > "sector_17/sub_sector_1258963242981452000019/my_file.user"

# Niveau 14 : Combo (Find + Exec)
mkdir -p "sector_13/vault"
echo "BRAVO ! LE CODE SECRET EST : 42_L1NUX_M4ST3R" > "sector_13/vault/final_flag.md"
touch -d "2020-01-01" "sector_13/vault/final_flag.md"

echo "✅ Environnement prêt. Rends-toi dans $BASE_DIR et commence par lire 'start_here.txt'"