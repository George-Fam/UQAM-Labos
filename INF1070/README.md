# INF1070 - Utilisation et administration des systèmes informatiques

Ce dossier regroupe tout le matériel que j’ai conçu en tant qu’auxiliaire d’enseignement pour **INF1070** : présentations, solutions détaillées, supports visuels et questionnaires interactifs.

## Contenu

Le projet est organisé par laboratoire, chacun comprenant selon le cas :

- **Diapositives** utilisées pendant les séances
- **Fichiers de solutions** servant de support lors des explications
- **Autre matériel visuel**
- **Liens vers les questionnaires Kahoot** utilisés comme activité interactive

## Matériel interactif

Tous les quiz utilisés en laboratoire sont accessibles ici : [Kahoot - INF1070](https://create.kahoot.it/course/a5f7f287-704b-4175-acd3-6fa3495a2886)

## Fichiers de configuration

Un `.bashrc` complet est disponible dans le dossier [`dotfiles/`](../dotfiles/) à la racine du dépôt.  
Il inclut des alias utiles, des fonctions pratiques (navigation, extraction d'archives, recherche de texte), et la configuration de l'historique bash.

Pour l'utiliser, copiez-le dans votre répertoire personnel :

```bash
cp dotfiles/.bashrc ~/.bashrc && source ~/.bashrc
```

### Mise en garde pour les TPs

**Alias qui redéfinissent des commandes existantes** — certains alias portent le même nom qu'une commande standard, ce qui change silencieusement leur comportement :

| Alias | Effet |
|-------|-------|
| `alias cp='cp -i'` | demande confirmation avant d'écraser |
| `alias mv='mv -i'` | demande confirmation avant d'écraser |
| `alias rm='trash -v'` | déplace vers la corbeille au lieu de supprimer |
| `alias mkdir='mkdir -p'` | crée les dossiers parents automatiquement |
| `alias ps='ps auxf'` | ajoute des options par défaut |
| `alias ls='…'` (et variantes) | ajoute couleurs, options, etc. |

Lorsque vous remettez un TP ou rédigez un rapport, **utilisez la commande telle qu'elle est demandée dans l'énoncé**, avec ses propres options — pas celles ajoutées par l'alias. Deux façons de contourner un alias le temps d'une commande :

```bash
# 1. Préfixer avec un backslash pour ignorer l'alias
\cp source destination
\rm fichier

# 2. Désactiver l'alias pour la session courante
unalias rm
```

> Dans vos rapports, écrivez toujours la vraie commande avec ses options explicites (ex. `ls -l`, `rm fichier`), et non le comportement implicite d'un alias.

**Fonctions** — les fonctions définies dans le `.bashrc` (navigation, extraction, etc.) sont fournies à titre indicatif pour vous faciliter la vie au quotidien. **Elles ne sont pas autorisées dans les TPs** : les énoncés attendent des commandes standard du shell.

## Référence officielle des laboratoires

Pour les instructions officielles et les énoncés complets des laboratoires du cours, consultez le dépôt principal : [INF1070 - Labs](https://gitlab.info.uqam.ca/inf1070/labs)

