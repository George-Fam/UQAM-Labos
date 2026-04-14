# INF2050 - Outils et pratiques de développement logiciel

Ce dossier regroupe tout le matériel que j’ai conçu en tant qu’auxiliaire d’enseignement pour **INF2050** : présentations, solutions détaillées, supports visuels et questionnaires interactifs.

## Contenu

Le projet est organisé par laboratoire, chacun comprenant selon le cas :

- **Diapositives** utilisées pendant les séances
- **Fichiers de solutions** servant de support lors des explications
- **Autre matériel visuel**
- **Liens vers les questionnaires Kahoot** utilisés comme activité interactive

## Matériel interactif

Tous les quiz utilisés en laboratoire sont accessibles ici : [Kahoot - INF2050](https://create.kahoot.it/course/a2d54ba9-c86c-4227-8a51-58c310b27f08)

## Fichiers de configuration

### Git config

Un outil de configuration Git est disponible dans le dossier [`dotfiles/`](../dotfiles/) à la racine du dépôt.  
Il configure les paramètres globaux recommandés (algorithme de diff, push automatique, fetch avec pruning, etc.), des alias utiles (`adog`, `st`, `ci`, `co`, etc.), et la gestion d'identités conditionnelles par dépôt.

**Utilisation (PowerShell — Windows/Linux/macOS) :**

```powershell
# Configurer git globalement
./dotfiles/gitconfig.ps1

# Appliquer uniquement les optimisations pour un gros dépôt
./dotfiles/gitconfig.ps1 -RepoPath "chemin/vers/repo"
```

Personnalisez d'abord `dotfiles/gitconfig.json` avec votre nom, courriel et patterns de dépôts.

### Bashrc

Un `.bashrc` avec des alias et fonctions utiles est également disponible dans [`dotfiles/`](../dotfiles/).  
Pour l'utiliser :

```bash
cp dotfiles/.bashrc ~/.bashrc && source ~/.bashrc
```

Consultez [dotfiles/README.md](../dotfiles/README.md) pour la liste complète des alias et fonctions inclus.

### Outil SSH

Un outil de configuration SSH est également disponible dans [`dotfiles/`](../dotfiles/).  
Il génère vos clés SSH et configure `~/.ssh/config` pour GitHub et/ou le GitLab de l'UQAM.

**Utilisation (PowerShell — Windows/Linux/macOS) :**

```powershell
./dotfiles/sshconfig.ps1
```

Pour les détails (options, format de `sshconfig.json`, test de connexion), consultez [dotfiles/README.md](../dotfiles/README.md).

## Référence officielle des laboratoires

Pour les instructions officielles et les énoncés complets des laboratoires du cours, consultez le site officiel du cours : [INF2050](https://inf2050.uqam.ca/fr/)

