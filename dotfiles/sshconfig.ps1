<#
.SYNOPSIS
Génère des clés SSH et configure ~/.ssh/config pour GitHub et GitLab UQAM.

.DESCRIPTION
Lit sshconfig.json et, pour chaque hôte configuré :
  - Génère une clé ed25519 si elle n'existe pas encore
  - Ajoute la clé à l'agent SSH (Windows : active le service si nécessaire)
  - Écrit/met à jour le bloc géré dans ~/.ssh/config
  - Affiche la clé publique avec les instructions pour l'ajouter sur le service

Le champ "alias" dans sshconfig.json est optionnel. S'il est présent, il est utilisé comme
nom Host dans ~/.ssh/config (ex : git@gitlabUqam:...). S'il est absent, le hostname est
utilisé directement (ex : git@gitlab.info.uqam.ca:...).

Le script est idempotent : relancez-le sans risque.

.PARAMETER ShowKeys
Affiche uniquement les clés publiques existantes avec leurs instructions,
sans modifier les fichiers ni générer de nouvelles clés.

.EXAMPLE
PS> ./sshconfig.ps1

Génère les clés manquantes et met à jour la config SSH.

.EXAMPLE
PS> ./sshconfig.ps1 -ShowKeys

Affiche les clés publiques et les instructions (utile si les clés existent déjà).

.NOTES
Testé sur Windows 10/11 (PowerShell 5.1+) et Linux/macOS (PowerShell 7+).
Sur Linux/macOS : chmod 700 appliqué au dossier ~/.ssh, chmod 600 aux clés privées.
Sur Windows : ACL restreintes appliquées via Set-Acl.
La gestion du service ssh-agent ne s'applique que sur Windows.
#>
param(
    [switch]$ShowKeys
)

$ErrorActionPreference = "Stop"

# ================================= constants =================================

$SSH_DIR = Join-Path $HOME ".ssh"
$CONFIG_FILE = Join-Path $SSH_DIR "config"

$MANAGED_BEGIN = "# BEGIN managed by sshconfig.ps1"
$MANAGED_END = "# END managed by sshconfig.ps1"

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$JsonPath = Join-Path $SCRIPT_DIR "sshconfig.json"
$IS_WINDOWS = $IsWindows -or $env:OS -eq "Windows_NT"

if (-not (Test-Path $JsonPath)) {
    throw "Fichier de configuration 'sshconfig.json' introuvable dans $SCRIPT_DIR"
}

$CONFIG = Get-Content $JsonPath -Raw | ConvertFrom-Json

# =============================================================================

# ================================= functions =================================

function Set-RestrictedPermissions {
    param([string]$Path, [bool]$IsDir = $false)

    if ($IS_WINDOWS) {
        $acl = Get-Acl $Path
        $acl.SetAccessRuleProtection($true, $false)
        $inheritance = if ($IsDir) { "ContainerInherit,ObjectInherit" } else { "None" }
        $rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
            $env:USERNAME, "FullControl", $inheritance, "None", "Allow"
        )
        $acl.AddAccessRule($rule)
        Set-Acl -Path $Path -AclObject $acl -ErrorAction SilentlyContinue
    }
    else {
        $mode = if ($IsDir) { "700" } else { "600" }
        chmod $mode $Path
    }
}

function Ensure-SshDir {
    if (-not (Test-Path $SSH_DIR)) {
        New-Item -ItemType Directory -Path $SSH_DIR | Out-Null
        Write-Host "Répertoire ~/.ssh créé." -ForegroundColor Green
    }
    Set-RestrictedPermissions -Path $SSH_DIR -IsDir $true
}

function Ensure-SshAgent {
    # Windows only: make sure the ssh-agent service is running
    if (-not $IS_WINDOWS) { return }

    $svc = Get-Service -Name "ssh-agent" -ErrorAction SilentlyContinue
    if ($null -eq $svc) {
        Write-Warning "Service ssh-agent introuvable. Assurez-vous qu'OpenSSH est installé (Paramètres > Applications > Fonctionnalités optionnelles > OpenSSH)."
        return
    }
    if ($svc.StartType -eq "Disabled") {
        try {
            Set-Service -Name "ssh-agent" -StartupType Manual
            Write-Host "Service ssh-agent activé (démarrage manuel)." -ForegroundColor Yellow
        }
        catch {
            Write-Warning "Impossible d'activer ssh-agent : $_"
            return
        }
    }
    if ($svc.Status -ne "Running") {
        Start-Service ssh-agent
        Write-Host "Service ssh-agent démarré." -ForegroundColor Green
    }
}

function Generate-Key {
    param(
        [string]$KeyPath,
        [string]$Comment
    )

    if (Test-Path $KeyPath) {
        Write-Host "  Clé existante trouvée : $KeyPath (ignorée)" -ForegroundColor DarkGray
        return
    }

    Write-Host "  Génération de la clé : $KeyPath" -ForegroundColor Cyan
    ssh-keygen -t ed25519 -C $Comment -f $KeyPath -N ""
    Set-RestrictedPermissions -Path $KeyPath -IsDir $false
    Write-Host "  Clé générée." -ForegroundColor Green
}

function Add-KeyToAgent {
    param([string]$KeyPath)
    try {
        ssh-add $KeyPath 2>&1 | Out-Null
        Write-Host "  Clé ajoutée à l'agent : $KeyPath" -ForegroundColor Green
    }
    catch {
        Write-Warning "  Impossible d'ajouter la clé à l'agent : $_"
    }
}


function Get-HostAlias {
    param($hostEntry)
    if ($hostEntry.alias) { return $hostEntry.alias } else { return $hostEntry.hostname }
}

