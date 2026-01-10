# Module 4 : Utilisateurs, Permissions et Sudo (Sécurité)

Sous Linux, la sécurité repose sur un principe simple : **Tout le monde n'a pas le droit de tout toucher.** C'est un système multi-utilisateurs strict.

## 1. Les Utilisateurs et les Groupes

Il y a trois types d'acteurs sur ton système :
1.  **Root (Super-Utilisateur) :** Il a tous les droits (UID = 0). Il peut supprimer tout le système en une commande.
2.  **Les Utilisateurs Système :** Des comptes créés pour faire tourner des services (ex: `www-data` pour le serveur web). Ils ne peuvent pas se connecter.
3.  **Les Vrais Utilisateurs :** Toi (`marco`), moi, etc.

### Les Fichiers Clés
* `/etc/passwd` : La liste publique des utilisateurs.
    * *Structure :* `marco:x:1000:1000:Marco,,,:/home/marco:/bin/bash`
    * (Nom : Mot de passe masqué : User ID : Group ID : Info : Dossier Home : Shell).
* `/etc/shadow` : **CONFIDENTIEL.** Contient les mots de passe chiffrés (hashés). Seul root peut le lire.
* `/etc/group` : La liste des groupes.

### Pourquoi des Groupes ?
Pour gérer les permissions en masse.
Si tu as 50 étudiants, tu ne vas pas donner l'accès à un fichier un par un. Tu crées un groupe `students`, tu mets tout le monde dedans, et tu donnes l'accès au groupe.

## 2. Les Permissions (Le cœur de la sécurité)

Chaque fichier ou dossier possède une carte d'identité avec 3 niveaux d'accès :
1.  **U**ser (Le propriétaire)
2.  **G**roup (Le groupe propriétaire)
3.  **O**thers (Tout le reste du monde)

Pour chacun de ces niveaux, on définit 3 droits :
* **R**ead (r) : Lire le fichier (ou lister le dossier).
* **W**rite (w) : Modifier/Supprimer le fichier (ou créer dans le dossier).
* **E**xecute (x) : Exécuter le fichier (script/programme) ou traverser le dossier.

### La Notation "ls -l"
Quand tu fais `ls -l`, tu vois ça : `-rwxr-xr--`
Découpons-le :
* `-` : C'est un fichier (si c'était `d`, ce serait un dossier).
* `rwx` (User) : Le proprio peut tout faire.
* `r-x` (Group) : Le groupe peut lire et exécuter, mais pas modifier.
* `r--` (Others) : Le reste du monde peut juste lire.

### La Notation Octale (Mathématiques)
C'est celle qu'on utilise avec la commande `chmod`. Chaque droit a une valeur :
* **R = 4**
* **W = 2**
* **X = 1**

On additionne les chiffres pour obtenir le droit total :
* 7 (4+2+1) = Tout (rwx)
* 6 (4+2) = Lire et Écrire (rw-)
* 5 (4+1) = Lire et Exécuter (r-x)
* 0 = Rien (---)

**Exemple concret :** `chmod 755 fichier`
* 7 (User) : Tout.
* 5 (Group) : Lecture + Exécution.
* 5 (Others) : Lecture + Exécution.

## 3. Les Commandes Vitales

### Gérer les fichiers
* `chmod` (**Ch**ange **Mod**e) : Change les droits.
```bash
chmod 644 mon_fichier.txt
# (Proprio écrit/lit, les autres lisent seulement)
```

* `chown` (**Ch**ange **Own**er) : Change le propriétaire.
```bash    
chown marco:students mon_fichier.txt
# (Appartient à l'user "marco" et au groupe "students")
```

### Gérer les utilisateurs (Commandes Debian)
* `adduser marco` : Crée un utilisateur proprement (crée son home, demande le mot de passe, etc.).
* `deluser marco` : Supprime l'utilisateur.
* `passwd marco` : Change le mot de passe de marco.
* `usermod -aG sudo marco` : Ajoute marco au groupe "sudo".

## 4. SUDO (SuperUser DO)

C'est le chien de garde.
Se connecter en **root** est dangereux (une faute de frappe et c'est la fin). On préfère utiliser un compte normal et demander des droits temporaires.

* `su` (Switch User) : Permet de devenir un autre utilisateur (souvent root). Demande le mot de passe de la CIBLE.
* `sudo` : Permet d'exécuter **une** commande en tant que root. Demande **TON** mot de passe (pour prouver que c'est toi).

### La configuration (`/etc/sudoers`)
C'est ici qu'on décide qui a le droit d'utiliser sudo.
**Règle d'or :** Ne modifie JAMAIS ce fichier avec `nano` ou `vim` directement. Si tu fais une erreur de syntaxe, tu perds l'accès root à jamais (on appelle ça se "lock out").
Utilise toujours la commande sécurisée :
    
    visudo


---

