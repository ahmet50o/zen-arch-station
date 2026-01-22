# RTFM – Referenz & Methodik

## Workflow: Selbst Hilfe finden

```
┌─────────────────────────────────────────┐
│ 1. type befehl    → Was ist es?         │
├─────────────────────────────────────────┤
│ 2. befehl --help  → Schnelle Syntax     │
├─────────────────────────────────────────┤
│ 3. tldr befehl    → Praktische Beispiele│
├─────────────────────────────────────────┤
│ 4. man befehl     → Volle Dokumentation │
│    → /keyword     → Suchen              │
│    → man -k KEY   → Apropos             │
├─────────────────────────────────────────┤
│ 5. /usr/share/doc/PAKET/                │
│    → README, examples/, configs         │
├─────────────────────────────────────────┤
│ 6. Source Code    → Ultimative Wahrheit │
└─────────────────────────────────────────┘
```

### Quellen-Hierarchie

```
1. Offizielle Dokumentation / Specs / RFCs
2. Source Code
3. Man-pages / --help
4. Maintainer-Blogs / Release Notes
5. Community (StackOverflow, GitHub Issues)
```

### Was ist es? → Welche Hilfe?

```bash
type BEFEHL
```

| `type` sagt | Dann nutze |
|-------------|------------|
| shell builtin | `help BEFEHL` |
| alias | `alias BEFEHL` oder `type -a BEFEHL` |
| function | `declare -f FUNKTIONSNAME` |
| /usr/bin/... | `man` / `--help` / `tldr` |

---

## Hilfe finden

```bash
type CMD           # Was ist es?
├─ builtin  → help CMD
├─ alias    → alias CMD
├─ function → declare -f CMD
└─ extern   → CMD --help → tldr CMD → man CMD

apropos KEYWORD    # Befehl vergessen
man -k KEYWORD     # Alternativ
whatis CMD         # Kurzbeschreibung
curl cheat.sh/CMD  # Online
```

### Konfigurationsdateien finden

```bash
# Welche Config liest das Programm?
strace -e openat BEFEHL 2>&1 | grep -E '\.(conf|cfg|ini)'

# Config-Manpage (Sektion 5)
man 5 CONFIGNAME               # z.B. man 5 ssh_config

# Paket-Dokumentation
ls /usr/share/doc/PAKETNAME/
zcat /usr/share/doc/PAKETNAME/README.gz

# Beispiel-Configs
ls /usr/share/doc/*/examples/

# Default-Configs finden
dpkg -L PAKETNAME | grep -E '(etc|conf)'    # Debian
rpm -qc PAKETNAME                            # RHEL
```

---

## Bash-Syntax

### Wo nachschlagen

| Thema | Befehl |
|-------|--------|
| Alles | `man bash` |
| Test-Operatoren | `help test` |
| Builtins | `help` |
| Spezialvariablen | `man bash` → `/^Special Parameters` |
| Expansion | `man bash` → `/^EXPANSION` |
| Globbing | `man 7 glob` |
| Regex | `man 7 regex` |
| Exit Codes | `man sysexits` |
| Signale | `kill -l`, `man 7 signal` |

### Spezialvariablen

```bash
$0 $1 $2       # Script, Arg1, Arg2
$# $@ $*       # Anzahl, Alle(array), Alle(string)
$? $$ $!       # Exit, PID, Background-PID
$_             # Letztes Argument
```

### Test-Operatoren

```bash
-f FILE   -d DIR   -e PATH   -L LINK     # Existenz
-r -w -x  -s                              # Rechte, Größe>0
-z "$v"   -n "$v"                         # String leer/nicht
-eq -ne -lt -le -gt -ge                   # Zahlen
== != < >                                 # Strings
```

### Parameter Expansion

```bash
${var:-default}   ${var:=default}      # Default
${var:+alt}       ${var:?error}        # Alt wenn set / Error wenn unset
${#var}           ${var:0:5}           # Länge, Substring
${var#prefix}     ${var##prefix}       # Prefix entfernen
${var%suffix}     ${var%%suffix}       # Suffix entfernen
${var/old/new}    ${var//old/new}      # Ersetzen
```

