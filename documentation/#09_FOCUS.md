# Focus : APT vs APTITUDE

Si `dpkg` est le mécanicien qui installe les pièces, `apt` et `aptitude` sont les architectes qui décident quelles pièces sont nécessaires.

## 1. APT (Advanced Package Tool)
C'est la commande standard et moderne recommandée pour l'utilisation quotidienne.

* **Ce qu'il fait :** C'est une surcouche "intelligente" à `dpkg`. Il gère les dépôts (sources internet), télécharge les paquets et résout les dépendances simples.

* **Son histoire :** Avant, on utilisait `apt-get` (pour installer) et `apt-cache` (pour chercher). La commande `apt` a été créée pour fusionner les deux et offrir une interface plus jolie (barre de progression, couleurs).
* **Utilisation :** Simple, rapide, efficace.

```bash
sudo apt update && sudo apt upgrade
sudo apt install git
```

## 2. APTITUDE
C'est un gestionnaire de paquets de "haut niveau", souvent préféré par les administrateurs système chevronnés pour des tâches complexes.

- **La différence visuelle** : Si tu tapes juste `aptitude` sans argument, tu entres dans une interface graphique textuelle (Ncurses) avec des menus navigables à la souris et au clavier.

- **La différence technique** : `aptitude` possède un algorithme de résolution de dépendances plus "agressif" et intelligent qu'`apt`.

	- Si une installation bloque à cause d'un conflit de versions, `apt` va souvent abandonner.

	- `aptitude` va te proposer plusieurs scénarios (solutions) : "Je peux désinstaller X pour installer Y, ou alors garder l'ancienne version de Z..."

- **Le nettoyage** : Il est réputé pour mieux gérer la suppression des paquets orphelins (les dépendances qui ne servent plus à rien).

## ⚔️ Le verdict
Utilise `apt` pour 99% de tes besoins quotidiens et tes scripts. C'est le standard actuel.

Utilise `aptitude` uniquement si tu es coincé dans un "Dependency Hell" (conflit de paquets insoluble) et que tu as besoin qu'on te propose des solutions complexes.