function Build-HostBlock {
    param($hostEntry, [string]$ResolvedAlias)
    $lines = @("Host $ResolvedAlias")
    $lines += "    HostName $($hostEntry.hostname)"
    $lines += "    User git"
    if ($hostEntry.addKeysToAgent) { $lines += "    AddKeysToAgent yes" }
    if ($hostEntry.identitiesOnly) { $lines += "    IdentitiesOnly yes" }
    $lines += "    IdentityFile ~/.ssh/$($hostEntry.keyFile)"
    return $lines -join "`n"
}

function Update-SshConfig {
    param([string[]]$HostBlocks)

    $managed = @(
        $MANAGED_BEGIN
        ""
        ($HostBlocks -join "`n`n")
        ""
        $MANAGED_END
    ) -join "`n"

    if (-not (Test-Path $CONFIG_FILE)) {
        Set-Content -Path $CONFIG_FILE -Value $managed -Encoding utf8NoBOM
        Write-Host "Fichier ~/.ssh/config créé." -ForegroundColor Green
        return
    }

    $existing = Get-Content $CONFIG_FILE -Raw

    if ($existing -match [regex]::Escape($MANAGED_BEGIN)) {
        # Replace the managed block
        $pattern = "(?s)" + [regex]::Escape($MANAGED_BEGIN) + ".*?" + [regex]::Escape($MANAGED_END)
        $updated = [regex]::Replace($existing.TrimEnd(), $pattern, $managed)
        Set-Content -Path $CONFIG_FILE -Value $updated -Encoding utf8NoBOM
        Write-Host "Bloc géré dans ~/.ssh/config mis à jour." -ForegroundColor Green
    }
    else {
        # Append managed block
        $updated = $existing.TrimEnd() + "`n`n" + $managed
        Set-Content -Path $CONFIG_FILE -Value $updated -Encoding utf8NoBOM
        Write-Host "Bloc géré ajouté à ~/.ssh/config." -ForegroundColor Green
    }
}

function Show-PublicKey {
    param($hostEntry, [string]$ResolvedAlias)

    $pubKeyPath = Join-Path $SSH_DIR "$($hostEntry.keyFile).pub"
    if (-not (Test-Path $pubKeyPath)) {
        Write-Host "  [!] Clé publique introuvable : $pubKeyPath" -ForegroundColor Red
        return
    }

    $pubKey = Get-Content $pubKeyPath -Raw
    $label = if ($ResolvedAlias -ne $hostEntry.hostname) { "$ResolvedAlias  ($($hostEntry.hostname))" } else { $hostEntry.hostname }

    Write-Host ""
    Write-Host "──────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host " $label" -ForegroundColor Yellow
    Write-Host "──────────────────────────────────────────────" -ForegroundColor DarkGray
    Write-Host $pubKey.Trim() -ForegroundColor White
    Write-Host ""
    Write-Host " Instructions :" -ForegroundColor Cyan
    $instructions = switch -Wildcard ($hostEntry.hostname) {
        "github.com" {
            "1. Copiez la clé publique affichée ci-dessus.",
            "2. Allez sur https://github.com/settings/keys",
            "3. Cliquez 'New SSH key', collez la clé, donnez-lui un titre.",
            "4. Testez avec : ssh -T git@github.com"
        }
        "*gitlab*" {
            "1. Copiez la clé publique affichée ci-dessus.",
            "2. Allez sur https://$($hostEntry.hostname)/-/profile/keys",
            "3. Collez la clé dans le champ 'Key', donnez-lui un titre.",
            "4. Testez avec : ssh -T git@$ResolvedAlias"
        }
        default {
            "1. Copiez la clé publique affichée ci-dessus.",
            "2. Ajoutez-la dans les paramètres SSH de $($hostEntry.hostname).",
            "3. Testez avec : ssh -T git@$ResolvedAlias"
        }
    }
    foreach ($line in $instructions) {
        Write-Host "   $line"
    }

    # Copy to clipboard automatically if possible
    try {
        $pubKey.Trim() | Set-Clipboard
        Write-Host ""
        Write-Host "  Clé copiée dans le presse-papiers." -ForegroundColor Green
    }
    catch {
        # clipboard not available (headless/remote) — silent
    }
}

# =============================================================================

if ($ShowKeys) {
    Write-Host "=== Clés publiques SSH ===" -ForegroundColor Cyan
    foreach ($h in $CONFIG.hosts) {
        Show-PublicKey $h (Get-HostAlias $h)
    }
    exit
}

# ================================= main flow =================================

Ensure-SshDir
Ensure-SshAgent

$hostBlocks = @()

foreach ($h in $CONFIG.hosts) {
    Write-Host ""
    Write-Host "=== $($h.hostname) ===" -ForegroundColor Cyan

    $keyPath = Join-Path $SSH_DIR $h.keyFile
    Generate-Key -KeyPath $keyPath -Comment $h.keyComment

    if ($h.addKeysToAgent) {
        Add-KeyToAgent -KeyPath $keyPath
    }

    $hostBlocks += Build-HostBlock $h (Get-HostAlias $h)
}

Write-Host ""
Write-Host "Mise à jour de ~/.ssh/config..." -ForegroundColor Cyan
Update-SshConfig -HostBlocks $hostBlocks

Write-Host ""
Write-Host "=== Clés publiques à ajouter sur les services ===" -ForegroundColor Cyan
foreach ($h in $CONFIG.hosts) {
    Show-PublicKey $h (Get-HostAlias $h)
}

Write-Host ""
Write-Host "Configuration SSH terminée." -ForegroundColor Green
foreach ($h in $CONFIG.hosts) {
    Write-Host "Testez avec : ssh -T git@$(Get-HostAlias $h)" -ForegroundColor DarkGray
}