### Globbing & Brace Expansion

```bash
*  ?  [abc]  [a-z]  [!a]              # Glob (man 7 glob)
{a,b,c}   {1..10}   {01..10}          # Brace Expansion
~  ~user                               # Tilde Expansion
```

### Klammern

```bash
( cmd )         # Subshell
{ cmd; }        # Gruppierung
(( expr ))      # Arithmetik
$(( expr ))     # Arithmetik+Output
[ test ]        # Test POSIX
[[ test ]]      # Test Bash
$( cmd )        # Command Substitution
```

### Redirects & Pipes

```bash
> >> 2> 2>> &>     # stdout, append, stderr, both
2>&1               # stderr→stdout
< <<EOF <<'EOF'    # stdin, heredoc, heredoc literal
<<<                # here string
|                  # pipe
mkfifo PIPE        # named pipe
<(cmd)             # process substitution
```

### Kontrollstrukturen

```bash
if [[ ]]; then ... elif ...; then ... else ... fi
for i in ...; do ... done
for ((i=0;i<10;i++)); do ... done
while [[ ]]; do ... done
case "$v" in pattern) ... ;; *) ... ;; esac
```

---

## Readline (Terminal)

```bash
man readline       # Dokumentation
bind -p            # Aktuelle Bindings
set -o emacs       # Emacs-Mode (default)
set -o vi          # Vi-Mode
```

### Emacs-Mode (Default)

```bash
# Navigation
Ctrl+a / Ctrl+e      # Zeilenanfang/-ende
Alt+b / Alt+f        # Wort zurück/vor
Ctrl+b / Ctrl+f      # Zeichen zurück/vor

# Löschen
Ctrl+u               # Bis Zeilenanfang
Ctrl+k               # Bis Zeilenende
Ctrl+w               # Wort zurück
Alt+d                # Wort vorwärts
Ctrl+d               # Zeichen (oder EOF)

# History
Ctrl+r               # Rückwärts suchen
Ctrl+s               # Vorwärts suchen
Ctrl+p / Ctrl+n      # Previous/Next
!! !$ !^ !*          # Letzter Cmd, letztes/erstes/alle Args
!:n                  # n-tes Argument

# Sonstiges
Ctrl+l               # Clear
Ctrl+c               # Abbrechen
Ctrl+z               # Suspend
Ctrl+d               # EOF/Logout
Ctrl+_ (Ctrl+Shift+-) # Undo
Tab                  # Complete
```

---

## Vim

```bash
vimtutor           # Tutorial
:help              # In Vim
:help CMD          # Spezifisch
```

```bash
i/Esc  v  :        # Modi: Insert, Visual, Command
hjkl   w/b  0/$    # Navigation
gg/G   :42         # Anfang/Ende, Zeile
x  dd  yy  p       # Delete, Line, Copy, Paste
u  Ctrl+r          # Undo, Redo
/pattern  n/N      # Suchen
:%s/old/new/g      # Ersetzen
:w :q :wq :q!      # Speichern/Beenden
```

---

## User & Rechte

```bash
man 5 passwd       # User-Datei
man 5 sudoers      # Sudo-Config
man 5 pam.conf     # PAM
man 5 limits.conf  # Limits
```

| Aufgabe | Befehl |
|---------|--------|
| User anzeigen | `getent passwd`, `id USER` |
| User erstellen | `useradd`, `adduser` |
| User ändern | `usermod -aG GROUP USER` |
| Passwort | `passwd USER` |
| Gruppen | `groups USER`, `getent group` |
| Sudo testen | `sudo -l` |
| Sudo editieren | `visudo` |

```
/etc/passwd  /etc/shadow  /etc/group
/etc/sudoers  /etc/sudoers.d/  /etc/pam.d/
```

---

## Dateien & Permissions

```bash
man chmod          # Permissions
man 7 glob         # Globbing
```

