# nvim — Configuration Neovim personnelle (NvChad)

Cette configuration Neovim est construite par-dessus **NvChad v2.5**. Elle conserve les défauts de NvChad et y ajoute des options, des raccourcis, une configuration LSP et un formatage automatique adaptés à un usage scolaire/personnel.

---

## Installation

### Prérequis

| Outil | Usage |
| ----- | ----- |
| **Neovim 0.10+** | Requis — utilise `vim.lsp.config` / `vim.lsp.enable` |
| **Git** | Requis — pour cloner lazy.nvim et les plugins |
| **Node.js** | Requis pour `markdown-preview.nvim` |
| **Python** | Requis pour `black` et `isort` (formatage Python) |
| **PowerShell (`pwsh`)** | Formatage `.ps1` via PSScriptAnalyzer |
| `clang-format` | Formatage C / C++ / Java |
| `prettierd` | Formatage HTML / JS / TS / JSON / Markdown |
| `beautysh` | Formatage Bash / Shell |
| `stylua` | Formatage Lua |
| `ocamlformat` | Formatage OCaml |

### Étapes

**1. Sauvegardez votre config actuelle (si applicable)**

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

**2. Copiez ce dossier vers `~/.config/nvim`**

```bash
cp -r dotfiles/nvim ~/.config/nvim
```

**3. Lancez Neovim**

```bash
nvim
```

Au premier lancement, `lazy.nvim` est automatiquement installé, puis tous les plugins sont téléchargés et compilés. Attendez que tout soit prêt avant de commencer à éditer.

---

## Structure des fichiers

```
nvim/
├── init.lua                  # Point d'entrée : bootstrap lazy.nvim, charge les plugins et options
├── .stylua.toml              # Config du formateur Lua (stylua)
└── lua/
    ├── chadrc.lua            # Thème et overrides NvChad (base46)
    ├── options.lua           # Options vim (indentation, numéros relatifs, listchars, etc.)
    ├── mappings.lua          # Tous les raccourcis clavier personnalisés
    ├── configs/
    │   ├── lazy.lua          # Options de lazy.nvim (performance, UI, plugins désactivés)
    │   └── lspconfig.lua     # Configuration des serveurs LSP (clangd, html, cssls)
    └── plugins/
        └── init.lua          # Plugins supplémentaires au-delà de NvChad
```

---

## Ce que ça fait

### Options (`options.lua`)

- Indentation à **4 espaces** (tabstop, shiftwidth, expandtab, smartindent)
- **Numéros de ligne relatifs** (`relativenumber`)
- **Caractères invisibles** visibles : espaces affichés en `.`, tabulations en `>.`, espaces de fin de ligne en `.`
- **Colonne de 80 caractères** mise en évidence (`colorcolumn`)
- Support syntaxique pour l'assembleur RISC-V (`riscv_asm_all_enable`)

### Thème (`chadrc.lua`)

- Thème **bearded-arc** via le système base46 de NvChad

### LSP (`configs/lspconfig.lua`)

Serveurs activés :

| Serveur | Langage |
| ------- | ------- |
| `clangd` | C / C++ (avec semantic tokens) |
| `html` | HTML |
| `cssls` | CSS |

> Pour ajouter un serveur, installez-le avec Mason (`:MasonInstall <serveur>`), puis ajoutez-le dans `lspconfig.lua`.

### Formatage automatique (`plugins/init.lua` — conform.nvim)

Le formatage se déclenche automatiquement à la sauvegarde (`BufWritePre`) :

| Langage | Formateur |
| ------- | --------- |
| C / C++ / H | `clang-format` |
| Java | `clang-format` |
| Bash / Shell | `beautysh` |
| HTML / JS / TS / JSON / Markdown | `prettierd` |
| Python | `isort` puis `black` |
| PowerShell | `psscriptanalyzer` (via `pwsh`) |
| OCaml | `ocamlformat` |
| Lua | `stylua` |

### Plugins supplémentaires

| Plugin | Rôle |
| ------ | ---- |
| `conform.nvim` | Formatage automatique multi-langages |
| `nvim-lspconfig` | Configuration LSP |
| `rainbow-variables-nvim` | Coloration des variables par identité (arc-en-ciel) |
| `riscv-asm-vim` | Syntaxe assembleur RISC-V |
| `telescope-diff.nvim` | Diff entre fichiers via Telescope |
| `tabular` | Alignement de texte en colonnes (`:Tabularize`) |
| `high-str.nvim` | Surlignage de texte persistant en mode visuel |
| `vimtex` | Support LaTeX (viewer : Zathura) |
| `markdown-preview.nvim` | Aperçu Markdown dans le navigateur |

---

## Raccourcis clavier

> `<leader>` = `Espace`

### Navigation de fenêtres

| Raccourci | Action |
| --------- | ------ |
| `Alt+A/W/S/D` | Aller à la fenêtre gauche/haut/bas/droite |
| `Alt+Shift+A/W/S/D` | Redimensionner la fenêtre |

### Splits

| Raccourci | Action |
| --------- | ------ |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Égaliser les splits |
| `<leader>sx` | Fermer le split |

### Fichiers / Telescope (`<leader>f`)

| Raccourci | Action |
| --------- | ------ |
| `<leader>ff` | Chercher un fichier |
| `<leader>fa` | Chercher tous les fichiers (cachés inclus) |
| `<leader>fw` | Grep dans le projet |
| `<leader>fb` | Buffers ouverts |
| `<leader>fo` | Fichiers récents |
| `<leader>fc` | Thèmes de couleur |
| `<leader>fh` | Aide Neovim |

### LSP (`<leader>l`)

| Raccourci | Action |
| --------- | ------ |
| `<leader>lD` | Aller à la définition |
| `<leader>lR` | Lister les références |
| `<leader>ld` | Documentation au survol |
| `<leader>la` | Action de code |
| `<leader>lr` | Renommer le symbole |
| `<leader>lf` | Formater le buffer |
| `<leader>lI` | Aller à l'implémentation |

### Git (`<leader>g`)

| Raccourci | Action |
| --------- | ------ |
| `<leader>gs` | Git status (Telescope) |
| `<leader>gc` | Git commits (Telescope) |
| `<leader>gb` | Git branches (Telescope) |
| `<leader>gd` | Git diff (Telescope) |
| `<leader>gt` | Git stash (Telescope) |
| `<leader>ga` | `git add %` |
| `<leader>gA` | `git add .` |
| `<leader>gp` | `git push` |
| `<leader>gP` | `git pull` |

### Buffers

| Raccourci | Action |
| --------- | ------ |
| `Tab` | Buffer suivant |
| `Shift+Tab` | Buffer précédent |
| `<leader>bb` | Nouveau buffer |
| `<leader>bx` | Fermer le buffer |

### Divers

| Raccourci | Action |
| --------- | ------ |
| `;` | Entrer en mode commande |
| `jk` (insert) | Quitter le mode insertion |
| `Ctrl+S` | Sauvegarder |
| `<leader>h` | Effacer les surbrillances de recherche |
| `<leader>e` | Ouvrir/fermer l'explorateur de fichiers |
| `J/K` (visuel) | Déplacer les lignes sélectionnées vers le bas/haut |
| `F3` (visuel) | Surligner la sélection |
| `F4` (visuel) | Retirer le surlignage |
| `<leader>Sr` | Substitution globale (rechercher/remplacer) |
