# Module 1 : Genèse, Philosophie et Architecture

## 1. D'où ça vient ? (La petite histoire)

Pour comprendre Linux, il faut remonter aux origines des systèmes d'exploitation modernes.

* **L'ancêtre UNIX (Années 70) :** Créé par Ken Thompson et Dennis Ritchie (le créateur du langage C) chez Bell Labs. Système révolutionnaire, puissant et multi-utilisateurs. Problème : il est devenu payant, propriétaire et son code source fermé.
* **La réponse académique (MINIX) :** Le professeur Andrew Tanenbaum crée MINIX pour enseigner les systèmes d'exploitation. C'est un système éducatif, interdit d'utilisation commerciale.
* **L'étincelle (1991) :** **Linus Torvalds**, un étudiant finlandais frustré par les limitations de MINIX et le prix d'UNIX, crée son propre noyau (kernel) pour le plaisir.

> **L'anecdote :** Au départ, Linus voulait juste créer un émulateur de terminal. Il a posté un message célèbre sur Usenet : *"I'm doing a (free) operating system (just a hobby, won't be big and professional like gnu)..."*.

## 2. Le mariage de raison : GNU + Linux




C'est une distinction technique et politique souvent incomprise. Pour clarifier, utilisons l'analogie de la Voiture 🚗 : 

Imagine que tu veux construire une voiture gratuite et libre pour tout le monde.

**=> Le Projet GNU** (La Carrosserie et les Accessoires) : Dans les années 80, Richard Stallman décide de construire cette voiture. Il fabrique le châssis, le volant, les sièges, le tableau de bord et les outils pour réparer la voiture.

Problème : Il n'arrive pas à fabriquer le moteur. (Leur projet de moteur, appelé Hurd, était trop compliqué et ne marchait pas).

**=> Le Projet Linux** (Le Moteur) : En 1991, Linus Torvalds arrive. Lui, il se fiche des sièges ou du volant. Ce qui l'intéresse, c'est la mécanique pure. Il fabrique un **super moteur (le Kernel)**.

Problème : Un moteur posé par terre, ça ne sert à rien. On ne peut pas le conduire.

**==>L'assemblage (GNU + Linux)** : Quelqu'un a eu l'idée de génie : "Hé, si on mettait le moteur de Linus dans la carrosserie de Stallman ?" Boum ! Ça roule. C'est ce système qu'on utilise aujourd'hui.

### Concrètement, c'est quoi GNU ?
GNU est un projet lancé en **1983** (bien avant Linux) avec un but politique et philosophique : créer un système d'exploitation complet qui soit 100% Libre (aucun secret de fabrication).

Le nom GNU est une blague de développeur (un acronyme récursif) qui veut dire : GNU's Not Unix. Pour dire : "On fonctionne comme Unix, mais on n'est pas Unix (car Unix est payant et fermé)".

Ce que GNU a créé (et que tu utilises tous les jours) :

- Quand tu ouvres ton terminal et que tu tapes des commandes, tu utilises à 90% des outils GNU, pas du Linux :
- Bash : C'est le shell du projet GNU (GNU Bourne-Again SHell).
- CoreUtils : Les commandes ls, cp, mv, rm, cat, mkdir... tout ça, c'est du code écrit par le projet GNU.
- GCC : Le compilateur (GNU Compiler Collection). Sans lui, tu ne pourrais pas compiler tes projets en C. D'ailleurs, sans GCC, Linus Torvalds n'aurait même pas pu compiler son noyau Linux !
- Make : L'outil qui lit ton Makefile. C'est du GNU.

#### Pourquoi Richard Stallman est-il fâché ? 😠
Imagine que tu passes 10 ans à construire toute la **voiture (GNU)**, que quelqu'un arrive à la dernière minute avec juste le **moteur (Linux)**, qu'on assemble le tout... et que le monde entier appelle la **voiture "Une Linux"**.

Tu te sentirais un peu volé, non ? C'est pour ça que **Stallman et la Free Software Foundation insistent pour qu'on dise GNU/Linux**. Pour rappeler que sans les outils GNU, le noyau Linux serait inutile pour un utilisateur normal.

En résumé :

**Linux** = Le Noyau (Gère le matériel, la mémoire, le CPU). C'est la partie "mécanique".

**GNU** = Les Outils et l'interface (Bash, ls, cat, compilateurs). C'est la partie "utilisateur".

**L'équation finale :** Noyau (Linux) + Outils (GNU) = **GNU/Linux** => Un système d'exploitation fonctionnel

## 3. La Philosophie : Libre vs Open Source

Linux a dominé le monde grâce à sa licence : la **GPL (General Public License)**.

* **Open Source :** Le code est visible et accessible.
* **Logiciel Libre (Free Software) :** Une question de liberté, pas de prix.
    * *Free as in Beer* (Gratuit comme une bière offerte).
    * *Free as in Speech* (Libre comme la liberté d'expression).

**La règle d'or de la GPL (Copyleft) :**
Si vous utilisez du code GPL, que vous le modifiez et le redistribuez, vous avez l'obligation de partager vos modifications avec la communauté sous la même licence.

## 4. Kernel vs Shell (Cœur vs Coquille)

Comprendre l'architecture pour ne pas confondre les rôles. Imaginez une noix :

1.  **Hardware (Le centre) :** Processeur, RAM, Disque.
2.  **Kernel (Le Noyau) :** La couche logicielle qui parle directement au matériel.
    * Il gère la mémoire (RAM).
    * Il gère le temps processeur (Scheduling).
    * Il pilote les périphériques (Drivers).
    * *L'utilisateur ne voit jamais le kernel directement.*
3.  **Shell (La Coquille) :** L'interface entre l'utilisateur et le noyau.
    * C'est un programme qui interprète les commandes.
    * Exemples : **Bash**, **Zsh**, **Fish**, **sh**.

## 5. Les Distributions (Distros)

Puisque Linux est libre, n'importe qui peut prendre le noyau Linux, les outils GNU, ajouter un gestionnaire de fenêtres graphique, un système d'installation, et appeler ça "MonOS". C'est ça une Distribution (ou "Distro").

Trois grandes familles dominent :

* **Famille Debian**  :
    * *Philosophie :* Stabilité absolue et respect strict du logiciel libre (Fixed Release).
    * *Gestionnaire de paquets :* `apt` (`.deb`).
    * *Exemples :* Debian, Ubuntu, Kali Linux, Linux Mint.
* **Famille Red Hat** :
    * *Philosophie :* Orientée entreprise et serveurs.
    * *Gestionnaire de paquets :* `dnf` / `yum` (`.rpm`).
    * *Exemples :* RHEL, Fedora, Rocky Linux, CentOS.
* **Famille Arch** :
    * *Philosophie* : "KISS" (Keep It Simple, Stupid). Tu construis ton système brique par brique. Mise à jour en continu (Rolling Release).
    * *Gestionnaire de paquets :* `pacman`.
    * *Exemples :* Arch Linux, Manjaro.

> **La stabilité :** Stable peut signifier "qui ne plante pas" (et c'est souvent lié) mais lorsqu'on parle de la stabilité de l'OS, stable veut dire "qui ne bouge pas".

L'analogie pour comprendre :

**Arch Linux (Rolling Release)** : C'est un chantier permanent. Tu as la dernière version de tout, tout de suite. Les développeurs testent, mais comme le logiciel change tous les jours (version 1.1, puis 1.2, puis 2.0...), tes scripts peuvent casser du jour au lendemain car une fonctionnalité a changé.

**Debian (Fixed Release)** : Ils prennent une photo de tous les logiciels à un instant T. Ils disent "On ne touche plus à rien pendant 2 ans".

Si un logiciel est en version 1.0, il restera en 1.0 pendant toute la vie de la Debian.

S'il y a un bug de sécurité ? On ne passe pas à la version 1.1 (qui pourrait apporter de nouvelles fonctions et donc de nouveaux bugs). On prend le code de la 1.0, on corrige juste la faille à la main (on appelle ça un backport ou un patch), et on garde la 1.0.

## 6. La philosophie UNIX (The Unix Way)

L'état d'esprit à adopter pour utiliser ces systèmes efficacement :

1.  **Faire une seule chose, et la faire bien :** Chaque commande a un but unique (`cat` lit, `grep` filtre).
2.  **Tout est fichier :** (Voir Module 2).
3.  **Collaborer via le texte :** Les programmes communiquent entre eux via des flux de texte (d'où l'importance des pipes `|`).

---

### 🧠 Culture G : Le "Fork"
Un **Fork** se produit quand une partie de la communauté est en désaccord avec l'évolution d'un projet libre. Ils copient le code source et partent dans une autre direction sous un nouveau nom.
*Exemple célèbre :* MySQL (racheté par Oracle) a été "forké" pour créer **MariaDB** (resté libre). C'est pour cela que MariaDB remplace souvent MySQL.

---