| Aufgabe | Befehl |
|---------|--------|
| Details | `stat FILE` |
| Inode | `ls -i` |
| Typ | `file FILE` |
| Permissions | `chmod 755`, `chmod u+x` |
| Owner | `chown USER:GROUP` |
| ACL | `getfacl`, `setfacl` |
| Links | `ln -s TARGET LINK`, `ln TARGET LINK` |
| Finden | `find PATH -name "*.txt"` |
| Locate | `locate PATTERN` |

```bash
# Timestamps
ls -l    # mtime
ls -lu   # atime
ls -lc   # ctime
stat     # alle
```

---

## Prozesse & Signale

```bash
man ps             # Prozesse
man 7 signal       # Signale
kill -l            # Signal-Liste
```

| Aufgabe | Befehl |
|---------|--------|
| Anzeigen | `ps aux`, `pstree -p` |
| Live | `top`, `htop` |
| Finden | `pgrep NAME`, `pidof NAME` |
| Beenden | `kill PID`, `pkill NAME` |
| Force | `kill -9 PID` |
| Background | `cmd &`, `nohup cmd &` |
| Jobs | `jobs`, `fg`, `bg`, `disown` |

```
/proc/PID/cmdline  /proc/PID/fd/  /proc/PID/status
```

---

## System & Hardware

```bash
man hier           # Dateisystem-Layout
man proc           # /proc
```

| Aufgabe | Befehl |
|---------|--------|
| CPU | `lscpu`, `/proc/cpuinfo` |
| RAM | `free -h`, `/proc/meminfo` |
| Disk | `lsblk`, `df -h`, `du -sh` |
| PCI/USB | `lspci`, `lsusb` |
| DMI/BIOS | `dmidecode` |
| Kernel | `uname -a`, `dmesg` |
| Load | `uptime`, `/proc/loadavg` |

### Kernel-Parameter & Module

```bash
sysctl -a | grep KEYWORD       # Kernel-Parameter suchen
cat /proc/sys/...              # Parameter lesen
ls /sys/...                    # Sysfs
modinfo MODULNAME              # Kernel-Modul Info
ls /usr/share/doc/linux-doc*/  # Kernel-Doku
```

---

## Systemd & Boot

```bash
man systemd.service
man systemd.exec
man systemd.timer
man journalctl
man systemd.journal-fields     # Journal-Felder
```

| Aufgabe | Befehl |
|---------|--------|
| Status | `systemctl status SERVICE` |
| Start/Stop | `systemctl start/stop/restart` |
| Enable | `systemctl enable SERVICE` |
| Logs | `journalctl -u SERVICE -f` |
| Boot-Logs | `journalctl -b` |
| Failed | `systemctl --failed` |
| Timers | `systemctl list-timers` |
| Unit anzeigen | `systemctl cat SERVICE` |
| Unit-Properties | `systemctl show SERVICE --property=PROP` |
| Boot-Analyse | `systemd-analyze blame` |

---

## Netzwerk

```bash
man ip
man ss
man dig
man 5 resolv.conf
man 5 hosts
man tcpdump
man pcap-filter              # tcpdump Filter-Syntax!
```

| Aufgabe | Befehl |
|---------|--------|
| IPs | `ip addr`, `ip a` |
| Routing | `ip route` |
| Ports | `ss -tulnp` |
| Verbindungen | `ss -tanp` |
| DNS | `dig DOMAIN`, `dig +short` |
| Ping | `ping HOST` |
| Trace | `traceroute`, `mtr` |
| Port-Check | `nc -zv HOST PORT` |
| Capture | `tcpdump -i IFACE` |
| Firewall | `ufw status`, `iptables -L` |
| Port→Service | `grep -w PORT /etc/services` |

```
/etc/resolv.conf  /etc/hosts  /etc/hostname
/etc/netplan/  /etc/network/
```

### RFCs

| Protokoll | RFC |
|-----------|-----|
| TCP | 793 |
| UDP | 768 |
| HTTP/1.1 | 2616 |
| HTTP/2 | 7540 |
| DNS | 1035 |
| TLS 1.3 | 8446 |
| SMTP | 5321 |

