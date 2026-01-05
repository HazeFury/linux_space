# Module 7 : Réseau, SSH et Pare-feu

Un serveur Linux sans réseau, c'est comme un cerveau dans un bocal : intelligent, mais coupé du monde. Ici, on va apprendre à ouvrir des portes (Ports) et à filtrer qui a le droit d'entrer (Firewall).

## 1. Les Bases : IP et Ports

### L'Adresse IP (L'immeuble)
C'est l'adresse unique de ta machine sur le réseau.
* **Commande historique (dépréciée) :** `ifconfig` (tu la verras souvent dans de vieux tutos).
* **Commande moderne :** `ip addr` (ou `ip a`).
    * Cherche l'interface `eth0` ou `enp0s3`. Tu y verras `inet 192.168.x.x`.

### Le Port (L'appartement)
L'IP amène le visiteur à l'immeuble. Le **Port** l'amène au bon service (au bon appartement).
Il y a 65535 ports disponibles.
* **Ports réservés (0-1023) :** Les "Well-known ports".
    * **22 :** SSH (Administration à distance)
    * **80 :** HTTP (Web)
    * **443 :** HTTPS (Web sécurisé)
* **Ports utilisateurs (1024-65535) :** Libres pour tes applications.

## 2. SSH (Secure Shell)

C'est LE protocole standard pour administrer des serveurs Linux.
Avant, on utilisait `telnet` (qui envoyait les mots de passe en clair sur le réseau 😱). SSH crypte tout. Même si un hacker écoute le câble, il ne voit que du bruit.

### Client vs Serveur
* **Le Serveur (`openssh-server`) :** Installé sur ta VM Born2beRoot. Il écoute et attend les connexions.
* **Le Client :** Ton terminal sur ton PC physique.

### Commande pour se connecter depuis ton PC

```bash
ssh marco@192.168.1.42 -p 1234
# ou
ssh marco@localhost -p 1234 # 'localhost' lorsque le tu te connecte a ta VM en local
```

### La Configuration (`/etc/ssh/sshd_config`)
C'est ici que tu vas sécuriser l'accès. Pour Born2beRoot, tu devras modifier 2 points cruciaux :

1.  **Changer le Port :** Par défaut, SSH écoute sur le 22. Les hackers scannent le port 22 en permanence.
    * *Action :* Changer `Port 22` en `Port 4242`. (Sécurité par obscurité).
    
2.  **Interdire le Root Login :**
    Si un hacker veut entrer, il va essayer le nom d'utilisateur "root" en premier.
    * *Action :* Mettre `PermitRootLogin no`.
    * *Conséquence :* On doit se connecter en tant que `marco`, puis utiliser `su` ou `sudo` pour devenir root. C'est une barrière supplémentaire.

> **⚠️ Important :** Après chaque modification de config, il faut redémarrer le service :
> `sudo systemctl restart ssh`

## 3. UFW (Uncomplicated Firewall)

Linux possède un pare-feu très puissant intégré au noyau : **Netfilter** (manipulé par la commande `iptables`).
Mais `iptables` est complexe et illisible pour un humain normal.
Debian propose **UFW**, une interface simplifiée pour gérer ces règles.

### Le Principe
Par défaut sur un serveur sécurisé : **On ferme TOUT, et on ouvre seulement ce qui est nécessaire.**

### Les Commandes pour B2BR
    
    # 1. Installer UFW (si pas installé)
    sudo apt install ufw
    
    # 2. Activer le pare-feu
    sudo ufw enable
    
    # 3. Ouvrir le port SSH (Attention : utilise le port que tu as choisi !)
    sudo ufw allow 4242
    
    # 4. Vérifier l'état (Doit afficher "Status: active" et la liste des règles)
    sudo ufw status numbered
    
    # 5. Supprimer une règle (si tu t'es trompé)
    sudo ufw delete [numéro_de_la_règle]

## 4. Hostname et Résolution

Ta machine a un petit nom : le **Hostname**.
Pour Born2beRoot, ton login doit apparaître dans le nom (ex: `marco42`).

### Commandes clés
    
    # Voir le nom actuel
    hostnamectl
    
    # Changer le nom (nécessite un redémarrage ou relogin pour être pris en compte partout)
    sudo hostnamectl set-hostname marco42

### Le fichier `/etc/hosts`
C'est l'annuaire local de la machine (l'ancêtre du DNS).
Il permet à la machine de savoir que "marco42" correspond à l'adresse "127.0.0.1" (localhost).
Si tu changes ton hostname, tu dois aussi le mettre à jour ici, sinon `sudo` va devenir très lent (car il cherche à résoudre le nom de la machine à chaque commande).

## 🎓 Résumé de la configuration B2BR

1.  Installer **OpenSSH-Server**.
2.  Modifier `/etc/ssh/sshd_config` (Port 4242 + No Root Login).
3.  Installer **UFW**.
4.  Bloquer tout, sauf le port 4242.
5.  Changer le **Hostname** en `tonlogin42`.

Une fois ceci fait, tu as un serveur "Bunker" accessible uniquement par toi sur un port spécifique.