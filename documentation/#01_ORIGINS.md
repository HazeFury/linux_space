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

<br>

<br>


# L'Histoire de Debian : Le Système Universel

Debian n'est pas juste une distribution Linux parmi d'autres. C'est l'une des plus anciennes, des plus respectées et des plus influentes de l'histoire de l'Open Source. C'est la "mère" de nombreuses distributions modernes (comme Ubuntu ou Kali Linux).

## 1. La Genèse (1993)

Tout commence le **16 août 1993**. Ian Murdock, un étudiant universitaire américain, n'est pas satisfait de la distribution dominante de l'époque (SLS). Il trouve qu'elle est mal maintenue et buggée.

Il rédige alors le **"Manifeste Debian"**.

Son objectif est radical pour l'époque : créer une distribution qui ne soit pas gérée par une entité commerciale ou une seule personne, mais qui soit construite ouvertement, dans l'esprit de Linux et de GNU.

> **L'anecdote du nom :**
> D'où vient le nom "Debian" ? C'est une contraction romantique.
> **Deb**ra (la petite amie d'Ian Murdock à l'époque) + **Ian** (lui-même) = **Debian**.

## 2. La Philosophie : Le Contrat Social

Ce qui rend Debian unique, c'est qu'il n'y a pas d'entreprise derrière (contrairement à RedHat, Suse ou Ubuntu). C'est une organisation bénévole et démocratique.

Pour garantir que le projet ne dévie jamais de ses idéaux, les développeurs ont signé le **Contrat Social Debian**. Ses points clés sont :

1.  **Debian restera 100% libre :** C'est le point le plus important. C'est pour cela que, par défaut, Debian n'inclut pas les pilotes propriétaires (Wifi, Carte Graphique) s'ils ne sont pas Open Source.
2.  **Nous rendrons à la communauté :** Toutes les améliorations faites pour Debian doivent être remontées aux auteurs originaux des logiciels.
3.  **On ne cache pas les problèmes :** La base de bugs est publique.

C'est cette rigueur (les **DFSG** - Debian Free Software Guidelines) qui fait que Debian est parfois jugée "austère" par les débutants, mais "pure" par les experts.

## 3. Les Dates Clés

* **1993 :** Annonce du projet par Ian Murdock.
* **1996 :** Sortie de la version 1.1 (Nom de code "Buzz"). C'est la première version stable utilisant le noyau Linux 2.0.
* **1999 :** Introduction d'**APT** (Advanced Package Tool). C'est une révolution. Avant cela, gérer les dépendances (installer A qui a besoin de B qui a besoin de C) était un enfer manuel. APT a automatisé tout ça et a donné à Debian un avantage technologique énorme.
* **2015 (Debian 8 "Jessie") :** Le grand changement technique. Debian passe au système d'initialisation **Systemd** par défaut, s'alignant sur les standards modernes malgré une forte résistance d'une partie de la communauté (les puristes d'UNIX).

## 4. Culture : La Connection Pixar (Toy Story)

Tu as sûrement remarqué que les versions de Debian ont des noms bizarres (Bookworm, Bullseye, Buster...).
C'est un hommage aux films **Toy Story** de Pixar.

Pourquoi ? Parce que **Bruce Perens**, qui a pris la tête du projet après Ian Murdock, travaillait chez Pixar à l'époque !

* **Buzz** (Debian 1.1) : Buzz l'éclair.
* **Rex** (Debian 1.2) : Le dinosaure.
* **Bo** (Debian 1.3) : La bergère.
* **Potato** (Debian 2.2) : M. Patate.
* **Woody** (Debian 3.0) : Le cow-boy.
* **Sarge** (Debian 3.1) : Le sergent.
* **Wheezy** (Debian 7) : Le pingouin asthmatique.
* **Jessie** (Debian 8) : La cow-girl.
* **Stretch** (Debian 9) : La pieuvre.
* **Buster** (Debian 10) : Le chien d'Andy.
* **Bullseye** (Debian 11) : Le cheval (Pile-Poil).
* **Bookworm** (Debian 12 - Actuelle stable) : Le ver de bibliothèque.
* **Trixie** (Debian 13 - Future stable) : Le tricératops.

**Le cas spécial : "Sid"**
Dans les films, **Sid** est le voisin méchant qui casse les jouets.
Chez Debian, la version "Unstable" (celle où les développeurs testent les nouveaux paquets et où tout peut casser) s'appelle toujours **Sid**.
* *Moyen mémotechnique :* "Sid casse les jouets".

## 5. Les branches de la famille

Debian est tellement solide qu'elle sert de base à des centaines d'autres distributions. On l'appelle souvent une "Meta-distribution".

* **Ubuntu :** C'est une Debian "polie" et rendue facile d'accès par l'entreprise Canonical.
* **Kali Linux :** C'est une Debian bourrée d'outils de sécurité pour le pentest (utilisée par les hackers éthiques).
* **Tails :** La distribution de l'anonymat (utilisée par Edward Snowden), basée sur Debian.
* **Raspbian (Raspberry Pi OS) :** Une Debian optimisée pour les processeurs ARM des Raspberry Pi.

## 6. Pourquoi choisir Debian pour un serveur ?

1.  **La Stabilité Légendaire :** "Debian Stable" est testée pendant des mois/années. Elle ne plante pas. C'est la référence pour les serveurs.
2.  **La Sécurité :** L'équipe de sécurité Debian est très réactive.
3.  **L'Administration Système pure :** Contrairement à Ubuntu qui pré-installe et pré-configure beaucoup de choses (Sudo, SSH...), Debian vient "nue". C'est parfait pour **apprendre** à tout monter soi-même (le but de Born2beRoot).