```bash
# RFCs lokal (falls installiert)
apt install doc-rfc
less /usr/share/doc/RFC/rfc*.txt

# Oder online
curl -s "https://www.rfc-editor.org/rfc/rfc793.txt" | less
```

---

## Disk & Storage

```bash
man lsblk
man mount
man 5 fstab
man lvm
```

| Aufgabe | Befehl |
|---------|--------|
| Devices | `lsblk`, `fdisk -l` |
| Usage | `df -h`, `df -i` |
| Mounts | `mount`, `findmnt` |
| Mounten | `mount /dev/X /mnt` |
| fstab | `/etc/fstab`, `mount -a` |
| Filesystem | `mkfs.ext4`, `mkfs.xfs` |
| LVM | `pvs`, `vgs`, `lvs` |
| Swap | `swapon --show` |

---

## Text Processing

```bash
man grep / sed / awk / sort / cut
```

| Aufgabe | Befehl |
|---------|--------|
| Filtern | `grep PATTERN`, `grep -E`, `grep -rn` |
| Ersetzen | `sed 's/old/new/g'`, `sed -i` |
| Spalten | `cut -d: -f1`, `awk '{print $1}'` |
| Sortieren | `sort`, `sort -n`, `sort -r` |
| Unique | `uniq`, `sort -u` |
| Zählen | `wc -l` |
| Head/Tail | `head -n`, `tail -n`, `tail -f` |
| JSON | `jq '.key'` |

### awk Kurzreferenz

```bash
awk '{print $1}'              # Spalte 1
awk -F: '{print $1}'          # Delimiter
awk '/pattern/ {print}'       # Filter
awk '{sum+=$1} END {print sum}' # Summe
# Variablen: $0=Zeile $1..$N=Spalten NF=Felder NR=Zeilennr
```

---

## Logs

```bash
man journalctl
man rsyslog.conf
man logger
```

| Aufgabe | Befehl |
|---------|--------|
| Journal | `journalctl -u SERVICE` |
| Follow | `journalctl -f` |
| Errors | `journalctl -p err` |
| Since | `journalctl --since "1h ago"` |
| Kernel | `journalctl -k` |
| Verbose | `journalctl --output=verbose -u SERVICE` |

```
/var/log/syslog  /var/log/auth.log  /var/log/kern.log
```

---

## Security & SSH

```bash
man ssh
man 5 ssh_config
man 5 sshd_config
man openssl
```

| Aufgabe | Befehl |
|---------|--------|
| Connect | `ssh user@host` |
| Key-Gen | `ssh-keygen -t ed25519` |
| Key-Copy | `ssh-copy-id user@host` |
| Tunnel | `ssh -L LOCAL:HOST:REMOTE` |
| SCP | `scp FILE user@host:/path/` |
| Rsync | `rsync -avz SRC DST` |
| Cert anzeigen | `openssl x509 -in CERT -text` |
| Remote Cert | `openssl s_client -connect HOST:443` |

---

## Archive

```bash
man tar
man gzip / bzip2 / xz
```

| Aufgabe | Befehl |
|---------|--------|
| tar.gz erstellen | `tar -czvf archive.tar.gz DIR` |
| tar.gz entpacken | `tar -xvf archive.tar.gz` |
| tar.xz | `tar -cJvf` / `tar -xJvf` |
| Inhalt | `tar -tvf archive.tar.gz` |
| gzip | `gzip` / `gunzip` |
| xz | `xz` / `unxz` |

---

## Packages

```bash
man apt / man dpkg       # Debian
man dnf / man rpm        # RHEL
```

| Aufgabe | Debian | RHEL |
|---------|--------|------|
| Update | `apt update` | `dnf update` |
| Install | `apt install PKG` | `dnf install PKG` |
| Search | `apt search` | `dnf search` |
| Info | `apt show PKG` | `dnf info PKG` |
| Dateien | `dpkg -L PKG` | `rpm -ql PKG` |
| Welches Paket | `dpkg -S FILE` | `rpm -qf FILE` |

