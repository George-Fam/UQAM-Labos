<#
.SYNOPSIS
Configure un environnement Git globalement ou pour un grand dépôt (surveillance de fichiers).

.DESCRIPTION
Fonctionne en deux modes :

1) Mode par défaut = configure le .gitconfig global :
    - applique les paramètres Git globaux
    - configure les alias
    - écrit 3 fichiers d'identité includeIf (Github Pro, Github Personnel, Gitlab École)
    - définit l'identité par défaut de secours à « joblu »

2) Mode dépôt local (seulement si -RepoPath est fourni) :
    applique uniquement les configurations de performance pour grands dépôts À CE dépôt :

       core.fsmonitor      = true
       core.untrackedCache = true

.PARAMETER RepoPath
Chemin vers un dossier de dépôt Git. Si présent, ignore la configuration globale et applique uniquement les optimisations pour grands dépôts localement.

.EXAMPLE
PS> ./git-setup.ps1

- installe les paramètres globaux, les alias et les identités.

.EXAMPLE
PS> ./git-setup.ps1 -RepoPath “C:\dev\grand-depot”

.NOTES
Ce script est idempotent. Vous pouvez le réexécuter sans risque.
#>
param(
    [string]$RepoPath
)

$erroractionpreference = "stop"

# ================================= constants =================================

# ----------------------------------- paths -----------------------------------
$CONFIG_DIR = $HOME

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$JsonPath = Join-Path $SCRIPT_DIR "gitconfig.json"

if (-not (Test-Path $JsonPath)) {
    throw "Configuration file 'gitconfig.json' not found at $JsonPath"
}

$CONFIG = Get-Content $JsonPath -Raw | ConvertFrom-Json

# =============================================================================

# ================================= Functions =================================
function write-identityfile {
    param(
        [string]$path,
        [string]$name,
        [string]$email
    )

    @"
[user]
    name = $name
    email = $email
[author]
    name = $name
    email = $email
[committer]
    name = $name
    email = $email
"@ | Out-File -FilePath $path -Encoding utf8NoBOM -Force

    Write-Host "Created identity file: $path"
}

function add-includeif {
    param(
        [string]$pattern,
        [string]$includefile
    )
    git config --global --remove-section "includeIf.$pattern" 2>$null
    git config --global --add "includeIf.$pattern.path" "$includefile"
    Write-Host "Added includeif for '$pattern' - $includefile"
}

function apply-defaultidentity {
    $id = $CONFIG.defaultIdentity
    Write-Host "Applying default identity..." -ForegroundColor cyan
    git config --global user.name       $id.name
    git config --global user.email      $id.email
    git config --global author.name     $id.name
    git config --global author.email    $id.email
    git config --global committer.name  $id.name
    git config --global committer.email $id.email
    Write-Host "Default identity applied successfully." -ForegroundColor green
}

function apply-globalsettings {
    Write-Host "Configuring global git settings..." -ForegroundColor cyan
    foreach ($kv in $CONFIG.globalSettings.psobject.Properties) {
        git config --global $kv.Name "$($kv.Value)"
    }
    Write-Host "Global settings applied successfully." -ForegroundColor green
}

function apply-aliases {
    Write-Host "Configuring git aliases..." -ForegroundColor cyan
    foreach ($kv in $CONFIG.aliases.psobject.Properties) {
        git config --global "alias.$($kv.Name)" "$($kv.Value)"
    }
    Write-Host "Aliases applied successfully." -ForegroundColor green
}
function apply-identities {
    Write-Host "Applying conditional identities" -ForegroundColor cyan
    foreach ($id in $CONFIG.identities) {
        $path = Join-Path $CONFIG_DIR $id.file
        write-identityfile -path $path -name $id.name -email $id.email

        foreach ($p in $id.patterns) {
            add-includeif -pattern "hasconfig:remote.*.url:$p/**" `
                -includefile $path
        }
    }
    Write-Host "All conditional identities configured successfully." `
        -ForegroundColor green
}

function apply-largerepolocal {
    param([string]$repo)

    if (-not (Test-Path $repo)) { throw "Repo path does not exist." }
    $abs = (Resolve-Path $repo).Path

    Write-Host "Applying large repo optimizations to: $abs" `
        -ForegroundColor Cyan

    foreach ($kv in $CONFIG.largeRepoSettings.psobject.Properties) {
        git -C $abs config $kv.Name $kv.Value
    }

    Write-Host "Large repo optimizations applied locally." `
        -ForegroundColor Green
}
# =============================================================================

if ($RepoPath) {
    apply-largerepolocal $RepoPath
    exit
}

apply-globalsettings
apply-aliases
apply-defaultidentity
apply-identities

Write-Host "`nAll git config applied." -ForegroundColor green