### ⚠️ Le Piège Classique
Si tu crées un script `bonjour.sh` :
1.  Tu l'écris.
2.  Tu essaies de le lancer `./bonjour.sh`.
3.  **Erreur : Permission denied.**
Pourquoi ? Par défaut, un nouveau fichier n'est pas exécutable (sécurité).
Tu dois **toujours** faire :
    
    chmod +x bonjour.sh


## 5. Le Dilemme du Sudo : Quand (ne pas) l'utiliser ?

"Avec de grands pouvoirs viennent de grandes responsabilités."
Utiliser `sudo` à tort et à travers est dangereux pour la stabilité de ton système et la sécurité de tes fichiers. Voici pourquoi et comment décider.

### 1. Pourquoi ne pas l'utiliser tout le temps ?

#### A. Le risque de destruction massive
Quand tu tapes `sudo`, tu enlèves toutes les sécurités.
* **Sans sudo :** `rm -rf /` -> Le système te rit au nez : "Permission denied". Tu es sauvé.
* **Avec sudo :** `sudo rm -rf /` -> Le système obéit. Ton OS est mort.
Une simple faute de frappe dans un script lancé en root peut effacer des dossiers système critiques.

#### B. L'Enfer des Permissions ("Permission Hell") ☠️
C'est le problème n°1 des développeurs.
Imagine : tu crées un projet dans ton dossier perso, mais tu utilises sudo par habitude.

    cd /home/marco/mon_projet
    sudo mkdir dossier_test
    sudo touch dossier_test/fichier.txt

Que se passe-t-il ?
* Le dossier `dossier_test` appartient désormais à **root**, pas à **marco**.
* Le fichier `fichier.txt` appartient à **root**.

Le lendemain, tu ouvres ton éditeur de code (VS Code, Vim...) en tant que `marco` (normal). Tu essaies de sauvegarder une modification dans `fichier.txt`.
**Erreur : Accès refusé.** Tu ne peux plus modifier tes propres fichiers chez toi !
*Résultat :* Tu es obligé de tout `chmod` ou `chown` pour réparer les dégâts.

#### C. La Sécurité
Si tu lances un programme téléchargé sur internet avec `sudo`, tu lui donnes les clés de la maison. S'il contient un virus ou un script malveillant, il peut s'installer partout, se cacher dans le système de démarrage, etc. En utilisateur normal, les dégâts sont limités à ton dossier personnel.

### 2. La Règle d'Or : Système vs Utilisateur

Pour savoir si tu dois utiliser sudo, pose-toi cette question :
**"Est-ce que mon action doit impacter tous les utilisateurs de la machine, ou juste moi ?"**



| Contexte | Action | Sudo ? | Pourquoi ? |
| :--- | :--- | :--- | :--- |
| **Mon Espace** | Créer un fichier dans `/home/marco` | ❌ **NON** | C'est chez toi. Tu es déjà le roi ici. |
| **Logiciel Global** | Installer `git` ou `vim` (`apt install`) | ✅ **OUI** | Ça touche `/bin` et `/usr`, donc tout le système. |
| **Logiciel Local** | Installer un paquet Python/Node (`npm`, `pip`) | ❌ **NON** | Installe-les dans ton dossier perso pour ne pas casser les libs du système. |
| **Configuration** | Modifier `/etc/ssh/sshd_config` | ✅ **OUI** | C'est la config du système. |
| **Configuration** | Modifier `~/.bashrc` | ❌ **NON** | C'est TA config personnelle. |
| **Service** | Redémarrer un serveur (`systemctl`) | ✅ **OUI** | Les services tournent pour tout le monde. |
| **Scripting** | Lancer un script de test | ❌ **NON** | Sauf s'il doit modifier des fichiers système. |
| **Ports Réseau** | Ouvrir un port < 1024 (ex: port 80) | ✅ **OUI** | Les "petits" ports sont réservés à root. |

### 3. Le Principe de Moindre Privilège

C'est un concept de cybersécurité fondamental.
> **"On ne doit accorder à un utilisateur ou un processus que les droits strictement nécessaires pour accomplir sa tâche, et rien de plus."**

Si tu peux faire quelque chose sans sudo, **fais-le sans sudo**.
Si tu as un doute ("Permission denied"), demande-toi :
1.  *Est-ce que j'essaie d'écrire dans un dossier système ?* -> Si oui, `sudo` est légitime.
2.  *Est-ce que j'essaie d'écrire chez moi ?* -> Si oui, c'est que les permissions sont cassées, il faut réparer avec `chown`, pas forcer avec `sudo`.

### 4. Bonnes Pratiques avec le sudo

* **Vérifie toujours ta commande avant Entrée :** Surtout avec `rm`, `mv` ou `dd`.
* **N'utilise pas `sudo su` ou `sudo -i` par paresse :** Rester connecté en permanence en tant que root dans ton terminal est risqué. Utilise `sudo commande` au coup par coup. Cela laisse une trace dans les logs (audit) de chaque action privilégiée.
* **Utilise `visudo` :** Pour modifier la configuration de sudo, n'édite jamais `/etc/sudoers` directement.