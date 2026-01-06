# La Mission : "Opération Chimère" 🕵️‍♂️

**Contexte** : Un administrateur système renégat a caché les codes de lancement de la machine à café (vital pour 42) quelque part dans ce serveur. Il a laissé des pistes, pensant être le seul à maîtriser la commande find. Prouve-lui qu'il a tort.

### Règle du jeu :

- dans un dossier de ton choix, lance le script `find_quest.sh` (vérifier le chemin de `BASE_DIR` par rapport à ton dossier).

- Va dans le dossier playground/find_quest.

- Chaque indice te donne la condition pour trouver le fichier suivant.

- Quand tu trouves un fichier, affiche son contenu (cat) pour avoir l'indice suivant.

- Interdiction d'utiliser ls -R (trop facile et illisible). Tu dois utiliser find.

<br>

--- 

### 🏁 Départ

Ton point de départ est le fichier start_here.txt à la racine du dossier. Lis-le.

## Feuille de route (Aide-mémoire)
Si tu es perdu, voici les objectifs traduits en langage technique (*mais essaie de déduire la commande tout seul d'abord !*).

<details>
<summary><b>VOIR LES INDICES</b></summary>

<br>

**Indice 1** : Trouve le fichier start_here.txt (facile).

<br>

---

<br>

**Indice 2** : Trouve par extension (.config).

<br>

---

<br>

**Indice 3** : Trouve par type (Dossier/Directory).

<br>

---

<br>

**Indice 4** : Trouve par nom insensible à la casse (Case Insensitive).

<br>

---

<br>

**Indice 5** : Trouve par taille exacte (42 octets c).

<br>

---

<br>

**Indice 6** : Trouve par taille minimum (+10 Mégas).

<br>

---

<br>

**Indice 7** : Trouve un fichier vide (Empty).

<br>

---

<br>

**Indice 8** : Trouve par permissions (Exécutable).

<br>

---

<br>

**Indice 9** : Trouve par permissions exactes (444).

<br>

---

<br>

**Indice 1**0 : Trouve par date de modification (+ vieux que X jours).

<br>

---

<br>

**Indice 1**1 : Trouve un fichier contenant une chaine de caractère (Combo find + grep ou
<br>

---

<br>
 find -exec grep).

**Indice 1**2 : Trouve un lien symbolique.

<br>

---

<br>

**Indice 1**3 : Trouve un fichier appartenant à ton utilisateur (-user).

<br>

---

<br>

**Indice 1**4 (BOSS) : Trouve dans un dossier précis, filtré par taille, inverse du no
<br>
m (! -name), et utilise -exec pour afficher le contenu.

</details>

<br>

## Correction

<details> <summary>🚑 <b>CLIQUE ICI POUR VOIR LES SOLUTIONS (Tricheurs !)</b></summary>

Voici les commandes attendues pour chaque étape. Ne regarde que si tu bloques vraiment !
- **Indice 1 :**

```bash
find . -name "start_here.txt"
```
- **Indice 2 :**

```bash
find . -name "*.config"
```
- **Indice 3 :**

```bash
find . -type d -name "ARCHIVES_SECRETES"
```
- **Indice 4 :**

```bash
find . -iname "evidence" # (Note le i devant name)
```
- **Indice 5 :**

```bash
find . -size 42c # (Le c est pour les octets/chars. Sans suffixe, c'est des blocs de 512b !)
```
- **Indice 6 :**

```bash
find . -size +10M
```
- **Indice 7 :**

```bash
find . -type f -empty
```
- **Indice 8 :**

```bash
find . -type f -executable # (Ou -perm /u=x,g=x,o=x)
```
- **Indice 9 :**

```bash
find . -perm 444
```
- **Indice 10 :**

```bash
find . -mtime +3650  # (10 ans * 365 jours = environ 3650 jours)
```
- **Indice 11 :**

```bash
find . -type f -exec grep -l "P4SSW0RD" {} \;  # (Le -l de grep affiche juste le nom du fichier)
```

- **Indice 12 :**

```bash
find . -type l
```
- **Indice 13 :**

```bash
find . -type d -name "*42*"
```

- **Indice 12 (Le Boss Final) :**

```bash
find sector_13 -mtime +1500 -not -name "*.txt" -exec cat {} \;
```
</details>