---

## Performance & Tuning

```bash
man sysctl
man 5 limits.conf
help ulimit
```

| Aufgabe | Befehl |
|---------|--------|
| Sysctl lesen | `sysctl KEY` |
| Sysctl setzen | `sysctl -w KEY=VAL` |
| Ulimit | `ulimit -a`, `ulimit -n` |
| Limits | `/etc/security/limits.conf` |

---

## Debugging & Troubleshooting

### Prozesse analysieren

```bash
# Was macht der Prozess?
strace -p PID                  # Syscalls live
strace -e openat BEFEHL        # Welche Dateien öffnet er?
strace -e connect BEFEHL       # Welche Verbindungen?
strace -c BEFEHL               # Syscall-Statistik

# Offene Dateien/Sockets
lsof -p PID                    # Alles was PID offen hat
lsof -i :PORT                  # Wer nutzt den Port?
lsof +D /pfad/                 # Wer nutzt dieses Verzeichnis?

# Memory Maps
cat /proc/PID/maps
pmap PID
```

### Performance-Analyse

```bash
# CPU-Profiling
perf top                       # Live CPU-Sampling
perf record -g COMMAND         # Aufzeichnen
perf report                    # Auswerten

# Netzwerk
ss -tunapl                     # Alle Sockets
iftop                          # Live Traffic
```

### Kernel Messages

```bash
dmesg -T --level=err,warn      # Fehler mit Timestamp
dmesg -w                       # Follow mode
```

---

## DevOps-Tools

### Git

```bash
git help CMD
man git-CMD                    # z.B. man git-rebase
```

### Docker

```bash
docker CMD --help
docker run --help | grep -i "memory"
docker inspect CONTAINER/IMAGE
docker history IMAGE
docker info --format '{{json .}}'
```

### Kubernetes

```bash
kubectl explain RESOURCE
kubectl explain RESOURCE.FIELD --recursive
kubectl api-resources
kubectl api-versions
kubectl describe / get -o yaml
kubectl get events --sort-by='.lastTimestamp'
```

### Helm

```bash
helm CMD --help
helm show values CHART
helm get values RELEASE
helm get manifest RELEASE
helm template RELEASE CHART --debug
```

### Terraform

```bash
terraform -help
terraform CMD -help
terraform providers schema -json | jq '...'
# → registry.terraform.io
```

### Ansible

```bash
ansible-doc MODULE
ansible-doc -l | grep KEY
ansible-doc -s MODULE          # Snippet/Kurzform
```

### AWS/GCloud

```bash
aws help / aws SERVICE help
aws ec2 describe-instances help | grep -A5 "EXAMPLES"
gcloud help / gcloud CMD --help
```

### Go

```bash
go doc fmt.Printf
go doc -all PACKAGE
go help build
```

### Python

```bash
python -c "help('os.path')"
python -c "import requests; help(requests.get)"
pydoc MODULE
```

### Make

```bash
make -p                       # Alle impliziten Regeln
man make
```

---

## Source Code lesen

### Wo liegt der Code?

```bash
# Debian: Source holen
apt source PAKETNAME

# Go: Lokaler Cache
ls ~/go/pkg/mod/

# GitHub
# → github.com/PROJEKT/PROJEKT
```

### Code durchsuchen

```bash
# Einstiegspunkte finden
grep -r "func main" .
grep -r "if __name__" .

# Definition finden
grep -rn "func FunctionName" .
grep -rn "def function_name" .
grep -rn "type StructName struct" .

# TODOs/Probleme
grep -rn "TODO\|FIXME\|HACK" .
```

---

## Observability

### Prometheus

```bash
# Verfügbare Metriken
curl -s localhost:9090/api/v1/metadata | jq '.data | keys[]'
curl -s localhost:9090/api/v1/label/__name__/values

# Metric Types: counter, gauge, histogram, summary
# → https://prometheus.io/docs/concepts/metric_types/
```

---

## Quick Reference

