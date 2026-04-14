# dotfiles — Configuration Git & SSH pour étudiants

Ces scripts automatisent la configuration de Git et SSH sur votre machine. Ils sont utiles si vous suivez **INF1070**, **INF2050**, ou n'importe quel cours où vous utilisez Linux ou Git (notamment avec GitHub ou le GitLab de l'UQAM).

Au lieu de taper manuellement une dizaine de commandes `git config` et `ssh-keygen` à chaque nouvelle machine, vous remplissez un fichier JSON et vous lancez un script — c'est tout.

---

## Contenu

| Fichier          | Rôle                                                        |
| ---------------- | ----------------------------------------------------------- |
| `gitconfig.json` | Vos paramètres Git (à personnaliser)                        |
| `gitconfig.ps1`  | Script qui applique `gitconfig.json` à votre `~/.gitconfig` |
| `sshconfig.json` | Vos hôtes SSH (à personnaliser)                             |
| `sshconfig.ps1`  | Script qui génère vos clés SSH et configure `~/.ssh/config` |
| `.bashrc`        | Fichier de configuration Bash                               |
| `nvim/`          | Configuration Neovim complète (NvChad)                      |

---

## Prérequis

- **PowerShell 5.1+** (Windows) ou **PowerShell 7+** (Linux/macOS)
  - Sur Linux : `sudo apt install powershell` ou équivalent selon votre distro
- **Git** installé et accessible dans le PATH
- **OpenSSH** installé (inclus par défaut sur Windows 10/11 et la plupart des Linux)

---

## 1. Configuration Git : `gitconfig.ps1`

### Ce que ça fait

- Applique des **paramètres globaux** utiles (`init.defaultBranch = main`, meilleur algorithme de diff, push automatique, etc.)
- Installe des **alias** pratiques (`git st`, `git co`, `git adog`, etc.)
- Configure des **identités conditionnelles** : Git choisit automatiquement le bon nom/courriel selon le remote du dépôt (pratique si vous avez un compte GitHub personnel et un compte GitLab UQAM)

### Comment l'utiliser

**Étape 1 : Copiez et personnalisez le JSON**

```
cp gitconfig.json gitconfig.local.json   # ou modifiez gitconfig.json directement
```

> Pour un usage simple (un seul compte), vous pouvez mettre `"identities": []` et remplir seulement `defaultIdentity`.

**Étape 2 : Lancez le script**

```powershell
./gitconfig.ps1
```

Le script est **idempotent** : vous pouvez le relancer autant de fois que vous voulez sans casser votre config.

**Bonus : Optimiser un grand dépôt**

```powershell
./gitconfig.ps1 -RepoPath "C:\chemin\vers\grand-depot"
```

Cela active `core.fsmonitor` et `core.untrackedCache` localement pour accélérer Git sur les gros projets.

### Alias installés

| Alias              | Commande complète                           |
| ------------------ | ------------------------------------------- |
| `git st`           | `git status`                                |
| `git ci`           | `git commit`                                |
| `git co`           | `git checkout`                              |
| `git br`           | `git branch`                                |
| `git ac "message"` | `git commit -am "message"`                  |
| `git adog`         | Log graphique compact (toutes les branches) |
| `git adogr`        | Log graphique avec dates relatives          |
| `git adoga`        | Log graphique avec auteur                   |

---

## 2. Configuration SSH : `sshconfig.ps1`

### Ce que ça fait

Pour chaque hôte défini dans `sshconfig.json`, le script :

1. **Génère une clé ed25519** si elle n'existe pas encore
2. **Ajoute la clé à l'agent SSH** (active le service sur Windows si nécessaire)
3. **Met à jour `~/.ssh/config`** avec le bon bloc `Host`
4. **Affiche la clé publique** avec les instructions pour l'ajouter sur GitHub / GitLab, et la copie dans le presse-papiers

### Comment l'utiliser

**Étape 1 : Personnalisez `sshconfig.json`**

```json
{
  "hosts": [
    {
      "alias": "github",
      "hostname": "github.com",
      "keyFile": "id_ed25519_github",
      "keyComment": "votre-username@github"
    },
    {
      "alias": "gitlabUqam",
      "hostname": "gitlab.info.uqam.ca",
      "keyFile": "id_ed25519_gitlab_uqam",
      "keyComment": "prenom.nom.XX@courrier.uqam.ca"
    }
  ]
}
```

> `alias` est le nom que vous utiliserez dans vos URLs SSH.
> Exemple : `git clone git@gitlabUqam:INF2050/tp1.git`

**`alias` est optionnel.** Si vous l'omettez, le `hostname` est utilisé directement dans `~/.ssh/config` et dans vos URLs SSH :

```json
{
  "hosts": [
    {
      "hostname": "github.com",
      "keyFile": "id_ed25519_github",
      "keyComment": "votre-username@github"
    }
  ]
}
```

> Sans alias, vous utilisez le hostname tel quel : `git clone git@github.com:user/repo.git`

**Étape 2 : Lancez le script**

```powershell
./sshconfig.ps1
```

Le script affichera vos clés publiques et les instructions pour les ajouter sur chaque service.

**Afficher les clés sans rien modifier**

```powershell
./sshconfig.ps1 -ShowKeys
```

Utile si vos clés existent déjà et que vous voulez juste retrouver la clé publique à copier.

**Tester la connexion**

Avec alias :
```powershell
ssh -T git@github       # doit afficher "Hi username!"
ssh -T git@gitlabUqam   # doit afficher "Welcome to GitLab, @username!"
```

Sans alias :
```powershell
ssh -T git@github.com            # doit afficher "Hi username!"
ssh -T git@gitlab.info.uqam.ca   # doit afficher "Welcome to GitLab, @username!"
```

---

## Flux rapide : Nouvelle machine

```powershell
# 1. Cloner ce dépôt (ou copier les fichiers)
# 2. Personnaliser gitconfig.json et sshconfig.json
# 3. Configurer Git
./gitconfig.ps1

# 4. Générer les clés SSH et configurer ~/.ssh/config
./sshconfig.ps1

# 5. Ajouter les clés publiques affichées sur GitHub / GitLab UQAM
# 6. Tester
ssh -T git@github
ssh -T git@gitlabUqam
```

---

## 3. Configuration Bash : `.bashrc`

### Ce que ça fait

- Définit des **alias pratiques** pour les commandes courantes (`ls`, `cp`, `mv`, `rm`, etc.)
- Ajoute des **fonctions utilitaires** : navigation rapide, extraction d'archives, recherche de texte
- Configure l'**historique Bash** pour conserver plus d'entrées

### Comment l'utiliser

```bash
cp dotfiles/.bashrc ~/.bashrc && source ~/.bashrc
```

> **Note pour INF1070** : certains alias portent le même nom que des commandes standard et changent silencieusement leur comportement lors de l'exécution. Consultez [INF1070/README.md](../INF1070/README.md) pour les mises en garde à prendre en compte lors des TPs.

---

## 4. Configuration Neovim : `nvim/`

Un environnement Neovim complet basé sur **NvChad v2.5**, avec LSP, formatage automatique, et raccourcis pensés pour le développement.

Voir [nvim/README.md](nvim/README.md) pour les détails d'installation et la liste complète des raccourcis.

```bash
cp -r dotfiles/nvim ~/.config/nvim
nvim   # lazy.nvim installe tout au premier lancement
```

---

## Notes

- Les scripts ne **lisent jamais** vos clés privées ni vos mots de passe.
- Aucune valeur sensible ne devrait se retrouver dans les fichiers JSON.
