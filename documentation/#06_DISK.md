# Module 6 : Disques, Partitions et LVM

C'est ici que les étudiants échouent le plus souvent lors de l'examen Born2beRoot. Pourquoi ? Parce que le partitionnement demande de comprendre comment s'empilent les couches de stockage.

## 1. Comment Linux voit tes Disques ?

Comme nous l'avons vu : "Tout est fichier". Tes disques durs sont des fichiers dans le dossier `/dev`.

### La Nomenclature
* **`sda`** : **S**CSI **D**isk **A** (Le 1er disque SATA ou USB).
* **`sdb`** : Le 2ème disque...
* **`vda`** : **V**irtual **D**isk **A** (Souvent utilisé dans les machines virtuelles comme B2BR).
* **`nvme0n1`** : Les SSD modernes (NVMe).

### Les Partitions
Un disque est comme un gâteau. On le coupe en parts.
* `sda1` : 1ère partition du disque A.
* `sda2` : 2ème partition du disque A.

## 2. Partitionnement : MBR vs GPT

C'est la "Table des matières" du disque. Elle dit où commence et où finit chaque partition.

* **MBR (Master Boot Record)** : L'ancêtre (Années 80).
    * *Limite :* Max 4 partitions principales. Max 2 To de disque.
    * *Usage :* Encore utilisé pour la compatibilité (BIOS Legacy).
* **GPT (GUID Partition Table)** : Le standard moderne.
    * *Avantages :* Quasi illimité en nombre de partitions et taille.
    * *Usage :* Obligatoire pour les systèmes UEFI modernes.

> Si tu configures ta VM en mode BIOS (classique), tu seras probablement en MBR.

## 3. LVM (Logical Volume Manager) - CRUCIAL

C'est le cœur du sujet.
Sans LVM, une partition a une taille fixe. Si tu as donné 10 Go à `/home` et qu'il est plein, tu es coincé. Il faut formater et recommencer.
**LVM** est une couche d'abstraction qui permet de modifier la taille des "partitions" à chaud, sans redémarrer !

### L'Analogie des Lego 🧱

Imagine que tu as 3 disques durs de tailles différentes.
* **Sans LVM :** Tu as 3 boîtes séparées.
* **Avec LVM :**
    1.  On broie les disques pour en faire une grosse pâte à modeler unique.
    2.  On recrée des morceaux de la taille qu'on veut à partir de cette pâte.

### Les 3 Étages de la fusée LVM

1.  **PV (Physical Volume) - La matière première**
    C'est le disque physique ou la partition brute qu'on "marque" pour être utilisé par LVM.
    * *Commande :* `pvcreate /dev/sda1`

2.  **VG (Volume Group) - Le Réservoir**
    On regroupe un ou plusieurs PV dans un grand groupe (un "super-disque" virtuel).
    Dans Born2beRoot, on te demandera souvent de nommer ton groupe "LVMGroup" ou similaire.
    * *Commande :* `vgcreate MonGroupe /dev/sda1`

3.  **LV (Logical Volume) - La Partition Virtuelle**
    C'est ce que tu découpes dans le VG. C'est ce que le système verra comme une partition finale. Tu peux les agrandir ou réduire à volonté tant qu'il reste de la place dans le VG.
    * *Commande :* `lvcreate -L 5G -n home MonGroupe` (Crée un volume de 5Go nommé "home").



## 4. Le Chiffrement (LUKS)

Le sujet Born2beRoot exige que tes partitions soient chiffrées.
Linux utilise **LUKS** (Linux Unified Key Setup).

**Comment ça marche ?**
C'est comme un coffre-fort.
1.  Le système démarre.
2.  Il voit une partition chiffrée. Il ne peut rien lire (c'est du bruit aléatoire).
3.  Il te demande une **Passphrase**.
4.  Si le code est bon, il "ouvre" le coffre et te donne accès aux données (souvent au LVM qui est caché dedans).

**L'ordre des couches pour B2BR :**
`Disque Physique` -> `Partition` -> `Chiffrement LUKS` -> `LVM (PV > VG > LV)` -> `Système de fichiers (ext4)`

## 5. Le Système de Fichiers (File System)

Une fois que tu as ton LV (ton morceau de disque virtuel), tu dois le **formater** pour pouvoir écrire des fichiers dessus. C'est comme tracer les lignes dans un cahier vierge.

* **ext4** : Le standard de Linux (stable, performant). C'est celui que tu utiliseras à 99%.
* **xfs** : Très performant pour les gros serveurs.
* **btrfs / zfs** : Systèmes avancés avec gestion de snapshots intégrée.
* **fat32 / ntfs** : Systèmes Windows (à éviter pour la racine Linux car ils ne gèrent pas bien les permissions UNIX).

## 6. Montage (Mounting)

Dernière étape : "Accrocher" ta partition formatée à un dossier du FHS.

* Ton volume logique `lv_home` sera monté sur `/home`.
* Ton volume logique `lv_var` sera monté sur `/var`.

Ce lien est défini dans le fichier **`/etc/fstab`** (File System Table).
Si tu te trompes dans ce fichier, le PC ne démarre plus !

---

### 📝 Résumé de la structure B2BR

Voici à quoi ressemblera ton disque à la fin du projet (schématiquement) :

    Disque (/dev/sda)
    ├── Partition 1 (/boot)  [Non chiffrée pour pouvoir démarrer le noyau]
    └── Partition 2 (Chiffrée LUKS)
        └── LVM (Volume Group)
            ├── Logical Volume: root (monté sur /)
            ├── Logical Volume: home (monté sur /home)
            ├── Logical Volume: swap (mémoire virtuelle)
            ├── Logical Volume: var  (monté sur /var)
            └── ... (autres partitions demandées)