| Thema | Nachschlagen |
|-------|--------------|
| Bash-Syntax | `man bash` |
| Test-Operatoren | `help test` |
| Globbing | `man 7 glob` |
| Regex | `man 7 regex` |
| Signale | `kill -l` |
| Exit Codes | `man sysexits` |
| ASCII | `man ascii` |
| Filesystem | `man hier` |
| Readline | `man readline` |
| Vim | `:help` |
| User DB | `man 5 passwd` |
| Sudo | `man 5 sudoers` |
| fstab | `man 5 fstab` |
| Systemd | `man systemd.service` |
| Cron | `man 5 crontab` |
| SSH | `man 5 ssh_config` |
| iptables | `man iptables-extensions` |
| TCP-States | RFC 793 / `man ss` |
| HTTP-Status | RFC 2616 |
| K8s Felder | `kubectl explain RESOURCE.FIELD` |
| AWS CLI | `aws SERVICE help` |
| Terraform | registry.terraform.io |

---

## Shell-Helfer (~/.bashrc)

```bash
# Intelligente Hilfe
h() {
    type "$1" &>/dev/null || { echo "Not found: $1"; return 1; }
    if [[ $(type -t "$1") == "builtin" ]]; then
        help "$1"
    else
        tldr "$1" 2>/dev/null || man "$1"
    fi
}

# Was ist das?
wtf() {
    type "$1" 2>/dev/null
    whatis "$1" 2>/dev/null
    apropos -e "$1" 2>/dev/null
}

# Cheat.sh (online)
cht() {
    curl -s "cheat.sh/$1"
}

# Man durchsuchen
mans() {
    man "$1" | grep -i --color=always "$2" | less -R
}

# Kubectl explain shortcut
kx() {
    kubectl explain "$1" --recursive 2>/dev/null | head -50
    kubectl explain "$1" 2>/dev/null
}
```

---

## Skript-Vorlage

```bash
#!/bin/bash
set -euo pipefail
[[ "${1:-}" == "-h" ]] && { echo "Usage: $0 <arg>"; exit 0; }
[[ $# -ge 1 ]] || { echo "ERROR: Missing arg" >&2; exit 1; }
```

---

## Skript-Workflow

```
┌─────────────────────────────────────────────────────────────┐
│  1. PROBLEM DEFINIEREN                                      │
│     • Was genau soll das Skript tun?                        │
│     • Welche Ein-/Ausgaben?                                 │
│                                                             │
│  2. LÖSUNG KONZIPIEREN                                      │
│     • Toolstack wählen (bash, python, etc.)                 │
│     • Abhängigkeiten identifizieren                         │
│                                                             │
│  3. ENTWURF (PSEUDOCODE)                                    │
│     • Grobe Struktur festlegen                              │
│     • Sinnvolle Teilaufgaben ableiten                       │
│                                                             │
│  4. IMPLEMENTIERUNG                                         │
│     Für jede Teilaufgabe:                                   │
│     a) Commands isoliert im Terminal testen                 │
│     b) Code ins Skript übertragen                           │
│     c) Position im Skript prüfen                            │
│                                                             │
│  5. QUALITÄTSSICHERUNG                                      │
│     • Fehlerbehandlung (set -e, exit codes)                 │
│     • Linting (shellcheck, pylint)                          │
│     • Ganzheitlicher Test mit Testdaten                     │
│     • Edge Cases prüfen                                     │
│                                                             │
│  6. FINALISIERUNG                                           │
│     • Kommentare & Dokumentation                            │
│     • Versionskontrolle (git)                               │
└─────────────────────────────────────────────────────────────┘
```

---

## Merksätze

> **`type` zuerst** – Builtin? Extern? Alias? Function?

> **`--help | grep`** – 70% aller Fragen beantwortet

> **`man -k` / `apropos`** – Befehl vergessen? Keyword reicht

> **`/usr/share/doc/`** – Die vergessene Goldgrube

> **Source Code** – Wenn alles andere lügt

> **RFC** – Protokolle verstehen, nicht raten


