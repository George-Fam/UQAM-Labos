### Exercice 1
1. **Création et manipulation d'archives**
	1. `tar -cf usr-dict.tar /usr/share/dict`
		- option c - crée un archive
		- option f - spécifie nom archive
	2. `tar -tf usr-dict.tar`
		- option t - Liste contenus d'archive
	3. `tar -C /usr/share/ -cf dict.tar dict`
		- option C - change le rep. d'exec. de tar
	4. `tar -tf dict.tar`
	5. `tar -xvf dict.tar`
		- option x - extrait
		- option v - verbose
	6. `sed -i '1d' dict/french`
		- commande sed - modifie text/fichier
		- option i - Modifie fichier sans affichage au console
		- `'1d'` - supprime 1 ligne
	7. `tar -df dict.tar`
		- option -d, --diff - Compare différences 
			- Non Utile
				- UID et GID - propriétaire différent (root)
			- Utile
				- Mod time - Date de modification 
				- Size - Taiile
	8. `tar -uf dict.tar dict/french`
		- option u (update) - met à jour archive
	9. `tar -tf dict.tar`
		- **tar signifie “Tape ARchiver”** et fonctionne de manière séquentielle. Lorsqu’on met à jour un fichier (option `-u` ou `-r`), tar ajoute simplement un nouveau bloc à la fin de l’archive. Sur une “bande” (tape), on enregistre après ce qui existe déjà. Ainsi le fichier `dict/french` existe dans la version initiale (première occurrence) et dans la nouvelle version (deuxième occurrence).
	10. `tar --delete -f dict.tar dict/french`
		- option delete - Supprime
	11. `tar -rf dict.tar dict/french`
		- option r (append) - ajoute fichiers au fin d'archive
2. **Compression**
	1. Comparaison
		- Taille: 
			- `ls -lh dict.tar` ou `du -h dict.tar`
				- option h - human-readable
		- Somme des tailles:
			- `du -h dict/`
		- Conclusion:
			- Tar ne fait pas de compression par défaut. la taille est donc à peu près la somme des fichiers (plus un léger overhead).
			- Utilise d'autres commandes (algos de compression) pour compression
			- Options de tar peuvent faire compression
				- `-j` bzip2
				- `-J` xz
				- `-z` gunzip / gzip
				- etc
	2. Compression
		1. GZIP
			-  `gzip --keep dict.tar`
				- option keep conserve fichier initial (dict.tar)
		2. BZIP2
			-  `bzip2 --keep dict.tar`
		3. XZ
			-  `xz --keep dict.tar`
	3. Temps de compression
		1. `time gzip --keep dict.tar`
		2. `time bzip2 --keep dict.tar`
		3. `time xz --keep dict.tar`
	4. Taille
		1. `ls -lh dict.tar.*` ou `du -sh dict.tar.*`
		2. Conclusions:
			- `gzip` : plus rapide, ratio de compression plus faible
			- `bzip2` : plus lent que `gzip`, ratio intermédiaire
			- `xz` : plus lent encore, ratio souvent le meilleur
	5. Archive compressés avec tar
		1. Option tar décrit dans 3.1
	6. Extraire avec outils
		- `gunzip dict.tar.gz --keep && tar -xf dict.tar`
			- Décompressez puis extraire
			- Même pour `bzip` et `xz`
	7. Extraire avec tar
		1. Option pour prog de compression
			1. `tar -xzf dict.tar.gz`
			2. `tar -xjf dict.tar.bz2`
			3. `tar -xJf dict.tar.xz`
		2. Auto
			1. `tar -xaf dict.tar.gz`
				-  option a - auto-compress
					- Utilise nom du fichier pour determiner programme de compression
				- Ne peut pas faire `tar -xaf dict.tar.*`
					- `tar -xaf dict.tar.*` regroupe tous les fichiers en un seul appel : `tar` cherche alors une archive multi‐volume, ce qui n’est pas le cas.
					- Alternatif: `find -name "*.tar.*" -exec tar -xaf {} \;`
### Exercice 2
1. `/etc/fstab`
	- Dans le même répertoire `/etc/`, on trouve beaucoup d’autres fichiers de configuration du système (`hostname`, `hosts`, `passwd`, `group`, etc.).
	- Lire plus:
		- `apropos -s 5 fstab`
		- `man fstab`
2. `/etc/passwd`
3. `/usr/bin/passwd`
	- Répertoire pour fichiers binaires (programmes).
	- Sur certaines anciennes distributions, il pouvait être dans `/bin/passwd`
4. `/usr/sbin/useradd`
	- Répertoire pour fichiers binaires accessible au superutilisateur (root)
		- EXTRA: C'est pour cette raison que `su -c "usermod -aG sudo $USER"` ne fonctionne pas (labo1). `usermod` est réservé au super utilisateur.
			- Si vous faites simplement `su -c <commande>` depuis un compte normal, vous conservez une bonne partie de l’environnement de l’utilisateur initial (notamment le `$PATH`). Vous risquez alors de ne pas avoir `/sbin` dans ce chemin, et donc devoir taper l’exécutable avec son chemin complet (`/sbin/ifconfig`, `/usr/sbin/iptables`, etc.) ou bien ajuster le `$PATH` manuellement.
5. `/usr/games/wump`
	- `/usr/games/` contient de nombreux petits jeux
6. `/usr/share/doc/bsdgames/README.hunt.gz`
	- Les **fichiers de documentation** des paquets se trouvent en général dans `/usr/share/doc/NOM_DU_PAQUET/`
	- Lisible avec `zcat` ou `zless`
7. `/var/log/dpkg.log`
	- Sur Debian/Ubuntu, les journaux système se trouvent dans `/var/log`
	- Pour voir la dernière installation, vous pouvez faire : `tail /var/log/dpkg.log`
		- ou consulter /var/log/dpkg.log.1 si le fichier a été *“tourné”* *(logrotate)*.
8. Localiser le fichier contenant le noyau Linux
	- Les fichiers du noyau sont stockés dans `/boot`.
		- `/boot/efi` ou `/efi` pour UEFI
	- Leur nom suit souvent le schéma `vmlinuz-X.Y.Z-ARCH` ou `vmlinux-X.Y.Z-ARCH` (image).
		- `initrd.img-5.X.Y-...` (initramfs).
	- Applicable pour la **plupart** des distributions Linux, mais **Ce n’est pas une règle absolue** pour toutes les distributions.
