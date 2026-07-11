[CmdletBinding()]
param(
  [switch]$SkipCurrentShellLoad
)

$ErrorActionPreference = 'Stop'

$wrapperBlock = @'
# >>> the-art-of-lazying Codex CLI wrappers >>>
# Windows PowerShell port of lazy-hacks/codex-cli helpers.
# codex  : enforce -s danger-full-access -a never
# codexr : shorthand for codex resume
# cr     : alias to codexr
# codexmv: migrate stored Codex session cwd values after a folder move

function __CodexRealBin {
  $cmd = Get-Command codex.cmd -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($cmd) { return $cmd.Source }
  $cmd = Get-Command codex.exe -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($cmd) { return $cmd.Source }
  $cmd = Get-Command codex -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
  if ($cmd) { return $cmd.Source }
  throw 'codex real binary not found on PATH'
}

function __CodexNormalizeArgs {
  param([object[]]$InputArgs)
  $pass = New-Object System.Collections.Generic.List[string]
  for ($i = 0; $i -lt $InputArgs.Count; $i++) {
    $a = [string]$InputArgs[$i]
    switch -Regex ($a) {
      '^(-s|--sandbox|--sandbox-mode|--sandbox_mode|-a|--ask-for-approval|--approval-policy|--approval_policy)$' { $i++; continue }
      '^(--sandbox|--sandbox-mode|--sandbox_mode|--ask-for-approval|--approval-policy|--approval_policy)=' { continue }
      '^(--full-auto|--dangerously-bypass-approvals-and-sandbox)$' { continue }
      '^-[sa].+' { continue }
      default { $pass.Add($a) }
    }
  }
  return $pass.ToArray()
}

function codex {
  [CmdletBinding()]
  param([Parameter(ValueFromRemainingArguments=$true)][string[]]$CodexArgs)
  $real = __CodexRealBin
  $pass = __CodexNormalizeArgs -InputArgs $CodexArgs
  & $real -s danger-full-access -a never @pass
}

function codexr {
  [CmdletBinding()]
  param([Parameter(ValueFromRemainingArguments=$true)][string[]]$CodexArgs)
  $pass = @($CodexArgs)
  if ($pass.Count -gt 0 -and $pass[0] -eq 'resume') { $pass = @($pass | Select-Object -Skip 1) }
  codex resume @pass
}

Set-Alias -Name cr -Value codexr -Scope Global -Force

function codexmv {
  [CmdletBinding()]
  param([Parameter(ValueFromRemainingArguments=$true)][string[]]$CodexMvArgs)

  $latest = $false
  $noResume = $false
  $rest = New-Object System.Collections.Generic.List[string]
  $stopOptions = $false

  for ($i = 0; $i -lt $CodexMvArgs.Count; $i++) {
    $arg = $CodexMvArgs[$i]
    if ($stopOptions) { $rest.Add($arg); continue }
    switch ($arg) {
      '-l' { $latest = $true; continue }
      '--latest' { $latest = $true; continue }
      '--no-resume' { $noResume = $true; continue }
      '-h' { codexmv-help; return }
      '--help' { codexmv-help; return }
      '--' { $stopOptions = $true; continue }
      default {
        if ($arg.StartsWith('-')) { throw "codexmv error: unknown option $arg" }
        $rest.Add($arg)
      }
    }
  }

  if ($rest.Count -lt 1 -or $rest.Count -gt 2) {
    throw 'Usage: codexmv [--latest|-l] [--no-resume] <oldpath> [newpath]'
  }

  $db = Join-Path $HOME '.codex\state_5.sqlite'
  if (-not (Test-Path -LiteralPath $db)) { throw "codexmv error: Codex state DB not found at $db" }
  if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw 'codexmv error: python not found on PATH' }

  $oldRaw = $rest[0]
  $newRaw = if ($rest.Count -eq 2) { $rest[1] } else { '.' }

  $python = @"
import os, sys, sqlite3, time

def abspath(p):
    p = os.path.expanduser(p)
    return os.path.abspath(p)

def variants(p):
    p = p.rstrip('\\\\/')
    out = [p]
    if len(p) >= 3 and p[1:3] == ':\\\\':
        out.append('\\\\\\\\?\\\\' + p)
    if p.startswith('\\\\\\\\?\\\\'):
        out.append(p[4:])
    seen = set()
    ret = []
    for x in out:
        k = x.lower()
        if k not in seen:
            seen.add(k)
            ret.append(x)
    return ret

def match_prefix(cwd, old_vars):
    for ov in old_vars:
        if cwd.lower() == ov.lower():
            return ov, ''
        for sep in ('\\\\', '/'):
            prefix = ov + sep
            if cwd.lower().startswith(prefix.lower()):
                return ov, cwd[len(ov):]
    return None, None

