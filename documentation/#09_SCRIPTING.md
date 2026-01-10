# 🐚 Le Guide de Survie du Bash Scripting

Le Bash (Bourne Again SHell) est bien plus qu'un simple interpréteur de commandes. C'est un langage de programmation complet qui permet d'automatiser tout ce que tu fais manuellement dans ton terminal.

## Sommaire

1.  [Le Shebang](#1-le-shebang)
2.  [Les Variables](#2-les-variables)
3.  [Les Arguments](#3-les-arguments)
4.  [Les Conditions (If/Else)](#4-les-conditions-ifelse)
5.  [Les Boucles (For/While)](#5-les-boucles-forwhile)
6.  [Les Fonctions](#6-les-fonctions)
7.  [Codes de Retour et Exit](#7-codes-de-retour-et-exit)
8.  [Opérations Arithmétiques](#8-opérations-arithmétiques)
9.  [Débogage](#9-débogage)

---

## 1. Le Shebang

C'est la toute première ligne obligatoire d'un script. Elle indique au système quel interpréteur utiliser pour lire le fichier.
```bash
#!/bin/bash
```

*Sans ça, le système utilisera le shell par défaut de l'utilisateur, qui n'est pas forcément bash (ça peut être zsh, sh, dash...).*

---

## 2. Les Variables

En Bash, les variables n'ont pas de type (int, string, etc.), tout est texte par défaut.

**Règle d'or :** Pas d'espace autour du signe égal `=` lors de l'assignation !

```bash
# Assignation
PRENOM="Marco"
ECOLE="42"

# Utilisation (avec $)
echo "Bonjour $PRENOM"

# Bonne pratique : Utiliser des accolades pour éviter les confusions
echo "Je suis à l'${ECOLE}Lyon"

**Les Quotes (Guillemets) :**
* `"Double Quotes"` : Interprètent les variables (affiche *Marco*).
* `'Single Quotes'` : N'interprètent RIEN (affiche *$PRENOM* littéralement).
```

---

## 3. Les Arguments

Quand tu lances un script (ex: `./script.sh arg1 arg2`), tu peux récupérer ces valeurs à l'intérieur.

	$0  : Le nom du script lui-même.
	$1  : Le premier argument.
	$2  : Le deuxième argument.
	$#  : Le nombre total d'arguments passés.
	$@  : La liste de tous les arguments.

**Exemple :**

```bash
echo "Tu as lancé le script $0 avec $# arguments."
echo "Le premier argument est : $1"
```

---

## 4. Les Conditions (If/Else)

La syntaxe est stricte. Les espaces à l'intérieur des crochets `[ ]` sont **obligatoires**.

```bash
if [ "$1" == "Marco" ]; then
	echo "Accès autorisé."
elif [ "$1" == "Root" ]; then
	echo "Bienvenue Maître."
else
	echo "Accès refusé."
fi
```

**Les Comparateurs :**

* **Pour les Textes (Strings) :**
    * `==` ou `=` : Égal à.
    * `!=` : Différent de.
    * `-z` : La chaîne est vide (Zero length).
    * `-n` : La chaîne n'est pas vide (Non-zero).

* **Pour les Nombres (Integers) :**
    * `-eq` : Égal (Equal).
    * `-ne` : Différent (Not Equal).
    * `-lt` : Plus petit que (Lower Than).
    * `-gt` : Plus grand que (Greater Than).
    * `-le` / `-ge` : Plus petit/grand ou égal.

---

## 5. Les Boucles (For/While)

Pour répéter des actions.

**Boucle FOR (Pour une liste ou un range) :**

```bash
# Itérer sur une liste de mots
for user in Marco Pierre Paul; do
	echo "Utilisateur : $user"
done

# Itérer sur une suite de nombres
for i in {1..10}; do
	echo "Numéro $i"
done
```

**Boucle WHILE (Tant que...) :**

```bash
COUNT=0
while [ $COUNT -lt 5 ]; do
	echo "Compteur : $COUNT"
	COUNT=$((COUNT + 1))  # Incrémentation
done
```

---

## 6. Les Fonctions

Pour organiser ton code et ne pas te répéter.

```bash
ma_fonction() {
	echo "Ceci est une fonction"
	local variable_locale="Je n'existe que dans la fonction"
}

# Appel de la fonction
ma_fonction
```

*Note : Les arguments passés à une fonction fonctionnent comme ceux du script (`$1`, `$2`...) mais sont propres à la fonction.*

[🔎 Focus : Les Arguments dans les Fonctions Bash](./#10_FOCUS.md)

---

## 7. Codes de Retour et Exit

Chaque commande sous Linux renvoie un "Exit Status" (code de retour) quand elle termine.
* `0` = Succès (Tout va bien).
* `1` à `255` = Erreur.

Tu peux récupérer le code de la *dernière* commande exécutée avec `$?`.

```bash
ls /dossier_inexistant

if [ $? -ne 0 ]; then
	echo "La commande précédente a échoué !"
	exit 1  # On arrête le script avec une erreur
fi
```

---

## 8. Opérations Arithmétiques

Bash ne sait pas calculer nativement sans une syntaxe spéciale : `(( ... ))`.

```bash
A=10
B=5

# Calcul
RESULTAT=$((A + B))

echo "Le résultat est $RESULTAT"
```

---

## 9. Débogage

Ton script plante et tu ne sais pas pourquoi ? Lance-le avec l'option `-x`. Cela affichera chaque ligne exécutée dans le terminal.

```bash
bash -x ./mon_script.sh
```

Ou ajoute ceci dans le script pour déboguer une section précise :

```bash
set -x  # Active le debug
# ... code problématique ...
set +x  # Désactive le debug
```
