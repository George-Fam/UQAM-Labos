1. ### Adresses IPs
- `ip addr`, `ip a`
    - Explique Interfaces (loopback, eth0, wlan0)
- `dig +short myip.opendns.com @resolver1.opendns.com`
    - `dig +short text ch whoami.cloudflare @1.0.0.1` 
    - `dig TXT +short o-o.myaddr.l.google.com @ns1.google.com`
2. ### Sockets
    1. #### Bases de netcat
        - `nc -l 3333 | rev`
            - `nc -l 3333`
        - `nc -kl 3333 | rev`
            - `nc -kl 3333`
    2. #### Comms Resaux
        - Étudiant A: `nc -l 3333`
        - Étudiant B: `echo "Bonjour" | nc private_ip_addr_A 3333`
        - Vice-versa
3. ### Tester les connexions avec ping
    - Loopback: `ping 127.0.0.1` ou `ping ::1` (IPV6)
    - Camarade: `ping private_ip_camarade`
    - Broadcast: `ping -b -c 2 addr_broadcast` (géner. addr res avec hote 255)
    - Uqam: `ping www.etudier.uqam.ca`
4. ### ARP cache
    - Le cache ARP (Address Resolution Protocol) stocke les correspondances entre adresses IP et adresses MAC. Il est utilisé par TCP/IP pour déterminer l'adresse physique correspondant à une adresse IP avant d'envoyer des paquets sur un réseau local.
    - Consultez ARP actuel: `arp -a` ou `ip neigh show`
    - Effacez addr: `sudo arp -d addr` ou `sudo ip neigh del addr dev interface`
    - Ping addr effacée: `ping -c 1 addr`
        - cache reconstruit automatiquement: observez avec `arp -a`
5. ### Téléchargement
    1. #### Interrompre et relancer un téléchargement
        - `curl -O https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.9.tar.xz`
        - Interrompre
        - Relancez: `curl -C - -O lien`
    2. #### Charger locaux
Script:
```bash
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 sigle_cours"
    exit 1
fi

curl -s "https://etudier.uqam.ca/cours?sigle=$1" |
   grep -Eo '[A-Z]{1,2}\-[A-Z][0-9]{3,4}'
```
6. ### Kahoot
- https://create.kahoot.it/share/inf1070-lab-13/28824893-9e33-438b-ae0d-e1312be9eaee