db, old_raw, new_raw = sys.argv[1:4]
old_abs = abspath(old_raw)
new_abs = abspath(new_raw)
old_vars = variants(old_abs)
backup = db + '.bak.' + time.strftime('%Y%m%d-%H%M%S')
con = sqlite3.connect(db)
bak = sqlite3.connect(backup)
con.backup(bak)
bak.close()
cur = con.cursor()
try:
    rows = cur.execute('SELECT id, cwd, updated_at FROM threads').fetchall()
except sqlite3.Error as e:
    raise SystemExit(f'codexmv error: cannot read threads table: {e}')
updates = []
for sid, cwd, updated in rows:
    if not cwd:
        continue
    ov, suffix = match_prefix(cwd, old_vars)
    if ov is not None:
        updates.append((new_abs + suffix, sid, updated, cwd))
if not updates:
    print('NO_MATCH')
    print(f'old={old_abs}')
    print(f'new={new_abs}')
    print(f'backup={backup}')
    raise SystemExit(3)
cur.execute('BEGIN')
for newcwd, sid, updated, oldcwd in updates:
    cur.execute('UPDATE threads SET cwd=? WHERE id=?', (newcwd, sid))
con.commit()
latest_id = sorted(updates, key=lambda x: x[2] if x[2] is not None else '', reverse=True)[0][1]
print(f'MIGRATED={len(updates)}')
print(f'old={old_abs}')
print(f'new={new_abs}')
print(f'backup={backup}')
print(f'latest_id={latest_id}')
"@

  $tmp = Join-Path ([IO.Path]::GetTempPath()) ('codexmv-' + [guid]::NewGuid().ToString() + '.py')
  Set-Content -LiteralPath $tmp -Value $python -Encoding UTF8
  try {
    $output = & python $tmp $db $oldRaw $newRaw 2>&1
    $exitCode = $LASTEXITCODE
  } finally {
    Remove-Item -LiteralPath $tmp -Force -ErrorAction SilentlyContinue
  }
  $output | ForEach-Object { Write-Output $_ }
  if ($exitCode -ne 0) { return $exitCode }

  $latestId = ($output | Where-Object { $_ -like 'latest_id=*' } | Select-Object -First 1) -replace '^latest_id=', ''
  $newPath = ($output | Where-Object { $_ -like 'new=*' } | Select-Object -First 1) -replace '^new=', ''
  if ($noResume) { return 0 }
  if ($latest) { codex resume $latestId -C $newPath } else { codex resume -C $newPath }
}

function codexmv-help {
  Write-Output 'Usage: codexmv [--latest|-l] [--no-resume] <oldpath> [newpath]'
  Write-Output 'Default: migrate then open resume picker in new/current folder.'
  Write-Output 'Use --latest/-l: migrate then auto-resume latest migrated session.'
  Write-Output 'Use --no-resume: migrate only; useful inside an active Codex session.'
}
# <<< the-art-of-lazying Codex CLI wrappers <<<
'@

function Install-CodexProfileBlock {
  param([Parameter(Mandatory=$true)][string]$ProfilePath)

  $parent = Split-Path -Parent $ProfilePath
  New-Item -ItemType Directory -Force -Path $parent | Out-Null
  if (Test-Path -LiteralPath $ProfilePath) {
    $backup = $ProfilePath + '.bak.' + (Get-Date -Format 'yyyyMMdd-HHmmss')
    Copy-Item -LiteralPath $ProfilePath -Destination $backup -Force
    $existing = Get-Content -Raw -LiteralPath $ProfilePath
    $existing = [regex]::Replace($existing, '(?s)# >>> the-art-of-lazying Codex CLI wrappers >>>.*?# <<< the-art-of-lazying Codex CLI wrappers <<<\s*', '')
  } else {
    $existing = ''
  }
  Set-Content -LiteralPath $ProfilePath -Value ($existing.TrimEnd() + "`r`n`r`n" + $wrapperBlock + "`r`n") -Encoding UTF8
  Write-Host "Installed Codex wrappers into $ProfilePath"
}

$documents = [Environment]::GetFolderPath('MyDocuments')
$profilePaths = @(
  (Join-Path $documents 'WindowsPowerShell\Microsoft.PowerShell_profile.ps1'),
  (Join-Path $documents 'PowerShell\Microsoft.PowerShell_profile.ps1')
)

foreach ($profilePath in $profilePaths) {
  Install-CodexProfileBlock -ProfilePath $profilePath
}

if (-not $SkipCurrentShellLoad) {
  . $profilePaths[0]
}

Write-Host 'Available after opening a new PowerShell: codex, codexr, cr, codexmv'
