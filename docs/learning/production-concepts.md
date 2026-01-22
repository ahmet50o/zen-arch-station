# Production Systems Engineering - 969 Essential Concepts

> Optimaler Lernpfad für DevOps Engineers 2026
> 57 Kategorien • 10 Phasen • Vollständig mit praktischen Beschreibungen

---

## TABLE OF CONTENTS

### PHASE 1: FUNDAMENTALS (~122 concepts, Weeks 1-8)
1. Git & Version Control Basics (15)
2. Linux Basics I: Shell & Files (19) - erweitert mit jq, vim/nvim
3. Linux Basics II: Processes & System (18)
4. Networking Basics (19) - erweitert mit VPN, SSH tunneling, proxy
5. Python Basics for DevOps (15)
6. Shell Scripting & Automation (18)
7. Web Fundamentals & HTTP (18)

### PHASE 2: DEVELOPMENT (~100 concepts, Weeks 9-14)
8. Git Advanced (15)
9. Databases I: SQL & PostgreSQL (18)
10. Databases II: NoSQL & Performance (17)
11. Programming with Go Basics (18)
12. Programming with Go Advanced (17)
13. API Design & gRPC (15)

### PHASE 3: CLOUD FOUNDATIONS (~120 concepts, Weeks 15-22)
14. Cloud Concepts & Architecture (15)
15. AWS Basics I: Compute & Storage (20)
16. AWS Basics II: Networking & IAM (20)
17. AWS Intermediate: Services & Integration (20)
18. Azure Basics: Core Services (18)
19. Azure Intermediate (17)
20. GCP Essentials (10)

### PHASE 4: INFRASTRUCTURE (~110 concepts, Weeks 23-30)
21. Infrastructure as Code I: Terraform Basics (18)
22. Infrastructure as Code II: Terraform Advanced (17)
23. Containerization I: Docker Basics (18)
24. Containerization II: Docker Advanced (17)
25. Configuration Management: Ansible (20)
26. VM & Compute Management (20)

### PHASE 5: ORCHESTRATION (~120 concepts, Weeks 31-38)
27. Kubernetes Basics I: Core Concepts (18)
28. Kubernetes Basics II: Workloads (18)
29. Kubernetes Intermediate: Networking & Storage (18)
30. Kubernetes Advanced I: Operators & CRDs (17)
31. Kubernetes Advanced II: Multi-cluster (17)
32. Service Mesh & Istio (17)
33. Networking Advanced (15)

### PHASE 6: CI/CD & GITOPS (~100 concepts, Weeks 39-44)
34. CI/CD Basics: Pipelines & GitHub Actions (18)
35. CI/CD Advanced: Jenkins & Complex Workflows (17)
36. GitOps I: ArgoCD Basics (15)
37. GitOps II: Flux & Progressive Delivery (15)
38. GitOps Advanced: Multi-env & Patterns (15)
39. Release Strategies & Deployment (20)

### PHASE 7: OBSERVABILITY & RELIABILITY (~90 concepts, Weeks 45-50)
40. Observability I: Metrics & Prometheus (18)
41. Observability II: Logging & Tracing (18)
42. Observability III: Advanced Patterns (14)
43. Distributed Systems Patterns (20)
44. SRE Practices & Reliability (20)

### PHASE 8: SECURITY & COMPLIANCE (~95 concepts, Weeks 51-56)
45. Security Basics: Auth & Encryption (18)
46. DevSecOps I: Supply Chain Security (15)
47. DevSecOps II: Policy as Code (15)
48. DevSecOps III: Secrets & Scanning (17)
49. Cloud Security & IAM (15)
50. Security Advanced: Zero Trust & Compliance (15)

### PHASE 9: PLATFORM ENGINEERING (~60 concepts, Weeks 57-60)
51. Platform Engineering I: IDP Concepts (15)
52. Platform Engineering II: Backstage (15)
53. Developer Experience & Tooling (15)
54. FinOps & Cost Optimization (15)

### PHASE 10: ADVANCED TOPICS (~39 concepts, Weeks 61-65)
55. Linux Advanced: systemd & Performance (18)
56. Advanced Networking: eBPF & CNI (16)
57. Meta-Skills & Best Practices (5)

---


## PHASE 1: FUNDAMENTALS

### Category 1: Git & Version Control Basics (15 concepts)

### 1. Git Fundamentals

**Version control:** track changes, history, collaboration, branching, distributed (every clone is full repo).

**Basic workflow:** `git init` (new repo) or `git clone <url>`, `git add file` (stage), `git commit -m "message"` (save snapshot), `git push` (upload), `git pull` (download + merge).

**Config:** `git config --global user.name "Name"`, `git config --global user.email "email"`, stored in `~/.gitconfig`, project-specific `git config` (no `--global`), stored in `.git/config`.

**Status:** `git status` (changed files), `git diff` (unstaged changes), `git diff --staged` (staged changes), `git log` (history), `git log --oneline` (compact), `git log --graph --all` (visual).

**Files:** `.git/` directory (repo data), `.gitignore` (exclude files), `.gitattributes` (file handling).

**Staging area:** index between working directory and commit, allows selective commits, `git add -p` (interactive, choose hunks).

---

### 2. Git Branching

**Branches:** parallel development, `git branch` (list), `git branch feature` (create), `git checkout feature` or `git switch feature` (switch), `git checkout -b feature` (create + switch).

**Main/master:** default branch, production code, protect from direct commits.

**Feature branches:** one branch per feature, `feature/user-auth`, `feature/payment`, develop independently, merge when done.

**Merge:** `git merge feature` (merge feature into current), creates merge commit, preserves history, may have conflicts.

**Fast-forward:** if target hasn't diverged, just moves pointer, `git merge --ff-only` (only if possible), `git merge --no-ff` (always create merge commit).

**Delete branch:** `git branch -d feature` (safe, checks if merged), `git branch -D feature` (force).

**Remote branches:** `git push origin feature` (upload branch), `git push origin --delete feature` (delete remote), `git fetch` (download refs), `git branch -r` (list remote).

---

### 3. Git Merge vs Rebase

**Merge:** combines branches, creates merge commit, preserves complete history, shows when branches were integrated, `git merge feature`.

**Rebase:** reapplies commits on top of another branch, linear history, rewrites commit hashes, cleaner history, `git rebase main` (rebase current branch onto main).

**Interactive rebase:** `git rebase -i HEAD~3`, edit last 3 commits, squash (combine), reword (change message), drop (remove), reorder.

**When to use:**
- Merge: public branches, preserve history, team collaboration.
- Rebase: feature branches before merge, clean up local commits, avoid "merge spam".

**Golden rule:** never rebase public/shared branches (rewrites history, breaks others' repos).

**Conflicts:** both can have conflicts, resolve with editor, mark `git add`, continue `git merge --continue` or `git rebase --continue`, abort `git merge --abort` or `git rebase --abort`.

---

### 4. Git Conflict Resolution

**Happens when:** same file, same lines changed differently, git can't auto-merge.

**Markers:** conflict shown as:
```
<<<<<<< HEAD
your change
=======
their change
>>>>>>> feature
```

**Resolve:** edit file, choose version or combine, remove markers, `git add file`, `git commit` (for merge) or `git rebase --continue`.

**Tools:** `git mergetool` (GUI), IDEs (VSCode, PyCharm), `git diff --ours` (your version), `git diff --theirs` (their version).

**Strategies:** recursive (default), ours (always take our version on conflict), theirs, `git merge -X ours feature`.

**Prevention:** communicate, small commits, frequent merges/rebases, divide work (different files).

---

### 5. Git Stash

**Purpose:** save uncommitted changes temporarily, switch branches without committing.

**Stash:** `git stash` or `git stash push` (save working directory + index), `git stash -u` (include untracked files), `git stash -a` (include ignored files).

**List:** `git stash list` (shows stash@{0}, stash@{1}, ...).

**Apply:** `git stash apply` (latest, keeps in stash), `git stash apply stash@{1}` (specific), `git stash pop` (apply + delete from stash).

**Show:** `git stash show` (summary), `git stash show -p` (full diff).

**Drop:** `git stash drop` (delete latest), `git stash drop stash@{1}` (specific), `git stash clear` (delete all).

**Use cases:** switch branches mid-work, pull without committing, experiment without committing.

---

### 6. Git Remote Repositories

**Remote:** external repo (GitHub, GitLab, Bitbucket, self-hosted), `git remote -v` (list), `git remote add name url` (add), `git remote remove name` (delete).

**Origin:** default remote name (created by `git clone`), convention not requirement.

**Fetch:** `git fetch origin` (download objects/refs, doesn't merge), updates remote-tracking branches `origin/main`.

**Pull:** `git pull origin main` = `git fetch origin` + `git merge origin/main`, `git pull --rebase` (fetch + rebase instead of merge).

**Push:** `git push origin main` (upload main branch), `git push -u origin feature` (set upstream, future `git push` enough), `git push --force` (rewrite remote, dangerous), `git push --force-with-lease` (safer, checks remote hasn't changed).

**Tracking branches:** local branch linked to remote, `git branch -u origin/main` (set upstream), `git push -u origin feature` (push + set).

**Multiple remotes:** `git remote add upstream original_repo_url` (for forks), `git fetch upstream`, `git merge upstream/main`.

---

### 7. Git Tags

**Purpose:** mark specific commits (releases, versions), immutable reference.

**Lightweight:** pointer to commit, `git tag v1.0.0` (on current commit), `git tag v1.0.0 <commit-hash>` (specific commit).

**Annotated:** full object, includes tagger, date, message, `git tag -a v1.0.0 -m "Release 1.0.0"`, stores in git database, recommended for releases.

**List:** `git tag` (all tags), `git tag -l "v1.*"` (pattern).

**Show:** `git show v1.0.0` (commit + diff), `git show-ref --tags` (tags with commits).

**Push:** tags not pushed by default, `git push origin v1.0.0` (specific), `git push origin --tags` (all), `git push --follow-tags` (only annotated).

**Delete:** `git tag -d v1.0.0` (local), `git push origin --delete v1.0.0` (remote).

**Checkout:** `git checkout v1.0.0` (detached HEAD, view old code, don't commit), create branch `git checkout -b hotfix-v1 v1.0.0`.

---

### 8. Git History and Log

**Log:** `git log` (commit history), `git log --oneline` (short), `git log --graph` (visual branches), `git log --all` (all branches).

**Filtering:** `git log --author="name"` (by author), `git log --since="2 weeks ago"`, `git log --until="2024-01-01"`, `git log --grep="fix"` (search messages), `git log -S "function_name"` (search code changes).

**File history:** `git log file` (commits affecting file), `git log -p file` (with diffs), `git log --follow file` (track renames).

**Blame:** `git blame file` (who changed each line), `git blame -L 10,20 file` (specific lines), `git blame -w` (ignore whitespace).

**Show:** `git show <commit>` (commit details + diff), `git show <commit>:file` (file contents at commit).

**Reflog:** `git reflog` (all ref updates, including deleted commits), recover lost commits, `git reset --hard <commit>` from reflog.

**Bisect:** binary search for bug, `git bisect start`, `git bisect bad` (current is bad), `git bisect good <commit>` (known good), git checks out commits, mark good/bad, finds first bad commit.

---

### 9. Git Reset and Revert

**Reset:** move HEAD (and branch), `git reset <commit>`, modes:
- `--soft`: move HEAD, keep index + working directory (uncommit).
- `--mixed` (default): move HEAD, reset index, keep working directory (unstage).
- `--hard`: move HEAD, reset index + working directory (discard changes).

**Use cases:** `git reset --soft HEAD~1` (undo last commit, keep changes staged), `git reset HEAD~1` (undo last commit, unstage), `git reset --hard HEAD~1` (undo last commit, discard changes).

**Revert:** create new commit that undoes previous commit, `git revert <commit>`, safe for public branches (doesn't rewrite history), may have conflicts.

**Difference:** reset rewrites history (dangerous for shared branches), revert adds new commit (safe).

**Detached HEAD:** `git checkout <commit>` (not a branch), view old code, changes lost unless create branch, return with `git checkout main`.

**Clean:** `git clean -fd` (remove untracked files + directories), `-n` (dry run), `-x` (include ignored files), dangerous!

---

### 10. Git Workflows

**Centralized:** one main branch, everyone commits to main, simple, no branching, risky.

**Feature branch:** main + feature branches, merge feature → main when done, isolated development, pull requests.

**Gitflow:** structured, branches: main (production), develop (integration), feature/* (features), release/* (release prep), hotfix/* (urgent fixes), complex, overkill for small teams.

**GitHub Flow:** simple, main + feature branches, main always deployable, feature → pull request → merge → deploy, continuous deployment.

**Trunk-based:** everyone commits to trunk (main) frequently, short-lived branches (< 1 day), feature flags for incomplete features, requires CI/CD.

**Forking:** each dev has own repo (fork), clone fork, push to fork, pull request to upstream, open source common.

**Choose based on:** team size, release cadence, CI/CD maturity, project complexity.

---

### 11. Git Submodules

**Purpose:** include other git repos as subdirectories, dependencies, shared libraries.

**Add:** `git submodule add <repo-url> path/to/submodule`, creates `.gitmodules` file, submodule tracked at specific commit.

**Clone with submodules:** `git clone --recurse-submodules <repo-url>`, or after clone `git submodule update --init --recursive`.

**Update:** `cd submodule; git pull origin main`, `cd ..; git add submodule; git commit`, or `git submodule update --remote` (update all to latest).

**Status:** `git submodule status` (current commits), `git diff --submodule` (show submodule changes).

**Remove:** `git submodule deinit submodule`, `git rm submodule`, `rm -rf .git/modules/submodule`.

**Alternatives:** git subtree (copy repo instead of reference), package managers (npm, pip), monorepo.

**Issues:** complexity, everyone must update submodules, easy to forget, commits detached.

---

### 12. Git Hooks

**Purpose:** scripts triggered by git events, automate workflows, enforce policies.

**Location:** `.git/hooks/`, templates in `.git/hooks/*.sample`, rename to remove `.sample` + make executable.

**Client-side:**
- `pre-commit`: before commit, run linter/tests, exit non-zero to abort.
- `prepare-commit-msg`: edit default commit message.
- `commit-msg`: validate commit message format, exit non-zero to abort.
- `post-commit`: after commit, notifications.
- `pre-push`: before push, run tests.

**Server-side:**
- `pre-receive`: before refs updated, reject push.
- `update`: per branch, reject specific branches.
- `post-receive`: after receive, deploy, notify CI.

**Example (pre-commit):**
```bash
#!/bin/bash
flake8 .
if [ $? -ne 0 ]; then exit 1; fi
```

**Tools:** Husky (JS), pre-commit framework (Python), lefthook, manage hooks in repo (hooks usually not committed).

**Use cases:** code formatting, linting, tests, prevent force push, enforce branch naming, ticket number in commit message.

---

### 13. Git Cherry-Pick

**Purpose:** apply specific commits from one branch to another, selective merge.

**Usage:** `git cherry-pick <commit-hash>`, applies commit to current branch, creates new commit (different hash).

**Multiple:** `git cherry-pick <commit1> <commit2>`, `git cherry-pick <commit1>..<commit3>` (range).

**Conflicts:** resolve like merge, `git add`, `git cherry-pick --continue`, abort `git cherry-pick --abort`.

**Use cases:** backport fix to old release branch, pick specific feature commits, fix applied to wrong branch.

**Warning:** duplicates commits (different hashes), can cause confusion, prefer merge/rebase when possible.

---

### 14. Git Large Files (LFS)

**Problem:** git stores full history of all files, large binaries (images, videos, models) bloat repo, slow clones.

**Solution:** Git LFS (Large File Storage), stores pointers in git, actual files on separate server.

**Install:** `git lfs install`, track files `git lfs track "*.psd"` (creates `.gitattributes`), add/commit normally.

**Clone:** `git lfs clone <url>` or `git clone` + `git lfs pull`, downloads large files.

**Storage:** GitHub/GitLab provide LFS storage (quota limits), self-hosted LFS server.

**Alternatives:** git-annex, DVC (data version control for ML), don't commit large files (use CDN/S3, reference in docs).

**Use cases:** design files, datasets, ML models, binaries, game assets.

---

### 15. Git Aliases

**Purpose:** shortcuts for common commands, improve efficiency.

**Create:** `git config --global alias.co checkout`, use `git co` instead of `git checkout`.

**Examples:**
- `git config --global alias.st status`
- `git config --global alias.br branch`
- `git config --global alias.ci commit`
- `git config --global alias.unstage 'reset HEAD --'`
- `git config --global alias.last 'log -1 HEAD'`
- `git config --global alias.visual 'log --oneline --graph --all'`

**Complex:** `git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"`.

**Shell commands:** `git config --global alias.save '!git add -A && git commit -m "SAVEPOINT"'` (! runs shell).

**Storage:** `~/.gitconfig` under `[alias]` section.

---

### Category 2: Linux Basics I: Shell & Files (18 concepts)

### 16. Shell Fundamentals

Command execution, pipes (`|`), redirection (`>`, `>>`, `2>&1`), exit codes (`$?`), environment variables (`export`, `printenv`). Master bash, zsh shells, understand command history (`history`, `Ctrl+R`), job control (`jobs`, `fg`, `bg`, `&`), command substitution (`$(command)`, backticks), process substitution (`<(command)`). 

**Files:** `~/.bashrc`, `~/.bash_profile`, `~/.zshrc`, `/etc/profile`.

---

### 17. File System Hierarchy

Understanding the Linux filesystem structure: `/` (root), `/bin` and `/usr/bin` (executables), `/etc` (configuration), `/var` (variable data like logs), `/proc` (process information, virtual filesystem), `/sys` (kernel/device info), `/tmp` (temporary files), `/home` (user directories), `/opt` (optional software), `/dev` (device files), `/lib` (shared libraries). 

Use `man hier` to understand the hierarchy. Navigate with `cd`, `pwd`, `ls`, `tree`.

---

### 18. Text Processing (grep, sed, awk, jq)

Pattern matching with **grep** (`grep -E` for regex, `-r` recursive, `-i` case-insensitive, `-v` invert), stream editing with **sed** (`sed 's/old/new/g'` substitution, `-i` in-place edit), field extraction with **awk** (`awk '{print $1}'` for columns, `-F` delimiter, pattern matching).

**jq** for JSON: `jq '.field'` extract field, `jq '.[] | select(.status=="active")'` filter, `jq -r .name` raw output, `jq 'map(.id)'` transform arrays, `echo '{"a":1}' | jq .a` piping. YAML: `yq` (jq for YAML), or convert with `yq eval -o=json file.yaml | jq`.

Combine with pipes for powerful text manipulation: `cat file | grep ERROR | awk '{print $3}'`, `curl api.com/data | jq '.items[] | .name'`. Essential for log analysis, config parsing, data extraction, API responses.

---

### 19. File Permissions & Ownership

Three permission types (read=4, write=2, execute=1) for user/group/other. Use `chmod` (numeric `chmod 755 file` or symbolic `chmod u+x file`), `chown user:group file` for ownership, `umask` for default permissions. 

Special bits: setuid (4000), setgid (2000), sticky bit (1000). Check with `ls -l`, understand `rwxrwxrwx` format. 

**Files:** `/etc/passwd`, `/etc/group` for user/group info. ACLs with `getfacl`/`setfacl` for fine-grained control.

---

### 20. Process Basics

Each process has a PID (process ID), PPID (parent process ID), UID (user ID). View with `ps aux`, `ps -ef`, `pstree` for hierarchy. 

**States:** running, sleeping, stopped, zombie. 

Foreground vs background execution (`command &`), job control (`jobs`, `fg`, `bg`, `disown`). Signal processes with `kill -SIGNAL PID`. 

**Files:** `/proc/[pid]/` for process info, `/proc/[pid]/status`, `/proc/[pid]/cmdline`, `/proc/[pid]/fd/` for file descriptors.

---

### 21. Standard Streams

Every process has three default file descriptors: stdin (0), stdout (1), stderr (2). Redirect output with `>` (stdout), `2>` (stderr), `&>` (both), `>>` (append). Redirect input with `<`. Connect programs with pipes `|`. 

Combine: `command 2>&1 | tee log.txt` to capture and display. 

**Files:** `/dev/stdin`, `/dev/stdout`, `/dev/stderr`, `/dev/null` (discard output), `/dev/zero`, `/dev/urandom`.

---

### 22. Exit Codes & Error Handling

Programs return 0 for success, non-zero for failure. Check with `echo $?` immediately after command. Use in scripts: `if command; then ... fi`, `command || echo "failed"`, `command && next_command`. Set exit codes with `exit N`. 

**Convention:** 1 general error, 2 misuse, 126 cannot execute, 127 command not found, 128+N signal N. Essential for automation, CI/CD pipelines, error handling in scripts.

---

### 23. Environment Variables

Configuration passed to processes: `PATH` (executable search path), `HOME` (user directory), `USER`, `SHELL`, `LANG` (locale), `TMPDIR`. View with `printenv`, `env`, `echo $VAR`. Set with `export VAR=value` (current session), persist in `~/.bashrc`, `~/.profile`, `/etc/environment`. Unset with `unset VAR`. Use in Go with `os.Getenv()`, in scripts with `${VAR:-default}` for default values.

---

### 24. Command Composition (Pipes)

Connect stdout of one program to stdin of another with `|`. Unix philosophy: small tools that do one thing well. 

**Examples:** 
- `cat access.log | grep ERROR | wc -l`
- `ps aux | grep nginx | awk '{print $2}' | xargs kill`

Named pipes (FIFOs): `mkfifo pipe; command1 > pipe & command2 < pipe`. Process substitution: `diff <(sort file1) <(sort file2)`. Essential for building complex workflows from simple building blocks.

---

### 25. Shell Scripting Fundamentals

Bash scripting: shebang `#!/bin/bash`, variables `VAR=value` (no spaces), `$VAR` or `${VAR}` to expand. 

**Conditionals:** `if [ condition ]; then ... fi`, test operators `-f` (file exists), `-d` (directory), `-z` (string empty), `-eq` (numeric equal). 

**Loops:** `for i in list; do ... done`, `while [ condition ]; do ... done`. 

**Functions:** `function_name() { ... }`. Read input: `read VAR`. Command-line args: `$1`, `$2`, `$@` (all args), `$#` (count).

---

### 26. Regular Expressions

Pattern matching language: `.` (any char), `*` (0+ of previous), `+` (1+), `?` (0 or 1), `^` (start), `$` (end), `[]` (character class), `()` (grouping), `|` (or). 

**PCRE (Perl-Compatible):** `\d` (digit), `\w` (word char), `\s` (whitespace), `{n,m}` (repetition). 

Use in `grep -E`, `sed -E`, `awk`. Test with grep, online regex testers. Essential for log parsing, validation, text extraction. 

**Example:** `grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' file` for IP addresses.

---

### 27. systemd Timers

Modern replacement for cron. Calendar timers: `OnCalendar=daily`, `OnCalendar=*-*-* 02:00:00` (2 AM daily). Monotonic timers: `OnBootSec=5min`, `OnUnitActiveSec=1h` (run 1h after last activation). 

Create timer unit (`*.timer`) paired with service unit (`*.service`). 

**Files:** `/etc/systemd/system/`, `/lib/systemd/system/`. 

**Commands:** `systemctl enable --now timer.timer`, `systemctl list-timers`, `journalctl -u timer.service`. 

Persistent timers run missed executions: `Persistent=true`. Randomize execution: `RandomizedDelaySec=10min`.

---

### 28. Archives & Compression

Create archives with **tar**: `tar -czf archive.tar.gz dir/` (gzip), `tar -cJf archive.tar.xz dir/` (xz, better compression). Extract: `tar -xzf archive.tar.gz`, `tar -xJf archive.tar.xz`. 

Modern compression: `zstd -T0 file` (parallel, fast), `xz -T0 file` (high compression). 

List contents: `tar -tzf archive.tar.gz`. Exclude files: `tar --exclude='*.log' -czf archive.tar.gz dir/`. Incremental backups: `tar -czf backup.tar.gz --listed-incremental=snapshot.file dir/`.

---

### 29. Text Editors (vim/nvim)

**vim** basics: modes (normal `Esc`, insert `i`, visual `v`, command `:`), save/quit (`:w`, `:q`, `:wq`, `:q!`), navigation (`h j k l`, `w` word, `gg` top, `G` bottom, `$` end of line, `0` start). Search (`/pattern`, `n` next, `N` previous), replace (`:%s/old/new/g`), undo (`u`), redo (`Ctrl+r`).

**nvim** (Neovim): Lua config (`~/.config/nvim/init.lua`), plugins (packer.nvim, lazy.nvim), LSP (native language server support, autocompletion, diagnostics), Treesitter (syntax highlighting, code parsing), Telescope (fuzzy finder), lazy loading (fast startup). Config example: `vim.opt.number = true`, `vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>')`.

Essential plugins: nvim-lspconfig (LSP), nvim-cmp (completion), nvim-treesitter (syntax), telescope.nvim (fuzzy find), vim-fugitive (git), which-key (key bindings).

---

### 30. Package Management (DNF/APT)

**Debian/Ubuntu:** `apt update` (refresh repos), `apt install package`, `apt remove package`, `apt search keyword`, `apt show package`.

**Config:** `/etc/apt/sources.list`, `/etc/apt/sources.list.d/`.

**RHEL/Fedora:** `dnf install package`, `dnf remove package`, `dnf search keyword`, `dnf info package`.

**Config:** `/etc/yum.repos.d/`.

Lock files: `/var/lib/dpkg/lock` (apt), `/var/lib/rpm/` (rpm). Clean cache: `apt clean`, `dnf clean all`. Pin versions: `/etc/apt/preferences.d/` (apt).

---

### 31. Process Model (Fork/Exec)

Process creation on Unix: `fork()` creates exact copy of parent (copy-on-write optimization), `exec()` replaces process image with new program. Parent gets child PID, child gets 0. Use `strace -e fork,execve command` to observe. 

**Files:** `/proc/[pid]/status` shows process state. 

Example: shell forks for each command, execs the program. Zombie processes: child exits but parent hasn't called `wait()`, shows as `<defunct>` in ps. Orphan processes: parent dies, reparented to PID 1 (systemd).

---

### 32. Virtual Memory

Each process sees its own address space, kernel maps virtual addresses to physical RAM via page tables. Pages are 4KB (x86_64, check with `getconf PAGE_SIZE`). Translation Lookaside Buffer (TLB) caches mappings. 

View memory: `/proc/meminfo` (system), `/proc/[pid]/status` (process), `VmRSS` is physical memory, `VmSize` is virtual. 

OOM killer: kernel kills processes when out of memory, scores in `/proc/[pid]/oom_score`, adjust with `oom_score_adj`. Overcommit: `/proc/sys/vm/overcommit_memory` (0=heuristic, 1=always, 2=never).

---

### 33. Memory Pages

Memory managed in pages (usually 4KB). Page faults: minor (page in RAM, not in TLB), major (page on disk, swap in). View with `ps -o min_flt,maj_flt,cmd`. 

Transparent Huge Pages (THP): 2MB pages, reduce TLB misses, check `/sys/kernel/mm/transparent_hugepage/enabled`. Disable for databases: `echo never > /sys/kernel/mm/transparent_hugepage/enabled`. 

Swapping: move pages to disk when RAM full, configure swap with `swapon`, `mkswap`, see `/proc/swaps`. Swappiness: `/proc/sys/vm/swappiness` (0-100, higher = more aggressive swapping).

---

### 34. System Calls

Interface between user space and kernel space. 

**Examples:** `open()`, `read()`, `write()`, `fork()`, `execve()`, `socket()`. 

Observe with `strace command` (shows all syscalls), `strace -c` for summary, `strace -e open,read,write` to filter. Library wrappers: glibc provides C functions that invoke syscalls. Context switch overhead: user→kernel→user. 

**Files:** `/proc/[pid]/syscall` shows current syscall. 

Fast syscalls: vDSO (virtual dynamic shared object) for `gettimeofday()`, `clock_gettime()` without context switch.

---

### Category 3: Linux Basics II: Processes & System (18 concepts)

### 35. Signals

Asynchronous notifications to processes: `SIGTERM` (15, graceful shutdown), `SIGKILL` (9, force kill), `SIGINT` (2, Ctrl+C), `SIGHUP` (1, reload config), `SIGUSR1`, `SIGUSR2` (user-defined). 

Send with `kill -SIGNAL PID`, `killall -SIGNAL name`, `pkill -SIGNAL pattern`. Handle in code with signal handlers. Ignore: `SIG_IGN`, default: `SIG_DFL`. Block signals: signal mask. Modern: `signalfd()` for event-driven handling. 

**Files:** `/proc/[pid]/status` shows blocked/caught signals. 

Trap in bash: `trap 'cleanup' EXIT TERM INT`.

---

### 36. File Descriptors

Integer handles for open files: 0 (stdin), 1 (stdout), 2 (stderr). Every `open()` returns next available FD. View with `ls -l /proc/[pid]/fd/`, `lsof -p PID`. Duplicate with `dup()`, `dup2()` for redirection. Close with `close()`. 

Limit: `ulimit -n` (soft), view limits in `/proc/[pid]/limits`. Increase: `ulimit -n 4096` (session), `/etc/security/limits.conf` (persistent). 

Non-blocking: `fcntl(fd, F_SETFL, O_NONBLOCK)`. Poll for readiness: `select()`, `poll()`, `epoll()` (Linux).

---

### 37. Inodes

Data structure storing file metadata: permissions, owner, size, timestamps (atime, mtime, ctime), block pointers. Inode != filename (directory entry maps name→inode). View with `ls -i` (inode number), `stat file` (detailed info). 

Hard links: multiple names for same inode, same data. Soft links (symlinks): special file pointing to path. Inode limit: `df -i` shows usage. 

Watch files: `inotifywait` uses kernel's inotify to monitor file events (create, modify, delete). 

**Files:** `/proc/sys/fs/inotify/max_user_watches` for limit.

---

### 38. File System Types

Modern Linux filesystems: **ext4** (default, journaling, up to 1EB), **XFS** (high performance, large files, RHEL default), **Btrfs** (CoW, snapshots, compression, RAID). 

View with `df -T`, `mount | grep type`, `/proc/filesystems`. 

Format: `mkfs.ext4 /dev/sdX`, `mkfs.xfs /dev/sdX`. 

**Features:** ext4 has extents, XFS has allocation groups, Btrfs has subvolumes. 

Tune: `tune2fs` (ext4), `xfs_admin` (XFS). Check: `fsck`, `xfs_repair`. 

Mount options: `noatime` (performance), `discard` (SSD TRIM).

---

### 39. systemd Service Management

Manage services with `systemctl`: `systemctl start service`, `stop`, `restart`, `reload` (config reload without restart), `enable` (start on boot), `disable`, `status`. 

**Service types:** `Type=simple` (main process), `Type=forking` (daemonize), `Type=oneshot` (exits after start), `Type=notify` (sd_notify). 

Socket activation: systemd listens on socket, starts service on connection. 

**Files:** `/etc/systemd/system/`, `/lib/systemd/system/`, `/run/systemd/system/`. 

Reload daemon: `systemctl daemon-reload`. 

**Dependencies:** `After=`, `Before=`, `Requires=`, `Wants=`.

---

### 40. systemd Targets

Group of units, similar to runlevels. Common targets: `multi-user.target` (multi-user text mode), `graphical.target` (GUI), `rescue.target` (single user), `emergency.target` (minimal). 

View: `systemctl list-units --type=target`, default: `systemctl get-default`, set: `systemctl set-default multi-user.target`. 

Boot to target: `systemctl isolate rescue.target`. 

Dependencies: `systemctl list-dependencies multi-user.target`. 

**Files:** `/lib/systemd/system/*.target`. Create custom targets for application stacks.

---

### 41. Journald Logging

systemd's logging daemon, binary format. View logs: `journalctl` (all), `journalctl -u service` (specific service), `journalctl -f` (follow), `journalctl -b` (current boot), `journalctl --since "1 hour ago"`. 

Filter: `journalctl -p err` (priority), `journalctl _PID=1234`. Structured fields: `journalctl MESSAGE="specific message"`. 

**Config:** `/etc/systemd/journald.conf`, storage: `/var/log/journal/`. 

Make persistent: `mkdir -p /var/log/journal`, `systemd-tmpfiles --create --prefix /var/log/journal`. 

Disk usage: `journalctl --disk-usage`, vacuum: `journalctl --vacuum-time=7d`.

---

### 42. Performance Monitoring Basics

**top/htop:** CPU/memory per process, load average, htop has better UI, filtering, tree view. 

**iostat:** disk I/O statistics, `iostat -x 1` (extended, 1 second interval), shows await (latency), %util. 

**vmstat:** virtual memory stats, `vmstat 1` (1 second), shows swapping, I/O, CPU. 

**mpstat:** CPU statistics per core, `mpstat -P ALL 1`. 

Load average: `uptime`, 1/5/15 minute averages, compare to CPU count. 

**free:** memory usage, `free -h` (human readable), buffers/cache. 

**sar:** system activity reporter, requires sysstat package, historical data.

---

### 43. Disk Management

List block devices: `lsblk` (tree view), `lsblk -f` (with filesystem). 

Partition: `fdisk /dev/sdX` (MBR, max 2TB), `gdisk /dev/sdX` (GPT, larger disks, UEFI). 

View partitions: `fdisk -l`, `parted -l`. 

Partition types: Linux (83), swap (82), LVM (8e). 

Format: `mkfs.ext4 /dev/sdX1`, `mkfs.xfs /dev/sdX1`. 

Resize: `resize2fs /dev/sdX1` (ext4), `xfs_growfs /mountpoint` (XFS, online only). 

UUID: `blkid /dev/sdX1` (get UUID for fstab). 

Smart monitoring: `smartctl -a /dev/sdX`.

---

### 44. LVM (Logical Volume Manager)

Flexible volume management. 

**Architecture:** Physical Volumes (PVs) → Volume Groups (VGs) → Logical Volumes (LVs). 

Create PV: `pvcreate /dev/sdX`, VG: `vgcreate vg_name /dev/sdX`, LV: `lvcreate -L 10G -n lv_name vg_name`. 

Extend: `lvextend -L +5G /dev/vg_name/lv_name`, then resize filesystem. 

View: `pvdisplay`, `vgdisplay`, `lvdisplay`, `lvs`, `vgs`, `pvs`. 

Snapshots: `lvcreate -L 1G -s -n snap_name /dev/vg_name/lv_name` (CoW snapshot). 

Thin provisioning: `lvcreate -T vg/thinpool -L 10G`, then `lvcreate -V 5G -T vg/thinpool -n lv_name`.

---

### 45. File System Operations

Mount filesystems: `mount /dev/sdX1 /mnt/point`, unmount: `umount /mnt/point`. 

Persistent mounts: `/etc/fstab` (format: device mountpoint fstype options dump pass). 

Options: `defaults`, `noatime` (no access time updates, performance), `ro` (read-only), `noexec` (no execution). 

Bind mounts: `mount --bind /source /dest` (same filesystem, different path). 

tmpfs: `mount -t tmpfs -o size=1G tmpfs /mnt/ramdisk` (RAM-based). 

View mounts: `mount`, `findmnt` (tree view), `/proc/mounts`. 

Remount: `mount -o remount,rw /`. 

Check filesystem: `df -h` (usage), `df -i` (inodes).

---

### 46. Time & NTP (chrony)

System time synchronization. Modern NTP client/server: chrony (replaces ntpd). 

**Config:** `/etc/chrony/chrony.conf`, servers: `pool pool.ntp.org iburst`. 

View status: `chronyc tracking` (offset, stratum), `chronyc sources` (time sources). 

Force sync: `chronyc makestep`. 

System time: `timedatectl` (view/set), `timedatectl set-timezone Europe/Berlin`, `timedatectl set-ntp true` (enable NTP). 

Hardware clock: `hwclock --show`, sync: `hwclock --systohc` (system to hardware). 

**Files:** `/etc/localtime` (symlink to timezone), `/usr/share/zoneinfo/` (timezone database). 

RTC: Real-Time Clock in `/sys/class/rtc/`.

---

### 47. Locale & Character Encoding

System language/encoding settings. View: `locale` (current settings), `localectl` (systemd). 

Set: `localectl set-locale LANG=en_US.UTF-8`, `export LANG=en_US.UTF-8`. 

Variables: `LANG` (default), `LC_ALL` (override all), `LC_TIME`, `LC_NUMERIC`, etc. 

Generate locales: `locale-gen` (Debian), edit `/etc/locale.gen`. 

UTF-8: universal character encoding, supports all languages. 

**Files:** `/etc/default/locale`, `/etc/locale.conf`. 

Check encoding: `file -i file.txt`, convert: `iconv -f ISO-8859-1 -t UTF-8 input.txt > output.txt`.

---

### 48. Package Building Basics

Create packages for distribution. 

**RPM (RHEL/Fedora):** spec file defines build, `rpmbuild -ba package.spec`, requires `~/rpmbuild/` structure (SOURCES, SPECS, BUILD, RPMS, SRPMS). Dependencies: `Requires:`, `BuildRequires:`. 

**DEB (Debian/Ubuntu):** `debian/` directory with control (metadata), rules (build script), changelog. Build: `dpkg-buildpackage -us -uc`. 

Tools: fpm (Effing Package Manager) for easy package creation from source. 

Sign packages: `gpg --armor --detach-sign package.rpm`. 

Repository: `createrepo` (RPM), `reprepro` or `aptly` (DEB).

---

### 49. System Resources & Limits

Limit resources per process/user. View: `ulimit -a` (current limits). 

Set: `ulimit -n 4096` (file descriptors), `ulimit -u 1024` (processes). 

Persistent: `/etc/security/limits.conf` (format: user/group type item value), example: `* soft nofile 4096`, `* hard nofile 8192`. 

Types: soft (warning), hard (enforced). 

systemd limits: `LimitNOFILE=`, `LimitNPROC=` in service units. 

View process limits: `/proc/[pid]/limits`. 

Common limits: nofile (file descriptors), nproc (processes), memlock (locked memory), stack (stack size).

---

### 50. Boot Process Overview

Modern Linux boot: UEFI firmware → reads ESP (EFI System Partition, `/boot/efi`) → loads bootloader (GRUB, systemd-boot) → loads kernel (`vmlinuz`) and initramfs (initial RAM filesystem) → kernel mounts initramfs as root, runs `/init` → loads drivers, mounts real root → switches root (`pivot_root`) → executes systemd (PID 1) → mounts filesystems, starts services per target. 

**Files:** `/boot/vmlinuz-*` (kernel), `/boot/initramfs-*.img`, `/boot/grub/grub.cfg`, `/etc/fstab`. 

Troubleshoot: GRUB rescue prompt, single-user mode (`systemd.unit=rescue.target`), init logs in journal.

---

### 51. Kernel Parameters (sysctl)

Runtime kernel tuning. View: `sysctl -a` (all), `sysctl net.ipv4.ip_forward` (specific). 

Set: `sysctl -w net.ipv4.ip_forward=1` (temporary), persistent: `/etc/sysctl.conf` or `/etc/sysctl.d/*.conf`, apply: `sysctl -p`. 

Virtual filesystem: `/proc/sys/` (modify files directly: `echo 1 > /proc/sys/net/ipv4/ip_forward`). 

Common: `net.ipv4.tcp_tw_reuse`, `vm.swappiness`, `fs.file-max`, `net.core.somaxconn`. 

Namespace-specific: `net.*` per network namespace. 

View current: `cat /proc/sys/net/ipv4/ip_forward`.

---

### 52. User & Group Management

Add users: `useradd username` (create), `useradd -m -s /bin/bash username` (with home + shell), `passwd username` (set password). Delete: `userdel username`, `userdel -r username` (remove home).

Modify: `usermod -aG group username` (add to group), `usermod -s /bin/zsh username` (change shell), `usermod -L username` (lock account).

Groups: `groupadd groupname`, `groupdel groupname`, `groups username` (list user's groups), `id username` (UID, GID, groups).

**Files:** `/etc/passwd` (users), `/etc/shadow` (password hashes), `/etc/group` (groups), `/etc/gshadow`.

Switch user: `su - username`, `sudo -u username command`.

Root access: `sudo command`, configure in `/etc/sudoers` (use `visudo`), allow group: `%wheel ALL=(ALL) ALL`.

### Category 4: Networking Basics (18 concepts)

### 53. Network Layers (TCP/IP Stack)

Layered model for networking. 

**L1 Physical:** bits on wire. 

**L2 Data Link (Ethernet):** frames, MAC addresses, switching, `ff:ff:ff:ff:ff:ff` (broadcast). 

**L3 Network (IP):** packets, routing, IP addresses (IPv4/IPv6), routers. 

**L4 Transport (TCP/UDP):** segments (TCP) or datagrams (UDP), ports, end-to-end delivery. 

**L7 Application (HTTP, DNS, etc.):** actual data, user-facing protocols. 

**Encapsulation:** each layer adds header, L7 data → L4 (add port) → L3 (add IP) → L2 (add MAC) → L1 (transmit). 

**Tools:** tcpdump, Wireshark (capture packets, inspect layers), ip (L3), ethtool (L2).

---

### 54. IP Addressing & CIDR

**IPv4:** 32-bit, dotted decimal (`192.168.1.1`). 

**IPv6:** 128-bit, hexadecimal (`2001:db8::1`). 

**CIDR notation:** `192.168.1.0/24` (/24 = subnet mask 255.255.255.0, 256 IPs, 254 usable). 

**Private ranges:** `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16` (RFC 1918). 

**Public:** routable on internet. 

**Subnetting:** divide network, `10.0.0.0/16` → `10.0.1.0/24`, `10.0.2.0/24`, etc. 

**Calculate:** network address (first), broadcast (last), usable (network+1 to broadcast-1). 

**Tools:** `ipcalc 192.168.1.0/24`, `ip addr show`, `ifconfig` (legacy). 

**IPv6 link-local:** `fe80::/10` (auto-config), global unicast: `2000::/3`.

---

### 55. Routing Fundamentals

Forward packets between networks. 

**Routing table:** list of routes (destination, gateway, interface). 

**Default route:** `0.0.0.0/0` (IPv4) or `::/0` (IPv6), catch-all, usually to gateway. 

**View:** `ip route` or `route -n`. 

**Add route:** `ip route add 10.1.0.0/24 via 192.168.1.1 dev eth0`. 

**Kernel routing:** checks table, longest prefix match, forwards to next hop or local delivery. 

**Next hop:** IP address of next router. 

**Metric:** preference (lower = preferred). 

**Multiple routes:** load balancing (ECMP). 

**Dynamic routing:** protocols (BGP, OSPF) update tables automatically. 

**Cloud:** VPC route tables, subnet associations.

---

### 56. Network Address Translation (NAT)

Translate IP addresses. 

**SNAT (Source NAT):** private → public on egress, enables internet access from private network. 

**DNAT (Destination NAT):** public → private on ingress, port forwarding. 

**Masquerading:** SNAT with dynamic IP (home router). 

**Port mapping:** translate port too, `80.80.80.80:80 → 192.168.1.10:8080`. 

**iptables:** `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE` (SNAT), `iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination 192.168.1.10:8080` (DNAT). 

**Cloud NAT:** managed NAT gateway (AWS NAT Gateway, GCP Cloud NAT). 

**Drawbacks:** breaks end-to-end connectivity, complicates protocols (FTP, SIP).

---

### 57. DNS Resolution

Name to IP lookup. 

**Hierarchy:** Root servers (.) → TLD (.com, .org) → Authoritative (example.com). 

**Recursive resolver:** client queries, resolver queries hierarchy, caches result, returns to client. 

**Iterative:** client queries each level. 

**TTL:** Time To Live, cache duration. 

**Query:** `dig example.com` (detailed), `nslookup example.com`, `host example.com`. 

**Record types:** A (IPv4), AAAA (IPv6), CNAME (alias), MX (mail), TXT (text), SRV (service), NS (nameserver), SOA (start of authority). 

**Resolver config:** `/etc/resolv.conf` (nameserver IPs), systemd-resolved: `/etc/systemd/resolved.conf`, view: `resolvectl status`. 

**Cache:** local resolver (systemd-resolved), application (some apps cache DNS).

---

### 58. DNS Record Types

**A:** IPv4 address, `example.com. 300 IN A 93.184.216.34`. 

**AAAA:** IPv6 address. 

**CNAME:** canonical name (alias), `www.example.com. CNAME example.com.`, cannot coexist with other records at same name. 

**MX:** mail exchanger, priority, `example.com. MX 10 mail.example.com.`. 

**TXT:** arbitrary text, SPF (email auth), DKIM, verification. 

**SRV:** service location, `_service._proto.name. TTL IN SRV priority weight port target`, e.g., `_http._tcp.example.com. SRV 0 5 80 web.example.com.`. 

**NS:** nameserver, delegates subdomain. 

**SOA:** start of authority, zone info. 

**PTR:** reverse DNS (IP → name), `in-addr.arpa`. 

**CAA:** certificate authority authorization. 

**Tools:** `dig example.com A`, `dig example.com ANY` (all records).

---

### 59. TCP Protocol

Connection-oriented, reliable. 

**Three-way handshake:** SYN (client → server), SYN-ACK (server → client), ACK (client → server), connection established. 

**Termination:** FIN/ACK four-way handshake or RST (abort). 

**Sequence numbers:** order data, detect duplicates. 

**Acknowledgments:** confirm receipt, cumulative or selective (SACK). 

**Flow control:** sliding window, receiver advertises window size (how much can buffer). 

**Retransmission:** if ACK not received, resend. 

**States:** LISTEN, SYN_SENT, SYN_RECEIVED, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, TIME_WAIT. 

**View:** `ss -tan` (TCP connections), `netstat -tan` (legacy). 

**Tuning:** `/proc/sys/net/ipv4/tcp_*`.

---

### 60. TCP Window & Flow Control

Prevent sender overwhelming receiver. 

**Sliding window:** receiver advertises buffer space (receive window), sender can send up to window size without ACK. 

**Window scaling:** extend window beyond 64KB, TCP option, `sysctl net.ipv4.tcp_window_scaling`. 

**Congestion control:** slow start, congestion avoidance, fast retransmit/recovery, algorithms: Reno, Cubic (Linux default), BBR (Google). 

**Bandwidth-delay product:** BW * RTT, optimal window size. 

**Tuning:** `sysctl net.core.rmem_max`, `net.core.wmem_max` (max buffer), `net.ipv4.tcp_rmem`, `tcp_wmem` (min/default/max per socket). 

**Monitor:** `ss -ti` (detailed info, window size, congestion window).

---

### 61. TCP Keep-Alive

Detect dead connections. 

**Idle connection:** no data, appears alive. 

**Keep-alive:** send probe after idle period, if no response, retry, eventually close. 

**Config:** `tcp_keepalive_time` (7200s default, start probes), `tcp_keepalive_intvl` (75s, interval), `tcp_keepalive_probes` (9, retries). 

**Enable:** `setsockopt(SO_KEEPALIVE)`, per socket or sysctl. 

**Use cases:** detect network failure, firewall timeout, NAT table cleanup. 

**Application-level:** better control (HTTP/2 PING, WebSocket ping/pong, gRPC keepalive). 

**Drawbacks:** extra traffic, not suitable for all use cases. 

**Cloud:** NAT timeout often 60-300s, keep-alive prevents closed connections.

---

### 62. UDP Protocol

Connectionless, unreliable. 

**No handshake:** send datagrams immediately. 

**No guarantees:** no ordering, no delivery guarantee, no duplicate detection. 

**Stateless:** each datagram independent. 

**Header:** small (8 bytes vs 20+ TCP). 

**Use cases:** DNS (queries small, retries cheap), streaming (video, audio, some loss acceptable), real-time (gaming, VoIP, low latency > reliability), monitoring (metrics, logs). 

**Broadcast/multicast:** UDP supports, TCP doesn't. 

**Application must handle:** retries, ordering, flow control (if needed). 

**Faster:** no connection setup, no ACK overhead. 

**View:** `ss -uan` (UDP sockets). 

**Example:** QUIC (HTTP/3) uses UDP, implements reliability/ordering in user space.

---

### 63. Ports & Sockets

**Ports:** 16-bit number (0-65535), identify application. 

**Well-known:** 0-1023 (require root/capability), e.g., 22 SSH, 80 HTTP, 443 HTTPS. 

**Registered:** 1024-49151. 

**Ephemeral:** 49152-65535 (client ports, dynamic). 

**Socket:** IP + port, e.g., `192.168.1.10:8080`. 

**Socket pair:** source IP:port + dest IP:port, uniquely identifies connection. 

**Bind:** listen on port, `listen(sockfd, backlog)`. 

**Connect:** client connects to server socket. 

**View:** `ss -tunlp` (listening), `ss -tun` (established), `lsof -i :80` (what's using port 80). 

**Exhaustion:** too many connections, increase ephemeral range: `sysctl net.ipv4.ip_local_port_range="1024 65535"`.

---

### 64. TLS/SSL

Transport Layer Security (TLS), formerly SSL. 

**Encryption:** symmetric (AES) for data, asymmetric (RSA/ECDH) for key exchange. 

**Handshake:** client → server hello, server → certificate + server hello, client verifies cert, key exchange (DHE/ECDHE), symmetric key derived, encrypted communication. 

**Certificate:** X.509, public key + metadata, signed by CA. 

**Chain:** leaf cert → intermediate CA → root CA (trusted). 

**Cipher suites:** encryption algorithm + key exchange + MAC, e.g., `TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384`. 

**TLS 1.3:** faster (fewer round trips), stronger (removed weak ciphers). 

**SNI (Server Name Indication):** client sends hostname, server selects cert (multiple certs on one IP). 

**ALPN:** application protocol negotiation (HTTP/2). 

**Tools:** `openssl s_client -connect example.com:443`, `openssl x509 -in cert.pem -text` (inspect cert).

---

### 65. Certificate Management

X.509 certificates. 

**Create CSR (Certificate Signing Request):** `openssl req -new -key private.key -out request.csr`, send to CA. 

**CA signs:** returns certificate. 

**Self-signed:** `openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes` (testing only). 

**Certificate chain:** cat intermediate + root, `cat cert.pem intermediate.pem root.pem > fullchain.pem`. 

**Formats:** PEM (Base64, `-----BEGIN CERTIFICATE-----`), DER (binary). 

**View:** `openssl x509 -in cert.pem -text -noout`, check expiry: `-enddate`. 

**Automated renewal:** cert-manager (Kubernetes), ACME protocol (Let's Encrypt), certbot (standalone), acme.sh. 

**Trust store:** `/etc/ssl/certs/` (Debian), `/etc/pki/tls/certs/` (RHEL), add CA: `update-ca-certificates`. 

**Revocation:** CRL (Certificate Revocation List), OCSP (Online Certificate Status Protocol), OCSP stapling (server provides OCSP response).

---

### 66. HTTP/2

Binary protocol. 

**Multiplexing:** multiple streams (requests/responses) over single TCP connection, no head-of-line blocking at HTTP level (still at TCP level). 

**Header compression:** HPACK, reduces overhead. 

**Server push:** server sends resources before client requests (deprecated in HTTP/3). 

**Stream priority:** hint server which responses to prioritize. 

**Flow control:** per-stream, prevent fast stream starving others. 

**Negotiation:** ALPN during TLS handshake, `h2` (HTTP/2 over TLS). 

**Requires TLS** (browsers enforce). 

**Backward compatible:** fallback to HTTP/1.1. 

**Tools:** `curl --http2` (if compiled with support), browser DevTools (Protocol column). 

**Performance:** better for many small requests, less effective for few large. 

**Config:** nginx `listen 443 ssl http2`, `http2_push` directive (for server push).

---

### 67. HTTP/3 & QUIC

HTTP over QUIC. 

**QUIC:** transport protocol over UDP, no TCP. 

**Benefits:** eliminates TCP head-of-line blocking (separate streams), faster connection (0-RTT, resume), connection migration (switch networks without reconnection, mobile). 

**TLS 1.3:** built-in, always encrypted. 

**Multiplexing:** independent streams, packet loss affects only that stream. 

**Negotiation:** Alt-Svc header in HTTP/2 response, `Alt-Svc: h3=":443"; ma=86400`. 

**UDP:** bypasses middlebox issues (NAT, firewall assume TCP behavior), user-space implementation (faster iteration). 

**Adoption:** growing, Google (QUIC invented), Facebook, Cloudflare. 

**Support:** Cloudflare (automatic), nginx (experimental, `listen 443 quic`), curl (`--http3`). 

**Drawbacks:** UDP blocked in some networks, CPU overhead (crypto in user space).

---

### 68. Load Balancing Algorithms

Distribute traffic. 

**Round Robin:** rotate through backends, simple, fair if backends equal. 

**Least Connections:** send to backend with fewest connections, better for variable request duration. 

**Weighted:** backends have weights, distribute proportionally, handle different capacities. 

**IP Hash:** hash client IP, consistent backend selection (sticky sessions without cookies). 

**Least Response Time:** send to fastest backend, requires health checks. 

**Random:** simple, works surprisingly well. 

**Consistent Hashing:** minimize redistribution when backends change (add/remove), used in caches, databases. 

**Dynamic:** combine metrics (connections, CPU, latency). 

**Config:** nginx `upstream { server backend1 weight=3; server backend2; }`, HAProxy `balance roundrobin`. 

**Sticky sessions:** maintain user session on same backend, cookie or IP hash.

---

### 69. L4 vs L7 Load Balancing

Layer 4 (Transport) vs Layer 7 (Application). 

**L4:** based on IP/port, fast (TCP/UDP stream), no content inspection, backends see real client IP (if configured), protocol-agnostic. Examples: AWS NLB, HAProxy in TCP mode, nginx stream module. Use: high throughput, non-HTTP, simple. 

**L7:** based on HTTP headers/path/method, content-aware routing (`/api` → backend1, `/static` → backend2), SSL termination, sticky sessions (cookie), slower (parses HTTP). Examples: AWS ALB, HAProxy in HTTP mode, nginx http module. Use: microservices, flexible routing, caching, WAF. 

**Comparison:** L4 faster, L7 more features. 

**Hybrid:** L4 for TLS termination + L7 routing.

---

### 70. Reverse Proxy

Sits in front of backends, receives client requests, forwards to backend, returns response.

**Benefits:** SSL termination (offload TLS from backends), caching (static assets), compression (gzip), load balancing, security (WAF, rate limiting), single entry point.

**vs Forward Proxy:** forward proxy (client side, hide client IP, access filtering), reverse proxy (server side, hide backend IPs, load balancing).

**Config:** nginx `location / { proxy_pass http://backend; }`, headers: `proxy_set_header X-Real-IP $remote_addr`, `proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for`, `proxy_set_header Host $host`.

**Caching:** `proxy_cache_path /cache keys_zone=my_cache:10m`, `proxy_cache my_cache`.

**Sticky sessions:** `ip_hash` or `proxy_cookie_path`.

**Use:** nginx, HAProxy, Envoy, Traefik.

---

### 71. VPN & Tunneling

**VPN types:** Site-to-Site (connect networks, offices to cloud), Remote Access (user to network, OpenVPN, WireGuard), SSL VPN (browser-based). **Protocols:** OpenVPN (reliable, TCP/UDP, certificates), WireGuard (modern, fast, simple config, public key crypto), IPsec (industry standard, complex, IKEv2/L2TP), PPTP (obsolete, insecure).

**WireGuard** config: `[Interface]` (private key, address, listen port), `[Peer]` (public key, endpoint, allowed IPs). Setup: generate keys (`wg genkey | tee privatekey | wg pubkey > publickey`), configure interface (`wg-quick up wg0`), route traffic. Fast handshake, roaming support, kernel-native.

**SSH tunneling:** local forward (`ssh -L 8080:localhost:80 user@remote`, access remote port 80 via local 8080), remote forward (`ssh -R 8080:localhost:80 user@remote`, expose local port 80 on remote 8080), dynamic (SOCKS proxy, `ssh -D 1080 user@remote`, route all traffic through SSH). Use case: bypass firewalls, secure connections, access internal services.

**Proxy tools:** squid (HTTP/HTTPS proxy, caching), privoxy (filter ads, privacy), tinyproxy (lightweight), SOCKS5 (generic, works with SSH dynamic tunnel). Use: corporate filtering, caching, anonymity, access control.

---

### Category 5: Python Basics for DevOps (15 concepts)

### 72. Python Basics

Interpreted language, dynamically typed. Syntax: indentation-based, no semicolons, `#` comments. 

**Variables:** `x = 10`, `name = "test"`, no type declaration needed. 

**Data types:** `int`, `float`, `str`, `bool`, `None`. Type checking: `type(x)`, `isinstance(x, int)`.

**Operators:** arithmetic (`+`, `-`, `*`, `/`, `//` floor division, `%` modulo, `**` power), comparison (`==`, `!=`, `<`, `>`, `<=`, `>=`), logical (`and`, `or`, `not`).

**Control flow:** `if condition:`, `elif:`, `else:`. Loops: `for item in iterable:`, `while condition:`. Break/continue: exit or skip iteration.

**Functions:** `def function_name(param1, param2=default):`, return with `return value`. Args: positional, keyword, `*args` (variable positional), `**kwargs` (variable keyword).

**Indentation:** 4 spaces standard (PEP 8), mixing spaces/tabs causes errors.

**Shebang:** `#!/usr/bin/env python3` for executable scripts, `chmod +x script.py`.

---

### 73. Python Data Structures

**Lists:** ordered, mutable, `my_list = [1, 2, 3]`, indexing `my_list[0]` (0-based), slicing `my_list[1:3]`, methods `append()`, `extend()`, `insert()`, `remove()`, `pop()`, `sort()`, list comprehension `[x*2 for x in range(10)]`.

**Tuples:** ordered, immutable, `my_tuple = (1, 2, 3)`, unpacking `a, b, c = my_tuple`, use for fixed data.

**Dictionaries:** key-value pairs, unordered (3.7+ insertion order preserved), `my_dict = {"key": "value"}`, access `my_dict["key"]` or `my_dict.get("key", default)`, methods `keys()`, `values()`, `items()`, dict comprehension `{k: v for k, v in items}`.

**Sets:** unordered, unique elements, `my_set = {1, 2, 3}`, operations: union `|`, intersection `&`, difference `-`, subset `<=`.

**Strings:** immutable sequence, `s = "hello"`, methods `upper()`, `lower()`, `strip()`, `split()`, `join()`, `replace()`, f-strings `f"value: {variable}"` (Python 3.6+), slicing `s[1:4]`, concatenation `+`.

**None:** null value, `x = None`, check with `if x is None:`.

---

### 74. File Handling in Python

**Reading:** `with open('file.txt', 'r') as f: content = f.read()`, reads entire file. Line by line: `for line in f:`. Modes: `'r'` read, `'w'` write (truncate), `'a'` append, `'r+'` read+write, `'b'` binary.

**Writing:** `with open('file.txt', 'w') as f: f.write("text")`. Write lines: `f.writelines(list_of_strings)`.

**Context manager:** `with` ensures file closes even on exception, alternative: `f = open()`, `f.close()` (manual, risky).

**Paths:** `import os`, `os.path.exists()`, `os.path.join()`, `os.path.dirname()`, `os.path.basename()`. Modern: `from pathlib import Path`, `Path('file.txt').exists()`, `Path.home()`, `Path.cwd()`, `path.read_text()`, `path.write_text()`.

**JSON:** `import json`, read `data = json.load(f)` from file or `json.loads(string)` from string, write `json.dump(data, f)` or `json.dumps(data)`.

**CSV:** `import csv`, reader `csv.reader(f)`, `csv.DictReader(f)`, writer `csv.writer(f)`, `csv.DictWriter(f)`.

**Binary:** `'rb'`, `'wb'` modes, `f.read()` returns bytes, useful for images, executables.

---

### 75. Virtual Environments (venv)

**Problem:** global package conflicts, different projects need different versions.

**Solution:** isolated Python environments per project.

**Create:** `python3 -m venv venv` (creates `venv/` directory with Python copy, pip, lib).

**Activate:** Linux/Mac `source venv/bin/activate`, Windows `venv\Scripts\activate`. Prompt changes: `(venv) $`.

**Deactivate:** `deactivate` command (returns to global Python).

**Structure:** `venv/bin/` (executables, python, pip), `venv/lib/` (installed packages), `venv/include/` (headers).

**What happens:** modifies `$PATH` to use venv's python/pip first, `which python` shows venv path.

**Ignore in Git:** add `venv/` to `.gitignore`, don't commit virtual environments.

**Alternatives:** `virtualenv` (older, more features), `conda` (for data science), `pipenv` (combines venv + requirements), `poetry` (modern dependency management).

---

### 76. Package Management (pip)

**Install:** `pip install package`, specific version `pip install package==1.2.3`, upgrade `pip install --upgrade package`, uninstall `pip uninstall package`.

**Requirements:** `pip freeze > requirements.txt` (save all installed), `pip install -r requirements.txt` (install from file).

**Search:** `pip search term` (deprecated, use PyPI website), `pip show package` (info about installed).

**Location:** packages in `site-packages/` directory, view with `pip show package | grep Location`.

**User install:** `pip install --user package` (installs to `~/.local/`, no root needed).

**Editable install:** `pip install -e .` (install from local directory, links instead of copy, changes reflect immediately), useful for development.

**PyPI:** Python Package Index (pypi.org), public repository, `pip` downloads from here by default.

**Private repos:** `pip install -i https://pypi.custom.com/simple package` or configure in `~/.pip/pip.conf`.

**Wheels:** precompiled packages (`.whl`), faster than source (`.tar.gz`), `pip` prefers wheels.

**Breaking system packages:** Python 3.11+ error "externally-managed-environment", use venv or `--break-system-packages` flag (risky).

---

### 77. Python for Scripting

**Subprocess:** `import subprocess`, run commands `subprocess.run(['ls', '-la'])`, capture output `result = subprocess.run(['ls'], capture_output=True, text=True)`, `result.stdout`, `result.returncode`. Check success: `subprocess.run(['cmd'], check=True)` (raises exception on failure). Old API: `os.system()` (deprecated).

**OS operations:** `import os`, current dir `os.getcwd()`, change dir `os.chdir()`, list dir `os.listdir()`, environment `os.environ['VAR']` or `os.getenv('VAR', default)`, execute `os.system('cmd')` (avoid, use subprocess).

**Path manipulation:** `import shutil`, copy `shutil.copy(src, dst)`, move `shutil.move()`, remove tree `shutil.rmtree()`, disk usage `shutil.disk_usage('/')`.

**Glob:** `import glob`, pattern matching `glob.glob('*.txt')`, recursive `glob.glob('**/*.py', recursive=True)`.

**Arguments:** `import sys`, `sys.argv[0]` is script name, `sys.argv[1:]` are args. Better: `import argparse`, define args `parser.add_argument('--name')`, parse `args = parser.parse()`, access `args.name`.

**Exit:** `sys.exit(0)` success, `sys.exit(1)` or any non-zero for error, `sys.exit("error message")` prints and exits with 1.

**Logging:** `import logging`, levels DEBUG, INFO, WARNING, ERROR, CRITICAL, config `logging.basicConfig(level=logging.INFO)`, log `logging.info("message")`, better than `print()` for production.

---

### 78. HTTP Requests in Python

**Requests library:** `import requests`, GET `response = requests.get('https://api.example.com')`, POST `requests.post(url, json=data)`, PUT, DELETE, PATCH supported.

**Response:** `response.status_code`, `response.text` (string), `response.json()` (parse JSON), `response.headers`, `response.content` (bytes).

**Parameters:** query params `requests.get(url, params={'key': 'value'})`, headers `requests.get(url, headers={'Authorization': 'token'})`.

**Authentication:** basic auth `requests.get(url, auth=('user', 'pass'))`, bearer token `headers={'Authorization': f'Bearer {token}'}`.

**Timeouts:** `requests.get(url, timeout=5)` (seconds), prevents hanging, raises `requests.Timeout`.

**Error handling:** `response.raise_for_status()` raises exception for 4xx/5xx, or check `if response.status_code == 200:`.

**Sessions:** `session = requests.Session()`, maintains cookies, connection pooling, set default headers `session.headers.update({'User-Agent': 'bot'})`.

**Use cases:** API calls, webhook triggers, download files, web scraping (with BeautifulSoup), monitoring endpoints.

---

### 79. Working with YAML in Python

**PyYAML:** `import yaml`, read `with open('config.yaml') as f: data = yaml.safe_load(f)`, returns dict/list.

**Write:** `with open('output.yaml', 'w') as f: yaml.dump(data, f)`, or `yaml.dump(data, default_flow_style=False)` for readable format.

**Safe load:** use `yaml.safe_load()` not `yaml.load()` (security risk, can execute code).

**Multiple documents:** YAML supports multiple docs in one file (`---` separator), load all `yaml.safe_load_all(f)` returns generator.

**Custom types:** register constructors for custom objects, `yaml.add_constructor()`.

**Use cases:** Kubernetes manifests, Ansible playbooks, config files, CI/CD pipelines (GitHub Actions, GitLab CI).

**Alternatives:** `ruamel.yaml` (preserves comments, order), `strictyaml` (validates against schema).

---

### 80. Python Data Processing

**Pandas basics:** `import pandas as pd`, DataFrame (2D table), Series (1D column). Read CSV: `df = pd.read_csv('file.csv')`, Excel `pd.read_excel()`, JSON `pd.read_json()`.

**Exploration:** `df.head()`, `df.info()`, `df.describe()`, `df.columns`, `df.shape`, `df.dtypes`.

**Selection:** columns `df['column']` or `df.column`, multiple `df[['col1', 'col2']]`, rows `df.loc[0]` (by label), `df.iloc[0]` (by position), filter `df[df['age'] > 30]`.

**Operations:** add column `df['new'] = df['a'] + df['b']`, drop `df.drop('column', axis=1)`, sort `df.sort_values('column')`, group `df.groupby('category').sum()`.

**Merge:** `pd.merge(df1, df2, on='key')`, concat `pd.concat([df1, df2])`.

**Export:** `df.to_csv('output.csv', index=False)`, `df.to_excel()`, `df.to_json()`.

**Use cases:** log analysis, metrics aggregation, report generation, data migration, ETL pipelines.

---

### 81. Python Testing

**unittest:** built-in, `import unittest`, class-based `class TestCase(unittest.TestCase):`, methods `test_*`, assertions `assertEqual()`, `assertTrue()`, `assertRaises()`, run `python -m unittest test_file.py`.

**pytest:** third-party (preferred), simpler syntax, `pip install pytest`, functions `def test_something():`, plain `assert x == 5`, fixtures `@pytest.fixture`, parametrize `@pytest.mark.parametrize()`, run `pytest` (discovers `test_*.py`), verbose `pytest -v`, specific `pytest test_file.py::test_function`.

**Mocking:** `from unittest.mock import Mock, patch`, mock objects `mock = Mock(return_value=42)`, patch functions `@patch('module.function')`, useful for testing code that calls APIs, databases, external services without actually calling them.

**Coverage:** `pip install pytest-cov`, run `pytest --cov=mypackage`, report `pytest --cov=mypackage --cov-report=html`, check untested code.

**CI integration:** run tests in CI/CD (GitHub Actions, GitLab CI), fail build if tests fail, `pytest --junitxml=report.xml` for CI parsers.

---

### 82. Python CLI Tools

**argparse:** `import argparse`, `parser = argparse.ArgumentParser(description='Tool')`, add args `parser.add_argument('--name', required=True)`, flags `parser.add_argument('--verbose', action='store_true')`, parse `args = parser.parse_args()`, access `args.name`.

**Click:** `import click`, decorator-based, `@click.command()`, `@click.option('--name')`, function `def cli(name):`, cleaner than argparse, features: auto-help, color, prompts, validation.

**Typer:** modern, type hints, `import typer`, `app = typer.Typer()`, `@app.command()`, uses type annotations for validation, auto-completion support.

**Rich:** beautiful terminal output, `from rich.console import Console`, `console = Console()`, `console.print("[bold red]Error")`, tables, progress bars, syntax highlighting, markdown rendering.

**Output formatting:** JSON `json.dumps(data, indent=2)`, tables (tabulate, prettytable), colors (colorama, termcolor).

**Use cases:** DevOps tools, deployment scripts, admin utilities, wrappers for complex commands.

---

### 83. Python Error Handling

**Exceptions:** `try: ... except ExceptionType as e: ... else: ... finally:`, catch specific `except ValueError:`, catch all `except Exception:` (avoid), multiple `except (ValueError, TypeError):`.

**Raising:** `raise ValueError("message")`, re-raise `raise` (in except block), custom exceptions `class MyError(Exception): pass`.

**Common exceptions:** `FileNotFoundError`, `ValueError`, `TypeError`, `KeyError`, `IndexError`, `AttributeError`, `ImportError`, `RuntimeError`.

**Best practices:** catch specific exceptions, don't silence errors (`except: pass` is bad), log errors, clean up in `finally`, fail fast (don't catch unless you can handle).

**Context managers:** `with` statement calls `__enter__` and `__exit__`, ensures cleanup even on exception, create custom `@contextmanager` decorator or `__enter__`/`__exit__` methods.

---

### 84. Python Debugging

**Print debugging:** `print(variable)`, quick but primitive, remove before commit.

**pdb:** `import pdb; pdb.set_trace()` (breakpoint), interactive debugger, commands: `n` next, `s` step into, `c` continue, `p variable` print, `l` list code, `q` quit. Python 3.7+: `breakpoint()` (better).

**IDEs:** VSCode, PyCharm have visual debuggers, set breakpoints, inspect variables, step through code.

**Logging:** `import logging`, levels (DEBUG, INFO, WARNING, ERROR, CRITICAL), `logging.debug("message")`, configure `logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(message)s')`, better than print for production.

**Stack traces:** `import traceback`, `traceback.print_exc()` in except block, `traceback.format_exc()` returns string.

**Post-mortem:** `pdb.post_mortem()` after exception, inspect state when error occurred.

---

### 85. Python Asyncio Basics

**Async/await:** `async def function():` defines coroutine, `await` calls another coroutine, `asyncio.run(main())` runs async function.

**Concurrency:** run multiple operations concurrently (not parallel), useful for I/O-bound tasks (network, file), not CPU-bound (use multiprocessing).

**Example:** `async with aiohttp.ClientSession() as session: response = await session.get(url)`, makes concurrent HTTP requests faster than `requests`.

**asyncio.gather:** run multiple coroutines `await asyncio.gather(task1(), task2(), task3())`, runs concurrently.

**asyncio.create_task:** schedule coroutine `task = asyncio.create_task(coroutine())`, runs in background, `await task` to get result.

**Use cases:** web scraping (many requests), API clients, webhooks, async frameworks (FastAPI, aiohttp), concurrent file operations.

**Caveats:** all code must be async-aware, blocking calls block entire loop, libraries need async versions (aiohttp vs requests, aiofiles vs open).

---

### 86. Python for Automation

**Fabric:** `pip install fabric`, SSH automation, `from fabric import Connection`, `c = Connection('host')`, run `c.run('command')`, sudo `c.sudo('command')`, put/get files `c.put('local', 'remote')`, `c.get('remote', 'local')`. Context managers: `with Connection():`, multiple hosts: loop or `fabric.Group()`.

**Paramiko:** lower-level SSH library, `import paramiko`, `ssh = paramiko.SSHClient()`, `ssh.connect('host')`, `stdin, stdout, stderr = ssh.exec_command('cmd')`, SFTP `sftp = ssh.open_sftp()`.

**Ansible:** call from Python `ansible.module_utils`, or subprocess `subprocess.run(['ansible-playbook', 'playbook.yml'])`.

**Schedule:** `pip install schedule`, cron alternative in Python, `import schedule`, `schedule.every().day.at("10:00").do(job)`, `while True: schedule.run_pending(); time.sleep(1)`.

**Use cases:** server provisioning, deployment, backup scripts, monitoring, log rotation, cleanup tasks.

---

### Category 6: Shell Scripting & Automation (18 concepts)

### 87. Shell Script Portability

POSIX compliance: use `#!/bin/sh`, avoid bashisms (`[[`, `((`, `$'...'`, arrays), test with `shellcheck -s sh`, `checkbashisms`.

Portability issues: `echo` varies (use `printf`), `test` vs `[` (use `[`), no `local` in POSIX (use subshells).

Detect shell: `if [ -n "$BASH_VERSION" ]; then ...fi`, or check `$0`.

Common shells: bash, dash (Debian /bin/sh), zsh, ksh, busybox sh (containers).

Best practices: test on target, use `/usr/bin/env`, avoid GNU-specific options, document requirements.

Bashisms: arrays, `[[`, `<( )`, `${var//}`, `&>`, `source` (use `.`), `function` keyword (use `name()`).

Trade-off: portability vs features, bash for complex scripts, POSIX for max compatibility.

---

### 88. Error Handling in Bash

Check exit codes: `$?` (last command), `if [ $? -eq 0 ]; then success; fi`, `command || handle_error`.

Set exit codes: `exit 0` (success), `exit 1` (error), `return N` in functions (0-255).

Stop on error: `set -e` (exit on error), `set +e` (disable), `set -o pipefail` (pipe fails if any command fails), `set -u` (error on undefined variable).

Error function: `error() { echo "ERROR: $*" >&2; exit 1; }`, use `error "message"`.

Trap: `trap 'cleanup' EXIT`, `trap 'error_handler' ERR`, `trap 'echo SIGINT' INT`.

Validation: `[ -f "$file" ] || error "File not found"`, always validate input.

### 89. Debugging Shell Scripts

Enable tracing: `set -x` or `bash -x script.sh`, shows commands before execution. Disable: `set +x`.

Verbose: `set -v` shows lines before expansion.

Debug function: `trap 'echo "Line $LINENO"' DEBUG`, prints each line.

PS4 variable: `export PS4='+ ${BASH_SOURCE}:${LINENO}: '`, adds file+line to traces.

Check syntax: `bash -n script.sh` (no execution).

ShellCheck: `shellcheck script.sh`, static analysis, catches common bugs.

Logging: redirect output `exec 5> debug.log`, `echo "debug" >&5`.

### 90. Command-Line Argument Parsing

Positional: `$1`, `$2`, etc., `$0` is script name, `$@` all args (array), `$*` all args (string), `$#` count.

Shift: `shift` removes `$1`, shifts others left, `shift N` removes N arguments.

getopts: `while getopts "hf:v" opt; do case $opt in h) usage ;; f) file=$OPTARG ;; v) verbose=1 ;; esac; done`, options with args use `:`, `shift $((OPTIND-1))` after parsing.

Long options: `getopt --options hf:v --longoptions help,file:,verbose -- "$@"`, more complex but supports `--long-option`.

Validation: check required args `[ -z "$file" ] && error "File required"`.

Usage function: `usage() { echo "Usage: $0 [-h] [-f file]" >&2; exit 1; }`.

### 91. Signal Handling

Trap signals: `trap 'handler' SIGNAL`, common signals: INT (Ctrl+C), TERM (kill), HUP (hangup), EXIT (script exit).

Cleanup: `trap 'rm -f /tmp/$$.*' EXIT`, ensures cleanup even on error.

Ignore: `trap '' SIGNAL`, prevent Ctrl+C: `trap '' INT`.

Reset: `trap - SIGNAL`, restore default behavior.

Example: `trap 'echo "Interrupted"; exit 130' INT`, 130 = 128 + 2 (SIGINT).

Multiple: `trap 'cleanup' EXIT TERM INT`.

Forward: `trap 'kill -TERM $child_pid' TERM`, propagate to child processes.

### 92. Parallel Execution

Background jobs: `command &`, get PID `$!`, wait `wait $pid` or `wait` (all jobs).

Job control: `jobs` (list), `fg %1` (foreground), `bg %1` (background), `disown` (detach from shell).

Parallel with xargs: `find . -name '*.txt' | xargs -P 4 -n 1 process.sh`, `-P N` parallel jobs, `-n 1` one arg per invocation.

GNU Parallel: `parallel -j 4 'process {}' ::: *.txt`, `--pipe` for stdin, `cat list | parallel command {}`.

Wait for multiple: store PIDs `pids=()`, launch `cmd & pids+=($!)`, wait `for pid in ${pids[@]}; do wait $pid; done`.

Semaphores: limit concurrent jobs, use named pipes or file locks.

### 93. File Locking

Prevent concurrent execution.

flock: `flock -n /tmp/lock.file -c "command"`, `-n` fail if locked, `-x` exclusive (default), `-s` shared.

Lockfile: `if mkdir /tmp/lock.dir 2>/dev/null; then do_work; rmdir /tmp/lock.dir; else echo "Locked"; fi`, atomic directory creation.

File descriptor: `exec 200>/tmp/lock.file; flock -n 200 || exit 1`, hold lock until script exits.

Timeout: `flock -w 10` wait up to 10 seconds.

Use cases: cron jobs (prevent overlap), critical sections, ensure single instance.

Cleanup: `trap 'rm -f /tmp/lock.file' EXIT`.

### 94. Logging in Scripts

Direct to file: `exec > logfile 2>&1`, redirects all output.

tee: `command | tee log.txt`, shows and logs, `tee -a` appends.

Logger: `logger -t scriptname "message"`, sends to syslog, view `journalctl -t scriptname`.

Functions: `log() { echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a log.txt; }`.

Levels: `ERROR`, `WARN`, `INFO`, `DEBUG`, prepend to messages.

Rotate: logrotate config, or manually in script with dates `log_$(date +%Y%m%d).txt`.

Structured: JSON logging for parsing `echo "{\"level\":\"INFO\", \"msg\":\"text\"}"`.

### 95. Testing Shell Scripts

bats: Bash Automated Testing System, `pip install bats-core`, create `test.bats`, test format `@test "description" { run command; [ "$status" -eq 0 ]; }`, assertions `[ "$output" = "expected" ]`, run `bats test.bats`.

shunit2: unit testing, `source shunit2`, functions `testFunction() { assertEquals "expected" "$(command)"; }`.

shellspec: BDD style, `Describe 'mycommand'`, `It 'should work'`, `When call mycommand`, `The status should be success`.

Manual: functions for assertions, `assertEquals() { [ "$1" = "$2" ] || { echo "Failed: $1 != $2"; exit 1; } }`.

Mock: replace commands with functions, `command() { echo "mocked"; }`.

CI: run tests in GitHub Actions, GitLab CI, fail pipeline on errors.

### 96. Configuration Files

Source files: `. config.sh` or `source config.sh`, sets variables, functions.

INI-style: `[section]`, `key=value`, parse with awk/sed or tools like crudini.

YAML/JSON: use yq, jq for parsing, `value=$(yq '.key' config.yaml)`, `value=$(jq -r '.key' config.json)`.

Environment: `.env` files, `export $(cat .env | xargs)` or `set -a; source .env; set +a`.

Defaults: `${VAR:-default}`, `${VAR:=default}` (assigns if unset).

Validation: check required vars `: "${VAR:?Variable not set}"`, errors if unset.

Precedence: defaults < config file < environment < command-line args.

### 97. Performance Optimization

Avoid subshells: `((count++))` vs `count=$((count+1))`, built-ins vs external commands.

Minimize pipes: combine awk/sed/grep into single awk command.

Read files once: load into variable, process multiple times.

Arrays vs repeated commands: `files=(*.txt)` then iterate vs `find` in loop.

Parallel: use background jobs, xargs -P, GNU parallel for independent tasks.

Profile: `time command`, `set -x` with timestamps `PS4='+ $(date "+%s.%N")	 '`.

Caching: store expensive results, `[ -f cache ] && read cache || compute > cache`.

Built-ins: `[[ ]]` vs `[ ]`, `[[` faster, more features.

### 98. Security in Scripts

Input validation: sanitize user input, avoid command injection.

Quoting: always quote variables `"$var"`, prevents word splitting, glob expansion.

Safe commands: use `--` to end options `rm -- "$file"`, prevents `-f` in filename.

Avoid eval: dangerous, executes arbitrary code, alternatives: arrays, associative arrays.

Temporary files: use `mktemp`, `tmpfile=$(mktemp)`, `trap 'rm -f "$tmpfile"' EXIT`, random names prevent race conditions.

Permissions: chmod 600 for sensitive files, 700 for scripts, check before use.

Secrets: never hardcode, use env vars, secret managers (Vault), encrypted files.

Code review: have others review scripts, ShellCheck for common issues.

### 99. Cron Jobs

Schedule periodic tasks.

Format: `minute hour day month weekday command`, `*` (any), `*/5` (every 5), `1,15` (list), `1-5` (range).

Examples: `0 2 * * * /backup.sh` (2 AM daily), `*/15 * * * * check.sh` (every 15 min), `0 0 * * 0 weekly.sh` (Sunday midnight).

User crontab: `crontab -e` (edit), `crontab -l` (list), `crontab -r` (remove), stored in `/var/spool/cron/`.

System crontab: `/etc/crontab`, `/etc/cron.d/`, `/etc/cron.{hourly,daily,weekly,monthly}/`.

Environment: limited PATH, set in crontab `PATH=/usr/local/bin:/usr/bin:/bin`, mail output `MAILTO=user`.

Logging: redirect output `command >> /var/log/cron.log 2>&1`, or use logger.

Alternatives: systemd timers (better logging, dependencies).

### 100. Systemd Timers

Modern cron alternative.

Timer unit: `*.timer` file, `[Timer]` section, `OnCalendar=daily`, `OnCalendar=*-*-* 02:00:00` (2 AM daily), `OnBootSec=5min` (5 min after boot), `OnUnitActiveSec=1h` (1h after last activation).

Service unit: `*.service` paired with timer, defines what to run.

Enable: `systemctl enable --now backup.timer`, list: `systemctl list-timers`, status: `systemctl status backup.timer`.

Persistent: `Persistent=true` runs missed executions after system was off.

Randomize: `RandomizedDelaySec=10min` spreads load.

Accuracy: `AccuracySec=1s` (default 1min), trade-off: power vs precision.

Logs: `journalctl -u backup.service`, includes stdout/stderr, timestamps, structured.

Example: better than cron for systemd systems, dependencies, logging, monitoring.

---

### 101. Shell Scripting Best Practices

Shebang: `#!/usr/bin/env bash` (portable) or `#!/bin/bash`.

Strict mode: `set -euo pipefail`, exit on error, undefined vars, pipe failures.

Quotes: always quote variables `"$var"`, arrays `"${arr[@]}"`.

Functions: modular, one task per function, document with comments.

Error handling: check command results, use `||` or `if`, meaningful error messages.

Logging: use functions, timestamps, levels, redirect stderr `>&2` for errors.

Testing: write tests, ShellCheck, test edge cases.

Documentation: comment complex logic, usage function, header with description.

Portability: POSIX compliance for max portability, test on target systems.

Security: validate input, quote everything, avoid eval, use mktemp, never trust user input.

### 102. HTTP Methods & Idempotency

Safe methods: GET, HEAD, OPTIONS (read-only, no side effects).

Idempotent: GET, PUT, DELETE, HEAD, OPTIONS (can repeat safely, same result). POST not idempotent (creates duplicate).

GET: retrieve resource, cacheable, parameters in URL, no body (technically allowed but ignored).

POST: create resource, not idempotent, body contains data, returns 201 Created with Location header.

PUT: replace entire resource, idempotent (same request = same state), must know full resource URI.

PATCH: partial update, not necessarily idempotent (depends on implementation), RFC 5789.

DELETE: remove resource, idempotent (deleting twice = deleted).

HEAD: like GET but no body, check existence, get metadata.

OPTIONS: allowed methods, CORS preflight.

Use correct method for semantics, don't use GET for mutations.

### 103. HTTP Status Codes Deep Dive

1xx Informational: 100 Continue (client should continue), 101 Switching Protocols (WebSocket upgrade).

2xx Success: 200 OK (GET success), 201 Created (POST success), 202 Accepted (async processing), 204 No Content (DELETE success), 206 Partial Content (range request).

3xx Redirection: 301 Moved Permanently (update bookmarks), 302 Found (temporary), 303 See Other (use GET), 304 Not Modified (cache valid), 307 Temporary Redirect (keep method), 308 Permanent Redirect (keep method).

4xx Client Error: 400 Bad Request (malformed), 401 Unauthorized (auth required), 403 Forbidden (auth insufficient), 404 Not Found, 405 Method Not Allowed, 409 Conflict (version mismatch), 410 Gone (permanently deleted), 422 Unprocessable Entity (validation error), 429 Too Many Requests (rate limit).

5xx Server Error: 500 Internal Server Error, 502 Bad Gateway (proxy error), 503 Service Unavailable (overload/maintenance), 504 Gateway Timeout.

Use specific codes, provide error details in body.

### Category 7: Web Fundamentals & HTTP (18 concepts)

### 104. HTTP Protocol Deep Dive

Request: `METHOD /path HTTP/1.1`, headers, optional body. 

Methods: GET (retrieve), POST (create), PUT (update/replace), PATCH (partial update), DELETE (remove), HEAD (metadata only), OPTIONS (supported methods). 

Headers: `Host:`, `User-Agent:`, `Accept:`, `Content-Type:`, `Authorization:`. 

Response: `HTTP/1.1 STATUS reason`, headers, body. 

Status codes: 1xx informational, 2xx success (200 OK, 201 Created), 3xx redirect (301 permanent, 302 temporary), 4xx client error (400 bad request, 401 unauthorized, 404 not found), 5xx server error (500 internal, 503 unavailable). 

Persistent connections: `Connection: keep-alive` (HTTP/1.1 default). 

HTTP/2: multiplexing (multiple requests over one connection), header compression (HPACK), server push. 

HTTP/3: QUIC transport (UDP-based), 0-RTT, better loss recovery.

---

### 105. RESTful API Design

Represent resources as nouns: `/users`, `/users/123`, `/users/123/posts`. 

HTTP verbs map to CRUD: GET (read), POST (create), PUT (replace), PATCH (update), DELETE (delete). 

Stateless: each request independent, no server-side session. 

Idempotent: GET, PUT, DELETE can be repeated safely. 

Status codes: 200 OK, 201 Created (return resource), 204 No Content (delete), 400 Bad Request, 404 Not Found, 409 Conflict, 422 Unprocessable Entity. 

Hypermedia (HATEOAS): links to related resources. 

Versioning: `/v1/users` (URL), `Accept: application/vnd.api.v1+json` (header). 

Pagination: `/users?page=2&limit=20`. 

Filtering: `/users?status=active`. 

Collections return arrays.

---

### 106. API Authentication

**API Keys:** `Authorization: Bearer <key>` or `X-API-Key: <key>` header. Simple but key rotation needed. 

**OAuth 2.0:** authorization framework, flows: authorization code (web apps, most secure), client credentials (service-to-service), implicit (deprecated), PKCE (mobile/SPA). 

Tokens: access token (short-lived), refresh token (long-lived, get new access token). 

**JWT:** self-contained tokens, no server-side session lookup. 

**Basic Auth:** `Authorization: Basic base64(user:pass)`, only over HTTPS. 

**mTLS:** certificate-based, strongest. 

Best practices: HTTPS required, rotate keys/tokens, scope permissions, short expiration.

---

### 107. Session Management

Server-side state for logged-in users. 

Session ID: random token stored in cookie (`Set-Cookie: session_id=xyz; HttpOnly; Secure; SameSite=Strict`). 

Session store: in-memory (single server), Redis/Memcached (distributed), database (persistent). 

Lifecycle: create on login, destroy on logout, expire after inactivity. 

Security: HttpOnly (prevent XSS), Secure (HTTPS only), SameSite (CSRF protection). 

Session fixation: regenerate ID on login. 

Alternative: stateless JWT (no server-side storage). 

Libraries: gorilla/sessions (Go), express-session (Node).

---

### 108. CORS (Cross-Origin Resource Sharing)

Browser security: same-origin policy prevents JS from accessing different origin (protocol + domain + port). 

CORS headers allow cross-origin requests. 

**Preflight:** OPTIONS request for non-simple requests (custom headers, methods other than GET/POST). 

Server responds with `Access-Control-Allow-Origin: https://example.com` (or `*` for public APIs), `Access-Control-Allow-Methods: GET, POST`, `Access-Control-Allow-Headers: Content-Type, Authorization`, `Access-Control-Allow-Credentials: true` (if sending cookies). 

Simple requests: GET/POST with simple headers. 

Libraries: cors middleware (Go/Node). 

Config: whitelist origins, don't use `*` with credentials.

---

### 109. WebSockets

Full-duplex communication over TCP. 

Protocol upgrade: client sends HTTP request with `Upgrade: websocket`, `Connection: Upgrade`, server responds 101 Switching Protocols. 

Binary or text frames. 

Use cases: real-time updates (chat, notifications, live data). 

Libraries: gorilla/websocket (Go), ws (Node). 

Server: `upgrader.Upgrade(w, r, nil)`, then `conn.ReadMessage()`, `conn.WriteMessage()`. 

Client: JS `new WebSocket("ws://...")`, events: `onopen`, `onmessage`, `onclose`, `onerror`. 

Ping/pong for keep-alive. 

Scaling: sticky sessions or message broker (Redis pub/sub).

---

### 110. Server-Sent Events (SSE)

Unidirectional server → client streaming over HTTP. 

Simpler than WebSockets (no special protocol), automatic reconnection. 

Server: `Content-Type: text/event-stream`, send `data: message\n\n`, `event: custom\ndata: message\n\n` for event types. 

Client: JS `new EventSource("/events")`, `addEventListener("message", handler)`. 

Use cases: live updates, logs, notifications. 

Keep-alive: send comments `: keepalive\n\n`. 

No binary support. HTTP/2 compatible. 

Libraries: built-in browser API, server: simple `fmt.Fprintf(w, "data: %s\n\n", msg); flusher.Flush()`.

---

### 111. Rate Limiting Strategies

Protect APIs from abuse/overload. 

**Token bucket:** bucket holds tokens (capacity), tokens added at rate, request consumes token, reject if empty. 

**Leaky bucket:** requests enter bucket (queue), processed at fixed rate, overflow rejected. 

**Fixed window:** count requests per time window (e.g., 100/minute), reset at window boundary. 

**Sliding window:** more precise, combines fixed window with sub-windows. 

**Sliding log:** track timestamp of each request, count in rolling window. 

Implement: in-memory (single server), Redis (distributed), `rate.Limiter` (Go), middleware. 

Headers: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`, return 429 Too Many Requests.

---

### 112. API Pagination

Handle large datasets. 

**Offset-based:** `?page=2&limit=20` or `?offset=20&limit=20`. Simple but inefficient for large offsets (database still scans skipped rows), inconsistent if data changes. 

**Cursor-based:** `?cursor=abc123&limit=20`, cursor is opaque token (encoded last item ID/timestamp), stable, efficient. 

**Keyset pagination:** `?after_id=100&limit=20`, use indexed column (ID, timestamp), efficient, consistent. 

Response: include `next_cursor` or `has_next`, `total_count` (optional, expensive). 

Links: Link header with next, prev URLs. 

Default limit, max limit (e.g., 100).

---

### 113. API Error Handling

Standardized error responses. 

**RFC 7807 Problem Details:** JSON format, `{ "type": "uri", "title": "Error Title", "status": 400, "detail": "Specific error", "instance": "/request/123" }`. 

Status codes: use appropriate code (400 validation, 401 auth, 403 forbidden, 404 not found, 422 unprocessable, 429 rate limit, 500 server error). 

Error codes: application-specific codes for client handling. 

Message: human-readable, actionable. 

Stack traces: only in development. 

Logging: log errors server-side with context (request ID, user, parameters). 

Validation errors: list all field errors in one response.

---

### 114. GraphQL Basics

Query language for APIs. 

Schema: define types, fields, relationships. 

Query: client specifies exactly what data needed, `{ user(id: "123") { name email posts { title } } }`. 

Mutations: modify data, `mutation { createUser(name: "Alice") { id name } }`. 

Resolvers: functions that fetch data for each field. 

Single endpoint (`/graphql`), POST request. 

Introspection: query schema itself. 

Tools: GraphQL Playground, GraphiQL. 

Libraries: graphql-go, gqlgen (Go), Apollo (JS). 

Advantages: no over/under-fetching, strong typing. 

Disadvantages: complexity, caching harder, N+1 problem (solve with DataLoader).

---

### 115. gRPC & Protocol Buffers

Binary RPC framework. 

**Protocol Buffers:** schema language, `.proto` files define services and messages. 

Compile: `protoc` generates code. 

Service: `service UserService { rpc GetUser(UserRequest) returns (UserResponse); }`. 

Types: unary (request/response), server streaming, client streaming, bidirectional streaming. 

Transport: HTTP/2. 

Advantages: fast (binary), type-safe, code generation, streaming. 

Disadvantages: not browser-friendly (need grpc-web proxy), binary payload (not human-readable). 

Tools: grpcurl (like curl for gRPC). 

Use: microservices, internal APIs, high-performance.

---

### 116. Content Negotiation

Client specifies desired format. 

Accept header: `Accept: application/json`, `Accept: application/xml`, `Accept: */*` (any), quality values: `Accept: application/json;q=0.9, application/xml;q=0.8`. 

Server responds with `Content-Type` matching request. 

Versioning: `Accept: application/vnd.api.v2+json` (vendor MIME type). 

Compression: `Accept-Encoding: gzip, deflate`, server: `Content-Encoding: gzip`. 

Language: `Accept-Language: en-US, de;q=0.8`. 

Server chooses best match, returns 406 Not Acceptable if can't satisfy. 

Implementation: check Accept header, respond accordingly.

---

### 117. Caching Headers

Control caching behavior. 

**Cache-Control:** `no-cache` (revalidate), `no-store` (don't cache), `max-age=3600` (cache for 1 hour), `public` (shared caches OK), `private` (browser only), `must-revalidate`, `immutable` (never changes). 

**ETag:** response header with hash/version, client sends `If-None-Match`, server returns 304 Not Modified if unchanged. 

**Last-Modified / If-Modified-Since:** similar with timestamp. 

**Vary:** `Vary: Accept-Encoding` (cache per header value). 

CDN: respects Cache-Control. 

Invalidation: change URL (versioning `style.v123.css`), set short TTL, purge cache.

---

### 118. SQL Fundamentals

Query data: `SELECT column1, column2 FROM table WHERE condition ORDER BY column LIMIT 10`. 

Joins: INNER JOIN (matching rows), LEFT JOIN (all left + matching right), RIGHT JOIN, FULL OUTER JOIN, CROSS JOIN (cartesian product). 

Group: `SELECT category, COUNT(*) FROM products GROUP BY category HAVING COUNT(*) > 5`. 

Subqueries: `SELECT * FROM users WHERE id IN (SELECT user_id FROM orders)`. 

Aggregate functions: `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`. 

Distinct: `SELECT DISTINCT category FROM products`. 

Aliases: AS, `SELECT u.name FROM users AS u`.

---

### 119. SQL Data Types

**Integers:** SMALLINT (2 bytes), INTEGER (4 bytes), BIGINT (8 bytes), SERIAL (auto-increment). 

**Floating-point:** REAL (4 bytes), DOUBLE PRECISION (8 bytes), NUMERIC(p,s) (exact decimal). 

**Strings:** VARCHAR(n) (variable, max n), TEXT (unlimited), CHAR(n) (fixed). 

**Boolean:** BOOLEAN (true/false/null). 

**Date/Time:** DATE, TIME, TIMESTAMP (with/without time zone), INTERVAL. 

**Binary:** BYTEA. 

**JSON:** JSON (text), JSONB (binary, indexable, PostgreSQL). 

**Arrays:** INTEGER[] (PostgreSQL). 

**UUID:** UUID. 

**Enums:** custom enum types. 

Choose appropriate type for storage/performance.

---

### 120. Database Indexes

Speed up queries by maintaining sorted data structure. 

**B-tree (default):** balanced tree, efficient for equality and range queries, `CREATE INDEX idx_name ON table(column)`. 

**Hash index:** equality only, faster but less common. 

**GIN (Generalized Inverted Index):** full-text search, JSON, arrays. 

**GiST (Generalized Search Tree):** geometric, full-text. 

**Composite index:** multiple columns, `CREATE INDEX ON table(col1, col2)`, order matters, leftmost prefix rule. 

**Unique index:** enforce uniqueness, `CREATE UNIQUE INDEX`. 

**Partial index:** where clause, `CREATE INDEX ON table(column) WHERE condition`. 

Cost: slower writes, more storage. 

Analyze: `EXPLAIN ANALYZE SELECT ...`, look for Seq Scan (bad) vs Index Scan (good).

---

### 121. SQL Transactions

Group multiple operations: `BEGIN`, `COMMIT`, or `ROLLBACK`. 

**ACID:** Atomicity (all or nothing), Consistency (valid state), Isolation (concurrent transactions don't interfere), Durability (persisted after commit). 

Example: 
```sql
BEGIN; 
UPDATE accounts SET balance = balance - 100 WHERE id = 1; 
UPDATE accounts SET balance = balance + 100 WHERE id = 2; 
COMMIT;
```

Savepoints: `SAVEPOINT sp1`, `ROLLBACK TO sp1` (partial rollback). 

Auto-commit: default mode, each statement is transaction. 

Explicit transactions for multi-statement operations. 

Deadlocks: two transactions wait for each other, database detects and aborts one.

---


## PHASE 2: DEVELOPMENT

### Category 8: Git Advanced (15 concepts)

### 122. GitIgnoring Files

**.gitignore:** patterns of files to ignore, not tracked, not shown in status.

**Patterns:** `file.txt` (specific file), `*.log` (extension), `dir/` (directory), `!important.log` (exception), `**/temp` (any temp dir), `*.py[cod]` (character class).

**Location:** root `.gitignore` (entire repo), subdirectory `.gitignore` (directory-specific), global `~/.gitignore_global` (all repos).

**Already tracked:** `.gitignore` doesn't affect already tracked files, remove from tracking `git rm --cached file`, then add to `.gitignore`.

**Templates:** github.com/github/gitignore (language/framework specific), Python, Node, Go, Java, etc.

**Common ignores:** `__pycache__/`, `*.pyc`, `venv/`, `.env`, `node_modules/`, `.DS_Store`, `*.log`, `.idea/`, `*.swp`.

**Check:** `git check-ignore -v file` (why file is ignored), `git status --ignored` (show ignored files).

---

### 123. Git Refspec

**Purpose:** mapping between remote and local refs, used in fetch/push.

**Format:** `+<src>:<dst>`, `+` forces, `<src>` source ref, `<dst>` destination ref.

**Fetch refspec:** `.git/config` under `[remote "origin"]`, `fetch = +refs/heads/*:refs/remotes/origin/*` (fetch all branches).

**Custom:** `git fetch origin refs/heads/main:refs/remotes/origin/main` (specific branch), `git fetch origin pull/123/head:pr-123` (GitHub PR).

**Push refspec:** `git push origin main:main` (push local main to remote main), `git push origin :branch` (delete remote branch, empty source).

**Use cases:** fetch PRs, custom branch mappings, advanced workflows.

---

### 124. Git Internals

**Objects:** blobs (file contents), trees (directory structure), commits (snapshot + metadata), tags (annotated).

**SHA-1:** all objects identified by 40-char hash, content-addressable, same content = same hash.

**Storage:** `.git/objects/`, first 2 chars = directory, rest = filename, compressed, deduplicated.

**Refs:** `.git/refs/heads/` (branches), `.git/refs/remotes/` (remote branches), `.git/refs/tags/` (tags), `.git/HEAD` (current branch).

**Index:** `.git/index` (staging area), binary file.

**Pack files:** `.git/objects/pack/`, compressed collections of objects, saves space, created by `git gc`.

**Plumbing:** low-level commands (`git hash-object`, `git cat-file`, `git ls-tree`), porcelain = user-facing (`git add`, `git commit`).

**Understanding:** helps debug, recover from disasters, appreciate design.

---

### 125. Git Best Practices

**Commit often:** small, logical commits, easier to review/revert/understand.

**Meaningful messages:** imperative mood ("Fix bug" not "Fixed bug"), first line < 50 chars (summary), blank line, detailed description, reference issue number.

**One logical change:** don't mix unrelated changes, separate commits for refactor + feature.

**Test before commit:** ensure code works, run tests, linters.

**Pull before push:** avoid merge conflicts, keep in sync.

**Branch naming:** descriptive, `feature/user-auth`, `bugfix/login-error`, `hotfix/security-patch`.

**Don't commit secrets:** API keys, passwords, use `.env` (in `.gitignore`), environment variables, secret managers.

**Don't commit generated files:** build artifacts, `node_modules/`, `__pycache__/`, add to `.gitignore`.

**Review before push:** `git diff`, `git log`, ensure you're pushing what you think.

**Use .gitignore:** from start of project, templates available.

**Protect main:** require PR reviews, CI checks, no direct pushes.

---

### 126. Git Troubleshooting

**Undo last commit:** `git reset --soft HEAD~1` (keep changes), `git reset --hard HEAD~1` (discard), `git revert HEAD` (new commit, safe for shared branches).

**Recover deleted branch:** `git reflog` (find commit), `git checkout -b branch-name <commit>`.

**Recover deleted commits:** `git reflog` (find commit), `git cherry-pick <commit>` or `git reset --hard <commit>`.

**Detached HEAD:** `git checkout -b new-branch` (save changes), or `git checkout main` (discard).

**Merge conflicts:** `git status` (conflicted files), edit/resolve, `git add`, `git commit`, or `git merge --abort`.

**Accidentally committed to wrong branch:** `git reset --soft HEAD~1`, `git stash`, `git checkout correct-branch`, `git stash pop`, `git add`, `git commit`.

**Large file committed:** remove from history `git filter-branch` or BFG Repo-Cleaner (faster), force push (rewrites history).

**Remote rejected push:** pull first `git pull`, rebase `git pull --rebase`, or use `--force` (dangerous, only if you know what you're doing).

**Check what will be pushed:** `git diff origin/main..main`, `git log origin/main..main`.

---

### 127. Git Worktrees

Multiple working directories for one repository.

Create: `git worktree add <path> <branch>`, creates new directory with checked out branch.

List: `git worktree list`, shows all worktrees with branches.

Remove: `git worktree remove <path>` or delete directory then `git worktree prune`.

Use case: work on multiple branches simultaneously (main + feature), no need to stash/switch, separate directory for each.

Shares `.git` directory, fast (no clone needed), independent working trees.

Example: hotfix in `/hotfix` while feature development in main directory.

Lock: `git worktree lock <path>` prevents removal.

Limitations: can't check out same branch in multiple worktrees.

### 128. Git Bisect

Binary search for bug introduction.

Start: `git bisect start`, mark current as bad: `git bisect bad`, mark known good commit: `git bisect good <commit>`.

Git checks out middle commit, test it, mark: `git bisect good` or `git bisect bad`.

Repeat until finding first bad commit.

Automate: `git bisect run <test-script>`, script exit 0 (good), non-zero (bad).

Reset: `git bisect reset` returns to original branch.

Visualize: `git bisect visualize` or `git bisect view`.

Skip: `git bisect skip` if commit can't be tested.

Finds bug in log(n) steps, essential for large histories.

Example: 1000 commits = ~10 tests.

### 129. Git Rebase Interactive

Rewrite commit history interactively.

Command: `git rebase -i HEAD~5` (last 5 commits), `git rebase -i <base-commit>`.

Opens editor with commits, commands: pick (keep), reword (change message), edit (modify commit), squash (combine with previous, keep messages), fixup (combine, discard message), drop (remove commit).

Reorder: move lines to change commit order.

Split commit: mark edit, `git reset HEAD^`, stage/commit separately, `git rebase --continue`.

Abort: `git rebase --abort` if issues.

Use case: clean up feature branch before merge, combine "fix typo" commits, improve commit messages.

Warning: never rebase published/shared branches (rewrites history).

### 130. Git Reflog Advanced

Reference log tracks HEAD movements.

View: `git reflog` shows history of HEAD, `git reflog show <branch>` for specific branch.

Format: `<commit> HEAD@{n}` (n steps ago), `HEAD@{2.hours.ago}` (time-based).

Recovery: find "lost" commit after reset/rebase, `git reset --hard HEAD@{n}` or `git reset --hard <commit-hash>`.

Branches: `git reflog show <branch>` tracks branch updates.

Expiration: entries expire after 90 days (default), `git reflog expire --expire=30.days --all`.

Config: `gc.reflogExpire`, `gc.reflogExpireUnreachable`.

Use case: undo rebase, recover deleted branch, find commit after force push.

Local only: not pushed to remote, per-repository.

### 131. Git Aliases Advanced

Custom commands and workflows.

Shell commands: prefix with `!`, `git config --global alias.save '!git add -A && git commit -m "SAVEPOINT"'`.

Functions: multi-line with `!f() { ... }; f`, `git config --global alias.undo '!f() { git reset HEAD~${1-1}; }; f'`.

Arguments: pass with `$1`, `$2`, `$@` in shell aliases.

Useful aliases:
- `git config --global alias.unstage 'reset HEAD --'`
- `git config --global alias.last 'log -1 HEAD'`
- `git config --global alias.amend 'commit --amend --no-edit'`
- `git config --global alias.graph 'log --graph --oneline --all'`
- `git config --global alias.contributors 'shortlog -sn'`

View aliases: `git config --get-regexp alias`, in `~/.gitconfig` under `[alias]`.

Distribution: dotfiles repo with `.gitconfig`.

### 132. Git Filter-Branch & Filter-Repo

Rewrite repository history.

filter-repo (modern, recommended): `pip install git-filter-repo`, remove file: `git filter-repo --path <file> --invert-paths`, remove folder: `git filter-repo --path <dir>/ --invert-paths`.

Rewrite authors: `git filter-repo --mailmap <file>`, format: `Proper Name <email@example.com> <old@example.com>`.

Extract subdirectory: `git filter-repo --subdirectory-filter <dir>` makes subdirectory root.

filter-branch (deprecated): `git filter-branch --tree-filter 'rm -f passwords.txt' HEAD`.

Use case: remove sensitive data (passwords, keys), clean large files, split repos, rewrite author info.

Warning: rewrites all commits, force push required, coordinate with team.

Alternative: BFG Repo-Cleaner (faster for file removal).

Backup: always backup before running.

### 133. Git Maintenance & Optimization

Keep repository healthy.

Garbage collection: `git gc` (cleanup unreachable objects, pack files), `git gc --aggressive` (thorough, slow).

Prune: `git prune` removes unreachable objects, `git fetch --prune` removes stale remote refs.

Repack: `git repack -Ad` consolidates pack files.

Count objects: `git count-objects -vH` shows size, `git rev-list --objects --all | git cat-file --batch-check='%(objectsize:disk)' | sort -n`.

Large files: find with `git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -10 | awk '{print $1}')"`.

Fsck: `git fsck --full` check integrity.

Maintenance: `git maintenance start` schedules background tasks (Git 2.31+).

Hooks: post-checkout, post-merge for automatic maintenance.

### 134. Git Signing Commits

Cryptographic verification of commits.

GPG signing: `git commit -S` signs commit, configure key: `git config user.signingkey <key-id>`, auto-sign: `git config commit.gpgsign true`.

Create key: `gpg --gen-key`, list keys: `gpg --list-secret-keys --keyid-format=long`, export public: `gpg --armor --export <key-id>`.

Verify: `git log --show-signature`, `git verify-commit <commit>`, GitHub/GitLab show verified badge.

SSH signing (Git 2.34+): `git config gpg.format ssh`, `git config user.signingkey <path-to-key.pub>`, simpler than GPG.

Tag signing: `git tag -s v1.0`, verify: `git tag -v v1.0`.

Use case: verify authorship, prevent impersonation, compliance requirements.

Team: share public keys, enforce with `receive.fsckObjects`, `receive.advertisePushOptions`.

### 135. Git LFS Advanced

Large file storage best practices.

Track patterns: `git lfs track "*.psd"`, `git lfs track "*.mp4"`, stored in `.gitattributes`.

Migrate existing files: `git lfs migrate import --include="*.psd"` rewrites history.

Fetch: `git lfs fetch --all` downloads all LFS objects, `git lfs fetch --recent` (recent only).

Prune: `git lfs prune` removes old LFS objects to save space.

Status: `git lfs ls-files` shows tracked files, `git lfs status` shows pending uploads.

Locks: `git lfs lock <file>` prevents concurrent editing of binary files, `git lfs unlock <file>`.

Server: GitHub/GitLab provide LFS storage (quota), self-hosted with `git-lfs-server`.

Skip: `GIT_LFS_SKIP_SMUDGE=1 git clone` clones without downloading LFS files (pointers only).

Use case: design files, ML models, datasets, videos, avoid bloating git history.

### 136. Git Troubleshooting Advanced

Solve common issues.

Detached HEAD: `git checkout -b new-branch` creates branch from current state, or `git switch -c new-branch`.

Merge conflicts: `git merge --abort` cancels merge, `git mergetool` launches GUI, `git checkout --ours <file>` (take ours), `git checkout --theirs <file>` (take theirs).

Lost commits: `git reflog`, `git fsck --lost-found`, `git show <commit>`.

Corrupted repository: `git fsck`, clone from remote if corrupted locally.

Wrong commit: `git commit --amend` (if not pushed), `git revert <commit>` (if pushed).

Undo push: `git revert <commit>` (safe), `git push --force-with-lease` after reset (dangerous, coordinate).

Large repository: shallow clone `git clone --depth=1`, sparse checkout, filter blob:none.

Authentication: SSH keys `ssh -T git@github.com`, HTTPS tokens, check remote URLs `git remote -v`.

### Category 9: Databases I: SQL & PostgreSQL (18 concepts)

### 137. Isolation Levels

Control visibility of concurrent transactions. 

**Read Uncommitted:** dirty reads (see uncommitted changes), lowest isolation, rarely used. 

**Read Committed (default most databases):** see only committed data, prevents dirty reads. 

**Repeatable Read:** same query returns same data within transaction, prevents non-repeatable reads. 

**Serializable:** highest, transactions execute as if serial, prevents phantoms (new rows appearing). 

Trade-off: higher isolation = less concurrency, more locks, potential deadlocks. 

PostgreSQL default: Read Committed. 

Set: `SET TRANSACTION ISOLATION LEVEL ...` or in `BEGIN`. 

Anomalies: dirty read, non-repeatable read, phantom read.

---

### 138. Database Constraints

Enforce data integrity. 

**Primary Key:** unique, not null, identifies row, `PRIMARY KEY (id)`. 

**Foreign Key:** references another table, `FOREIGN KEY (user_id) REFERENCES users(id)`, actions: `ON DELETE CASCADE` (delete children), `ON DELETE SET NULL`, `ON UPDATE CASCADE`. 

**Unique:** no duplicates, allows null (unless NOT NULL), `UNIQUE (email)`. 

**Check:** custom validation, `CHECK (age >= 18)`, `CHECK (status IN ('active', 'inactive'))`. 

**Not Null:** mandatory field. 

**Default:** default value, `DEFAULT CURRENT_TIMESTAMP`. 

Constraint names: `CONSTRAINT name ...` for better error messages.

---

### 139. SQL Query Optimization

Analyze queries: `EXPLAIN ANALYZE SELECT ...` shows execution plan, actual time, rows. 

Look for: sequential scans (add index), nested loops (maybe use hash join), high cost. 

Use indexes: on WHERE, JOIN, ORDER BY columns. 

Avoid: `SELECT *` (specify columns), functions on indexed columns (`WHERE YEAR(date) = 2024` doesn't use index, use `date >= '2024-01-01' AND date < '2025-01-01'`), OR (use UNION), implicit conversions. 

Limit results: LIMIT. 

Join order: database optimizer usually handles, but sometimes hint needed. 

Denormalization: for read-heavy workloads. 

Materialized views: precompute expensive queries. 

Statistics: `ANALYZE table` updates planner stats. 

Connection pooling: reuse connections.

---

### 140. Database Connection Pooling

Reuse connections to reduce overhead. 

Pool maintains idle connections, reuses on request. 

Config: min/max connections, idle timeout, max lifetime (handle stale connections). 

Too few: requests wait, too many: resource exhaustion (database max connections). 

Formula: `connections = ((core_count * 2) + effective_spindle_count)` (rough). 

Libraries: built-in (Go database/sql), pgx (PostgreSQL), HikariCP (Java). 

Monitor: active connections, wait time, idle connections. 

Transaction isolation: ensure proper cleanup (`defer tx.Rollback()` or `tx.Commit()`). 

Health checks: test connection before use.

---

### 141. Database Migrations

Version control for schema changes. 

Tools: migrate (Go), Flyway (Java), Alembic (Python), Liquibase. 

Migration files: numbered/timestamped, SQL or code. 

Up migration: apply change, down migration: rollback. 

Example: `001_create_users_table.up.sql`, `001_create_users_table.down.sql`. 

Apply: tool tracks applied migrations in database table (e.g., `schema_migrations`). 

Run in order, idempotent. 

Zero-downtime: backward-compatible changes (add column nullable, deploy code, populate data, make not null, remove old code). 

Lock migrations during apply. 

CI/CD: run migrations before deploying app.

---

### 142. PostgreSQL Specific Features

**JSONB:** binary JSON, indexable, `column->'key'` extract, `column @> '{"key": "value"}'` contains, GIN index for fast lookups. 

**Arrays:** `INTEGER[]`, `SELECT * FROM table WHERE 1 = ANY(array_column)`. 

**Full-text search:** `to_tsvector('english', text)`, `to_tsquery('search & query')`, GIN index, ranking. 

**CTEs (Common Table Expressions):** `WITH cte AS (SELECT ...) SELECT * FROM cte`, recursive CTEs for hierarchies. 

**Window functions:** `ROW_NUMBER() OVER (PARTITION BY ... ORDER BY ...)`, `RANK()`, `LAG()`, `LEAD()`. 

**LISTEN/NOTIFY:** pub/sub, `LISTEN channel`, `NOTIFY channel, 'message'`. 

**Extensions:** PostGIS (geographic), pg_stat_statements (query stats), pg_trgm (fuzzy search).

---

### 143. Database Backup Strategies

**Logical backups:** SQL dump, `pg_dump database > backup.sql`, `pg_dumpall` (all databases), restore: `psql database < backup.sql`. Portable, but slow for large databases. 

**Physical backups:** copy data files, `pg_basebackup` (PostgreSQL), faster, includes WAL for PITR. 

**Point-in-time recovery (PITR):** base backup + WAL archives, restore to specific timestamp. 

**Continuous archiving:** `archive_command` in `postgresql.conf`, copy WAL files to archive. 

**Incremental:** only changed data, faster, tools: pgBackRest, Barman. 

**Snapshots:** filesystem/VM snapshots (LVM, ZFS, cloud), instant, CoW-based. 

Schedule: daily full, hourly incremental. 

Test restores regularly. 

Offsite: 3-2-1 rule.

---

### 144. Database Performance Monitoring

Key metrics: queries per second, slow queries, connection count, cache hit ratio, replication lag. 

**pg_stat_statements (PostgreSQL):** tracks query execution stats, `CREATE EXTENSION pg_stat_statements`, view: `SELECT * FROM pg_stat_statements ORDER BY total_exec_time DESC`, reset: `pg_stat_statements_reset()`. 

**Slow query log:** `log_min_duration_statement = 1000` (log queries > 1s), file: `/var/log/postgresql/`. 

**Connection stats:** `pg_stat_activity` view, active queries, idle connections. 

**Cache hit ratio:** `pg_stat_database`, `blks_hit / (blks_hit + blks_read)`, aim > 99%. 

**Lock monitoring:** `pg_locks` view, detect contention. 

Tools: pgAdmin, pgBadger (log analyzer), Prometheus exporters, Grafana dashboards.

---

### 145. SQL Window Functions

Perform calculations across rows.

OVER clause: `SELECT column, SUM(value) OVER (PARTITION BY category ORDER BY date) FROM table`.

Functions: ROW_NUMBER() (unique sequential), RANK() (with gaps), DENSE_RANK() (no gaps), NTILE(n) (buckets), LAG(column, offset) (previous row), LEAD(column, offset) (next row).

Partitioning: `PARTITION BY category` separate calculation per group.

Ordering: `ORDER BY date` defines window frame.

Frame: ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW (cumulative), ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING (rolling).

Use case: running totals, moving averages, rank within group, compare to previous row.

Example: `SELECT product, sales, sales - LAG(sales) OVER (ORDER BY month) AS growth FROM monthly_sales`.

### 146. SQL Common Table Expressions (CTE)

Named temporary result sets.

Syntax: `WITH cte_name AS (SELECT ...) SELECT * FROM cte_name`.

Multiple: `WITH cte1 AS (...), cte2 AS (...) SELECT ...`.

Recursive CTE: `WITH RECURSIVE cte AS (base_case UNION ALL recursive_case) SELECT * FROM cte`, use case: hierarchies, trees, graphs.

Advantages: readable (vs subqueries), reusable in same query, self-referencing.

Example: organizational hierarchy:
```sql
WITH RECURSIVE employees AS (
  SELECT id, name, manager_id FROM staff WHERE manager_id IS NULL
  UNION ALL
  SELECT s.id, s.name, s.manager_id FROM staff s JOIN employees e ON s.manager_id = e.id
) SELECT * FROM employees;
```

Performance: similar to subqueries, optimizer may inline or materialize.

### 147. SQL Views

Virtual tables defined by query.

Create: `CREATE VIEW active_users AS SELECT * FROM users WHERE status = 'active'`.

Use: `SELECT * FROM active_users` (like regular table).

Materialized views (Postgres): `CREATE MATERIALIZED VIEW mv AS SELECT ...`, stored results, refresh: `REFRESH MATERIALIZED VIEW mv`, faster queries, stale data.

Updatable views: simple views (single table, no aggregates) support INSERT/UPDATE/DELETE.

Benefits: abstraction, security (hide columns/rows), simplify complex queries.

Drop: `DROP VIEW view_name`.

Dependencies: views depend on underlying tables, cascade drops.

Use case: reporting, row-level security, API layer.

### 148. Database Normalization

Organize data to reduce redundancy.

1NF (First Normal Form): atomic values, no repeating groups, each column single value.

2NF: 1NF + no partial dependencies (all non-key columns depend on entire primary key).

3NF: 2NF + no transitive dependencies (non-key columns depend only on primary key, not other non-key columns).

BCNF (Boyce-Codd): stricter 3NF.

Denormalization: intentionally violate for performance (read-heavy), add redundant columns, avoid joins.

Trade-offs: normalization reduces redundancy + update anomalies, denormalization improves read performance.

Use case: OLTP systems (normalized), data warehouses (denormalized star schema).

### 149. SQL Joins Deep Dive

Combine rows from tables.

INNER JOIN: only matching rows, `SELECT * FROM orders o INNER JOIN users u ON o.user_id = u.id`.

LEFT JOIN (LEFT OUTER): all left + matching right (nulls for non-matching), `SELECT * FROM users u LEFT JOIN orders o ON u.id = o.user_id`.

RIGHT JOIN: all right + matching left.

FULL OUTER JOIN: all rows from both, nulls where no match.

CROSS JOIN: Cartesian product, every row from left with every row from right, no ON clause.

SELF JOIN: join table to itself, `SELECT e1.name, e2.name AS manager FROM employees e1 JOIN employees e2 ON e1.manager_id = e2.id`.

Natural join: auto-join on same column names (avoid, implicit).

Performance: indexes on join columns, order matters (put smallest table first in old optimizers).

Use case: relationships, hierarchies, denormalization.

### 150. SQL Subqueries

Query within query.

Scalar subquery: returns single value, `SELECT name FROM users WHERE id = (SELECT user_id FROM orders WHERE id = 1)`.

Row subquery: returns row, use with comparison operators.

Table subquery: returns table, `SELECT * FROM (SELECT * FROM users WHERE active = true) AS active_users`.

Correlated subquery: references outer query, executed for each row, `SELECT name FROM users u WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id)`.

IN: `SELECT * FROM users WHERE id IN (SELECT user_id FROM orders)`.

EXISTS: `SELECT * FROM users u WHERE EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id)`, faster than IN for large datasets.

NOT IN vs NOT EXISTS: NOT EXISTS handles nulls correctly.

Performance: CTE often more readable, may perform differently.

### 151. SQL Aggregate Functions

Compute across rows.

COUNT: `COUNT(*)` all rows, `COUNT(column)` non-null, `COUNT(DISTINCT column)` unique.

SUM, AVG: numeric columns only.

MIN, MAX: any comparable type.

GROUP BY: `SELECT category, COUNT(*) FROM products GROUP BY category`.

HAVING: filter after aggregation, `SELECT category, COUNT(*) FROM products GROUP BY category HAVING COUNT(*) > 5`.

WHERE vs HAVING: WHERE filters before grouping, HAVING after.

Multiple columns: `GROUP BY category, subcategory`.

ROLLUP: subtotals, `GROUP BY ROLLUP(year, month)`.

CUBE: all combinations.

STRING_AGG (Postgres): concatenate strings, `STRING_AGG(name, ', ')`.

ARRAY_AGG: aggregate into array.

### 152. SQL Performance Best Practices

Write efficient queries.

Use indexes: WHERE, JOIN, ORDER BY columns should be indexed.

Avoid SELECT *: specify needed columns, reduces data transfer.

Limit results: LIMIT, pagination.

Proper JOIN order: query planner optimizes but be aware.

Avoid N+1 queries: fetch related data in single query (JOIN or IN).

Use EXPLAIN: analyze query plan, look for Seq Scan, Index Scan, nested loops.

Batch operations: single INSERT with multiple VALUES, bulk updates.

Avoid functions in WHERE: `WHERE YEAR(date) = 2024` prevents index use, use `WHERE date >= '2024-01-01' AND date < '2025-01-01'`.

Connection pooling: reuse connections, don't open/close per query.

Prepared statements: precompiled, prevents SQL injection, parameterized.

### 153. SQL EXPLAIN ANALYZE

Understand query execution.

EXPLAIN: shows plan without executing, `EXPLAIN SELECT * FROM users WHERE id = 1`.

EXPLAIN ANALYZE: executes and shows actual times, `EXPLAIN ANALYZE SELECT ...`.

Output: nodes (Seq Scan, Index Scan, Nested Loop, Hash Join), cost (estimate), rows (estimate vs actual), time (actual).

Seq Scan: full table scan (slow for large tables), add index.

Index Scan: uses index (good).

Index Only Scan: all data from index (best).

Bitmap Index Scan: combines multiple indexes.

Nested Loop: for each row in outer, scan inner (good for small datasets).

Hash Join: build hash table (good for large datasets).

Buffers: `EXPLAIN (ANALYZE, BUFFERS)` shows cache hits.

Use case: optimize slow queries, validate indexes.

### 154. SQL Triggers

Automatic actions on events.

Types: BEFORE/AFTER INSERT/UPDATE/DELETE, INSTEAD OF (views).

Create:
```sql
CREATE TRIGGER trigger_name
BEFORE INSERT ON table
FOR EACH ROW
EXECUTE FUNCTION function_name();
```

Function: PL/pgSQL, access NEW (inserted/updated row), OLD (deleted/updated row).

Use case: audit log, enforce business rules, maintain denormalized data, auto-update timestamps.

Example: `updated_at` timestamp:
```sql
CREATE TRIGGER update_timestamp
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();
```

Cascading triggers: can call other triggers (be careful of infinite loops).

Performance: adds overhead, use sparingly, prefer application logic for complex rules.

Debugging: can be hidden, hard to trace.

### Category 10: Databases II: NoSQL & Performance (17 concepts)

### 155. Database Replication (Postgres)

**Streaming replication:** primary sends WAL to replicas in real-time, `pg_basebackup` to create replica, config: `primary_conninfo`, `hot_standby = on`. 

Asynchronous (default, possible data loss) vs synchronous (`synchronous_commit = on`, `synchronous_standby_names`, slower but no data loss). 

**Logical replication:** row-based, selective (tables/databases), different versions possible, `CREATE PUBLICATION`, `CREATE SUBSCRIPTION`. 

**Replication slots:** prevent WAL deletion before replica consumes, `pg_create_physical_replication_slot()`. 

**Cascading:** replica replicates to another replica. 

Monitoring: `pg_stat_replication` view, replication lag. 

Failover: promote replica to primary, `pg_ctl promote`.

---

### 156. Read Replicas

Offload read traffic from primary. 

Asynchronous replication: slight lag (milliseconds to seconds). 

Use: reporting, analytics, read-heavy workloads. 

Load balancing: application routes reads to replicas, writes to primary. 

Lag monitoring: `pg_stat_replication`, application checks. 

Eventual consistency: accept stale data or route critical reads to primary. 

Connection pooling: separate pools for primary and replicas. 

Frameworks: some ORMs support read/write splitting. 

Scaling: add more replicas (up to practical limit). 

Not for high availability alone (use synchronous replication + failover).

---

### 157. NoSQL Concepts

Non-relational databases. 

**Types:** 
- **Document** (MongoDB, CouchDB): JSON documents, flexible schema. 
- **Key-Value** (Redis, DynamoDB): simple get/put by key, fast. 
- **Column-family** (Cassandra, HBase): wide-column store, scalable. 
- **Graph** (Neo4j, ArangoDB): nodes and edges, relationships. 

Use cases: unstructured data, high write throughput, horizontal scaling, flexible schema. 

Trade-offs: eventual consistency (often), no ACID (usually), no joins (denormalize), query limitations. 

CAP theorem: choose 2 of 3 (consistency, availability, partition tolerance). 

Not a replacement for SQL, complementary. 

Choose based on access patterns.

---

### 158. Data Modeling

**Relational:** normalize to reduce redundancy, 1NF (atomic values), 2NF (no partial dependencies), 3NF (no transitive dependencies). 

Denormalize for performance: duplicate data, trade storage for read speed. 

**Entity-Relationship diagrams:** visualize entities, attributes, relationships (one-to-one, one-to-many, many-to-many). 

**NoSQL:** model for queries, embed related data (documents), use references sparingly. 

Schema design: consider access patterns, query performance, write patterns. 

Indexes: plan early. 

Versioning: soft delete (`deleted_at`), immutable records. 

Audit: `created_at`, `updated_at`, `created_by`. 

UUIDs vs auto-increment: UUIDs for distributed, auto-increment simpler.

---

### 159. NoSQL Database Types

Different models for different use cases.

Document stores: MongoDB, CouchDB, store JSON-like documents, flexible schema, nested data, queries on any field.

Key-value stores: Redis, DynamoDB, simple get/set, very fast, limited queries, use case: caching, sessions.

Column-family: Cassandra, HBase, wide columns, distributed, high write throughput, time-series data.

Graph databases: Neo4j, relationships as first-class, traverse connections efficiently, use case: social networks, recommendations.

Search engines: Elasticsearch, full-text search, inverted indexes, aggregations.

Choose based on: data model, query patterns, scale, consistency requirements.

SQL vs NoSQL: SQL for complex queries + transactions, NoSQL for scale + flexible schema.

### 160. CAP Theorem

Distributed systems trade-offs.

Consistency: all nodes see same data at same time.

Availability: every request receives response (success or failure).

Partition tolerance: system continues despite network partitions.

CAP: can only guarantee 2 of 3.

CA: impossible in distributed system (network partitions happen).

CP: sacrifice availability during partition (MongoDB, HBase, Redis Cluster), strong consistency.

AP: sacrifice consistency during partition (Cassandra, DynamoDB), eventual consistency.

Modern: tune per-operation (e.g., quorum reads/writes in Cassandra).

PACELC: extends CAP, if Partition (choose C or A), Else (choose Latency or Consistency).

Use case: choose based on requirements (banking = CP, social media = AP).

### 161. Eventual Consistency

Relaxed consistency model.

Definition: if no new updates, all replicas eventually converge to same value.

Stale reads: may read old data temporarily.

Conflict resolution: last-write-wins (timestamp), vector clocks (Riak), CRDTs (Conflict-free Replicated Data Types).

Benefits: high availability, low latency, partition tolerance.

Use case: DNS, caches, social media (like counts can be stale).

Implement: async replication, read from replicas, write to primary.

Tunable consistency: Cassandra quorum reads/writes (R + W > N for strong consistency).

Application-level: handle stale data, retry logic, idempotency.

### 162. MongoDB Basics

Document-oriented database.

Data model: JSON-like documents (BSON), collections (like tables), flexible schema.

CRUD: `db.collection.insertOne({name: "Alice"})`, `find({})`, `updateOne({_id: ...}, {$set: {name: "Bob"}})`, `deleteOne({_id: ...})`.

Queries: `db.users.find({age: {$gt: 30}})`, projection: `find({}, {name: 1, _id: 0})`.

Indexes: `db.collection.createIndex({email: 1})`, compound indexes, text indexes.

Aggregation: pipeline stages `db.collection.aggregate([{$match: ...}, {$group: ...}, {$sort: ...}])`.

Replication: replica sets, primary + secondaries, automatic failover.

Sharding: horizontal scaling, shard key determines distribution.

Transactions: ACID transactions (4.0+), multi-document.

Use case: flexible schema, rapid development, hierarchical data.

### 163. Redis Data Structures

In-memory key-value store with rich types.

Strings: `SET key value`, `GET key`, `INCR counter`, atomic operations.

Lists: `LPUSH list item`, `RPUSH`, `LPOP`, `LRANGE list 0 -1`, queues, stacks.

Sets: `SADD set item`, `SMEMBERS set`, `SINTER set1 set2` (intersection), unique items, tags.

Sorted sets: `ZADD zset score member`, `ZRANGE zset 0 -1`, leaderboards, priority queues.

Hashes: `HSET hash field value`, `HGETALL hash`, objects, user profiles.

Bitmaps: `SETBIT`, `GETBIT`, counting, feature flags.

HyperLogLog: `PFADD`, `PFCOUNT`, cardinality estimation.

Streams: `XADD`, `XREAD`, append-only log, event sourcing.

Expiration: `EXPIRE key seconds`, `TTL key`, caching.

Persistence: RDB snapshots, AOF (append-only file).

Use case: caching, sessions, real-time analytics, queues.

### 164. Cassandra Data Modeling

Wide-column NoSQL database.

Data model: keyspace > table > rows, partition key + clustering columns.

Partition key: determines data distribution across nodes, must be in WHERE clause.

Clustering columns: sort order within partition, range queries.

Primary key: (partition key, clustering columns).

Denormalization: duplicate data to optimize reads, query-driven modeling.

Consistency: tunable (ONE, QUORUM, ALL), R + W > N for strong consistency.

Writes: fast (append-only), memtable → SSTable.

Reads: slower (multiple SSTables), compaction helps.

CQL: SQL-like query language, limited JOINs.

Use case: time-series, IoT, high write throughput, multi-datacenter.

Example: `CREATE TABLE events (user_id UUID, timestamp TIMESTAMP, data TEXT, PRIMARY KEY (user_id, timestamp))`.

### 165. ElasticSearch Basics

Search and analytics engine.

Document store: JSON documents, full-text search.

Inverted index: maps terms to documents, fast text search.

Index: collection of documents, mapping defines schema.

Queries: match (full-text), term (exact), range, bool (combine), aggregations (analytics).

Relevance scoring: TF-IDF, BM25.

Analyzers: tokenize text (standard, whitespace, language-specific), stemming, stop words.

Sharding: distribute index across nodes.

Replication: replicas for availability.

Use case: log analysis (ELK stack), full-text search, metrics.

Example: `GET /index/_search { "query": { "match": { "message": "error" } } }`.

### 166. Time-Series Databases

Optimized for time-stamped data.

Examples: InfluxDB, TimescaleDB (Postgres extension), Prometheus.

Data model: timestamp + tags + fields, e.g., `cpu_usage,host=server1,region=us value=80 1609459200`.

Compression: delta encoding, gorilla compression for timestamps.

Retention policies: auto-delete old data.

Downsampling: aggregate old data (hourly → daily).

Queries: time range, aggregations (avg, sum over time windows).

Continuous aggregations: pre-compute rollups.

Use case: monitoring metrics, IoT sensors, stock prices, APM.

InfluxDB: InfluxQL or Flux, tags indexed, fields not.

TimescaleDB: SQL queries, hypertables, continuous aggregates.

Prometheus: pull-based, PromQL, service discovery.

### 167. Database Caching Strategies

Improve read performance.

Cache-aside: app checks cache, if miss loads from DB + populates cache, simple, stale data possible.

Read-through: cache fetches from DB on miss, transparent to app.

Write-through: write to cache + DB synchronously, consistency, slower writes.

Write-behind: write to cache, async to DB, fast writes, risk data loss.

Write-around: write directly to DB, cache miss on read, avoid cache pollution.

Eviction policies: LRU (Least Recently Used), LFU (Least Frequently Used), TTL (time-based).

Cache stampede: multiple simultaneous requests on miss, lock or probabilistic early expiration.

Invalidation: on update/delete, or TTL.

Use case: read-heavy workloads, reduce DB load, improve latency.

Tools: Redis, Memcached, CDN (for static assets).

### 168. Database Connection Management

Efficient resource usage.

Connection pooling: reuse connections, pool size = (max concurrent queries), avoid open/close overhead.

Pool configuration: min/max size, idle timeout, connection lifetime.

Libraries: PgBouncer (Postgres), ProxySQL (MySQL), HikariCP (Java), pgx (Go), psycopg2 (Python).

Leaks: always close connections (defer, try-finally), monitor pool usage.

Prepared statements: precompile queries, reuse across connections, prevent SQL injection.

Timeouts: connect timeout, query timeout, idle timeout.

Health checks: test connections before use, remove stale.

Scaling: increase pool size with traffic, but limited by DB max connections.

Use case: web apps (many short queries), batch jobs (long-running queries).

Monitor: active connections, pool exhaustion, wait times.

### 169. Database Sharding

Horizontal partitioning across multiple databases.

Partition key: determines shard (user_id, tenant_id), even distribution crucial.

Methods: range-based (1-1000 shard1, 1001-2000 shard2), hash-based (hash(key) % N), directory-based (lookup table).

Benefits: scale writes, distribute load, isolate tenants.

Challenges: complex queries (joins across shards), rebalancing (add/remove shards), transactions.

Shard key choice: immutable, high cardinality, query patterns.

Application-level: app routes to correct shard.

Database-level: Vitess (MySQL), Citus (Postgres).

Use case: multi-tenant SaaS, large datasets (> single DB capacity).

Avoid if possible: adds complexity, exhaust vertical scaling first.

### 170. Database Read Replicas

Scale read operations.

Architecture: primary (writes) + replicas (reads), async replication.

Replication lag: replicas behind primary (seconds), eventual consistency.

Read distribution: load balancer, round-robin, or app logic.

Failover: promote replica to primary if primary fails.

Use case: read-heavy workloads (analytics, reporting), geographic distribution.

Challenges: stale reads, replication lag monitoring, connection string management.

Postgres: streaming replication, logical replication.

MySQL: binary log replication.

Routing: read from replica for non-critical, primary for critical (after write).

Monitor: lag (`pg_stat_replication`), alert if exceeds threshold.

### 171. Multi-Region Databases

Deploy across geographic regions.

Active-Active: write to any region, conflict resolution (last-write-wins, CRDTs), high availability, complex.

Active-Passive: writes to primary region, replicas in others, simpler, failover.

Data locality: GDPR compliance, low latency, store data in user's region.

Consistency: eventual consistency common (AP), conflicts possible.

Replication: async (low latency, stale data), sync (high latency, consistent).

Examples: DynamoDB Global Tables, Cosmos DB, CockroachDB, Spanner.

Use case: global applications, disaster recovery, compliance.

Challenges: network latency, split-brain (network partition), increased cost.

Testing: simulate failures, measure failover time, verify conflict resolution.

### Category 11: Programming with Go Basics (18 concepts)

### 172. Go Basics

Package declaration: `package main`, imports: `import "fmt"`, entry point: `func main()`. 

Variables: `var name string = "value"`, short declaration: `name := "value"` (type inference). 

Types: `int`, `string`, `bool`, `float64`, custom types: `type UserID int`. 

Constants: `const Pi = 3.14`. 

Visibility: uppercase = exported (public), lowercase = package-private. 

Zero values: 0 for numbers, "" for strings, false for bool, nil for pointers/slices/maps. 

Multiple return: `func divide(a, b int) (int, error)`. 

Defer: `defer file.Close()` (executes at function exit).

---

### 173. Go Slices

Dynamic arrays: `[]int{1, 2, 3}`, zero value: nil. Capacity vs length: `len(slice)`, `cap(slice)`. 

Create: `make([]int, length, capacity)`. 

Append: `slice = append(slice, elem)` (may reallocate). 

Slicing: `slice[start:end]` (shares underlying array). Full slice: `slice[:]`. 

Copy: `copy(dst, src)`. 

Range: `for i, v := range slice`. 

Memory: backed by array, slice is struct with pointer, len, cap. 

Gotcha: slices share data, modifying one affects others unless copied.

---

### 174. Go Maps

Hash table: `map[string]int{"key": 42}`, zero value: nil. 

Create: `make(map[string]int)`. 

Set: `m["key"] = value`. 

Get: `value := m["key"]`, check existence: `value, ok := m["key"]`. 

Delete: `delete(m, "key")`. 

Iterate: `for key, value := range m` (order random). 

Not safe for concurrent use (need `sync.Map` or mutex). 

Zero value for missing keys: 0, "", nil, etc. 

Capacity hint: `make(map[string]int, 100)`.

---

### 175. Go Structs

Composite types: `type User struct { Name string; Age int }`. 

Initialize: `User{"Alice", 30}`, named fields: `User{Name: "Alice", Age: 30}`. 

Access: `user.Name`. Pointers: `&User{}` returns pointer. 

Methods: `func (u User) Greet() string` (value receiver), `func (u *User) SetAge(age int)` (pointer receiver, can modify). 

Embedding: `type Admin struct { User; Level int }` (composition). 

JSON tags: ```Name string `json:"name"` ``` for serialization. 

Export rules: uppercase fields exported.

---

### 176. Go Interfaces

Define behavior: `type Reader interface { Read(p []byte) (n int, err error) }`. 

Implicit implementation (no "implements" keyword). 

Empty interface: `interface{}` (any type), modern: `any`. 

Type assertion: `value.(Type)`, safe: `value, ok := value.(Type)`. 

Type switch: `switch v := value.(type)`. 

Common interfaces: `io.Reader`, `io.Writer`, `error`. 

Pointer vs value receivers: method set differs. 

Interface values: hold type and value, nil interface vs interface holding nil value.

---

### 177. Go Error Handling

Explicit error returns: `func Do() error`, `func Get() (Value, error)`. 

Create errors: `errors.New("message")`, `fmt.Errorf("context: %w", err)` (wrap). 

Check: `if err != nil { return err }`. 

Wrap/unwrap: `errors.Unwrap(err)`, check wrapped: `errors.Is(err, ErrNotFound)`, `errors.As(err, &target)`. 

Sentinel errors: `var ErrNotFound = errors.New("not found")`. 

Custom errors: implement `Error() string`. 

No exceptions, explicit control flow.

---

### 178. Go Pointers

Memory address: `&variable` (address-of), `*pointer` (dereference). 

Declaration: `var ptr *int`. Nil pointer: zero value, dereferencing causes panic. 

Use: passing large structs, mutating in functions. 

Automatic dereferencing: `ptr.Field` same as `(*ptr).Field`. 

No pointer arithmetic (unlike C). 

Escape analysis: compiler decides stack vs heap allocation. 

Function arguments: pass by value (copy), pass pointer to modify original.

---

### 179. Go Goroutines

Lightweight threads: `go function()`, `go func() { ... }()`. 

M:N scheduling: M goroutines on N OS threads. Multiplexed by Go runtime. 

Very cheap: millions possible. Concurrent, not parallel (unless GOMAXPROCS > 1). 

Communication: channels (preferred) or shared memory + mutex. 

Wait for completion: `sync.WaitGroup`. 

Stack: starts small (2KB), grows dynamically. 

Scheduler: work-stealing, preemptive (Go 1.14+). 

Main goroutine: program exits when `main()` returns, even if other goroutines running.

---

### 180. Go Channels

Goroutine communication: `ch := make(chan int)`, buffered: `make(chan int, 10)`. 

Send: `ch <- value`, receive: `value := <-ch`. 

Close: `close(ch)` (sender closes, not receiver). 

Check closed: `value, ok := <-ch` (ok false if closed). 

Range: `for value := range ch` (until closed). 

Select: `select { case v := <-ch1: ... case ch2 <- v: ... default: ... }` (non-blocking with default). 

Directions: `chan<-` (send-only), `<-chan` (receive-only). 

Unbuffered: synchronous, buffered: asynchronous until full.

---

### 181. Go Context

Cancellation and deadlines: `ctx, cancel := context.WithCancel(context.Background())`. 

Timeout: `context.WithTimeout(ctx, 5*time.Second)`. 

Deadline: `context.WithDeadline(ctx, time)`. 

Values: `context.WithValue(ctx, key, value)` (avoid overuse). 

Check: `ctx.Done()` channel, `ctx.Err()` for reason. 

Pass as first parameter: `func DoWork(ctx context.Context, ...)`. 

Propagate: child contexts inherit cancellation. 

Use: HTTP requests, database queries, graceful shutdown. 

Never store in structs.

---

### 182. Go sync Package

**Mutex:** `var mu sync.Mutex`, `mu.Lock()`, `mu.Unlock()` (use with defer). 

**RWMutex:** `var rw sync.RWMutex`, `rw.RLock()`, `rw.RUnlock()` (multiple readers, one writer). 

**WaitGroup:** `var wg sync.WaitGroup`, `wg.Add(1)`, `wg.Done()`, `wg.Wait()`. 

**Once:** `var once sync.Once`, `once.Do(func)` (executes exactly once). 

**Atomic:** `sync/atomic` package for lock-free operations, `atomic.AddInt64(&counter, 1)`. 

**Pool:** `sync.Pool` for temporary object reuse. 

**Cond:** `sync.Cond` for condition variables.

---

### 183. Go Standard Library (net/http)

HTTP server: `http.ListenAndServe(":8080", handler)`. 

Handler: `func(w http.ResponseWriter, r *http.Request)`. 

ServeMux: `mux := http.NewServeMux()`, `mux.HandleFunc("/path", handler)`. 

Write response: `fmt.Fprintf(w, "response")`, `w.WriteHeader(200)`. 

Read request: `r.Method`, `r.URL.Path`, `r.Header.Get("Content-Type")`, `io.ReadAll(r.Body)`. 

HTTP client: `resp, err := http.Get(url)`, `http.Post()`, custom client with timeout: `client := &http.Client{Timeout: 10*time.Second}`. 

Middleware: wrap handlers.

---

### 184. Go JSON Handling

Marshal: `json.Marshal(value)` (struct to JSON bytes), `json.MarshalIndent(value, "", "  ")` (pretty). 

Unmarshal: `json.Unmarshal(data, &target)`. 

Struct tags: ```type User struct { Name string `json:"name"`; Age int `json:"age,omitempty"` }```. 

Omit empty: skip zero values. Ignore field: `json:"-"`. 

Decoder/Encoder: streaming, `json.NewDecoder(reader).Decode(&value)`, `json.NewEncoder(writer).Encode(value)`. 

Custom marshaling: implement `MarshalJSON()`, `UnmarshalJSON()` methods. 

Handle unknown fields: `json:",unknown"` or decoder `DisallowUnknownFields()`.

---

### 185. Go Testing

Test files: `*_test.go`, function: `func TestName(t *testing.T)`. 

Run: `go test`, `go test -v` (verbose), `go test ./...` (all packages). 

Assertions: `t.Error()`, `t.Fatal()` (stop test), `t.Logf()`. 

Subtests: `t.Run("subtest", func(t *testing.T) {...})`. 

Table-driven: `tests := []struct{input, expected}{{...}}`; `for _, tt := range tests { t.Run(tt.name, ...) }`. 

Coverage: `go test -cover`, `go test -coverprofile=coverage.out`, `go tool cover -html=coverage.out`. 

Benchmarks: `func BenchmarkName(b *testing.B) { for i := 0; i < b.N; i++ {...} }`, run: `go test -bench=.`. 

Fuzzing: `func FuzzName(f *testing.F) {...}`, run: `go test -fuzz=.`.

---

### 186. Go Modules

Dependency management: `go.mod` file (module path, dependencies). 

Initialize: `go mod init github.com/user/repo`. 

Add dependency: import in code, `go get`, `go mod tidy` (clean unused). 

Version: semantic versioning, `require github.com/pkg/errors v0.9.1`. 

Indirect dependencies: `// indirect` comment. 

Vendor: `go mod vendor` (copy dependencies), `go build -mod=vendor`. 

Replace: `replace github.com/old/pkg => github.com/new/pkg v1.2.3` (fork, local). 

Proxy: GOPROXY, checksum database: GOSUMDB, `go.sum` for integrity.

---

### 187. Go Build & Compilation

Build: `go build` (creates binary), `go build -o name`, `go install` (builds and installs to `$GOPATH/bin`). 

Cross-compile: `GOOS=linux GOARCH=amd64 go build`. 

Build tags: `//go:build linux` at top of file, build: `go build -tags production`. 

Linker flags: `go build -ldflags "-X main.version=1.0.0"` (inject variables), `-s -w` (strip debug, reduce size). 

Race detector: `go build -race` (detect data races). 

Compiler: `go build -gcflags="-m"` (escape analysis), `-N -l` (disable optimization/inlining for debugging). 

Output: static binary (mostly), cgo links dynamically.

---

### 188. Go Performance Profiling

CPU profiling: `import _ "net/http/pprof"`, `http.ListenAndServe(":6060", nil)`, access `http://localhost:6060/debug/pprof/`. 

Capture: `go tool pprof http://localhost:6060/debug/pprof/profile?seconds=30`. 

Memory: `http://localhost:6060/debug/pprof/heap`. 

Goroutines: `/debug/pprof/goroutine`. 

Analyze: `go tool pprof -http=:8080 profile.pb.gz` (web UI). 

Test benchmarks: `go test -bench=. -cpuprofile=cpu.out`, then `go tool pprof cpu.out`. 

Commands: `top`, `list function`, `web` (graph). 

Flame graphs: go-torch or pprof web UI.

---

### 189. Go Memory Management

Stack vs heap: small, known-size variables on stack (fast), others heap (GC). 

Escape analysis: `go build -gcflags="-m"` shows allocations. 

GC: mark-and-sweep, concurrent, pauses < 1ms. 

Tune: `GOGC=100` (default, GC when heap grows 100%), `GOMEMLIMIT` (Go 1.19+, soft memory limit). 

Debug: `GODEBUG=gctrace=1` (GC stats). 

Memory profile: see profiling above. 

Reduce allocations: reuse objects (`sync.Pool`), avoid pointer-heavy structs, use value receivers. 

Stack size: starts 2KB, grows to 1GB max. 

Prevent leaks: close goroutines, don't leak timers/contexts.

---

### Category 12: Programming with Go Advanced (17 concepts)

### 190. Go HTTP Middleware

Wrap handlers: `func middleware(next http.Handler) http.Handler { return http.HandlerFunc(func(w, r) { /*before*/ next.ServeHTTP(w, r) /*after*/ }) }`. 

Chain: `handler = middleware1(middleware2(handler))`. 

Frameworks: chi, gorilla/mux. 

Common middleware: logging (request/response), auth (check tokens), recovery (catch panics), CORS, rate limiting. 

Context: pass data via `context.WithValue()`. 

Example: `func logger(next http.Handler) http.Handler { return http.HandlerFunc(func(w, r) { log.Printf("%s %s", r.Method, r.URL.Path); next.ServeHTTP(w, r) }) }`.

---

### 191. Go Graceful Shutdown

Catch signals: `import "os/signal"`, `sigCh := make(chan os.Signal, 1)`, `signal.Notify(sigCh, syscall.SIGTERM, syscall.SIGINT)`. 

HTTP server shutdown: `server := &http.Server{Addr: ":8080"}`, `go server.ListenAndServe()`, `<-sigCh`, `ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)`, `server.Shutdown(ctx)`. 

Wait for connections to close, stop accepting new ones. 

Close resources: databases, files. 

Propagate context: cancel contexts on shutdown. 

Use `sync.WaitGroup` for goroutines. 

systemd: receives SIGTERM on stop.

---

### 192. Go Database/SQL

Import driver: `_ "github.com/lib/pq"` (PostgreSQL). 

Connect: `db, err := sql.Open("postgres", "connstring")`, `db.Ping()` to verify. 

Connection pool: `db.SetMaxOpenConns(25)`, `db.SetMaxIdleConns(5)`, `db.SetConnMaxLifetime(5*time.Minute)`. 

Query: `rows, err := db.Query("SELECT ...")`, `defer rows.Close()`, iterate: `for rows.Next() { rows.Scan(&vars...) }`. 

QueryRow: single row, `row := db.QueryRow("SELECT ...")`, `row.Scan(&vars...)`. 

Exec: insert/update/delete, `result, err := db.Exec("INSERT ...")`. 

Transactions: `tx, err := db.Begin()`, `tx.Commit()` or `tx.Rollback()`. 

Prepared statements: `stmt, err := db.Prepare("INSERT ...")`, `stmt.Exec(...)`.

---

### 193. Go Concurrency Patterns

**Pipeline:** stage1 → stage2 → stage3, each stage is goroutine with channels. 

**Fan-out:** distribute work to multiple workers, `for i := 0; i < workers; i++ { go worker(input, output) }`. 

**Fan-in:** merge results from multiple channels, select on all. 

**Worker pool:** fixed number of workers, work queue (channel). 

**Context cancellation:** pass ctx to goroutines, check `ctx.Done()`, propagate. 

**Errgroup:** `golang.org/x/sync/errgroup`, `g, ctx := errgroup.WithContext(ctx)`, `g.Go(func() error {...})`, `err := g.Wait()`. 

**Or-done:** cancel on first completion. 

**Rate limiting:** `time.Tick()` or `rate.Limiter`.

---

### 194. Go Project Structure

Common layout: `cmd/` (applications, one dir per binary), `internal/` (private packages, not importable by other modules), `pkg/` (libraries, importable), `api/` (OpenAPI/gRPC specs), `configs/` (config files), `scripts/`, `build/`, `deployments/`. 

Example: `cmd/server/main.go`, `internal/handlers/`, `pkg/models/`. 

Flat is fine for small projects. Don't nest too deep. 

`go.mod` at root. 

Internal packages: enforced by compiler, can't be imported outside module or parent of `internal/`.

---

### 195. Go Dependency Injection

Manual DI: pass dependencies as function arguments or struct fields. 

Constructor functions: `func NewService(db *sql.DB, cache *redis.Client) *Service { return &Service{db: db, cache: cache} }`. 

Interface-based: depend on interfaces, not concrete types. 

DI frameworks: wire (compile-time code generation), fx (runtime reflection). 

Example with wire: define providers, wire generates initialization code. 

Avoid global variables, use explicit dependencies. 

Testability: mock dependencies by implementing interfaces.

---

### 196. Go Configuration Management

Environment variables: `os.Getenv("VAR")`, `os.LookupEnv("VAR")` (check existence). 

Default: `value := os.Getenv("VAR"); if value == "" { value = "default" }`. 

Libraries: viper (multiple sources: env, files, flags), envconfig (struct tags). 

12-factor: config in environment. 

Config files: JSON, YAML, TOML. 

Example viper: `viper.SetConfigName("config")`, `viper.AddConfigPath(".")`, `viper.ReadInConfig()`, `viper.GetString("key")`. 

Secrets: never hardcode, use env vars or secret management.

---

### 197. Go Logging

Standard library: log package, `log.Println("message")`, `log.Printf("format %s", var)`. 

Structured logging: `log/slog` (Go 1.21+), `slog.Info("message", "key", value)`, handlers for JSON/text output. 

Levels: Debug, Info, Warn, Error. 

Context: `logger.With("requestID", id)`. 

Third-party: logrus, zap (high performance), zerolog. 

JSON output: parseable by log aggregators. 

Example slog: `logger := slog.New(slog.NewJSONHandler(os.Stdout, nil))`, `logger.Info("started", "port", 8080)`. 

Don't use `fmt.Println` in production.

---

### 198. Go HTTP Client Best Practices

Timeouts: `client := &http.Client{Timeout: 10*time.Second}`. 

Transport tuning: `transport := &http.Transport{MaxIdleConns: 100, MaxIdleConnsPerHost: 10, IdleConnTimeout: 90*time.Second}`. 

Connection pooling: reuse connections. 

Context: `req, err := http.NewRequestWithContext(ctx, "GET", url, nil)`, cancel on timeout. 

Retries: use library like go-retryablehttp. 

Circuit breaker: gobreaker library. 

Headers: `req.Header.Set("User-Agent", "...")`. 

Close body: `defer resp.Body.Close()`. 

Read body: `io.ReadAll(resp.Body)`. 

Check status: `resp.StatusCode`.

---

### 199. Go Code Organization

Package design: cohesive (related functionality), loosely coupled (minimal dependencies). 

Avoid cyclic dependencies: refactor common code to separate package. 

Internal packages: use `internal/` for implementation details. 

API packages: `pkg/` for public APIs. 

One package per directory, no nested packages. 

Naming: lowercase, short, meaningful. 

Export only necessary types/functions. 

Group related files: `user.go`, `user_test.go`, `user_repo.go`. 

Avoid "utils" packages. 

Domain-driven: organize by business domain, not by layer (not `models/`, `controllers/`).

---

### 200. Go Kubernetes Client

Library: `k8s.io/client-go`. 

Create client: `config, err := rest.InClusterConfig()` (in-pod) or `clientcmd.BuildConfigFromFlags("", kubeconfig)` (out-of-cluster), `clientset, err := kubernetes.NewForConfig(config)`. 

List pods: `pods, err := clientset.CoreV1().Pods(namespace).List(ctx, metav1.ListOptions{})`. 

Informers: watch resources, `informer := cache.NewSharedIndexInformer(...)`, add event handlers, `informer.Run(stopCh)`. 

Listers: local cache for fast reads. 

Controller runtime: `sigs.k8s.io/controller-runtime`, higher-level API for operators. 

Watches: real-time updates via WebSocket.

---

### 201. Go Static Analysis

Linters: **golangci-lint** (aggregates many linters), install: `go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest`, run: `golangci-lint run`. 

Config: `.golangci.yml`. 

Built-in: `go vet` (suspicious code), `go fmt` (format), `gofmt -s` (simplify). 

Specific linters: staticcheck (bugs), gosec (security), errcheck (unchecked errors), gocritic (style). 

CI integration: run in pipeline, fail on errors. 

Pre-commit hooks: pre-commit framework. 

IDE integration: VSCode Go extension runs linters on save.

---

---

### 202. Go Generics

Type parameters (Go 1.18+).

Define: `func Print[T any](s []T) { for _, v := range s { fmt.Println(v) } }`, call: `Print[int]([]int{1,2,3})` or `Print([]int{1,2,3})` (type inference).

Constraints: `func Sum[T int | float64](nums []T) T`, or interfaces: `type Number interface { int | float64 }`.

Type sets: `~int` (underlying type int), `comparable` (built-in for ==, !=).

Generic types: `type Stack[T any] struct { items []T }`, methods: `func (s *Stack[T]) Push(item T)`.

Use case: collection types, data structures, algorithms (sort, filter, map).

Limitations: no type parameters on methods (only on types), no operator overloading.

Performance: compile-time, zero runtime overhead (unlike interface{}).

Standard library: slices, maps packages use generics.

### 203. Go Reflection

Runtime type inspection.

reflect package: `reflect.TypeOf(x)` (type), `reflect.ValueOf(x)` (value).

Kind: underlying type (Int, String, Struct, Slice, etc.), `v.Kind()`.

Struct fields: `t.NumField()`, `t.Field(i)` (StructField), tags: `field.Tag.Get("json")`.

Modify: `v.SetInt(10)`, requires addressable (pass pointer), `v.CanSet()` check.

Invoke methods: `method := v.MethodByName("String")`, `method.Call(args)`.

Use case: JSON marshaling, ORMs, dependency injection, generic utilities.

Performance: slow (runtime overhead), use sparingly.

Type assertion vs reflection: prefer type assertion `x.(string)` when type known.

### 204. Go Embedded Structs

Composition over inheritance.

Embed: `type Admin struct { User; level int }`, promotes User fields/methods to Admin.

Access: `admin.Name` (promoted), `admin.User.Name` (explicit).

Method promotion: embedded type's methods available on outer type.

Interfaces: if User implements io.Reader, Admin does too.

Name conflicts: outer field shadows inner, use explicit path.

Multiple embeds: `type X struct { A; B }`, access: `x.A.field`, `x.B.field`.

Use case: code reuse without inheritance, mix-in behavior, satisfy interfaces.

Example: `http.Handler` embedding for middleware.

### 205. Go Build Tags

Conditional compilation.

Tags in file: `//go:build linux && amd64`, old format: `// +build linux,amd64`.

Build: `go build -tags tag1,tag2`, includes files with matching tags.

OS/Arch: automatic tags (linux, darwin, windows, amd64, arm64, etc.).

Custom tags: `//go:build integration`, exclude from default build.

Negation: `//go:build !windows`.

Boolean logic: `&&` (and), `||` (or), `!` (not).

Use case: platform-specific code, test vs production, feature flags.

File naming: `file_linux.go`, `file_windows.go` (implicit tags).

Example: `//go:build integration` for integration tests, run: `go test -tags integration`.

### 206. Go Workspace Mode

Manage multiple modules (Go 1.18+).

go.work file: `go work init ./module1 ./module2`, lists local modules.

Use case: develop changes across multiple modules simultaneously without replace directives.

Commands: `go work use ./module3` (add), `go work sync` (update).

Structure:
```
go 1.21
use (
    ./api
    ./lib
)
```

Ignore: add `go.work` to `.gitignore`, for local development only.

Replace: workspace overrides replace directives in go.mod.

Benefits: simpler than replace, better IDE support.

Disable: `GOWORK=off go build` ignores go.work.

### Category 13: API Design & gRPC (15 concepts)

### 207. JWT (JSON Web Tokens)

Stateless authentication.

Structure: header.payload.signature (Base64URL encoded).

Header: `{"alg": "HS256", "typ": "JWT"}` (algorithm, type).

Payload: claims (sub, iss, exp, iat, custom), `{"sub": "user123", "exp": 1234567890}`.

Signature: HMAC or RSA, `HMACSHA256(base64(header) + "." + base64(payload), secret)`.

Verify: decode, check signature, check expiration.

Libraries: jwt-go, golang-jwt (Go), jsonwebtoken (Node), PyJWT (Python).

Storage: localStorage (XSS risk), httpOnly cookie (CSRF risk), session storage.

Refresh tokens: long-lived, exchange for new access token.

Use case: stateless auth, microservices, SPAs, mobile apps.

Security: short expiration (15 min), HTTPS only, validate claims, secret rotation.

### 208. API Versioning Strategies

Handle API evolution.

URL path: `/v1/users`, `/v2/users`, simple, clear, CDN-friendly, requires routing.

Query parameter: `/users?version=1`, flexible but less visible.

Header: `Accept: application/vnd.api.v2+json`, clean URLs, complex for consumers.

Content negotiation: same URL, different Accept header.

Subdomain: `v1.api.example.com`, isolate versions, DNS overhead.

No versioning: breaking changes not allowed, deprecation, sunset headers.

Best practices: semantic versioning, deprecation warnings (Sunset, Deprecation headers), long support windows, migration guides.

When to version: breaking changes (remove field, change type), non-breaking: add optional field.

Avoid: v0, start with v1.

### 209. API Rate Limiting Implementation

Protect against abuse.

Token bucket: `type Limiter struct { tokens, capacity, refillRate }`, consume token per request, refill at rate.

Sliding window: track requests in time window, count last N seconds.

Libraries: golang.org/x/time/rate (Go), express-rate-limit (Node), flask-limiter (Python).

Go example: `limiter := rate.NewLimiter(rate.Limit(10), 100)`, `limiter.Wait(ctx)` blocks until token.

Storage: in-memory (single server), Redis (distributed), `INCR key EX 60` pattern.

Headers: `X-RateLimit-Limit: 1000`, `X-RateLimit-Remaining: 999`, `X-RateLimit-Reset: 1234567890`.

Response: 429 Too Many Requests, Retry-After header.

Per-user: key by user ID or API key, anonymous: key by IP.

Use case: APIs, login endpoints, expensive operations.

### 210. API Documentation

Make APIs discoverable.

OpenAPI (Swagger): YAML/JSON spec, describes endpoints, parameters, responses, schemas.

Generate: from code (annotations, docstrings), or write spec manually.

Tools: Swagger UI (interactive docs), Redoc (clean), Postman collections.

Go: swaggo/swag (annotations), example: `// @Summary Get user`, `// @Param id path int true "User ID"`, generate: `swag init`.

Versioning: document each version separately.

Examples: request/response examples in spec, curl examples.

Authentication: document auth methods (API key, OAuth, JWT).

Changelog: document breaking changes, deprecations.

Try it out: interactive API explorer.

Use case: onboarding, external APIs, reduce support tickets.

### 211. API Webhooks

Event-driven notifications.

Flow: event occurs → server POSTs to registered URL → consumer processes.

Registration: API to register webhook URL, events to subscribe.

Payload: JSON with event type, timestamp, data.

Security: verify signature (HMAC of payload with secret), check timestamp (prevent replay).

Retry: exponential backoff if delivery fails (5xx, timeout), max retries.

Idempotency: send event ID, consumer dedup.

Testing: webhook.site, ngrok for local dev.

Use case: GitHub webhooks (push, PR), Stripe (payment events), Slack (slash commands).

Challenges: consumer downtime, payload size, ordering.

### 212. API Idempotency

Safe to retry operations.

Idempotency key: client-generated UUID, `Idempotency-Key` header.

Server: store key + result (in database or cache), if duplicate key, return stored result.

TTL: expire after 24 hours, balance storage vs retry window.

Methods: GET, PUT, DELETE naturally idempotent, POST not (needs explicit key).

Use case: payment APIs (don't charge twice), distributed systems (network retries).

Implementation: before processing, check key in store, if exists return cached response, else process + store.

Response: return same status code (200 or 201), indicate cached (`X-Idempotent-Replayed: true`).

Libraries: middleware for frameworks.

Standards: draft IETF spec.

### 213. API Throttling vs Rate Limiting

Control request rate.

Rate limiting: hard limit (100 req/min), reject excess (429).

Throttling: slow down requests, add delay, queue, degrade gracefully.

Use together: rate limit external APIs, throttle internal background jobs.

Implementation: rate limit with token bucket, throttle with queue (channel in Go).

Strategies: per-user, per-IP, per-endpoint, global.

Bursting: allow temporary spike (bucket capacity > rate).

Shed load: reject non-critical requests under high load.

Use case: rate limit (abuse prevention), throttle (avoid overload).

Monitoring: track rejected requests, adjust limits.

### 214. API Hypermedia (HATEOAS)

Hypertext As The Engine Of Application State.

Concept: API responses include links to related resources.

Example: `{"id": 1, "name": "Alice", "_links": {"self": {"href": "/users/1"}, "orders": {"href": "/users/1/orders"}}}`.

Benefits: discoverability, clients navigate via links (not hardcode URLs), evolvable (change URLs without breaking clients).

HAL: Hypertext Application Language format.

JSON:API: standard format with links, relationships.

Drawbacks: extra data, complexity, not widely adopted.

Use case: public APIs, long-lived clients, RESTful purity.

Contrast: most APIs don't use (clients hardcode URLs).

### 215. API Response Pagination

Handle large result sets.

Offset-based: `?page=2&limit=20` or `?offset=20&limit=20`, simple but inefficient for large offsets.

Cursor-based: `?cursor=xyz&limit=20`, opaque cursor (encoded last item ID), efficient, handles inserts/deletes.

Keyset: `?after_id=100&limit=20`, use indexed column, fast, consistent.

Response: `{"data": [...], "next_cursor": "abc", "has_more": true}`.

Links: `Link: </users?cursor=abc>; rel="next"` header.

Limits: default 20, max 100, validate input.

Total count: expensive for large datasets, optionally return.

Use case: list endpoints, search results, feeds.

### 216. API Filtering & Sorting

Query refinement.

Filtering: `?status=active&role=admin`, support common operators: `?created_at[gte]=2024-01-01`.

Advanced: `?filter[status]=active&filter[age][gt]=30` (nested), JSON in query param.

SQL injection: use parameterized queries, validate input.

Sorting: `?sort=created_at` (asc), `?sort=-created_at` (desc), multiple: `?sort=name,-created_at`.

Default sort: consistent ordering (e.g., ID), important for pagination.

Field selection: `?fields=id,name` (return subset), reduces bandwidth.

Search: `?q=keyword`, full-text search (Elasticsearch), or simple LIKE query.

Standards: JSON:API, OData define conventions.

### 217. API ETags & Conditional Requests

Optimize caching.

ETag: response header with version/hash, `ETag: "abc123"`.

Client: stores ETag, subsequent request: `If-None-Match: "abc123"`.

Server: checks if resource changed, 304 Not Modified (no body) if same, 200 (full body) if changed.

Strong vs weak: strong (`"abc"`), byte-for-byte match, weak (`W/"abc"`), semantically equivalent.

Last-Modified: timestamp-based, `If-Modified-Since` header, less precise.

Use case: reduce bandwidth, API responses, static files.

Generate: hash content, database version column, updated_at timestamp.

Concurrency: optimistic locking, `If-Match` for updates (prevent lost update).

### 218. gRPC Error Handling

Structured error responses.

Status codes: OK, CANCELLED, UNKNOWN, INVALID_ARGUMENT, DEADLINE_EXCEEDED, NOT_FOUND, ALREADY_EXISTS, PERMISSION_DENIED, RESOURCE_EXHAUSTED, FAILED_PRECONDITION, ABORTED, OUT_OF_RANGE, UNIMPLEMENTED, INTERNAL, UNAVAILABLE, DATA_LOSS, UNAUTHENTICATED.

Return: `status.Errorf(codes.NotFound, "user not found: %v", id)`.

Client: `st, ok := status.FromError(err)`, check: `st.Code() == codes.NotFound`.

Details: attach metadata, `st.WithDetails(&errdetails.BadRequest{...})`.

Retry: client-side retry on UNAVAILABLE, DEADLINE_EXCEEDED, exponential backoff.

Interceptors: server-side error logging, transform errors.

Use case: rich error info, typed errors, better than HTTP status codes.

Standards: google.rpc.Status, google.rpc.ErrorInfo.

### Category 14: Cloud Concepts & Architecture (15 concepts)

### 219. Cloud Service Models

IaaS, PaaS, SaaS.

IaaS (Infrastructure as a Service): VMs, networking, storage, OS control, examples: EC2, Azure VMs, GCE, use case: full control, lift-and-shift.

PaaS (Platform as a Service): deploy code, platform manages infrastructure, examples: Heroku, App Service, Cloud Run, use case: faster development, less ops overhead.

SaaS (Software as a Service): ready-to-use applications, examples: Gmail, Salesforce, GitHub, use case: end users, no infrastructure management.

FaaS (Functions as a Service): serverless functions, examples: Lambda, Cloud Functions, use case: event-driven, pay-per-execution.

CaaS (Containers as a Service): managed container orchestration, examples: ECS, AKS, GKE.

Shared responsibility: IaaS (you manage OS+), PaaS (you manage app+), SaaS (provider manages all).

### 220. Cloud Deployment Models

Public, private, hybrid, multi-cloud.

Public cloud: shared infrastructure, AWS, Azure, GCP, cost-effective, scalable, less control.

Private cloud: dedicated infrastructure, on-premises or hosted, full control, higher cost, use case: compliance, sensitive data.

Hybrid cloud: combines public + private, workloads span both, use case: burst to public, keep data private.

Multi-cloud: multiple public clouds (AWS + Azure), avoid lock-in, complexity, use case: best-of-breed services, disaster recovery.

Community cloud: shared by organizations, use case: industry-specific (healthcare, finance).

Edge: compute near users, CDN, IoT gateways.

### 221. Cloud Regions & Availability Zones

Geographic distribution.

Region: geographic area, multiple datacenters, e.g., us-east-1, eu-west-1, isolated, low latency within region.

Availability Zone (AZ): isolated datacenter within region, separate power/network, redundancy, deploy across AZs for HA.

Multi-region: deploy across regions, disaster recovery, compliance (data residency), higher cost, latency.

Choosing region: latency (close to users), cost (varies by region), compliance (GDPR), service availability (not all services in all regions).

Networking: inter-AZ fast + free (AWS), inter-region slower + paid.

Use case: HA (multi-AZ), DR (multi-region), global apps (multi-region with traffic routing).

### 222. Cloud Pricing Models

Understand costs.

On-demand: pay per hour/second, no commitment, flexible, highest cost.

Reserved: commit 1-3 years, 30-75% discount, upfront payment options, use for steady workloads.

Spot/Preemptible: bid on spare capacity, up to 90% discount, can be interrupted, use for fault-tolerant workloads.

Savings Plans: flexible commitment (compute spend), apply across instance types/regions.

Free tier: limited usage free (12 months or always), use for testing, small workloads.

Data transfer: free inbound, paid outbound (egress), inter-region.

Operations: API calls, snapshots, load balancers.

Optimize: right-size, auto-scale, use spot, reserved for base load, monitor unused resources.

### 223. Cloud Resource Tagging

Organize and track resources.

Tags: key-value pairs, `Environment: production`, `Team: platform`, `CostCenter: eng-1234`.

Use cases: cost allocation, automation (tag-based policies), search/filter, access control.

Standards: naming conventions (CamelCase, lowercase, etc.), required tags (owner, environment, project).

Enforcement: policies require tags on creation (AWS Tag Policy, Azure Policy).

Cost tracking: tag-based cost reports, showback/chargeback.

Automation: auto-tag on creation (CloudFormation tags, Terraform default_tags).

Limits: max 50 tags (AWS), max key/value length.

Best practices: consistent naming, automate, audit compliance.

### 224. Cloud IAM Basics

Identity and access management.

Principals: users, groups, roles, service accounts.

Policies: JSON document, effect (allow/deny), actions (service:operation), resources (ARN/ID), conditions.

RBAC: role-based access control, assign roles to users/groups.

Principle of least privilege: grant minimum required permissions.

Root account: full access, secure (MFA), don't use for daily tasks.

Service accounts: for applications, no password, use roles (instance profile in AWS, managed identity in Azure).

Federation: SSO with corporate IdP (SAML, OIDC).

Audit: CloudTrail (AWS), Activity Log (Azure), audit logs (GCP).

### 225. Cloud Networking Basics

VPC fundamentals.

VPC (Virtual Private Cloud): isolated network, CIDR block (e.g., 10.0.0.0/16).

Subnets: subdivide VPC, public (internet gateway route), private (no internet), per-AZ.

Internet Gateway: connect VPC to internet, attached to VPC, route in public subnet.

NAT Gateway/Instance: allow private subnet to access internet (outbound only), for updates, not inbound.

Route tables: control traffic, rules: destination CIDR → target (IGW, NAT, local).

Security groups: stateful firewall, inbound/outbound rules, per-instance.

NACLs: stateless firewall, per-subnet, numbered rules.

Peering: connect VPCs (same/different accounts/regions), non-transitive.

### 226. Cloud Load Balancers

Distribute traffic.

Types: Application Load Balancer (L7, HTTP/HTTPS), Network Load Balancer (L4, TCP/UDP), Classic (legacy).

ALB: path-based routing, host-based, WebSocket, HTTP/2, SSL termination, sticky sessions (cookie).

NLB: ultra-low latency, static IP, preserve client IP, TCP/UDP, millions req/sec.

Cross-zone: distribute across AZs, additional cost.

Health checks: HTTP, TCP, interval, unhealthy threshold.

Target groups: instances, IPs, Lambda.

TLS: terminate at LB, or pass-through.

Use case: ALB for microservices (path routing), NLB for high throughput, low latency.

### 227. Cloud Auto Scaling

Dynamic capacity.

Auto Scaling Group (ASG): min/desired/max capacity, health checks, AZs.

Launch template: AMI, instance type, security groups, user data.

Scaling policies: target tracking (CPU 50%), step (if CPU > 80% add 2), scheduled.

Cooldown: wait period after scaling, prevent flapping.

Lifecycle hooks: custom actions on launch/terminate (drain connections, register in service discovery).

Health checks: EC2 (instance status), ELB (application health), replace unhealthy.

Spot instances in ASG: mix spot + on-demand, diversify types.

Kubernetes: Cluster Autoscaler, Karpenter (AWS).

Use case: handle variable load, cost optimization, HA.

### 228. Cloud Storage Types

Object, block, file storage.

Object storage: S3, Azure Blob, GCS, unstructured data, REST API, unlimited scale, metadata, versioning, use case: backups, media, data lakes.

Block storage: EBS, Azure Disk, persistent disks, attached to instances, file system, snapshots, use case: databases, boot volumes.

File storage: EFS, Azure Files, NFS/SMB, shared across instances, concurrent access, use case: home directories, shared data.

Ephemeral: instance store (local SSD), lost on stop, high performance, use case: caches, temporary data.

Archive: Glacier, Azure Archive, low cost, slow retrieval (hours), use case: compliance, long-term backup.

Choose: access pattern, performance, durability, cost.

### 229. Cloud Databases

Managed database services.

Relational: RDS (MySQL, Postgres, etc.), Azure SQL, Cloud SQL, automated backups, patching, Multi-AZ, read replicas.

NoSQL: DynamoDB (key-value), Cosmos DB (multi-model), Firestore (document).

Data warehouse: Redshift, Synapse, BigQuery, columnar, OLAP, petabyte scale.

Cache: ElastiCache (Redis, Memcached), Azure Cache.

In-memory: MemoryDB for Redis.

Graph: Neptune, Cosmos DB (Gremlin).

Time-series: Timestream.

Serverless: Aurora Serverless, Cosmos DB serverless, auto-scale capacity.

Use case: offload management (backups, patches, scaling), focus on application.

### 230. Cloud Monitoring & Logging

Observability services.

Metrics: CloudWatch (AWS), Azure Monitor, Cloud Monitoring (GCP), CPU, memory, disk, custom metrics.

Logs: CloudWatch Logs, Log Analytics, Cloud Logging, centralized, searchable, retention.

Traces: X-Ray (AWS), Application Insights (Azure), Cloud Trace (GCP), distributed tracing.

Dashboards: visualize metrics, create alerts.

Alarms: threshold-based, SNS notifications, auto-scaling triggers.

Log insights: query logs (CloudWatch Insights, KQL), analyze patterns.

Export: S3, SIEM integration.

Cost: pay per metric, log storage, retrieval.

Use case: troubleshooting, performance monitoring, security.

### 231. Cloud Security Best Practices

Secure cloud workloads.

IAM: least privilege, MFA, rotate credentials, no root account usage.

Network: security groups (whitelist IPs), NACLs, private subnets, VPN/PrivateLink.

Encryption: at-rest (S3, EBS default), in-transit (TLS), KMS keys.

Compliance: certifications (SOC 2, HIPAA, PCI-DSS), audit logs.

Secrets: Secrets Manager, Parameter Store, Key Vault, no hardcoded.

Patching: enable auto-patching, use managed services.

Backup: automated backups, test restores, cross-region.

Monitoring: GuardDuty, Security Center, Security Command Center, anomaly detection.

Incident response: playbooks, contact AWS/Azure/GCP support.

### 232. Cloud Cost Optimization

Reduce spending.

Right-sizing: match instance size to usage, use CloudWatch metrics.

Reserved capacity: commit for discounts (RIs, Savings Plans).

Spot instances: use for fault-tolerant workloads.

Auto-scaling: scale down when not needed, scheduled scaling (turn off dev environments).

Storage: lifecycle policies (S3 → Glacier), delete unused snapshots/volumes.

Data transfer: minimize cross-region, use CDN, caching.

Unused resources: idle instances, unattached volumes, old snapshots.

Budgets: set alerts, prevent overruns.

Tools: Cost Explorer, Azure Cost Management, Cloud Billing, third-party (CloudHealth).

Culture: make engineers cost-aware, showback/chargeback.

### 233. Infrastructure as Code Basics

Declarative infrastructure.

Tools: Terraform (multi-cloud), CloudFormation (AWS), ARM templates (Azure), Deployment Manager (GCP).

Benefits: version control, reproducible, automate, review changes (PR), disaster recovery.

State: tracks actual vs desired, lock to prevent concurrent modifications.

Modules: reusable components, parameters, outputs.

Workflow: write → plan (preview changes) → apply (execute).

Drift: manual changes differ from code, detect with tools.

Best practices: modular, DRY, use variables, store state remotely, lock state, CI/CD integration.

Use case: provision infrastructure, consistent environments, multi-region deployments.

### Category 15: AWS Basics I: Compute & Storage (20 concepts)

### 234. EC2 Instance Types

Compute optimized (C6i, C7g), memory optimized (R6i, X2idn), storage optimized (I4i, D3), general purpose (T3, M6i). Burstable: T2/T3 (CPU credits), baseline performance. Graviton: ARM-based (better price/performance). Naming: m6i.xlarge = family (m), generation (6), features (i=Intel), size. Spot: up to 90% discount, interruptible. Reserved: 1-3 year commitment, up to 72% discount. Use case: match workload (CPU, memory, I/O).

### 235. EC2 Launch & User Data

Launch: console, CLI, IaC (Terraform, CloudFormation). AMI: OS image (Amazon Linux, Ubuntu, custom). Instance profile: IAM role for EC2. User data: script runs on first boot, `#!/bin/bash` for setup (install packages, configure). Metadata service: `curl http://169.254.169.254/latest/meta-data/`, IMDSv2 (token-based, more secure). Key pairs: SSH access. Security groups: firewall rules. Tags: organize, cost allocation.

### 236. EBS Volume Types

gp3: general purpose SSD, 3000 IOPS baseline, up to 16000 IOPS, 125-1000 MB/s throughput, cost-effective. gp2: older, burst pool. io2 Block Express: 64000 IOPS, 4000 MB/s, 99.999% durability, multi-attach (16 instances). st1: throughput HDD, big data, 500 MB/s. sc1: cold HDD, archival, cheapest. Snapshots: incremental backups to S3. Encryption: KMS, at-rest. Performance: EBS-optimized instances, provisioned IOPS.

### 237. EBS Snapshots & Lifecycle

Create: `aws ec2 create-snapshot --volume-id`, incremental (only changed blocks), stored in S3. Restore: create volume from snapshot. Copy: across regions (DR). Lifecycle: Data Lifecycle Manager (automate), schedule (daily, weekly), retention. Fast Snapshot Restore: instant restore, extra cost. EBS Direct APIs: read snapshots without volume. Encryption: encrypted snapshots from encrypted volumes. Use case: backups, AMI creation, DR.

### 238. S3 Storage Classes

Standard: frequent access, 11 9s durability, 99.99% availability, low latency. Intelligent-Tiering: auto-move between tiers, no retrieval fees. Standard-IA: infrequent access, 99.9% availability, lower cost, retrieval fee. One Zone-IA: single AZ, 99.5% availability, 20% cheaper than Standard-IA. Glacier Instant: archive, ms retrieval, 68% cheaper. Glacier Flexible: minutes-hours retrieval. Glacier Deep Archive: cheapest, 12h retrieval. Lifecycle policies: transition S3 → IA → Glacier.

### 239. S3 Bucket Operations

Create: `aws s3 mb s3://bucket-name`, globally unique name. Upload: `aws s3 cp file s3://bucket/key`, multipart for large files. List: `aws s3 ls s3://bucket/`. Delete: `aws s3 rm`, versioned buckets need delete marker. Sync: `aws s3 sync local/ s3://bucket/`. Presigned URLs: temporary access, `aws s3 presign`. Access: bucket policy (resource-based), IAM policy (identity-based). Block public access: enabled by default.

### 240. S3 Versioning

Enable: per bucket, keeps all versions of object. Version ID: unique identifier per version. List: `aws s3api list-object-versions`. Get specific: `aws s3api get-object --version-id`. Delete: creates delete marker (soft delete), permanent delete needs version ID. MFA Delete: require MFA for permanent deletion. Use case: protect against accidental deletion, rollback, compliance. Cost: storage for all versions.

### 241. S3 Lifecycle Policies

Automate transitions and expiration. Rules: prefix-based or tag-based. Transitions: Standard → IA (30 days), IA → Glacier (90 days), Glacier → Deep Archive (180 days). Expiration: delete after N days, delete incomplete multipart uploads. Current vs previous versions: separate rules. Filter: by prefix, tags, object size. Cost optimization: move old data to cheaper tiers. Example: logs to Glacier after 90 days, delete after 365 days.

### 242. S3 Replication

Cross-Region Replication (CRR): disaster recovery, compliance, low latency. Same-Region Replication (SRR): aggregate logs, dev/prod separation. Requirements: versioning enabled on both buckets, IAM role. Replication Time Control (RTC): 15 min SLA. What's replicated: new objects by default, existing objects with batch replication. Not replicated: delete markers (unless configured), system metadata. Use case: DR, compliance, reduce latency.

### 243. S3 Security

Encryption at-rest: SSE-S3 (S3-managed keys, AES-256), SSE-KMS (AWS KMS keys, audit), SSE-C (customer keys). In-transit: HTTPS/TLS. Bucket policy: JSON, allow/deny by principal, IP, VPC endpoint. ACLs: legacy, avoid. Block public access: account/bucket level. Object Lock: WORM (write once read many), legal hold, retention. Versioning + MFA Delete: protect against deletion. Access points: simplify permissions. Macie: detect sensitive data (PII).

### 244. S3 Performance Optimization

Prefix: 3500 PUT/COPY/POST/DELETE, 5500 GET/HEAD per prefix per second, use multiple prefixes. Multipart upload: files >100MB, parallel, resume, `aws s3api create-multipart-upload`. Transfer Acceleration: CloudFront edge locations, faster long-distance uploads. Byte-range fetches: partial downloads, parallel. S3 Select: filter with SQL, reduce data transfer. Caching: CloudFront, ElastiCache. Compression: reduce size. Use case: high-throughput applications.

### 245. EC2 Storage Options

EBS: persistent, network-attached, snapshots, 1:1 with instance (multi-attach for io2). Instance Store: ephemeral, physically attached, lost on stop, high IOPS, no cost. EFS: shared NFS, multi-AZ, concurrent access, expensive. S3: object storage, unlimited, API access. FSx: managed file systems (Lustre, Windows, NetApp). Choose: EBS for DB, instance store for cache, EFS for shared, S3 for unstructured.

### 246. AMI (Amazon Machine Image)

Template for EC2: OS, software, config. Types: Amazon Linux, community, marketplace, custom. Create: from running instance, `aws ec2 create-image`, creates EBS snapshots. Copy: across regions. Share: public, specific accounts, marketplace. Launch permissions: private, public, explicit. Deregister: delete AMI. Use case: golden images, rapid deployment, disaster recovery. Best practice: automate with Packer, version, test.

### 247. EC2 Placement Groups

Cluster: low latency (10 Gbps), same AZ, same hardware rack, use case: HPC, tightly-coupled workloads. Spread: distribute across hardware, max 7 instances per AZ per group, use case: critical instances, HA. Partition: divide into partitions (separate racks), up to 7 partitions per AZ, use case: distributed systems (Hadoop, Cassandra). Limitations: some instance types not supported, can't merge groups.

### 248. EC2 Hibernate

Save RAM to EBS, fast startup. Hibernation: OS freeze, RAM → EBS root volume, stop instance, start resumes from RAM. Requirements: root volume encrypted, instance RAM <150 GB, supported instance types. Use case: long-running processes, avoid slow startup, save state. Limit: 60 days max hibernation. Comparison: stop (terminates, launches new), hibernate (resume state).

### 249. EC2 Networking

ENI (Elastic Network Interface): virtual network card, primary private IP, secondary IPs, elastic IP, security groups, MAC address. Multiple ENIs: different subnets, licensing, HA (move ENI). ENA (Elastic Network Adapter): enhanced networking, 100 Gbps, SR-IOV. EFA (Elastic Fabric Adapter): HPC, low latency, OS-bypass. Placement: cluster for low latency. MTU: jumbo frames (9001). Public IPv4: elastic IP (static), public IP (dynamic).

### 250. S3 Event Notifications

Trigger on object events: s3:ObjectCreated, s3:ObjectRemoved, s3:ObjectRestore. Destinations: SNS, SQS, Lambda. Filter: prefix, suffix (e.g., .jpg). Use case: process uploads (Lambda), fan-out (SNS → multiple SQS), pipeline triggers. Configuration: bucket properties, notification configuration. EventBridge: advanced routing, multiple targets, filtering. Example: resize image on upload, move to Glacier on delete.

### 251. S3 Batch Operations

Perform bulk operations on billions of objects. Operations: copy, tag, ACL, restore from Glacier, invoke Lambda. Manifest: S3 inventory or CSV list. Tracking: completion report, failed objects. Retry: automatic. Use case: encrypt unencrypted objects, copy to another bucket, tag for lifecycle. Example: copy all objects from us-east-1 to eu-west-1.

### 252. S3 Static Website Hosting

Host static content (HTML, CSS, JS, images). Enable: bucket properties, index document, error document. URL: `http://bucket-name.s3-website-region.amazonaws.com`. Public access: bucket policy allow GetObject. Custom domain: Route 53 alias record. HTTPS: use CloudFront (S3 website endpoint doesn't support HTTPS). Use case: blogs, SPAs (React, Vue), documentation. Redirect: 301/302 for www → non-www.

### 253. EC2 Auto Scaling

Dynamic capacity based on demand. ASG (Auto Scaling Group): min, desired, max instances. Launch template: AMI, instance type, security groups, user data. Scaling policies: target tracking (CPU 50%), step (add 2 if CPU >80%), simple, scheduled. Health checks: EC2 (instance status), ELB (application health). Termination: oldest instance, closest to billing hour, or configured. Lifecycle hooks: custom actions (drain connections). Suspend processes: troubleshooting.

### Category 16: AWS Basics II: Networking & IAM (20 concepts)

### 254. VPC Fundamentals

Virtual Private Cloud: isolated network, CIDR block (e.g., 10.0.0.0/16). Subnets: subdivide VPC, per-AZ, public (IGW route), private (no internet). Route table: control traffic, rules: destination → target. Internet Gateway: connect to internet, 1 per VPC. Main route table: default for subnets. Best practice: multiple AZs, public/private subnets, reserve IP space. Default VPC: pre-created, public subnets, easy start. Use case: network isolation, hybrid cloud.

### 255. VPC Subnets & Routing

Subnet: range of IPs in VPC, tied to AZ. Public subnet: route to IGW (0.0.0.0/0 → igw-xxx). Private subnet: no IGW route, use NAT for outbound. Route table: explicit association or main. Local route: VPC CIDR (automatic). Custom routes: peering, VPN, transit gateway. CIDR: /24 = 256 IPs (AWS reserves 5: network, router, DNS, future, broadcast). Subnet sizing: plan for growth, /24 for most, /20 for large. Use case: separate tiers (web, app, db).

### 256. Security Groups

Stateful firewall per ENI: track connections, return traffic auto-allowed. Rules: allow only (no deny), inbound + outbound. Source/dest: CIDR, security group ID, prefix list. Default: all outbound, no inbound. Multiple: up to 5 per ENI, evaluated together. Best practices: least privilege, separate groups per tier, reference other SGs. Example: app SG allows from web SG on port 8080. Use case: instance-level firewall, microsegmentation.

### 257. Network ACLs

Stateless firewall per subnet: rules for inbound + outbound separately. Rule number: 1-32766, evaluated in order, first match wins. Allow + deny rules: unlike SGs. Default NACL: allow all. Custom NACL: deny all by default. Ephemeral ports: 1024-65535 for return traffic. Use case: subnet-level protection, block specific IPs. Comparison: SGs for common use, NACLs for additional layer. Best practice: keep simple, increment rules by 10 or 100.

### 258. NAT Gateway & NAT Instance

NAT Gateway: managed service, per AZ, high availability, 45 Gbps, auto-scale, elastic IP. NAT Instance: EC2 instance, manage yourself, cheaper, limited throughput, single point of failure. Setup: in public subnet, route 0.0.0.0/0 from private subnet to NAT. Bandwidth: NAT Gateway scales, NAT Instance limited by instance type. HA: NAT Gateway per AZ, NAT Instance + ASG. Cost: NAT Gateway charged per hour + data processed. Use case: private instances access internet (updates, APIs), not internet → private.

### 259. VPC Peering

Connect 2 VPCs: same/different account/region. Non-transitive: if A↔B and B↔C, A cannot reach C. Route tables: add routes for peered CIDR. CIDR: must not overlap. Limitations: no transitive routing, no edge-to-edge (VPN/IGW). Security groups: reference peered SG (same region). Use case: shared services VPC, multi-account architecture. Alternative: Transit Gateway for hub-spoke.

### 260. VPC Endpoints

Private connection to AWS services without internet. Interface endpoint (PrivateLink): ENI with private IP, powered by PrivateLink, charged per hour + data. Gateway endpoint: route table target, free, only S3 and DynamoDB. Use case: access S3/DynamoDB from private subnet without NAT, comply with regulations (data doesn't traverse internet). Example: VPC endpoint for S3, ec2 in private subnet accesses S3 directly. Security: VPC endpoint policy.

### 261. Elastic IP

Static public IPv4 address. Allocate: from AWS pool, associated with account. Associate: to instance or ENI. Remap: move to another instance (failover). Charge: free when associated, charged when not (to discourage hoarding). Limit: 5 per region (can request increase). Release: when done. Use case: static IP for web server, HA (remap on failure), mask instance replacement. Alternative: NLB with static IP, Elastic IP for NAT Gateway.

### 262. VPC Flow Logs

Capture IP traffic metadata (not content): src, dst, ports, protocol, packets, bytes, action (accept/reject). Levels: VPC, subnet, ENI. Destination: S3, CloudWatch Logs, Kinesis Data Firehose. Fields: version, account, eni, src, dst, srcport, dstport, protocol, packets, bytes, start, end, action, log-status. Use case: troubleshoot connectivity, security analysis, compliance. Athena: query S3 logs. Limitations: doesn't capture DNS to Route 53, Windows license activation.

### 263. Route 53 Basics

DNS service: domain registration, hosted zones, health checks. Hosted zone: container for records, public (internet) or private (VPC). Records: A (IPv4), AAAA (IPv6), CNAME (alias domain), ALIAS (AWS resource, better than CNAME), MX (mail), TXT (verification). TTL: cache duration. Query: Route 53 → authoritative answer. Use case: register domain, route traffic, alias to CloudFront/ALB/S3. Pricing: per hosted zone + queries.

### 264. Route 53 Routing Policies

Simple: single resource, no health check. Weighted: split traffic by percentage, A/B testing, gradual migration. Latency: route to lowest latency region, measure from user. Failover: active-passive, health check on primary. Geolocation: by user location (country, continent), localization, compliance. Geoproximity: by proximity + bias, use traffic flow. Multivalue: multiple IPs, client-side load balancing, health checks. Use case: DR (failover), global app (latency), testing (weighted).

### 265. Elastic Load Balancer Types

Application Load Balancer (ALB): L7, HTTP/HTTPS, path-based routing (/api → backend1), host-based (api.example.com → backend2), query params, WebSocket, HTTP/2, target: instances, IPs, Lambda. Network Load Balancer (NLB): L4, TCP/UDP/TLS, ultra-low latency (<100ms), static IP, preserve source IP, millions req/sec, target: instances, IPs, ALB. Classic Load Balancer (CLB): legacy, L4+L7. Gateway Load Balancer: L3, transparent network gateway, firewall/IDS/IPS appliances.

### 266. ALB Features

Target groups: route to group of targets (instances, IPs, Lambda), health checks per group. Rules: conditions (path, host, header, query) → actions (forward, redirect, fixed response). Sticky sessions: cookie-based, duration 1s-7d. SSL/TLS: terminate at ALB, certificates from ACM, SNI for multiple domains. HTTP/2: enabled by default. WebSocket: supported. Authentication: OIDC, Cognito. IP address: changes (use DNS), use NLB for static IP. Use case: microservices, container-based apps.

### 267. NLB Features

TCP/UDP: L4 load balancing, preserve source IP (Target sees actual client IP, not LB). Static IP: 1 per AZ, elastic IP support. Cross-zone: distribute across AZs (disabled by default, cost). TLS termination: offload TLS, certificate from ACM. Proxy Protocol: add client connection info header (v2). Use case: extreme performance, TCP/UDP apps, static IP requirement, millions req/sec. Limitations: no path-based routing, no HTTP headers inspection.

### 268. ELB Health Checks

Monitor target health. Interval: 5-300 seconds. Healthy threshold: consecutive successes (default 3). Unhealthy threshold: consecutive failures (default 3). Timeout: 2-120 seconds. Protocol: HTTP, HTTPS, TCP, gRPC. Path: for HTTP/HTTPS, status code 200 or range. Drain: connection draining, deregistering target serves existing requests. ALB: target group health. NLB: TCP handshake or HTTP. Use case: automatic failover, avoid sending traffic to unhealthy targets.

### 269. IAM Users & Groups

Users: identity for person or application, long-term credentials (password, access keys). Groups: collection of users, attach policies to group. Root user: full access, email-based, enable MFA, don't use for daily tasks. Access keys: programmatic access (CLI, SDK), access key ID + secret. Best practice: use groups for permissions, no inline policies, rotate credentials, principle of least privilege. MFA: virtual (Google Authenticator), hardware (YubiKey), SMS (deprecated). User tags: metadata, cost allocation.

### 270. IAM Policies Deep Dive

JSON document: Version, Statement. Statement: Effect (Allow/Deny), Action (service:operation, e.g., s3:GetObject), Resource (ARN), Condition (when to apply, IP, MFA, time). Types: identity-based (attached to user/group/role), resource-based (S3 bucket policy). Evaluation: explicit Deny > explicit Allow > default Deny. Policy types: AWS managed (maintained by AWS), customer managed (you maintain), inline (embedded, discouraged). Variables: ${aws:username}, ${aws:sourceIp}. Conditions: StringEquals, DateGreaterThan, IpAddress, MFA.

### 271. IAM Roles

Temporary credentials for entities. AssumeRole: STS returns temp credentials (access key, secret, token), valid 15min-12h. Trust policy: who can assume (principal). Use cases: EC2 instance profile (role for instances), cross-account access, federated access (SAML, OIDC), AWS services (Lambda execution role). No long-term credentials: more secure than access keys. Best practice: use roles for applications, not access keys. Role chaining: assume role A, then assume role B (max 1h session). Service-linked roles: AWS service-specific, can't modify trust policy.

### 272. IAM Policy Conditions

Fine-grained control. Operators: StringEquals, StringLike, DateGreaterThan, DateLessThan, IpAddress, NotIpAddress, Bool, NumericEquals, ArnEquals, etc. Condition keys: aws:SourceIp (request IP), aws:MultiFactorAuthPresent (MFA used), aws:CurrentTime (request time), s3:prefix (S3 folder), ec2:InstanceType, etc. Example: allow S3 access only from corporate IP, require MFA for delete operations, allow EC2 launch only t3.micro. Multi-condition: all must match. Use case: security, compliance, cost control.

### 273. IAM Best Practices

Root account: enable MFA, don't use for daily tasks, no access keys. Users: one per person/app, strong password policy, enable MFA, rotate credentials, delete unused. Groups: assign permissions to groups, not users directly. Roles: for applications (EC2, Lambda), cross-account, federation. Policies: least privilege, AWS managed for common tasks, customer managed for specific, no inline. Access keys: rotate 90 days, delete unused, use roles when possible. Audit: CloudTrail logs, IAM credential report, Access Analyzer. Separate accounts: dev, staging, prod.

### Category 17: AWS Intermediate: Services & Integration (20 concepts)

### 274. Lambda Fundamentals

Serverless compute: run code without servers. Trigger: API Gateway, S3, DynamoDB, EventBridge, SQS, SNS, etc. Code: ZIP or container image, runtime (Node.js, Python, Java, Go, .NET, Ruby, custom). Handler: entry point, `exports.handler = async (event) => {}`. Execution role: IAM permissions. Environment vars: config. Layers: shared code/dependencies. Memory: 128MB-10GB (CPU scales with memory). Timeout: max 15 min. Concurrency: 1000 per region (unreserved), reserved for critical. Cold start: first invocation delay.

### 275. Lambda Execution Model

Event-driven: synchronous (API Gateway, ALB, wait for response), asynchronous (S3, SNS, retry on error), stream (Kinesis, DynamoDB Streams, batch). Execution context: reused for subsequent invocations, init code runs once. VPC: access private resources, adds latency (Hyperplane reduces it). File system: /tmp (512MB-10GB), ephemeral. Layers: up to 5, share code (libraries, config). Destinations: success/failure routing (SQS, SNS, EventBridge, Lambda). Error handling: retry async 2 times, DLQ for failed. Batch size: for stream sources.

### 276. Lambda Performance Optimization

Memory: affects CPU, 1769MB = 1 vCPU, test optimal size (cost vs performance). Provisioned concurrency: pre-warmed instances, no cold start, charged per hour. SnapStart (Java): restore from snapshot, reduce cold start 90%. Package size: smaller = faster cold start, remove unused deps, use layers. VPC: Hyperplane (2019+) reduces init time, pre-2019 slow. ARM Graviton2: 34% better price/performance. Async: don't wait for response, use async invocation. Power tuning: open-source tool finds optimal memory. Monitoring: X-Ray, CloudWatch Logs Insights.

### 277. API Gateway REST API

Managed API service: create, deploy, maintain APIs. REST API: resource-based (/users/{id}), methods (GET, POST), integrations (Lambda, HTTP, AWS service, Mock). Stages: dev, staging, prod, separate deployments, stage variables. Deployment: create deployment to stage. Throttling: 10000 req/sec, burst 5000. Caching: TTL 300s default, per stage. CORS: enable for cross-origin. Auth: API key, Lambda authorizer, Cognito, IAM. Usage plans: rate limits, quotas per API key. Models: request/response validation. Use case: serverless APIs, microservices.

### 278. API Gateway HTTP API

Simpler, cheaper, faster than REST API. Features: Lambda, HTTP integration, OIDC/JWT auth, CORS. Pricing: 70% cheaper. Use case: simple APIs, no caching/models/usage plans. Migration: REST → HTTP API if features not needed. Limitations: no API key, no request validation, no usage plans, no caching. When to use: cost-sensitive, simple Lambda proxies. Comparison: REST for full features, HTTP for simple + cheap.

### 279. DynamoDB Basics

NoSQL: key-value, document, serverless, single-digit ms latency. Table: collection of items, item: collection of attributes. Primary key: partition key (hash key), optional sort key (range key), uniquely identifies item. Partition key: determines storage partition, high cardinality, even distribution. Query: by primary key, efficient. Scan: full table, slow, avoid. Attributes: flexible schema, nested objects. Data types: scalar (string, number, binary, boolean, null), set (string set, number set, binary set), document (list, map). Max item size: 400KB.

### 280. DynamoDB Capacity Modes

On-demand: pay per request, unpredictable workload, auto-scale. Provisioned: specify RCU (read), WCU (write), 50% cheaper, predictable workload, auto-scaling available. RCU: 1 strongly consistent 4KB read/sec, 2 eventually consistent. WCU: 1 write 1KB/sec. Burst: unused capacity accumulates (5 min), handle spikes. Throttling: ProvisionedThroughputExceededException, retry with exponential backoff. Switch: on-demand ↔ provisioned once per 24h. Use case: on-demand for spiky, provisioned for steady.

### 281. DynamoDB Indexes

Primary key: partition key + optional sort key. Local Secondary Index (LSI): same partition key, different sort key, created at table creation, 5 max, shares RCU/WCU with table. Global Secondary Index (GSI): different partition + sort key, created anytime, 20 max, separate RCU/WCU. Query: on GSI like table. Projection: keys only, include (specific attributes), all. Use case: query by non-primary key attributes. Example: table PK=UserID, GSI PK=Email (query by email). Cost: storage + RCU/WCU for GSI.

### 282. DynamoDB Streams

Change data capture: real-time stream of item changes (insert, update, delete). Record: keys + old/new images. Use case: trigger Lambda, replicate to another table/region, analytics, audit. View type: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES. Lambda trigger: polls stream, batch processing. Kinesis Data Streams: alternative, 1 year retention (Streams 24h). Shard: partition of stream, auto-managed. Best practice: idempotent Lambda, handle duplicates.

### 283. SNS (Simple Notification Service)

Pub/sub messaging: push. Topic: channel for messages. Publisher: send message to topic. Subscriber: receive from topic (SQS, Lambda, HTTP/S, Email, SMS). Fan-out: 1 publisher, N subscribers. Message: up to 256KB, attributes (metadata), filtering. FIFO: ordered, exactly-once, throughput 300 msg/sec (batching 3000). Standard: best-effort ordering, at-least-once. Use case: fan-out to multiple services, alerts, notifications. Message filtering: filter policy on subscription.

### 284. SQS (Simple Queue Service)

Message queue: decoupling. Standard: at-least-once delivery, best-effort ordering, unlimited throughput. FIFO: exactly-once, ordered, 300 msg/sec (3000 with batching). Message: up to 256KB, larger use S3. Retention: 4 days (default), 14 days max. Visibility timeout: message hidden after receive, delete or it reappears. Long polling: wait up to 20s for message, reduce costs. Dead-letter queue: failed messages after max receives. Delay: up to 15 min. Use case: async processing, decouple services, buffer.

### 285. EventBridge (CloudWatch Events)

Serverless event bus: route events to targets. Event sources: AWS services (EC2 state change, S3 upload), custom apps, SaaS (Shopify, Zendesk). Rules: event pattern (match fields) or schedule (cron). Targets: Lambda, Step Functions, SQS, SNS, Kinesis, etc. (14+). Schema registry: discover event schemas. Archive/replay: debug, testing. Cross-account: send events to other accounts. Use case: event-driven architectures, automate workflows. Example: EC2 stopped → SNS alert.

### 286. Step Functions

Serverless orchestration: coordinate AWS services. State machine: JSON/ASL, states (Task, Choice, Parallel, Wait, Succeed, Fail, Pass). Task: Lambda, ECS, Batch, DynamoDB, SNS, SQS, etc. Choice: conditional branching. Parallel: run in parallel. Wait: delay. Standard: up to 1 year, exactly-once, audit. Express: up to 5 min, at-least-once, high-rate (100k/sec), cheaper. Use case: workflows, long-running processes, orchestrate microservices, ETL. Visual workflow: ASL visual editor.

### 287. CloudWatch Metrics

Monitor AWS resources: time-series data. Namespace: container for metrics (AWS/EC2, custom). Metric: data points (CPUUtilization, RequestCount). Dimension: name/value pair (InstanceId=i-123). Resolution: standard (60s), high (1s). Statistics: sum, avg, min, max, sample count, percentiles. Custom metrics: `put-metric-data` API. Alarms: threshold-based, trigger actions (SNS, Auto Scaling, EC2). Dashboards: visualize. Anomaly detection: ML-based. Use case: performance monitoring, auto-scaling, alerting.

### 288. CloudWatch Logs

Centralized logging. Log groups: container for streams (e.g., /aws/lambda/function-name). Log streams: sequence of events (e.g., per Lambda execution). Retention: 1 day to never. Insights: query language (SQL-like), `fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 20`. Metric filters: extract metrics from logs. Subscriptions: stream to Lambda, Kinesis, OpenSearch. Export: S3, Kinesis Data Firehose. Live Tail: real-time. Use case: application logs, debugging, monitoring.

### 289. CloudWatch Alarms

Threshold-based alerting. Metric alarm: compare metric to threshold. Composite alarm: combine multiple alarms (AND, OR). States: OK, ALARM, INSUFFICIENT_DATA. Actions: SNS, Auto Scaling, EC2 (stop, terminate, reboot, recover), Systems Manager. Evaluation: datapoints to alarm (M of N periods). Missing data: treat as missing, breaching, not breaching, ignore. Anomaly detection: dynamic thresholds. Use case: alert on high CPU, scale on request count, recover instance. Best practice: use composite for complex conditions.

### 290. X-Ray

Distributed tracing: trace requests across services. Segment: work done by service. Subsegment: more granular (API call, DB query). Trace ID: unique per request, propagated via headers. Service map: visualize architecture, latencies. Annotations: indexed for filtering. Metadata: not indexed. Sampling: reduce volume (e.g., 1% of requests). Daemon: runs on EC2/ECS/Lambda, sends traces. SDK: instrument code. Use case: debug performance, find bottlenecks, understand dependencies. Example: API Gateway → Lambda → DynamoDB (see latency of each).

### 291. Systems Manager Parameter Store

Centralized config and secrets: hierarchical, versioning, encryption (KMS). Types: String, StringList, SecureString (encrypted). Standard: free, 10k params, 4KB size. Advanced: charged, 100k params, 8KB size. Hierarchy: /dev/db/password, /prod/db/password. Policies: TTL (expiration), notifications. GetParameter API: SecureString auto-decrypts with KMS. Use case: config for EC2, Lambda, containers, secrets (DB password, API key). Comparison: Secrets Manager (rotation, RDS integration, more expensive), Parameter Store (simpler, cheaper).

### 292. Secrets Manager

Manage secrets: auto-rotation, integration. Secret: password, API key, DB credentials. Rotation: Lambda function, schedule (30 days), automatic for RDS. Encryption: KMS. Versioning: previous versions retrievable. Resource policy: who can access. Replicate: multi-region. Cost: $0.40/secret/month + API calls. Use case: RDS credentials (auto-rotation), external APIs, compliance. Comparison: Parameter Store cheaper for static secrets, Secrets Manager for rotation. Example: rotate RDS password every 30 days without downtime.

### 293. CloudFormation Basics

Infrastructure as Code: declarative JSON/YAML. Template: define resources (EC2, S3, RDS), parameters (input), outputs (export), mappings (conditionals). Stack: deployed resources, create/update/delete. Change set: preview changes before apply. Stack policies: prevent accidental updates. Nested stacks: modular, reuse. StackSets: deploy to multiple accounts/regions. Drift detection: detect manual changes. Rollback: auto on failure. Use case: reproducible infrastructure, disaster recovery, multi-region. Best practice: version control, modules, parameters, conditions.

### Category 18: Azure Basics: Core Services (18 concepts)

### 294. Azure Virtual Machines

Compute service: Windows/Linux VMs. Series: B (burstable, dev/test), D (general purpose), E (memory optimized), F (compute optimized), N (GPU). Sizes: v3, v4, v5 generations. Pricing: pay-as-you-go, reserved (1-3 years, up to 72% savings), spot (up to 90% off, evictable). Availability: Availability Sets (fault/update domains, 99.95% SLA), Availability Zones (separate datacenters, 99.99% SLA). Managed Disks: OS disk, data disks. Networking: VNet, NIC, NSG, public IP. Scale Sets: auto-scaling groups. Extensions: custom scripts, diagnostics. CLI: `az vm create`, `az vm start`, `az vmss` for scale sets.

### 295. Azure Storage Accounts

Scalable object storage. Services: Blob (objects), File (SMB shares), Queue (messaging), Table (NoSQL). Blob types: Block (files, media), Append (logs), Page (VHD disks). Performance: Standard (HDD), Premium (SSD). Redundancy: LRS (local 3 copies), ZRS (3 zones), GRS (geo-replicated), GZRS (geo + zone). Access tiers: Hot (frequent access), Cool (30 days, cheaper storage), Archive (180 days, lowest cost, retrieval latency). Security: encryption at rest (default), SAS tokens, RBAC, firewall, private endpoints. Lifecycle management: auto-tier, delete old blobs. CLI: `az storage account create`, `az storage blob upload`.

### 296. Azure Virtual Network (VNet)

Private network in Azure. Address space: CIDR blocks (10.0.0.0/16). Subnets: segment VNet (10.0.1.0/24, 10.0.2.0/24). No NAT between subnets. Peering: connect VNets (same region or global), non-transitive by default. VPN Gateway: site-to-site (on-prem), point-to-site (client VPN). ExpressRoute: dedicated connection (not internet), SLA. Service Endpoints: direct route to Azure services (Storage, SQL). Private Link: private IP for Azure services. NSG: subnet/NIC level firewall. Route Tables: custom routing. CLI: `az network vnet create`, `az network vnet peering create`.

### 297. Azure Network Security Groups (NSG)

Firewall for VNet. Rules: priority (100-4096, lower = higher priority), allow/deny, inbound/outbound, protocol (TCP/UDP/any), source/dest (IP/CIDR/service tag/ASG), port range. Default rules: allow VNet traffic, allow Azure Load Balancer, deny internet inbound. Service tags: Internet, VirtualNetwork, AzureLoadBalancer, Storage, Sql. Application Security Groups (ASG): group VMs, use in NSG rules (instead of IPs). Attach to: subnet (all resources), NIC (specific VM). Effective rules: `az network nic show-effective-nsg`. Logging: NSG flow logs (to Storage, analyze with Traffic Analytics). Best practice: least privilege, document rules.

### 298. Azure App Service

PaaS for web apps. Supports: .NET, Java, Node.js, Python, PHP, Docker containers. App Service Plan: pricing tier (Free, Shared, Basic, Standard, Premium, Isolated), defines CPU/memory/features. Scaling: scale up (bigger plan), scale out (more instances, auto-scale rules). Deployment: Git, GitHub Actions, Azure DevOps, FTP, ZIP deploy, Docker. Deployment slots: staging environments, swap (zero downtime), traffic splitting (A/B test). Custom domains: map domain, SSL certificates (free with App Service Certificate). Monitoring: App Insights, logs. CLI: `az webapp create`, `az webapp deployment slot create`, `az webapp up`.

### 299. Azure Kubernetes Service (AKS)

Managed Kubernetes. Cluster: control plane (free), worker nodes (VMs, you pay). Node pools: multiple node types (CPU, GPU, spot instances), can add/remove. Networking: kubenet (basic), Azure CNI (advanced, VNet integration). Upgrades: control plane, node pools (separate). RBAC: Azure AD integration. Monitoring: Azure Monitor for Containers, Prometheus. Scaling: HPA, cluster autoscaler. Security: network policies, Azure Policy, secret management (Key Vault integration). CLI: `az aks create`, `az aks get-credentials`, `az aks scale`. Best practice: separate node pools for system/user workloads, enable monitoring, use managed identities.

### 300. Azure SQL Database

Managed relational DB (SQL Server). Deployment: single database, elastic pool (share resources). Service tiers: General Purpose (balanced), Business Critical (high performance, read replicas), Hyperscale (100TB+). Compute: provisioned (DTU or vCore models), serverless (auto-pause, pay per use). Backup: automatic, 7-35 days retention, long-term retention (up to 10 years). Geo-replication: active (readable secondaries), failover groups (automatic failover). Security: firewall, VNet rules, encryption (TDE), Always Encrypted, auditing. Scaling: vertical (change tier), horizontal (read replicas). CLI: `az sql server create`, `az sql db create`.

### 301. Azure Active Directory (Azure AD)

Identity service. Users: cloud-only, synced from on-prem (AD Connect). Groups: security (permissions), Microsoft 365 (collaboration). RBAC: assign roles (Owner, Contributor, Reader, custom) to users/groups/service principals. Service principals: app identity. Managed identities: system-assigned (lifecycle tied to resource), user-assigned (shared). Conditional Access: policies (MFA, location, device compliance). B2B: invite external users. B2C: customer identity. Single Sign-On (SSO): SAML, OAuth, OpenID Connect. CLI: `az ad user create`, `az role assignment create`. Use case: all Azure authentication, RBAC for resource access.

### 302. Azure Resource Groups

Logical container for resources. All resources must be in a resource group. Lifecycle: delete RG → delete all resources. RBAC: assign permissions at RG level (inherited by resources). Tags: metadata (environment:prod, cost-center:IT), used for billing, automation. Locks: CanNotDelete (prevent deletion), ReadOnly (prevent changes). Region: RG has location (metadata), resources can be in different regions. Best practice: organize by lifecycle (delete together), environment, project. CLI: `az group create`, `az group delete`, `az group lock create`. Deploy: ARM templates, Bicep, Terraform target RG.

### 303. Azure Load Balancer

Layer 4 load balancer. SKUs: Basic (free, limited features), Standard (production, SLA, availability zones). Types: public (internet-facing), internal (private IP). Frontend IP: public IP or private IP. Backend pool: VMs, scale sets. Health probes: TCP, HTTP (check port or path). Load balancing rules: frontend IP+port → backend pool+port, session persistence (None, Client IP, Client IP+protocol). Outbound rules: SNAT for outbound internet. HA ports: all ports (internal LB only). Zones: zone-redundant or zonal frontend. CLI: `az network lb create`, `az network lb rule create`. Use case: distribute traffic to VMs.

### 304. Azure Application Gateway

Layer 7 load balancer / WAF. Features: HTTP/HTTPS, URL-based routing (/api → backend1, /web → backend2), host-based routing, SSL termination, end-to-end SSL, WebSocket, HTTP/2. WAF: protect from OWASP top 10 (SQL injection, XSS), managed rules, custom rules. SKUs: Standard, Standard_v2 (auto-scaling, zone redundancy), WAF, WAF_v2. Components: frontend IP, listeners (port, protocol, SSL cert), routing rules, backend pools (VMs, scale sets, App Service), health probes. Rewrite: modify headers, URL. CLI: `az network application-gateway create`. Use case: web applications, API gateway, micro services.

### 305. Azure Functions

Serverless compute: event-driven, pay per execution. Triggers: HTTP, timer, queue (Storage Queue, Service Bus), blob, Event Grid, Cosmos DB. Bindings: input/output (no SDK needed), declarative. Languages: C#, JavaScript, Python, Java, PowerShell, Go (custom handler). Hosting: Consumption (pay per execution, 5 min timeout), Premium (VNet, unlimited duration, faster cold start), Dedicated (App Service Plan). Durable Functions: stateful workflows, orchestrations. Deployment: ZIP, Docker, CI/CD. Monitoring: App Insights. CLI: `az functionapp create`, `func init`, `func start`. Use case: webhooks, data processing, automation.

### 306. Azure Container Instances (ACI)

Run containers without orchestration. Fast startup (seconds), pay per second. Use case: batch jobs, dev/test, simple apps. Limitations: no auto-scaling, no load balancing (need Application Gateway), ephemeral storage. Container groups: multiple containers (sidecar pattern), share resources, networking (public IP or VNet). Persistent storage: mount Azure Files. Restart policy: Always, OnFailure, Never. CLI: `az container create --image nginx --ports 80 --ip-address Public`. Comparison: AKS for orchestration, ACI for simple containers. Integration: Virtual Kubelet (ACI as K8s nodes, burst workloads).

### 307. Azure DevOps

CI/CD platform. Services: Boards (Agile, work items, sprints), Repos (Git), Pipelines (CI/CD, YAML), Test Plans, Artifacts (package feeds). Pipelines: stages (deploy to dev, test, prod), jobs (parallel), steps (tasks), agents (Microsoft-hosted, self-hosted). Triggers: push, PR, scheduled. Variables: pipeline, secret (from Key Vault). Approvals: manual gate. YAML schema: `trigger`, `pool`, `stages`, `jobs`, `steps`. Deployment: deployment groups (VMs), environments (K8s, approvals). CLI: `az devops`, `az pipelines`. Alternative: GitHub Actions. Integration: any git repo, multi-cloud.

### 308. Azure Monitor

Observability platform. Metrics: CPU, memory, disk, network (auto-collected), custom metrics (App Insights). Logs: Log Analytics workspace (KQL query language), VM logs (agent), container logs (AKS). Alerts: metric alerts, log query alerts, action groups (email, webhook, runbook). Dashboards: visualize metrics/logs. Application Insights: APM for web apps, distributed tracing, dependency map. Workbooks: interactive reports. Diagnostic settings: send logs to Log Analytics, Storage, Event Hub. CLI: `az monitor metrics list`, `az monitor log-analytics query`. Use case: performance monitoring, troubleshooting, alerting.

### 309. Azure Key Vault

Secrets management: passwords, connection strings, API keys. Keys: encryption keys, RSA/EC, hardware-backed (HSM). Certificates: SSL/TLS, auto-renew. RBAC: Azure RBAC (recommended), access policies (legacy). Soft delete: 90 days retention, purge protection. Firewall: VNet rules, private endpoint. Integration: App Service (reference as env vars), AKS (CSI driver), VMs (extensions). Rotation: manual or automated (Event Grid + Function). Backup: managed backups. CLI: `az keyvault create`, `az keyvault secret set`. Use case: never hardcode secrets, central management, audit access.

### 310. Azure Cosmos DB

Multi-model NoSQL: document (MongoDB API), key-value (Table API), graph (Gremlin), columnar (Cassandra). Global distribution: multi-region writes, replication. Consistency: strong, bounded staleness, session, consistent prefix, eventual (tunable). Throughput: provisioned (RU/s, can auto-scale), serverless. Partition key: distribute data, choose wisely (high cardinality, even distribution). Change feed: event stream for changes. TTL: auto-expire documents. Backup: continuous, point-in-time restore. CLI: `az cosmosdb create`, `az cosmosdb sql database create`. Use case: globally distributed apps, low latency, flexible schema.

### 311. Azure CLI & PowerShell

Command-line tools. Azure CLI: cross-platform (Python), `az` command, intuitive, JSON output. Azure PowerShell: Windows focus, object-oriented, `.ps1` scripts. Installation: CLI via apt/brew/installer, PowerShell via `Install-Module Az`. Authentication: `az login` (browser), `az login --service-principal`, managed identity. Common: `az account show`, `az group list`, `az resource list`. Query: `--query` with JMESPath (CLI), `| Select-Object` (PowerShell). Output: JSON, table, YAML. Scripts: combine commands, error handling. CLI: preferred for cross-platform automation. Use case: CI/CD, automation, quick tasks.

### Category 19: Azure Intermediate (17 concepts)

### 312. ARM Templates

Infrastructure as Code: JSON declarative. Template sections: `$schema`, `contentVersion`, `parameters` (inputs), `variables` (computed values), `resources` (define resources), `outputs` (export values). Resource: type (Microsoft.Compute/virtualMachines), apiVersion, name, location, properties. Dependencies: `dependsOn` array or reference() (implicit). Deployment modes: incremental (default, add/update), complete (delete unlisted resources). Deployment: `az deployment group create --template-file main.json`. Linked templates: modular, nested or external. Best practice: parameterize, use variables, version control. Alternative: Bicep (cleaner syntax, transpiles to ARM).

### 313. Azure Bicep

DSL for ARM templates: cleaner, simpler syntax. Transpiles to JSON. Resources: `resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = { name: 'myVM', location: location }`. Parameters: `param location string = 'eastus'`. Variables: `var vnetName = 'myVNet'`. Modules: reusable files, `module storage './storage.bicep' = { params: { location: location } }`. Outputs: `output id string = vm.id`. CLI: `az bicep build`, `az deployment group create --template-file main.bicep`. Loops: `for i in range(0, 3): { ... }`. Conditionals: `if (env == 'prod') { ... }`. IDE: VS Code extension (IntelliSense, validation). Best practice: prefer Bicep over ARM JSON.

### 314. Azure Resource Manager (ARM)

Deployment and management layer. All requests go through ARM API (Portal, CLI, PowerShell, SDK, REST). Resource providers: Microsoft.Compute, Microsoft.Storage, Microsoft.Network, register providers. Deployment: template deployment, resource groups. RBAC: assign roles at subscription/RG/resource level. Locks: prevent accidental deletion/changes. Tags: metadata for organization, billing. Management groups: hierarchy above subscriptions, policy inheritance. Activity log: audit API calls. Best practice: use ARM templates/Bicep for IaC, RBAC for access control, locks for critical resources.

### 315. Azure Policy

Governance: enforce rules and compliance. Policy definition: JSON, effect (Deny, Audit, DeployIfNotExists, Modify). Built-in policies: require tags, allowed locations, allowed VM sizes. Custom policies: define conditions. Initiative: group policies. Scope: management group, subscription, resource group. Assignment: apply policy to scope. Compliance: dashboard, non-compliant resources. Remediation: fix non-compliant resources (for DeployIfNotExists/Modify). CLI: `az policy definition create`, `az policy assignment create`. Use case: cost control (enforce VM sizes), security (require encryption), compliance (audit untagged resources).

### 316. Azure Blueprints

Repeatable environment: combine ARM templates, policies, RBAC, resource groups. Artifact: template, policy assignment, role assignment, RG. Blueprint definition: create at management group or subscription. Assignment: deploy to subscription, tracked (can update). Versioning: publish versions (v1, v2), update assignments. Locking: protect deployed resources from modification/deletion. Use case: landing zones, multi-subscription deployments, governance. CLI: `az blueprint create`, `az blueprint assignment create`. Comparison: Terraform for flexibility, Blueprints for governance + compliance.

### 317. Azure Service Bus

Enterprise messaging: queues, topics/subscriptions. Queue: FIFO, point-to-point, competing consumers. Topic: pub/sub, multiple subscriptions, filters (SQL filter, correlation filter). Features: sessions (ordered processing), scheduled messages, dead-letter queue (failed messages), duplicate detection, transactions. Message: body (binary), properties (metadata), TTL. Tiers: Basic (queues), Standard (topics, 256KB), Premium (1MB, dedicated capacity, VNet). CLI: `az servicebus namespace create`, `az servicebus queue create`. Use case: decouple micro services, reliable messaging, event-driven architecture. Comparison: Storage Queue (simple), Service Bus (advanced features).

### 318. Azure Event Grid

Event routing: serverless event distribution. Event sources: Azure services (Storage, Event Hubs, Resource Manager), custom (HTTP POST). Event handlers: Functions, Logic Apps, webhooks, Storage Queue, Service Bus, Event Hubs. Topics: custom topics, system topics (Azure service events). Event schema: JSON, CloudEvents. Filtering: event type, subject. Retry: exponential backoff, dead-letter. Security: webhook validation, managed identity. Latency: sub-second. CLI: `az eventgrid topic create`, `az eventgrid event-subscription create`. Use case: react to Azure events (blob created → process), event-driven automation.

### 319. Azure Event Hubs

Big data streaming: millions of events/sec. Partitions: parallel processing, order within partition. Consumer groups: multiple readers (different apps). Capture: archive to Blob/Data Lake (Avro format). Throughput units: ingress/egress capacity (Standard tier), processing units (Premium, auto-inflate). Retention: 1-7 days (Standard), up to 90 days (Premium). Kafka compatible: use Kafka clients. CLI: `az eventhubs namespace create`, `az eventhubs eventhub create`. Use case: telemetry, log aggregation, IoT, clickstream. Comparison: Service Bus (messaging), Event Hubs (streaming).

### 320. Azure Logic Apps

Low-code automation: visual designer. Triggers: HTTP, schedule, event (Service Bus, Event Grid, Blob). Actions: connectors (500+), built-in (HTTP, variables, loops), Azure services (Functions, SQL), SaaS (Office 365, Salesforce). Control flow: condition, switch, loop, scope. Expressions: dynamic content, functions. Integration account: B2B (EDI, XML). Consumption: pay per execution. Standard: App Service, VNet. CLI: `az logic workflow create`. Use case: business process automation, integration, data transformation, alerting. Comparison: Functions (code), Logic Apps (visual).

### 321. Azure Front Door

Global CDN + WAF + load balancer. Features: global load balancing (route to nearest backend), CDN (cache static content), WAF (protect APIs), SSL offload, URL-based routing, session affinity. Backend pools: App Service, VMs, Storage (static site). Health probes: endpoint availability. Routing: priority, weighted (A/B testing), latency-based. Rules engine: modify requests/responses (headers, redirects). Tiers: Standard (CDN + routing), Premium (WAF + advanced security). CLI: `az afd profile create`. Use case: global web apps, multi-region failover, DDoS protection.

### 322. Azure Traffic Manager

DNS-based load balancer: global routing. Routing methods: priority (failover), weighted (A/B, blue/green), performance (lowest latency), geographic (by user location), multivalue (return multiple IPs), subnet (by source IP). Endpoints: Azure (App Service, public IP, AKS), external (on-prem, other cloud). Health checks: HTTP/HTTPS, TCP. Nested profiles: combine methods. TTL: DNS cache time. Use case: multi-region apps, disaster recovery, geolocation routing. CLI: `az network traffic-manager profile create`. Comparison: Front Door (Layer 7, faster), Traffic Manager (DNS, flexible).

### 323. Azure API Management

API gateway: secure, monitor, rate limit. Components: gateway (proxy), portal (developer docs), management (configure). Products: group APIs, subscription (API key), rate limits. Policies: inbound/backend/outbound (XML), IP filter, JWT validation, rate limit, caching, transformation. Backends: any HTTP endpoint (App Service, Functions, external). Tiers: Consumption (serverless), Developer, Basic, Standard, Premium (multi-region, VNet). APIM + Functions: common pattern. OAuth: Azure AD integration. CLI: `az apim create`. Use case: expose internal APIs, third-party integration, API monetization.

### 324. Azure Managed Identities

Identity for Azure resources: no credentials in code. Types: system-assigned (lifecycle tied to resource, 1:1), user-assigned (shared, can be assigned to multiple resources). RBAC: assign roles to managed identity. Use: Azure SDK, REST API (auto-fetch token). Token: from IMDS endpoint (http://169.254.169.254/...). Supported: VMs, App Service, Functions, AKS, Container Instances. Use case: App Service → Key Vault, AKS → ACR, VM → Storage. Best practice: always use managed identities over service principals. CLI: enable on resource (`az vm identity assign`), assign role (`az role assignment create --assignee <principal-id>`).

### 325. Azure Private Link

Private access to Azure services: over VNet, no public internet. Private endpoint: private IP in your VNet, connects to Azure service (Storage, SQL, Key Vault, custom). Service endpoint vs Private Link: service endpoint (subnet-level, service still has public IP), Private Link (resource-level, private IP, more secure). Traffic: stays on Microsoft backbone. NSG: control access to private endpoint. DNS: private DNS zone (privatelink.blob.core.windows.net → private IP). Use case: secure access, compliance, hybrid connectivity. CLI: `az network private-endpoint create`. Cost: per endpoint + data processed.

### 326. Azure Site Recovery

Disaster recovery: replicate VMs, physical servers. Replicate: Azure to Azure (region to region), on-prem (Hyper-V, VMware) to Azure. Recovery plan: orchestrate failover, scripts, manual actions. RPO: replication frequency (Azure-to-Azure: continuous, on-prem: 30 sec to 15 min). RTO: failover time (minutes). Test failover: validate without impact. Failback: after disaster, return to primary. Backup: separate service (Azure Backup). CLI: recovery services vault, site recovery. Use case: business continuity, DR compliance.

### 327. Azure Backup

Backup service: VMs, SQL, SAP HANA, files, blobs. Recovery Services Vault: store backups. VM backup: app-consistent (VSS/scripts), file-consistent. Retention: daily, weekly, monthly, yearly (up to 9999 years). Recovery: full VM, file-level restore. Backup policies: schedule, retention. Soft delete: 14 days (protect from accidental deletion). Cross-region restore: geo-redundant vault. Security: encryption, RBAC. CLI: `az backup vault create`, `az backup protection enable-for-vm`. Use case: data protection, compliance, ransomware recovery.

### 328. Azure Cost Management

Monitor and optimize costs. Cost analysis: visualize spending (by resource, RG, service, tag), forecast. Budgets: set budget, alerts (email, action group), scope (subscription, RG). Recommendations: Azure Advisor (resize VMs, reserved instances, delete unused resources). Exports: schedule exports to Storage. Showback/chargeback: tag resources, allocate costs to teams. Savings: reserved instances (1-3 year commitment), spot VMs (up to 90% off), hybrid benefit (bring Windows/SQL licenses). CLI: `az consumption usage list`, `az consumption budget create`. Use case: FinOps, cost visibility, prevent overruns.

### Category 20: GCP Essentials (10 concepts)

### 329. GCP Compute Engine

VMs in GCP. Machine types: general purpose (E2, N1, N2, N2D), compute optimized (C2, C2D), memory optimized (M1, M2), accelerator optimized (A2, GPU). Preemptible VMs: up to 80% discount, max 24h, can be terminated. Spot VMs: similar to preemptible, more flexible. Custom machine types: choose vCPUs and memory. Persistent disks: boot disk, data disk, standard (HDD), balanced (SSD), SSD. Local SSD: ephemeral, high performance. Instance groups: managed (auto-scaling, auto-healing), unmanaged. gcloud: `gcloud compute instances create`, `gcloud compute instance-groups managed create`. Use case: general compute workloads.

### 330. GCP Cloud Storage

Object storage: globally distributed, 11 9s durability. Storage classes: Standard (hot data), Nearline (30 days), Coldline (90 days), Archive (365 days), auto-class (automatic tiering). Bucket: global namespace, location (region, dual-region, multi-region). Objects: immutable, versioning (keep old versions). Lifecycle policies: delete, transition to cheaper class (age, created before date). Access: IAM (bucket/project level), ACLs (object level, legacy), signed URLs (temporary access). Encryption: at rest (default, customer-managed keys), in transit (TLS). Transfer: gsutil, Storage Transfer Service, Transfer Appliance. CLI: `gsutil mb gs://bucket`, `gsutil cp file gs://bucket/`. Use case: backups, data lake, static website hosting.

### 331. GCP Virtual Private Cloud (VPC)

Global network: not regional. Subnets: regional (not zonal), CIDR blocks, primary/secondary ranges (for GKE pods). Firewall rules: stateful, priority (0-65535), allow/deny, ingress/egress, source/dest (IP, range, tag, service account), protocols/ports. Routes: default (internet gateway), custom. VPC peering: connect VPCs (same or different projects), transitive (via third VPC). Shared VPC: central VPC, multiple projects. Cloud NAT: outbound internet for private instances (no public IP). Cloud VPN: site-to-site, IPsec. Cloud Interconnect: dedicated connection (not internet). CLI: `gcloud compute networks create`, `gcloud compute firewall-rules create`. Use case: network isolation, hybrid connectivity.

### 332. GCP Identity and Access Management (IAM)

Access control: who (identity) can do what (role) on which resource. Identity: Google Account, service account, Google Group, Cloud Identity domain. Role: permissions bundle, primitive (Owner, Editor, Viewer, deprecated for production), predefined (Compute Admin, Storage Object Viewer), custom. Policy: bindings (identity → role), attached to resource (project, bucket, VM). Service account: robot account for applications, keys (JSON), best practice: use Workload Identity (K8s), short-lived tokens. Conditions: attribute-based (resource name, date/time). CLI: `gcloud projects add-iam-policy-binding`, `gcloud iam service-accounts create`. Use case: least privilege, segregation of duties.

### 333. GCP Kubernetes Engine (GKE)

Managed Kubernetes. Modes: Autopilot (Google manages nodes, billing per pod, opinionated, easier), Standard (you manage nodes, full control). Cluster: zonal (single zone), regional (multi-zone, HA). Node pools: groups of nodes, different machine types, preemptible nodes. Networking: VPC-native (alias IPs, better integration), routes-based (legacy). Workload Identity: GKE pods → GCP services (IAM, no keys). Binary Authorization: enforce signed images. GKE Enterprise (Anthos): multi-cluster, hybrid, on-prem. Release channels: rapid, regular, stable. CLI: `gcloud container clusters create`, `gcloud container clusters get-credentials`. Use case: microservices, cloud-native apps.

### 334. GCP Cloud Functions

Serverless compute: event-driven. Generations: 1st gen (original), 2nd gen (based on Cloud Run, better performance, longer timeout). Triggers: HTTP, Cloud Storage, Cloud Pub/Sub, Firestore, Firebase. Runtimes: Node.js, Python, Go, Java, .NET, Ruby, PHP. Timeout: 1st gen (9 min), 2nd gen (60 min). Concurrency: 1st gen (1 request/instance), 2nd gen (up to 1000). Memory: 128MB-8GB. Deployment: gcloud, Cloud Build, Terraform. Environment variables, secrets (Secret Manager). CLI: `gcloud functions deploy myfunction --runtime python39 --trigger-http`. Use case: webhooks, data pipelines, API backends.

### 335. GCP Cloud Run

Serverless containers: fully managed, any language/binary. Container: from Artifact Registry or Docker Hub, must listen on PORT env var (default 8080). Autoscaling: 0 to N instances, scale to zero (no cost when idle). Concurrency: up to 1000 requests per instance. Memory: 128MB-32GB. Timeout: 60 min. CPU: allocated only during request (cheaper) or always (faster cold start). Ingress: all, internal (VPC only), internal + Cloud Load Balancing. Custom domains, TLS. Revisions: immutable, traffic splitting (blue/green, canary). CLI: `gcloud run deploy myservice --image gcr.io/project/image --platform managed`. Use case: APIs, web apps, microservices, batch jobs.

### 336. GCP Cloud Pub/Sub

Messaging: global, real-time. Topic: named resource, publish messages. Subscription: receive messages, push (HTTP endpoint), pull (client polls). Message: data (base64), attributes (metadata). Ordering: order key (within partition). Exactly-once delivery: deduplication. Dead-letter topic: failed messages. Retention: 7 days (default), up to 31 days. At-least-once delivery: ack messages. Filtering: subscription filters (attribute-based). Schemas: validate messages (Avro, Protocol Buffers). CLI: `gcloud pubsub topics create`, `gcloud pubsub subscriptions create`. Use case: event-driven architectures, streaming analytics, decouple microservices.

### 337. GCP BigQuery

Serverless data warehouse: analyze petabytes. SQL: standard SQL, supports nested/repeated fields (STRUCT, ARRAY). Storage: columnar, automatic compression, encryption. Compute: on-demand (pay per query), flat-rate (reserved slots). Partitioning: by date/time/integer, improve performance and cost. Clustering: sort by columns, combine with partitioning. Slots: unit of compute, auto-scaled. Streaming: real-time inserts. Federated queries: query external data (Cloud Storage, Bigtable, Sheets). BI Engine: in-memory cache. CLI: `bq query 'SELECT * FROM dataset.table'`, `bq load`. Use case: analytics, data lake, BI, ML (BQML).

### 338. GCP Cloud Build

CI/CD: serverless build service. Build config: cloudbuild.yaml, steps (Docker image, args, env vars). Steps: build Docker image, run tests, deploy to GKE/Cloud Run. Triggers: push to repo (Cloud Source Repos, GitHub, Bitbucket), PR, manual. Build: runs in container, each step is a container. Artifacts: store in Artifact Registry or GCS. Substitution variables: $_BRANCH, $SHORT_SHA. Private pools: VPC access for builds. Integration: Cloud Deploy (continuous delivery), GKE, Cloud Run. CLI: `gcloud builds submit`, `gcloud builds triggers create github`. Use case: automate deployments, test pipelines, container builds.

### Category 21: Infrastructure as Code I: Terraform Basics (18 concepts)

### 339. IaC Principles

Treat infrastructure as code: version control (Git), review (pull requests), test, deploy. 

**Reproducible:** same code = same infrastructure. 

**Declarative:** describe desired state, tool handles how to achieve. 

**Idempotent:** re-apply produces same result. 

**Automated:** CI/CD pipelines. 

**Documentation:** code is documentation, up-to-date. 

**Collaboration:** team can modify, peer review. 

**Drift detection:** compare actual vs desired state. 

**Rollback:** use Git history. 

**Environments:** dev/staging/prod from same code with different variables.

---

### 340. Declarative vs Imperative IaC

**Declarative (Terraform, CloudFormation):** describe end state, tool figures out steps, `resource "aws_instance" "web" { ... }`, idempotent, simpler. 

**Imperative (scripts, Ansible partially):** specify steps, create instance, configure, order matters, more control but complex. 

**Convergence:** declarative tools converge to desired state, handle dependencies. 

Terraform: declarative HCL, state file tracks reality. 

Ansible: mix (declarative modules, imperative playbooks). 

Choose: declarative for infrastructure provisioning, imperative for complex workflows.

---

### 341. Terraform Basics

HashiCorp Configuration Language (HCL). 

**Providers:** `provider "aws" { region = "us-east-1" }`, plugin that talks to API. 

**Resources:** `resource "aws_instance" "web" { ami = "ami-123" instance_type = "t3.micro" }`, actual infrastructure. 

**Data sources:** `data "aws_ami" "ubuntu" { ... }`, query existing resources. 

**Variables:** `variable "instance_type" { default = "t3.micro" }`, use: `var.instance_type`. 

**Outputs:** `output "instance_ip" { value = aws_instance.web.public_ip }`. 

**Locals:** computed values, `locals { common_tags = {...} }`. 

**Commands:** `terraform init` (download providers), `terraform plan` (preview), `terraform apply` (create), `terraform destroy` (delete). 

**Files:** `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars` (values).

---

### 342. Terraform State Management

**State file:** `terraform.tfstate`, JSON, maps config to real resources. 

Tracks dependencies, metadata. 

Lock during operations (prevent concurrent modifications). 

**Local state:** default, `terraform.tfstate` in directory, not collaborative. 

**Remote state:** backend (S3, GCS, Terraform Cloud), `backend "s3" { bucket = "..." key = "..." region = "..." dynamodb_table = "..." }`, DynamoDB for locking. 

**State commands:** `terraform state list` (resources), `terraform state show resource` (details), `terraform state mv` (rename), `terraform state rm` (unmanage), `terraform state pull/push`. 

**Sensitive data:** state may contain secrets, encrypt, restrict access. 

**Import existing:** `terraform import resource.name id`.

---

### 343. Terraform Modules

Reusable components. 

**Structure:** `module "vpc" { source = "./modules/vpc" cidr = "10.0.0.0/16" }`, module folder has `main.tf`, `variables.tf`, `outputs.tf`. 

**Inputs:** variables passed to module. 

**Outputs:** expose values, `output "vpc_id" { value = aws_vpc.main.id }`, access: `module.vpc.vpc_id`. 

**Sources:** local path, Git URL, Terraform Registry. 

**Versioning:** `source = "terraform-aws-modules/vpc/aws" version = "3.0.0"`. 

**Benefits:** DRY (don't repeat yourself), encapsulation, testing. 

**Composition:** nested modules. 

**Root module:** main configuration that calls modules.

---

### 344. Terraform Workspaces

Manage multiple environments (dev/staging/prod) with same code. 

**Create:** `terraform workspace new dev`, list: `terraform workspace list`, switch: `terraform workspace select prod`. 

**Separate state per workspace:** `terraform.tfstate.d/dev/`, `terraform.tfstate.d/prod/`. 

Use workspace name: `${terraform.workspace}`, e.g., `bucket = "myapp-${terraform.workspace}"`. 

**Alternative:** separate directories per environment (clearer separation, different backends). 

Workspaces good for: testing, similar environments. 

Not good for: drastically different environments, complex setups. 

**Combined approach:** separate repos/dirs for prod, workspaces for dev/staging.

---

### 345. Terraform Providers

Plugins that interact with APIs. 

**Official:** AWS, Azure, GCP, Kubernetes, etc. 

**Community:** hundreds available. 

**Config:** 
```hcl
terraform { 
  required_providers { 
    aws = { 
      source = "hashicorp/aws" 
      version = "~> 5.0" 
    } 
  } 
}
```

**Version constraints:** `~>` (pessimistic, allows patch updates), `>=`, `<=`, `=`. 

**Multiple instances:** aliased providers, `provider "aws" { alias = "west" region = "us-west-2" }`, use: `provider = aws.west`. 

**Authentication:** environment variables (`AWS_ACCESS_KEY_ID`), config files (`~/.aws/credentials`), IAM roles (EC2, ECS). 

**Plugin cache:** `~/.terraform.d/plugin-cache` to reuse.

---

### 346. Terraform Planning

Preview changes before apply. 

**terraform plan:** shows `+create`, `~modify`, `-destroy`, output as diff. 

**Detailed:** `terraform plan -out=plan.tfplan` (save plan), `terraform show plan.tfplan` (inspect), `terraform apply plan.tfplan` (apply exact plan). 

**Refresh:** `terraform refresh` updates state from real world (implicit in plan/apply). 

**Target:** `terraform plan -target=resource.name` (plan subset). 

**Destroy plan:** `terraform plan -destroy`. 

**CI integration:** run plan on PR, post as comment, manual approval, apply on merge. 

**Sentinel (Terraform Enterprise):** policy as code, validate plans.

---

### 347. Terraform Import

Adopt existing infrastructure. 

`terraform import resource.name id`, e.g., `terraform import aws_instance.web i-1234567890abcdef`. 

Writes to state, doesn't generate config (you write config to match). 

**Process:** write resource block matching existing resource, import, `terraform plan` should show no changes. 

**Bulk import:** tools like terraformer, terracognita. 

**Challenges:** complex resources, many dependencies. 

**State after import:** verify with `terraform state show resource.name`. 

**Alternative:** start fresh with IaC, migrate services gradually.

---

### 348. Terraform Best Practices

**Version control:** `.tf` files in Git, `.terraform/` and `*.tfstate` in `.gitignore` (if local state). 

**Remote state:** always use for teams. 

**Locking:** DynamoDB for S3 backend. 

**Modules:** reusable, versioned, tested. 

**Variables:** use `terraform.tfvars` or environment variables, never hardcode secrets (use vault, parameter store). 

**Outputs:** expose needed values. 

**Pin versions:** providers, modules, Terraform itself. 

**Formatting:** `terraform fmt`. 

**Validation:** `terraform validate`. 

**Plan in CI:** automated checks. 

**Secrets:** use data sources to fetch (`data "aws_ssm_parameter"`), never in code/state if avoidable. 

**Tags:** consistent tagging strategy. 

**Documentation:** README per module.

---

### 349. Virtual Machine Concepts

Software emulation of computer. 

**Hypervisor:** software that runs VMs. 

**Type 1 (bare-metal):** runs on hardware (VMware ESXi, KVM, Hyper-V, Xen), better performance. 

**Type 2 (hosted):** runs on OS (VirtualBox, VMware Workstation), easier but slower. 

**Hardware virtualization:** CPU extensions (Intel VT-x, AMD-V) accelerate. 

**VM components:** virtual CPU, memory, disk, network. 

**Isolation:** VMs isolated from host and each other. 

**Overhead:** hypervisor layer, less than containers but more efficient than separate physical machines. 

**Use:** legacy apps, Windows on Linux host, multi-tenancy, testing.

---

### 350. KVM/QEMU

**KVM (Kernel-based Virtual Machine):** Linux kernel module, Type 1 hypervisor. 

**QEMU:** emulator, user-space, uses KVM for acceleration. 

**Libvirt:** management layer, abstraction over KVM/QEMU. 

**Tools:** `virsh` (CLI), `virt-manager` (GUI). 

**Create VM:** 
```bash
virt-install --name vm1 --ram 2048 \
  --disk path=/var/lib/libvirt/images/vm1.qcow2,size=20 \
  --vcpus 2 --os-type linux --os-variant ubuntu20.04 \
  --network bridge=virbr0 --graphics none \
  --console pty,target_type=serial \
  --location 'http://...' --extra-args 'console=ttyS0'
```

**Manage:** `virsh list`, `virsh start vm1`, `virsh shutdown vm1`, `virsh destroy vm1` (force off). 

**Images:** qcow2 (CoW, snapshots), raw. 

**Networking:** NAT (default), bridge (VMs on network). 

**Storage pools:** `/var/lib/libvirt/images/`.

---

### 351. Cloud VM Instances

Compute resources in cloud. 

**Instance types:** t3 (burstable, credits), m5 (general), c5 (compute-optimized), r5 (memory-optimized), etc. 

**Pricing:** on-demand (hourly), reserved (commitment discount), spot (unused capacity, cheap but interruptible). 

**Size:** vCPUs, memory, network bandwidth, storage. 

**Launch:** specify AMI (Amazon Machine Image), instance type, network, security group, key pair. 

**Metadata service:** `http://169.254.169.254/latest/meta-data/` (instance info). 

**User data:** script run at boot. 

**Stop/start:** preserve instance, change IP (unless elastic IP). 

**Terminate:** delete instance. 

**EBS volumes:** persistent storage, independent of instance lifecycle.

---

### 352. VM Images

Pre-configured templates. 

**Cloud:** AMI (AWS), custom images (GCP), managed images (Azure). 

**Golden image:** base image with OS, patches, software, hardened. 

**Creation:** launch instance, configure, create image (`aws ec2 create-image`). 

**Image pipeline:** automated with Packer. 

**Formats:** VMDK (VMware), VHD (Hyper-V), qcow2 (KVM), raw. 

**Versioning:** tag images, immutable infrastructure. 

**Marketplace:** public images (Ubuntu, CentOS), vendor images. 

**Security:** scan images, update regularly, minimal software. 

**Size:** smaller images = faster boot. 

**Regions:** copy images to multiple regions for disaster recovery.

---

### 353. Cloud-Init

Industry-standard for VM initialization. 

**Config:** cloud-config YAML, user data. 

**Capabilities:** set hostname, install packages, run scripts, configure users/SSH keys, mount filesystems, write files. 

**Example:** 
```yaml
#cloud-config
packages:
  - nginx
runcmd:
  - systemctl start nginx
```

**Metadata:** `http://169.254.169.254/latest/user-data/` (instance gets config). 

**Modules:** run in stages (init, config, final). 

**Logs:** `/var/log/cloud-init.log`, `/var/log/cloud-init-output.log`. 

**Templating:** Jinja2, `${instance_id}`. 

**Supported:** AWS, GCP, Azure, OpenStack, etc. 

**First boot only** (unless configured otherwise). 

**Config packages:** datasource-specific (AWS uses IMDSv2).

---

### 354. VM Networking

**Virtual networks:** VPC (AWS), VNet (Azure), VPC (GCP), isolated network space. 

**Subnets:** divide network, public (internet-accessible) vs private. 

**Routing tables:** route traffic, default route to internet gateway (public) or NAT gateway (private). 

**Security groups:** stateful firewall, allow inbound/outbound rules, applied to instances. 

**Network ACLs:** stateless, subnet-level. 

**Elastic/Static IPs:** persistent public IP. 

**Network interfaces:** multiple NICs per VM, different subnets. 

**DNS:** private DNS zone, public DNS for public IPs. 

**VPN:** site-to-site, client-to-site. 

**Peering:** connect VPCs. 

**Direct Connect / ExpressRoute:** dedicated connection.

---

### 355. VM Storage

**Block storage:** virtual disks attached to VMs. 

**Root volume:** OS disk, ephemeral (terminates with instance) or persistent. 

**Data volumes:** additional disks, persistent, detach/reattach. 

**Types:** SSD (gp3, io2 in AWS, fast, expensive), HDD (st1, sc1, slower, cheap). 

**Provisioned IOPS:** guaranteed performance. 

**Snapshots:** point-in-time backups, incremental (only changed blocks). 

**Encryption:** at-rest, transparent to OS. 

**Resize:** some types support online resize. 

**Lifecycle:** independent of instance (except root if configured as ephemeral). 

**Multi-attach:** some storage types support attaching to multiple instances (for clustering).

---

### 356. VM Scaling

**Vertical:** increase instance size (more CPU/memory), requires stop/start, downtime. 

**Horizontal:** add more instances, use load balancer. 

**Auto-scaling:** automatically add/remove instances based on metrics (CPU, requests). 

**Auto Scaling Group (AWS):** desired/min/max capacity, launch template, scaling policies (target tracking, step scaling, scheduled). 

**Health checks:** remove unhealthy instances. 

**Scale-in protection:** prevent specific instances from termination. 

**Cool-down period:** wait after scaling to avoid thrashing. 

**Predictive scaling:** ML-based forecasting. 

**Right-sizing:** analyze usage, choose optimal instance type.

---

### Category 22: Infrastructure as Code II: Terraform Advanced (17 concepts)

### 357. Infrastructure Testing

Validate IaC before apply. 

**Syntax:** `terraform validate` (HCL syntax), `terraform fmt -check` (formatting). 

**Static analysis:** tfsec (security), checkov (compliance), tflint (errors, deprecated), terrascan. 

**Unit tests:** Terratest (Go), write tests for modules, `terraform plan` + assertions. 

**Integration tests:** deploy to test environment, verify resources, destroy. 

**Policy:** Sentinel (Terraform Cloud), Open Policy Agent, define rules (e.g., require tags, prevent public S3 buckets). 

**Contract tests:** mock provider responses. 

**CI integration:** run tests on PRs, fail pipeline on violations. 

**Test environments:** separate from prod, clean up after tests.

---

### 358. Configuration Drift

Actual infrastructure diverges from IaC. 

**Causes:** manual changes via console, scripts, other tools. 

**Detection:** `terraform plan` shows drift (resources out of sync), `terraform refresh` updates state to match reality. 

**Prevention:** read-only console access, use IaC exclusively, audit logs. 

**Remediation:** `terraform apply` to converge back to desired state, or update IaC to match reality (if intentional change). 

**Automated drift detection:** scheduled `terraform plan` in CI, alerts on drift. 

**Drift tools:** AWS Config, Azure Policy, cloud-native. 

**Immutability:** replace resources instead of modifying, no drift possible.

---

### 359. Multi-Stage Builds

Optimize image size. Multiple FROM statements in Dockerfile. Build stage: install dependencies, compile. Runtime stage: copy artifacts, minimal base. Example: `FROM golang:1.20 AS builder` (build), `FROM alpine` (runtime), `COPY --from=builder /app/binary .`. Benefits: smaller images (no build tools), faster deployments, security (fewer attack surface). Use case: compiled languages (Go, Rust, C++), Node.js (npm install in build stage). Pattern: builder → minimal runtime (alpine, distroless, scratch).

### 360. Docker BuildKit

Next-gen build engine. Enable: `export DOCKER_BUILDKIT=1` or `docker buildx`. Features: parallel builds (faster), build cache (remote cache), secrets (no leaks in layers), SSH forwarding (git clone private repos). Syntax: `# syntax=docker/dockerfile:1.4` (top of Dockerfile). Cache mounts: `RUN --mount=type=cache,target=/root/.cache/pip pip install -r requirements.txt`. Secrets: `RUN --mount=type=secret,id=token curl -H "Authorization: Bearer $(cat /run/secrets/token)" ...`. SSH: `RUN --mount=type=ssh git clone ...`. Output: export images, local files, registry. Use docker buildx for multi-arch builds.

### 361. Docker Compose Production

Multi-container orchestration. Compose file v3+: `version: '3.8'`, services, networks, volumes. Production considerations: restart policies (on-failure, always), health checks, resource limits (memory, CPU), logging drivers. Deploy: multiple replicas (swarm mode), placement constraints. Secrets: external (not in compose file). Networks: custom bridge, overlay (swarm). Volumes: named volumes, bind mounts (avoid in prod). Environment: `.env` file, `env_file:`, overrides with `-f docker-compose.prod.yml`. Commands: `docker-compose up -d`, `docker-compose logs -f`, `docker-compose down`. Limitations: single host (use K8s/Swarm for multi-host).

### 362. Docker Networking Deep Dive

Network drivers: bridge (default, single host), host (no isolation, performance), none (no networking), overlay (multi-host, swarm), macvlan (direct MAC address). Bridge: containers on same network can communicate by name (DNS), port publish for external access. Custom networks: `docker network create mynet`, better isolation, automatic DNS. Network policies: not native (use K8s, Cilium). Inspect: `docker network inspect bridge`. Embedded DNS: 127.0.0.11. Port mapping: `-p 8080:80` (host:container). Network namespaces: each container has own network stack. Use case: microservices (custom bridge), high performance (host network).

### 363. Docker Volume Drivers

Persistent storage. Local driver: default, host filesystem. Volume plugins: NFS, Ceph, AWS EBS, Azure Disk, GlusterFS. Create: `docker volume create --driver local myvolume`, `docker volume create --driver rexray/ebs myvolume`. Mount: `-v myvolume:/data` or `--mount source=myvolume,target=/data`. Volume lifecycle: independent from containers, persist after container deletion. Backup: `docker run --rm -v myvolume:/data -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz /data`. Inspect: `docker volume inspect`, `docker volume ls`. Use case: databases (persistence), shared data (multiple containers), backup/restore.

### 364. Docker Registry Deep Dive

Image storage. Registry types: Docker Hub (public/private), self-hosted (Docker Registry v2, Harbor), cloud (ECR, ACR, GCR). Self-hosted: `docker run -d -p 5000:5000 --restart=always --name registry registry:2`. TLS: required for production, use Let's Encrypt or self-signed. Authentication: basic auth, token auth (Harbor). Push: `docker tag myimage localhost:5000/myimage`, `docker push localhost:5000/myimage`. Pull: `docker pull localhost:5000/myimage`. Garbage collection: delete unused layers. Mirroring: pull-through cache. Harbor: UI, RBAC, vulnerability scanning, replication. Use case: private images, air-gapped environments, CI/CD.

### 365. Docker Security Best Practices

Minimize attack surface. Run as non-root: `USER 1000` in Dockerfile, avoid `root`. Read-only filesystem: `docker run --read-only`, writable with tmpfs. Drop capabilities: `--cap-drop=ALL`, add specific `--cap-add=NET_BIND_SERVICE`. Seccomp: default profile blocks dangerous syscalls, custom profiles. AppArmor/SELinux: mandatory access control. No privileged: avoid `--privileged`. Secrets: use Docker secrets (swarm) or env vars from vault, never in image. Scan images: Trivy, Grype, Clair, Docker Scout. Minimal base: alpine, distroless, scratch. Update regularly: rebuild images with security patches. Limit resources: prevent DoS.

### 366. Docker Content Trust

Image signing and verification. Enable: `export DOCKER_CONTENT_TRUST=1`. Sign on push: uses Notary, creates signature with private key. Verify on pull: checks signature with public key. Root key: offline, generates tagging key. Tagging key: online, signs tags. Delegation: allow multiple signers. Notary server: stores signatures (separate from registry). Use case: supply chain security, prevent MITM, verify image integrity. Alternative: Cosign (Sigstore), simpler, OCI-native. Commands: signatures stored in `~/.docker/trust/`. Best practice: enable in production, rotate keys regularly.

### 367. Docker in Docker (DinD)

Run Docker inside Docker container. Use cases: CI/CD (build images in pipeline), sandboxed builds. Methods: mount Docker socket (`-v /var/run/docker.sock:/var/run/docker.sock`, security risk, shares host Docker daemon), true DinD (`docker:dind` image, separate daemon, privileged). DinD image: `docker run --privileged -d docker:dind`. Security concerns: privileged mode, potential escape to host. Alternatives: Kaniko (daemonless builds), BuildKit (better isolation), Podman (rootless). Use case: GitLab CI, Jenkins Docker agents. Best practice: avoid Docker socket mount, use Kaniko or BuildKit in K8s.

### 368. Docker Swarm Basics

Native orchestration. Cluster: manager nodes (Raft consensus), worker nodes. Initialize: `docker swarm init`, join: `docker swarm join --token ...`. Services: replicated (N instances) or global (1 per node). Deploy: `docker service create --replicas 3 --name web nginx`. Update: rolling updates, `docker service update --image nginx:1.20 web`. Networking: overlay networks (multi-host), ingress routing mesh (external access). Volumes: local or shared (NFS, cloud). Secrets: encrypted, distributed to services. Stack: deploy compose file, `docker stack deploy -c docker-compose.yml mystack`. Use case: simple orchestration. Limitations: less features than K8s, smaller ecosystem.

### 369. Docker Context

Manage multiple Docker hosts. Context: connection config (host, TLS, socket). Default: local Docker daemon. Create: `docker context create remote --docker "host=ssh://user@host"`, `docker context create aws --docker "host=tcp://aws-host:2376,ca=ca.pem,cert=cert.pem,key=key.pem"`. Switch: `docker context use remote`, commands now target remote. List: `docker context ls`. Use case: deploy to multiple environments (dev, prod), remote Docker hosts, edge devices. SSH: `docker context create --docker "host=ssh://user@host"` (uses SSH tunnel). Best practice: avoid exposing Docker daemon on TCP (security risk), use SSH or VPN.

### 370. Docker Resource Management

Limit CPU, memory. Memory: `docker run -m 512m` (hard limit), `--memory-reservation 256m` (soft limit), `--oom-kill-disable` (dangerous). CPU: `--cpus=1.5` (1.5 cores), `--cpu-shares` (relative weight), `--cpuset-cpus="0,1"` (pin to cores). Block I/O: `--blkio-weight`, `--device-read-bps`, `--device-write-bps`. PIDs: `--pids-limit` (prevent fork bombs). cgroups v2: unified hierarchy, better resource isolation. View: `docker stats`, `docker inspect` (HostConfig.Memory). Use case: multi-tenant, prevent noisy neighbor, resource guarantees. Best practice: always set memory limits, test OOM behavior.

### 371. Docker Logging Drivers

Collect container logs. Default: json-file (stores in `/var/lib/docker/containers/`). Drivers: syslog (local or remote), journald (systemd), fluentd, awslogs (CloudWatch), gcplogs, splunk, gelf (Graylog). Configure: `docker run --log-driver=syslog --log-opt syslog-address=udp://logserver:514`. Daemon-wide: `/etc/docker/daemon.json`, `{"log-driver": "json-file", "log-opts": {"max-size": "10m", "max-file": "3"}}`. View logs: `docker logs <container>` (only json-file/journald, others not accessible). Rotation: max-size, max-file. Use case: centralized logging, compliance, debugging. Best practice: limit json-file size (disk usage), use external log system (ELK, Loki).

### 372. Docker Init Process

PID 1 problem. Issue: container main process is PID 1, doesn't reap zombie processes, doesn't handle signals properly. Solution: use init system. Tini: `docker run --init` (uses tini), lightweight init. dumb-init: alternative, similar. Dockerfile: `RUN apk add --no-cache tini`, `ENTRYPOINT ["/sbin/tini", "--", "myapp"]`. Behavior: tini spawns child (myapp), forwards signals (SIGTERM), reaps zombies. Use case: shell scripts that spawn children, long-running apps. Check: `docker exec <container> ps aux | grep -E 'PID|defunct'`. Best practice: always use `--init` or add init to image.

### 373. Docker Image Layers Deep Dive

Union filesystem. Layers: read-only (base image, each RUN/COPY), writable (container layer). Storage driver: overlay2 (modern, best), aufs (legacy), devicemapper, btrfs. Overlay2: lower (image layers), upper (container changes), merged (combined view). Layer size: each instruction adds layer, minimize layers. Flatten: export/import or multi-stage builds. Inspect: `docker history myimage`, `docker inspect` (RootFS.Layers). Cache: reuses layers if unchanged (order matters). Best practice: combine RUN commands (`&&`), order by change frequency (base packages first, code last), use .dockerignore.

### Category 23: Containerization I: Docker Basics (18 concepts)

### 374. Container Fundamentals

Lightweight virtualization. 

**Process isolation:** containers share kernel, isolated user space. 

**Faster than VMs:** no hypervisor, boot in seconds. 

**Image-based:** package app + dependencies, consistent across environments. 

**Immutable:** container ephemeral, state in volumes. 

**Portable:** runs anywhere (Docker installed). 

Use namespaces for isolation, cgroups for resource limits. 

**Not VMs:** no separate kernel, less overhead. 

**Security:** weaker isolation than VMs, can escape to host kernel. 

**Suitable for:** microservices, CI/CD, dev environments.

---

### 375. Namespaces

Linux kernel feature for isolation. 

**PID:** separate process IDs, container sees PID 1 as its init. 

**Network:** separate network stack, interfaces, IPs, routing. 

**Mount:** separate filesystem mounts. 

**UTS:** hostname and domain name. 

**IPC:** inter-process communication (message queues, semaphores). 

**User:** map UIDs/GIDs, root in container != root on host (rootless containers). 

**Cgroup:** isolate cgroup hierarchy (newer). 

**Commands:** `unshare` (create namespaces), `nsenter` (enter namespaces), `/proc/[pid]/ns/` (namespace references). 

Docker uses all by default. 

Kubernetes: pods share network namespace.

---

### 376. Control Groups (cgroups v2)

Resource management. 

**Hierarchy:** `/sys/fs/cgroup/`, unified hierarchy in v2. 

**Controllers:** cpu (shares, quotas), memory (limits), io (I/O bandwidth), pids (process count), cpuset (which CPUs). 

**Set limits:** write to files, e.g., `echo 1G > /sys/fs/cgroup/container/memory.max`. 

**Docker:** `-m` (memory), `--cpus` (CPU), systemd: `MemoryLimit=`, `CPUQuota=` in units. 

**Kubernetes:** `resources.limits` and requests in pod spec. 

**View:** `systemd-cgls` (tree), `systemd-cgtop` (top-like). 

**OOM killer:** kills processes exceeding memory limits. 

**Accounting:** track resource usage per cgroup.

---

### 377. Capabilities

Fine-grained permissions. 

**Linux capabilities:** split root into ~40 capabilities, e.g., `CAP_NET_BIND_SERVICE` (bind ports < 1024), `CAP_SYS_ADMIN` (admin tasks), `CAP_NET_ADMIN` (network config), `CAP_DAC_OVERRIDE` (ignore file permissions). 

**Set:** `setcap 'cap_net_bind_service=+ep' /usr/bin/app` (binary can bind privileged ports without root). 

**View:** `getcap /usr/bin/app`. 

**Docker:** `--cap-add=NET_ADMIN`, `--cap-drop=ALL` (drop all, add specific). 

**Kubernetes:** `securityContext.capabilities.add/drop`. 

**Principle of least privilege:** drop unnecessary capabilities. 

Default Docker drops many dangerous capabilities.

---

### 378. Seccomp

Syscall filtering. 

**Seccomp-BPF:** Berkeley Packet Filter for syscall decisions. 

**Modes:** strict (only read, write, exit, sigreturn), filter (custom profile). 

**Docker default profile:** blocks ~60 dangerous syscalls (reboot, mount, etc.). 

**Custom profile:** JSON, list allowed/blocked syscalls. 

**Apply:** `docker run --security-opt seccomp=profile.json`. 

**Kubernetes:** `securityContext.seccompProfile`. 

**Create profile:** start with default, trace app (strace), allow only needed syscalls. 

**Security:** reduces attack surface, can prevent container escapes. 

**Trade-off:** compatibility (some apps need blocked syscalls).

---

### 379. Container Images

Read-only templates. 

**Layers:** each instruction in Dockerfile creates layer (ADD, COPY, RUN). 

**Base image:** starting point (e.g., `alpine:3.18`, `ubuntu:22.04`). 

**Scratch:** empty base for static binaries. 

**Tag:** `image:tag`, e.g., `nginx:1.25`, `latest` (default, avoid for production). 

**Registry:** storage for images (Docker Hub, ECR, GCR, Harbor). 

**Pull:** `docker pull nginx:1.25`. 

**List:** `docker images`. 

**Remove:** `docker rmi image`. 

**Digest:** SHA256 hash, immutable reference, `image@sha256:abc123`. 

**Manifest:** metadata (layers, config). 

**OCI Image Spec:** standard format.

---

### 380. Image Layers

Union filesystem (OverlayFS, AUFS). 

**Each layer:** diff from previous. 

**Read-only:** lower layers, writable: top layer (container layer). 

**Sharing:** same layers reused across images, save disk space. 

**Inspection:** `docker history image` (layers), `docker inspect image` (details), dive tool (interactive). 

**Size optimization:** minimize layers, combine RUN commands (`RUN apt-get update && apt-get install -y ... && rm -rf /var/lib/apt/lists/*`), order (least frequently changing first, leverage cache). 

**Max layers:** 127 (Docker). 

**Cache:** Docker reuses layers if unchanged, bust cache by changing earlier layer. 

**Multi-stage:** builder stage (large), final stage (small, copy artifacts only).

---

### 381. Dockerfile Best Practices

**Instructions:** `FROM` (base image), `RUN` (execute command, create layer), `COPY` (copy files), `ADD` (copy + extract tar/fetch URL, avoid), `ENV` (environment), `EXPOSE` (document port), `WORKDIR` (working directory), `CMD` (default command), `ENTRYPOINT` (executable), `USER` (non-root), `LABEL` (metadata). 

**Multi-stage:** `FROM base AS builder`, `FROM final`, `COPY --from=builder /app /app`, reduces size. 

**Layer optimization:** combine commands, clean up in same RUN (e.g., `apt-get remove + rm`). 

**.dockerignore:** exclude files from build context (`node_modules`, `.git`). 

**Non-root:** `USER 1000` or named user. 

**Specific versions:** pin base image tag. 

**Health check:** `HEALTHCHECK CMD curl -f http://localhost/ || exit 1`. 

**Minimal base:** alpine, distroless. 

**Security:** scan with trivy, no secrets in image.

---

### 382. Container Registries

Storage and distribution. 

**Public:** Docker Hub (official images), Quay.io. 

**Private:** Harbor (self-hosted, open source, vulnerability scanning, replication), AWS ECR, GCP GCR, Azure ACR, GitLab Container Registry, JFrog Artifactory. 

**Push:** `docker tag image registry/repo:tag`, `docker push registry/repo:tag`. 

**Pull:** `docker pull registry/repo:tag`. 

**Authentication:** `docker login registry`, credentials in `~/.docker/config.json` or credential helpers. 

**OCI Distribution Spec:** standard API. 

**Replication:** mirror images across regions. 

**Retention:** delete old images automatically. 

**RBAC:** control access per repository. 

**Webhooks:** trigger on push.

---

### 383. Image Signing & Verification

Supply chain security. 

**Docker Content Trust (DCT):** sign images, `export DOCKER_CONTENT_TRUST=1`, uses Notary. 

**Signing:** `docker push` signs with key. 

**Verification:** Docker verifies signature on pull, fails if tampered. 

**Cosign (Sigstore):** modern, `cosign sign image`, `cosign verify image`, keyless signing (OIDC), store signatures in registry or separate. 

**Admission controllers:** Kubernetes enforces signed images only (Kyverno, Gatekeeper policies). 

**Trust on first use (TOFU):** trust first pull, verify subsequent. 

**Benefits:** authenticity, integrity, non-repudiation. 

**Key management:** protect private keys, rotate.

---

### 384. Container Networking Modes

Docker networking. 

**Bridge (default):** containers on private network (`docker0`), NAT to host, communicate via container IP or name (if on same network). 

**Create:** `docker network create mynet`. 

**Host:** container shares host network stack, no isolation, port conflicts. 

**None:** no network, loopback only. 

**Macvlan:** container gets MAC address, appears as physical device. 

**Overlay:** multi-host networking (Swarm, Kubernetes). 

**Custom:** create networks, `docker network create --driver bridge mynet`, attach: `docker run --network mynet`. 

**DNS:** Docker DNS server resolves container names. 

**Port mapping:** `-p 8080:80` (host:container).

---

### 385. Container Volumes

Persistent storage. 

**Types:** 
- **Named volumes:** managed by Docker, `/var/lib/docker/volumes/`, `docker volume create myvol`, use: `-v myvol:/data`. 
- **Bind mounts:** host path, `-v /host/path:/container/path`, direct access. 
- **tmpfs:** memory-based, not persistent, `--tmpfs /tmp`. 

**Tmpfs use:** sensitive data, temp files. 

**Volume drivers:** local (default), cloud storage (AWS EBS, GCE Persistent Disk), NFS, CIFS. 

**Lifecycle:** volumes persist after container removed (unless `--rm` with anonymous volume). 

**Sharing:** multiple containers can mount same volume. 

**Backup:** `docker run --rm -v myvol:/data -v $(pwd):/backup busybox tar czf /backup/backup.tar.gz /data`.

---

### 386. Docker Compose

Multi-container applications. 

**File:** `docker-compose.yml` (YAML). 

**Define services:** 
```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: secret
```

**Networks:** services on same network by default. 

**Volumes:** define volumes, mount to services. 

**Commands:** `docker-compose up` (create and start), `up -d` (detached), `docker-compose down` (stop and remove), `docker-compose logs`, `docker-compose ps`. 

**Build:** `build: ./path` or `build:\n  context: .\n  dockerfile: Dockerfile.dev`. 

**Override:** `docker-compose.override.yml` (dev-specific config). 

**Profiles:** `profiles: [dev]`, start: `docker-compose --profile dev up`. 

**Environment:** `.env` file for variables.

---

### 387. Container Runtime Interface (CRI)

Kubernetes abstraction. 

**Decouples Kubernetes from runtime.** 

**Implementations:** containerd (Docker's runtime, most common), CRI-O (lightweight, OCI-based), Docker (deprecated CRI support, use containerd shim). 

**Protocol:** gRPC, two services: RuntimeService (container lifecycle), ImageService (image management). 

**CLI:** `crictl` (like docker CLI for CRI), `crictl ps`, `crictl images`, `crictl pull`, `crictl logs`, `crictl exec`. 

**Pod sandboxes:** CRI concept, wraps containers. 

**Kubelet:** talks to CRI, not directly to runtime. 

**Choose:** containerd (default, stable), CRI-O (minimal, OCI focus), Docker (legacy).

---

### 388. OCI Standards

Open Container Initiative, Linux Foundation. 

**Image Spec:** standard format (layers, manifest, config). 

**Runtime Spec:** how to run containers (`config.json`, process, mounts, hooks). 

**Distribution Spec:** registry API (push, pull, manifest). 

**Benefits:** portability (any OCI-compliant runtime), innovation (multiple implementations). 

**Tools:** runc (reference implementation of runtime spec), skopeo (image operations without runtime), umoci (manipulate OCI images). 

Docker, containerd, CRI-O all OCI-compliant. 

**Attestation:** SLSA, in-toto (supply chain).

---

### 389. Container Init Process

PID 1 inside container. 

**Responsibilities:** reap zombie processes (children that exited, parent didn't call wait), handle signals (forward SIGTERM to child processes). 

**Problems:** bash, shell scripts don't reap zombies. 

**Solutions:** tini (minimal init, `docker run --init`), dumb-init (similar), s6 (process supervisor), or proper init in image. 

**Dockerfile:** `ENTRYPOINT ["/tini", "--", "/app"]` or Docker `--init` flag. 

**Signal handling:** SIGTERM should gracefully shutdown app. 

**Zombies:** consume PIDs, eventually exhaust (`ps aux | grep defunct`). 

**Single process:** if app handles signals and no children, direct ENTRYPOINT fine.

---

### 390. Container Resource Limits

Prevent resource starvation. 

**Memory:** `docker run -m 512m` (limit), `--memory-swap` (total), swap disabled: `--memory-swap=512m` (same as memory). 

**CPU:** `--cpus=1.5` (CPU cores), `--cpu-shares=1024` (relative weight, default 1024), `--cpuset-cpus=0,1` (specific CPUs). 

**PIDs:** `--pids-limit=100` (max processes). 

**I/O:** `--blkio-weight=500` (I/O priority, 10-1000). 

**Kubernetes:** `resources.requests` (guaranteed, scheduling), `resources.limits` (maximum, enforced). 

**OOM:** Out Of Memory killer kills container if exceeds memory limit. 

**Monitoring:** `docker stats`, cAdvisor. 

**Right-sizing:** monitor actual usage, set limits slightly above average, handle spikes.

---

### 391. Container Health Checks

Determine if container is healthy. 

**Dockerfile HEALTHCHECK:** `HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1`, exit 0 = healthy, 1 = unhealthy. 

**Docker:** `docker inspect` shows health status. 

**Kubernetes probes:** liveness (restart if fails), readiness (remove from service if fails), startup (initial health). 

**Probe types:** HTTP (`httpGet`), TCP (`tcpSocket`), Exec (`exec.command`). 

**Config:** `initialDelaySeconds`, `periodSeconds`, `timeoutSeconds`, `successThreshold`, `failureThreshold`. 

**Best practices:** separate readiness (app ready to serve) and liveness (app alive, not deadlocked), don't restart too quickly (grace period), check dependencies (DB, cache).

---

### Category 24: Containerization II: Docker Advanced (17 concepts)

### 392. Container Logging

Capture stdout/stderr. 

**Docker:** `docker logs container`, `-f` (follow), `--tail 100` (last N lines), `--since` (time filter). 

**Log drivers:** json-file (default, writes to `/var/lib/docker/containers/[id]/[id]-json.log`), journald (systemd journal), syslog, fluentd, awslogs (CloudWatch), gcplogs, splunk, none (discard). 

**Set:** `docker run --log-driver=syslog`. 

**Kubernetes:** logs in `/var/log/pods/`, kubelet handles. 

**View:** `kubectl logs pod`, `-c container` (specific container in pod), `-f` (follow), `--previous` (previous container instance). 

**Centralized:** ship logs to Loki, Elasticsearch, CloudWatch. 

**Structured:** log JSON, parseable. 

**Don't log to files in container** (use stdout).

---

### 393. Rootless Containers

Run containers without root privileges. 

**User namespaces:** map root in container to non-root user on host. 

**Security:** limit damage if escape, no privileged operations. 

**Docker rootless:** install in user mode, `dockerd-rootless-setuptool.sh install`, uses slirp4netns (user-space networking) or rootlesskit. 

**Podman:** rootless by default, `podman run` as regular user. 

**Limitations:** can't bind privileged ports (< 1024, workaround: port mapping from 8080 to 80 via proxy), some storage drivers unsupported, performance overhead (networking). 

**Enable:** `sysctl kernel.unprivileged_userns_clone=1`, `/etc/subuid` and `/etc/subgid` for UID/GID mapping. 

**Use:** CI/CD runners, multi-tenant environments.

---

### 394. Container Security Scanning

Detect vulnerabilities. 

**Tools:** Trivy (fast, accurate, `trivy image nginx:latest`), Grype (Anchore, `grype nginx:latest`), Clair (static analysis, API-based), Snyk (commercial, CLI + CI), Docker Hub (auto-scan). 

**Databases:** CVE (Common Vulnerabilities and Exposures), vendor advisories. 

**Scan:** layers, OS packages, application dependencies (npm, pip, go modules). 

**Results:** vulnerability list, severity (critical, high, medium, low), fix version. 

**CI integration:** fail build on critical vulnerabilities. 

**Remediation:** update base image, update dependencies, rebuild. 

**Continuous scanning:** re-scan periodically (new CVEs). 

**False positives:** triage, suppress.

---

### 395. Container Build Systems

Modern alternatives to Docker build. 

**BuildKit (Docker, enabled by `DOCKER_BUILDKIT=1`):** parallel builds, cache mounts, secrets, SSH forwarding, `RUN --mount=type=cache` (persistent cache). 

**Kaniko:** builds in Kubernetes, no Docker daemon, `executor --context=dir --destination=image`. 

**Buildah:** OCI image builder, Podman ecosystem, Dockerfile or scripted, `buildah bud`, `buildah commit`. 

**img:** standalone, unprivileged, Dockerfile-compatible. 

**Jib (Java/Go):** builds images without Dockerfile, integrates with Maven/Gradle. 

**ko (Go):** builds Go apps directly to images. 

**Benefits:** daemonless, rootless, reproducible, layer caching. 

**Use:** CI/CD (no Docker daemon), Kubernetes-native (Kaniko), language-specific (Jib, ko).

---

### 396. Distroless Images

Minimal base images. 

**No shell, no package manager,** only app + runtime dependencies. 

**Google distroless:** `gcr.io/distroless/static` (static binary), `gcr.io/distroless/base` (glibc, no shell), language-specific (Java, Python, Node). 

**Benefits:** smaller attack surface (fewer binaries to exploit), smaller size, faster pulls. 

**Drawbacks:** debugging harder (no shell, use `kubectl debug` or ephemeral containers). 

**Chainguard Images:** similar concept, updated regularly. 

**Usage:** `FROM gcr.io/distroless/static`, `COPY app /app`, `ENTRYPOINT ["/app"]`. 

**Debug variant:** `:debug` tag includes busybox shell. 

**Combine with multi-stage:** build in full image, copy to distroless.

---

### 397. Container Debugging

Troubleshooting running containers. 

**Docker:** `docker exec -it container bash` (shell access, requires shell in image), `docker logs container` (logs), `docker inspect container` (detailed info), `docker top container` (processes), `docker stats container` (resource usage). 

**Kubernetes:** `kubectl exec -it pod -- bash` (shell), `kubectl logs pod` (logs), `kubectl describe pod` (events, status), `kubectl get pod -o yaml` (full spec). 

**No shell:** `kubectl debug pod --image=busybox --target=container` (ephemeral debug container, K8s 1.23+), or use `docker cp` to copy debugger into container. 

**Logs:** if app logs to file, `kubectl exec` to view. 

**Network:** `kubectl port-forward pod 8080:80` (access from local), `docker run --network=container:id` (join network).

---

### 398. Multi-Architecture Images

Support multiple CPU architectures. 

**Architectures:** amd64 (x86_64), arm64 (ARM 64-bit), arm/v7, etc. 

**Manifest list:** single tag, multiple images (one per arch), Docker pulls correct one. 

**Build:** Docker Buildx, `docker buildx build --platform linux/amd64,linux/arm64 -t image --push .`, requires QEMU for emulation or native builders. 

**Kubernetes:** nodes pull arch-specific image automatically. 

**Base images:** official images have multi-arch (e.g., alpine, ubuntu). 

**Use:** support ARM (Raspberry Pi, AWS Graviton), Mac M1/M2. 

**Check:** `docker manifest inspect image` (shows platforms). 

**regctl tool (regclient):** inspect registries.

---

### 399. Image Optimization

Reduce image size. 

**Techniques:** 
- Minimal base (alpine ~5MB, distroless ~20MB vs ubuntu ~77MB)
- Multi-stage builds (separate build/runtime)
- Layer order (COPY app after dependencies)
- Combine RUN (one layer for `apt-get update + install + clean`)
- `.dockerignore` (exclude unnecessary files)
- Remove caches (`rm -rf /var/lib/apt/lists/*` after apt)
- Compress (not effective, images already compressed)
- Specific versions (avoid pulling unnecessary updates)

**Tools:** dive (analyze layers, find waste), docker-slim (minify images, remove unused files). 

**Size matters:** faster pulls, less storage, smaller attack surface. 

**Goal:** < 50MB for most apps, < 10MB for static binaries.

---

### 400. Content Addressable Storage

Addressing by content hash. 

**Hash = SHA256(content).** 

**Same content = same hash = single storage.** 

**Benefits:** 
- Deduplication (save space, image layers shared)
- Integrity (tamper detection, hash mismatch = corruption)
- Immutability (hash never changes)

**Used in:** Docker images (layers addressed by digest), Git (commits, blobs), IPFS (distributed storage). 

**Docker:** `docker pull image@sha256:abc123` (digest pull, immutable), registry stores by digest, tags are pointers. 

**Garbage collection:** remove unreferenced content. 

**Trust:** verify hash, cryptographic guarantee.

---

### 401. Container Storage Drivers

How container filesystem layers are implemented. 

**Drivers:** 
- **overlay2** (modern, default, OverlayFS, fast, efficient)
- **aufs** (legacy, Ubuntu)
- **devicemapper** (RHEL/CentOS 7, direct-lvm for production)
- **btrfs** (requires btrfs filesystem)
- **zfs** (requires zfs)

**overlay2:** lower layers (image, read-only), upper layer (container, writable), merged view. 

**Performance:** overlay2 and btrfs best. 

**Copy-on-write:** writing to read-only file copies to writable layer. 

**Check driver:** `docker info | grep Storage`. 

**Change:** `/etc/docker/daemon.json`, `"storage-driver": "overlay2"`, restart Docker. 

**Data:** `/var/lib/docker/<driver>/`. 

**Production:** overlay2 on ext4/xfs.

---

### 402. Copy-on-Write (CoW)

Never modify original, copy on write. 

**Used in:** filesystems (Btrfs, ZFS), VM disks (qcow2), container layers (overlay2). 

**Mechanism:** data blocks shared (read-only), write creates copy in writable layer, subsequent reads from copy. 

**Benefits:** 
- Space efficiency (share unchanged data)
- Fast snapshots (instant, no copy)
- Isolation (containers don't affect each other)

**Example:** 10 containers from same image share base layers, only writable layer unique. 

**Drawback:** write performance hit (first write to block), workaround: volumes (bypass CoW). 

**Applications:** container images, VM snapshots, filesystem snapshots. 

**Docker:** overlay2 CoW, volumes are native (no CoW overhead).

---

### 403. Container Benchmarking

Measure performance. 

**Metrics:** startup time, memory usage, CPU usage, throughput, latency. 

**Tools:** `docker stats` (real-time usage), cAdvisor (detailed metrics, web UI), Prometheus + cAdvisor exporter (historical), perf (Linux profiler, CPU profiling inside container). 

**Benchmark:** run app, measure under load (e.g., ab, wrk for HTTP), compare with bare-metal, VM. 

**Overhead:** containers ~5% CPU overhead (namespaces, cgroups), ~0% memory (shared kernel), VMs ~10-20% (hypervisor). 

**Network:** slight overhead (NAT, bridge), host network = no overhead. 

**Storage:** overlay2 CoW = write overhead, volumes = native. 

**Optimize:** tune cgroup limits, use host network, use volumes for I/O-heavy.

---

---

### 404. Docker Healthchecks

Monitor container health. Dockerfile: `HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:8080/health || exit 1`. States: starting (grace period), healthy (check passed), unhealthy (check failed). Behavior: orchestrators (K8s, Swarm) can restart unhealthy containers. View: `docker ps` (STATUS), `docker inspect` (State.Health). Override: `docker run --health-cmd`, `--no-healthcheck` (disable). Use case: web apps (HTTP check), databases (connection test), microservices. Best practice: always define healthchecks, check dependencies (DB connection), keep fast (< 10s).

### 405. Docker API & SDK

Automate Docker. REST API: exposed by daemon, `/var/run/docker.sock` (Unix socket) or TCP (port 2375/2376). Endpoints: `/containers/json` (list), `/containers/create`, `/containers/{id}/start`, `/images/json`. curl: `curl --unix-socket /var/run/docker.sock http://localhost/containers/json`. SDKs: Python (docker-py), Go (docker/docker/client), JavaScript, others. Python example: `import docker; client = docker.from_env(); containers = client.containers.list()`. Use case: custom tooling, CI/CD, monitoring, management UI (Portainer). Security: protect socket (bind mount risky), use TLS for TCP. Best practice: use SDK over raw API, implement retries and error handling.

### 406. Docker Build Cache Optimization

Speed up builds. Cache: reuses layers if instruction unchanged. Cache keys: instruction + context (files referenced). Invalidation: any change invalidates cache + all subsequent layers. Strategies: order by change frequency (base image, system packages, app dependencies, code), leverage .dockerignore (exclude unnecessary files), use COPY before RUN (dependencies first), multi-stage (build cache separate). BuildKit cache: `--cache-from` (pull cache from registry), `--cache-to` (push cache). Inline cache: `docker build --build-arg BUILDKIT_INLINE_CACHE=1 -t myimage --push .`. CI: restore cache between builds. Example: COPY package.json → RUN npm install → COPY . (code changes don't invalidate npm install).

### 407. Docker Buildx & Multi-Arch

Build for multiple architectures. Buildx: Docker CLI plugin, uses BuildKit. Multi-arch: amd64, arm64, arm/v7, etc. Setup: `docker buildx create --use` (builder with multi-arch support). Build: `docker buildx build --platform linux/amd64,linux/arm64 -t myimage --push .`. Manifest: single image tag, contains images for each platform, Docker pulls correct one. QEMU: emulation for cross-compilation, `docker run --privileged --rm tonistiigi/binfmt --install all`. Use case: support Raspberry Pi (ARM), Apple Silicon (M1/M2), cloud ARM instances (Graviton). Best practice: use multi-stage to minimize QEMU overhead, test on native hardware if possible.

### 408. Docker Compose Override

Environment-specific configs. Base: `docker-compose.yml` (common), override: `docker-compose.override.yml` (local dev, auto-loaded), `docker-compose.prod.yml` (production, explicit). Merge: `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up`. Override behavior: adds/replaces keys (ports, environment), appends arrays (volumes, networks). Use case: dev (bind mounts, debug ports), prod (resource limits, logging). Example: dev mounts code for live reload, prod uses image. Commands: `-f` multiple times for multiple files, order matters (later overrides earlier). Best practice: keep secrets out of compose files, use env vars or external secrets.

### Category 25: Configuration Management: Ansible (20 concepts)

### 409. Ansible Basics

Configuration management, agentless (SSH). 

**Inventory:** list of hosts, INI or YAML, `inventory.ini`: `[webservers]\nweb1.example.com\nweb2.example.com`. 

**Playbooks:** YAML, define tasks, `playbook.yml`: `- hosts: webservers\n  tasks:\n    - name: Install nginx\n      apt: name=nginx state=present`. 

**Modules:** apt, yum, copy, template, service, command, shell, etc. 

**Run:** `ansible-playbook -i inventory.ini playbook.yml`. 

**Ad-hoc commands:** `ansible webservers -i inventory.ini -m ping`, `ansible all -m shell -a 'uptime'`. 

**Variables:** vars in playbook, `group_vars/`, `host_vars/`. 

**Idempotent:** most modules are. 

**Dry-run:** `--check` flag.

---

### 410. Ansible Roles

Organize playbooks. 

**Structure:** `roles/webserver/` contains `tasks/main.yml`, `handlers/main.yml`, `templates/`, `files/`, `vars/main.yml`, `defaults/main.yml`, `meta/main.yml`. 

**Use:** `- hosts: webservers\n  roles:\n    - webserver`. 

**Tasks:** ordered list of module calls. 

**Handlers:** triggered by notify, run at end, e.g., restart service after config change. 

**Templates:** Jinja2, `template: src=nginx.conf.j2 dest=/etc/nginx/nginx.conf`. 

**Dependencies:** `meta/main.yml` defines role dependencies. 

**Ansible Galaxy:** public role repository, `ansible-galaxy install username.rolename`, `requirements.yml` for dependencies.

---

### 411. Ansible Variables

Define data. 

**Scope:** global, play, host, group. 

**group_vars:** `group_vars/webservers.yml`, apply to inventory group. 

**host_vars:** `host_vars/web1.example.com.yml`, specific host. 

**vars in playbook:** `vars:\n  http_port: 80`. 

**vars_files:** external file, `vars_files:\n  - vars.yml`. 

**Precedence:** role defaults < inventory < group_vars < host_vars < playbook vars < extra vars (CLI). 

**Extra vars:** `ansible-playbook -e "version=1.2.3"`. 

**Facts:** auto-gathered, `ansible_hostname`, `ansible_os_family`, disable: `gather_facts: no`. 

**Register:** save task output, `register: result`, access: `result.stdout`.

---

### 412. Ansible Templates (Jinja2)

Dynamic files. 

**Syntax:** `{{ variable }}`, `{% if condition %}...{% endif %}`, `{% for item in list %}...{% endfor %}`. 

**Filters:** `{{ var | default('default') }}`, `{{ list | join(',') }}`, `{{ var | upper }}`. 

**Template module:** `template: src=config.j2 dest=/etc/config`. 

**Example:** `nginx.conf.j2`: `server_name {{ ansible_hostname }};`. 

**Conditionals:** `{% if env == 'prod' %}...{% endif %}`. 

**Loops:** `{% for user in users %}\nuser {{ user.name }};\n{% endfor %}`. 

**Variables:** access playbook vars, facts. 

**Complex:** use vars for computed values, then reference in template.

---

### 413. Idempotent Configuration

Safe to run multiple times. 

**Ansible modules:** mostly idempotent (apt, copy, template check state first). 

**Command/shell:** not idempotent unless `creates` or `removes` used, `command: /usr/bin/app creates=/path/to/file` (skip if file exists). 

**Handlers:** run only once even if notified multiple times, at end of play. 

**Check mode:** `--check`, preview without changes. 

**Changed:** modules report `changed=true` if modified. 

**Best practice:** prefer declarative modules over shell commands, use creates/removes for non-idempotent commands. 

**Testing:** run twice, second run should report `changed=0`.

---

---

### 414. Ansible Fundamentals

**Purpose:** configuration management, automation, orchestration, agentless (SSH), declarative (YAML), idempotent (safe to run multiple times).

**Architecture:** control node (where you run ansible), managed nodes (targets, servers), inventory (list of hosts), modules (units of work), playbooks (automation scripts).

**Agentless:** uses SSH, no agent on targets, simpler than Puppet/Chef, just needs Python on targets.

**Idempotent:** running same playbook multiple times produces same result, safe, no accidental changes, checks current state before applying.

**Install:** `pip install ansible` or package manager `apt install ansible`, control node only (Linux/Mac, not Windows).

**Config:** `/etc/ansible/ansible.cfg` (global) or `ansible.cfg` in project directory (preferred), configure SSH, inventory path, plugins.

---

### 415. Ansible Inventory

**Purpose:** define managed hosts, groups, variables.

**Format:** INI-style (simple) or YAML.

**INI inventory:**
```ini
[webservers]
web1.example.com
web2.example.com

[databases]
db1.example.com
db2.example.com

[all:children]
webservers
databases
```

**YAML inventory:**
```yaml
all:
  children:
    webservers:
      hosts:
        web1.example.com:
        web2.example.com:
    databases:
      hosts:
        db1.example.com:
```

**Host variables:** `web1.example.com ansible_host=192.168.1.10 ansible_user=admin`.

**Group variables:** `[webservers:vars]`, `http_port=80`.

**Variables in files:** `group_vars/webservers.yml` (group vars), `host_vars/web1.yml` (host-specific).

**Dynamic inventory:** scripts that generate inventory (AWS, GCP, Azure), query cloud APIs, `ansible-inventory --list`.

**Default inventory:** `/etc/ansible/hosts` or specify `-i inventory.ini`.

---

### 416. Ansible Ad-Hoc Commands

**Purpose:** one-off tasks, quick actions, testing, not playbooks.

**Syntax:** `ansible <pattern> -m <module> -a <arguments>`.

**Examples:**
- Ping: `ansible all -m ping`
- Command: `ansible webservers -m command -a "uptime"`
- Shell: `ansible all -m shell -a "df -h"` (supports pipes, redirects)
- Copy file: `ansible all -m copy -a "src=file.txt dest=/tmp/"`
- Install package: `ansible all -m apt -a "name=nginx state=present"` (Debian)
- Restart service: `ansible all -m service -a "name=nginx state=restarted"`
- Gather facts: `ansible all -m setup` (collects system info)

**Options:** `-i inventory.ini` (inventory), `-u username` (SSH user), `--become` (sudo), `--ask-become-pass` (sudo password), `-f 10` (parallelism, forks).

**Use cases:** quick checks, testing connectivity, emergency fixes, exploring modules.

---

### 417. Ansible Playbooks

**Purpose:** automation scripts, declarative, YAML, define desired state.

**Structure:**
```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Start nginx
      service:
        name: nginx
        state: started
        enabled: yes
```

**Plays:** top-level, one or more, targets hosts, contains tasks.

**Tasks:** actions, use modules, idempotent, have names (for logging).

**Modules:** `apt`, `yum`, `service`, `copy`, `template`, `file`, `user`, `git`, hundreds available.

**Run:** `ansible-playbook playbook.yml`, `-i inventory.ini`, `--check` (dry run), `--diff` (show changes).

**Multiple plays:** one playbook, different plays for different hosts, runs sequentially.

---

### 418. Ansible Conditionals

**when:** execute task conditionally.

```yaml
- name: Install apache (Debian)
  apt:
    name: apache2
  when: ansible_os_family == "Debian"

- name: Install httpd (RedHat)
  yum:
    name: httpd
  when: ansible_os_family == "RedHat"
```

**Operators:** `==`, `!=`, `>`, `<`, `>=`, `<=`, `and`, `or`, `not`, `in`.

**Fact-based:** `when: ansible_memory_mb.real.total > 4096`.

**Variable-based:** `when: enable_feature == true`.

**Defined:** `when: myvar is defined`, `when: myvar is not defined`.

**Failed/changed:** `when: result is failed`, `when: result is changed`.

**Multiple conditions:** `when: ansible_os_family == "Debian" and ansible_distribution_version >= "20.04"`.

---

### 419. Ansible Loops

**loop:** iterate over list.

```yaml
- name: Create users
  user:
    name: "{{ item.name }}"
    uid: "{{ item.uid }}"
  loop:
    - { name: alice, uid: 1001 }
    - { name: bob, uid: 1002 }
```

**Simple list:** `loop: [nginx, git, curl]`, access with `{{ item }}`.

**with_items:** older syntax, still works, `with_items: "{{ users }}"`.

**with_dict:** iterate dict, `with_dict: "{{ mydict }}"`, access `{{ item.key }}`, `{{ item.value }}`.

**loop_control:** customize, `loop_control: loop_var: user`, use `{{ user }}` instead of `{{ item }}`.

**register in loop:** `register: results`, `results.results` is list of outputs.

**Use cases:** create multiple users, install packages, configure files, deploy services.

---

### 420. Ansible Handlers

**Purpose:** tasks that run only if notified, avoid redundant restarts, run at end of play (or flushed).

**Define:**
```yaml
handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
```

**Notify:**
```yaml
- name: Update nginx config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: restart nginx
```

**Run once:** handler runs once even if notified multiple times.

**Flush:** `meta: flush_handlers` (run handlers immediately, mid-play).

**Use cases:** restart services after config change, reload systemd, run custom scripts.

---

### 421. Ansible Galaxy

**Purpose:** share/download roles, community-contributed, like Docker Hub for Ansible.

**Install role:** `ansible-galaxy install geerlingguy.nginx`, downloads to `~/.ansible/roles/` or `roles/` (if `ansible.cfg` configured).

**Requirements file:**
```yaml
# requirements.yml
- src: geerlingguy.nginx
- src: geerlingguy.mysql
  version: 3.3.0
```
Install: `ansible-galaxy install -r requirements.yml`.

**Search:** `ansible-galaxy search nginx`, or browse galaxy.ansible.com.

**Popular roles:** geerlingguy.* (Jeff Geerling, high quality), debops.*, many others.

**Create account:** upload your own roles, version control, documentation.

**Best practices:** pin versions in requirements, read role docs, test in dev, review code (security).

---

### 422. Ansible Vault

**Purpose:** encrypt sensitive data (passwords, API keys), store in Git safely.

**Create encrypted file:** `ansible-vault create secrets.yml`, prompts for password, opens editor.

**Edit:** `ansible-vault edit secrets.yml`.

**View:** `ansible-vault view secrets.yml`.

**Encrypt existing:** `ansible-vault encrypt vars.yml`.

**Decrypt:** `ansible-vault decrypt vars.yml`.

**Rekey:** `ansible-vault rekey secrets.yml` (change password).

**Run playbook:** `ansible-playbook playbook.yml --ask-vault-pass` (prompts for password), or `--vault-password-file password.txt` (file with password), or `--vault-id @prompt` (multiple vaults).

**Inline encryption:** `ansible-vault encrypt_string 'secret' --name 'db_password'`, paste output in playbook.

**Best practices:** encrypt sensitive vars, not entire playbooks, `.gitignore` password file, use password manager, consider CI/CD secrets (env vars).

---

### 423. Ansible Facts

**Purpose:** auto-collected system information, use in conditionals, templates.

**Gather:** `ansible all -m setup` (ad-hoc), or auto-gathered at start of play (unless `gather_facts: no`).

**Common facts:**
- `ansible_os_family`: Debian, RedHat, etc.
- `ansible_distribution`: Ubuntu, CentOS, etc.
- `ansible_distribution_version`: 20.04, 8, etc.
- `ansible_hostname`: short hostname.
- `ansible_fqdn`: fully qualified domain name.
- `ansible_default_ipv4.address`: primary IP.
- `ansible_memory_mb.real.total`: total RAM.
- `ansible_processor_vcpus`: CPU cores.
- `ansible_devices`: disks.

**Filter facts:** `ansible all -m setup -a "filter=ansible_os_family"`.

**Custom facts:** place executable in `/etc/ansible/facts.d/*.fact` (INI or JSON), returns key-value pairs, accessible as `ansible_local.filename`.

**Use in playbooks:** `when: ansible_os_family == "Debian"`, `{{ ansible_hostname }}` in templates.

**Disable:** `gather_facts: no` (speeds up playbook if facts not needed).

---

### 424. Ansible Error Handling

**ignore_errors:** continue on failure, `ignore_errors: yes`, use sparingly.

**failed_when:** custom failure condition, `failed_when: result.rc != 0 and result.rc != 2` (fail unless rc 0 or 2).

**changed_when:** custom change detection, `changed_when: "'already' not in result.stdout"` (don't mark changed if "already" in output).

**block/rescue/always:**
```yaml
- block:
    - name: Risky task
      command: /might/fail
  rescue:
    - name: Handle failure
      debug:
        msg: "Task failed, recovering"
  always:
    - name: Cleanup
      file:
        path: /tmp/file
        state: absent
```

**any_errors_fatal:** stop entire playbook on any error, `any_errors_fatal: yes` (at play level).

**max_fail_percentage:** continue if failures below threshold, `max_fail_percentage: 30` (stop if >30% hosts fail).

**Use cases:** retry logic, graceful degradation, ensure cleanup, fail-fast.

---

### 425. Ansible Tags

**Purpose:** run subset of tasks, skip others, faster execution, testing.

**Tag tasks:**
```yaml
- name: Install nginx
  apt:
    name: nginx
  tags: [packages, nginx]

- name: Configure nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  tags: [config, nginx]
```

**Run tags:** `ansible-playbook playbook.yml --tags "nginx"` (only nginx tasks), `--tags "packages,config"` (multiple).

**Skip tags:** `ansible-playbook playbook.yml --skip-tags "config"`.

**List tags:** `ansible-playbook playbook.yml --list-tags`.

**Special tags:** `always` (always run), `never` (never run unless explicitly tagged), `tagged` (all tagged tasks), `untagged`, `all`.

**Use cases:** run only config updates (skip install), test specific part, skip slow tasks.

---

### 426. Ansible Strategies

**Purpose:** control task execution order, parallelism.

**linear (default):** all hosts complete task before next task, sequential tasks, parallel hosts.

**free:** each host runs independently, fast hosts don't wait for slow, maximum speed.

**debug:** interactive, pause before each task, good for troubleshooting.

**Set strategy:**
```yaml
- name: My play
  hosts: all
  strategy: free
  tasks: ...
```

**Forks:** parallel hosts, `ansible-playbook -f 20` (20 hosts at once), default 5, set in `ansible.cfg`.

**serial:** batch execution, `serial: 3` (run on 3 hosts, then next 3), or percentage `serial: "30%"`, useful for rolling updates.

**Use cases:** free for independent tasks, serial for canary/rolling deployments, linear for consistency.

---

### 427. Ansible Delegation and Local Actions

**delegate_to:** run task on different host.

```yaml
- name: Add to load balancer
  command: /add_to_lb.sh {{ inventory_hostname }}
  delegate_to: loadbalancer
```

**local_action:** run on control node (not managed host).

```yaml
- name: Fetch file from managed node
  local_action:
    module: command
    args: scp user@{{ inventory_hostname }}:/path/file /local/path
```

**run_once:** run task only once (on first host), `run_once: yes`, useful for database migrations, deployments.

**wait_for:** wait for condition, `wait_for: port=80 state=started` (wait for port 80 open), `delay=10` (wait 10s before checking), `timeout=300` (fail after 300s).

**Use cases:** update load balancer, database migrations, orchestration, external API calls.

---

### 428. Ansible Best Practices

**Directory structure:** use roles, group_vars, host_vars, separate inventory per environment (dev, staging, prod).

**Idempotency:** ensure tasks are idempotent, use state modules (`state=present`), avoid raw commands.

**Naming:** descriptive task names, helps debugging, log readability.

**Variables:** use group_vars/host_vars, not inline, separate data from logic, defaults in roles.

**Secrets:** encrypt with vault, never commit plaintext passwords.

**Version control:** Git, track playbooks/roles, collaborate, rollback.

**Testing:** test in dev, use `--check` (dry run), `--diff` (see changes), molecule for role testing.

**Tags:** tag tasks, run subsets, faster iterations.

**Documentation:** README in roles, comment complex logic, variable descriptions.

**Linting:** `ansible-lint playbook.yml`, enforces style, catches errors.

---

### 429. Ansible Modules Overview

**Command modules:** `command` (simple), `shell` (supports pipes), `raw` (no Python needed), `script` (runs local script on remote).

**Package modules:** `apt`, `yum`, `dnf`, `package` (auto-detects).

**Service modules:** `service`, `systemd`.

**File modules:** `file` (create/delete/permissions), `copy` (static files), `template` (Jinja2), `fetch` (download from managed node), `lineinfile` (edit line in file), `blockinfile` (insert block), `replace` (regex replace).

**User modules:** `user`, `group`.

**Network modules:** `get_url` (download URL), `uri` (HTTP request).

**Cloud modules:** `ec2`, `azure_rm_*`, `gcp_*`.

**Container modules:** `docker_container`, `docker_image`.

**Database modules:** `mysql_db`, `postgresql_db`.

**Git module:** `git` (clone/update repo).

**Find modules:** `ansible-doc -l` (list all), `ansible-doc module_name` (docs).

---

### 430. Ansible Dynamic Inventory

**Purpose:** auto-generate inventory from cloud/CMDB, always up-to-date, no manual updates.

**AWS:** `aws_ec2` plugin, queries EC2 API, groups by tags, regions, `ansible-inventory -i aws_ec2.yml --graph`.

**Config (aws_ec2.yml):**
```yaml
plugin: aws_ec2
regions:
  - us-east-1
keyed_groups:
  - key: tags.Environment
    prefix: env
```

**GCP:** `gcp_compute` plugin.

**Azure:** `azure_rm` plugin.

**Custom script:** executable that outputs JSON inventory, `--list` (all hosts), `--host <hostname>` (host vars).

**Use cases:** cloud environments, autoscaling groups, dynamic infrastructure.

---

### 431. Ansible Async and Polling

**Purpose:** long-running tasks, avoid SSH timeout, parallel long tasks.

**Async:** run task in background.

```yaml
- name: Long running task
  command: /long_script.sh
  async: 3600  # max time (seconds)
  poll: 0      # don't wait (fire and forget)
  register: job
```

**Check later:**
```yaml
- name: Check status
  async_status:
    jid: "{{ job.ansible_job_id }}"
  register: result
  until: result.finished
  retries: 30
  delay: 10
```

**poll > 0:** check every N seconds, `poll: 10` (check every 10s).

**Use cases:** yum update, apt upgrade, large file downloads, database backups.

---

### 432. Ansible and CI/CD

**Integration:** run playbooks in CI/CD pipelines, automate deployments.

**Jenkins:** Ansible plugin, or execute `ansible-playbook` in shell step, pass inventory, variables.

**GitLab CI:** `.gitlab-ci.yml`, Docker image with Ansible, `script: ansible-playbook deploy.yml`.

**GitHub Actions:** use Ansible action, or install Ansible in step, run playbook.

**Variables from CI:** pass via `--extra-vars`, e.g., `ansible-playbook deploy.yml -e "version=$CI_COMMIT_TAG"`.

**Inventory from CI:** dynamic inventory, or generate from env vars.

**Secrets:** CI/CD secret management (Jenkins credentials, GitLab variables), pass to Ansible.

**Testing:** run `ansible-playbook --check` in CI, syntax check `ansible-playbook --syntax-check`.

**Deployment patterns:** blue-green, canary, rolling updates with Ansible + CI/CD.

---

### 433. Ansible vs Other Tools

**Ansible vs Terraform:**
- Ansible: config management, mutable infrastructure, procedural (tasks), agentless.
- Terraform: infrastructure provisioning, immutable, declarative (state), API-based.
- Use together: Terraform creates infra, Ansible configures servers.

**Ansible vs Puppet/Chef:**
- Ansible: agentless, push-based, YAML, simple, no master server.
- Puppet/Chef: agent-based, pull-based, DSL (Ruby), scalable, master-agent architecture.
- Ansible easier to start, Puppet/Chef better for huge fleets (thousands of servers).

**Ansible vs SaltStack:**
- Similar (agentless mode, YAML), Salt has master-minion, faster (ZeroMQ), more complex.

**Ansible vs Bash scripts:**
- Ansible: declarative, idempotent, reusable (roles), structured.
- Bash: procedural, manual idempotency, harder to maintain, quick for simple tasks.

**Choose Ansible:** config management, multi-server, reusable automation, team collaboration.

---

### 434. Ansible Troubleshooting

**Verbose output:** `ansible-playbook -v` (verbose), `-vv`, `-vvv`, `-vvvv` (max, shows SSH commands).

**Syntax check:** `ansible-playbook --syntax-check playbook.yml`.

**Dry run:** `ansible-playbook --check playbook.yml` (no changes), `--diff` (show what would change).

**Step mode:** `ansible-playbook --step playbook.yml` (confirm each task).

**Limit hosts:** `ansible-playbook --limit webserver1 playbook.yml` (run on subset).

**Start at task:** `ansible-playbook --start-at-task "Install nginx" playbook.yml`.

**Debug module:** `debug: msg="{{ variable }}"`, print variables.

**SSH issues:** `ansible all -m ping`, check SSH keys, `~/.ssh/config`, port, user.

**Fact issues:** `ansible hostname -m setup` (test facts), `gather_facts: no` if slow.

**Module not found:** check Ansible version, `ansible-doc module_name`.

**Slow playbook:** `--forks 20` (more parallelism), `gather_facts: no`, optimize tasks.

---

### 435. Ansible Tower / AWX

**Purpose:** web UI for Ansible, RBAC, scheduling, credentials, logs, enterprise features.

**AWX:** open source, upstream of Tower, self-hosted.

**Tower:** Red Hat product, support, advanced features.

**Features:** web dashboard, inventory management, credential management, job scheduling, RBAC (teams, users, permissions), workflow templates (chain playbooks), REST API, notifications (Slack, email), audit logs.

**Workflow:** create inventory, add credentials, create job template (playbook + inventory + credentials), launch job, view logs.

**Use cases:** self-service for ops, audit trail, scheduled jobs, multi-tenancy, centralized Ansible.

**Alternatives:** Ansible Semaphore (lightweight UI), Jenkins + Ansible plugin, custom dashboards.

---

### Category 26: VM & Compute Management (20 concepts)

### 436. Vagrant Basics

Development environments with VMs. Vagrantfile: Ruby DSL, defines VM config. Box: base image (Ubuntu, CentOS), from Vagrant Cloud. Providers: VirtualBox (default), VMware, Hyper-V, libvirt. Create: `vagrant init ubuntu/focal64`, `vagrant up` (create VM), `vagrant ssh` (connect). Synced folder: host folder → VM (default: project dir → /vagrant). Networking: port forwarding (host:guest), private network (host-only), public network (bridged). Provisioning: shell script, Ansible, Chef, Puppet. Multi-machine: define multiple VMs in one Vagrantfile. Commands: `vagrant halt` (stop), `vagrant destroy` (delete), `vagrant reload` (restart). Use case: local dev, testing, consistent environments.

### 437. Packer Basics

Build machine images. Template: JSON/HCL, defines builders, provisioners, post-processors. Builders: create images (AWS AMI, Azure Image, GCP Image, VirtualBox, VMware, Docker). Provisioners: configure image (shell, Ansible, Chef, file upload). Post-processors: compress, upload. Example: `packer build template.json`. Variables: parameterize templates. Parallel builds: multiple platforms simultaneously. Output: immutable images. Use case: golden images, consistent environments, IaC for images. Commands: `packer validate`, `packer inspect`, `packer build`. Integration: Terraform (data source), CI/CD (automated image builds).

### 438. Cloud-init Advanced

VM initialization. Modules: users, packages, runcmd, write_files, disk_setup. User-data: cloud-config YAML, passed to VM on boot. Network config: static IP, multiple interfaces. Cloud-config modules: run once or per-instance/always. Example: `#cloud-config`, `packages: [nginx]`, `runcmd: [systemctl start nginx]`. Templating: Jinja2 (cloud-init variables). Vendordata: cloud provider config (separate from user-data). Debugging: `/var/log/cloud-init.log`, `/var/log/cloud-init-output.log`. Datasources: EC2, Azure, GCP, NoCloud (for testing). Use case: VM provisioning, auto-scaling, immutable infrastructure.

### 439. Immutable Infrastructure

Replace, don't modify. Concept: never update running servers, deploy new versions. Benefits: consistency (no config drift), rollback (keep old images), testing (same artifact dev → prod). Implementation: build AMIs/images (Packer), deploy via auto-scaling, blue/green or canary. No SSH/manual changes. Configuration: baked into image or fetched at boot (S3, Parameter Store). Stateless: externalize state (databases, S3). Disposable: treat servers as cattle, not pets. Use case: cloud-native apps, CI/CD, high availability. Tools: Terraform, Packer, CloudFormation, K8s (similar concept with pods).

### 440. VM Auto-Scaling

Dynamic capacity. Cloud: Auto Scaling Groups (AWS), Scale Sets (Azure), Instance Groups (GCP). Metrics: CPU, memory, custom (request count, queue depth). Policies: target tracking (maintain 50% CPU), step scaling (add 2 instances if CPU > 70%), scheduled scaling (scale up at 9am). Cooldown: wait period after scaling action (prevent flapping). Health checks: replace unhealthy instances. Launch template: AMI, instance type, security groups, user-data. Min/max/desired capacity. Use case: handle traffic spikes, cost optimization (scale down when idle), high availability.

### 441. VM Monitoring & Logging

Observability. Metrics: CloudWatch (AWS), Azure Monitor, GCP Monitoring, custom metrics (StatsD, Prometheus). Agent: collect system metrics (CPU, disk, memory, logs). Logs: CloudWatch Logs, Azure Monitor Logs, GCP Logging, centralized (ELK, Loki). Dashboards: visualize metrics, set alerts. Alarms: trigger on thresholds (CPU > 80%, disk full). Actions: SNS notification, auto-scaling, Lambda. Distributed tracing: X-Ray (AWS), App Insights (Azure), Cloud Trace (GCP). Use case: troubleshooting, performance optimization, capacity planning, alerting.

### 442. VM Backup & Disaster Recovery

Data protection. Backups: snapshots (EBS, Azure Disk, GCP Persistent Disk), AMIs (full VM image), cross-region replication. Snapshot schedule: daily, weekly, retention policy. Incremental: only changed blocks (efficient). Restore: create new volume/VM from snapshot. Disaster recovery: backup region, RTO/RPO targets. Automated: AWS Backup, Azure Backup, GCP Cloud Backup, scripts (Lambda, cron). Testing: verify backups regularly. Use case: ransomware protection, human error, compliance, regional failure.

### 443. VM Cost Optimization

Reduce cloud spend. Right-sizing: match instance type to workload (t3 for burstable, c5 for CPU-intensive). Reserved instances: 1-3 year commitment, up to 72% savings. Savings plans: flexible RIs. Spot instances: up to 90% off, interruptible. Auto-scaling: scale down when idle. Stop unused: evenings/weekends (dev/test environments). Delete orphaned: EBS volumes, snapshots, AMIs, Elastic IPs. Monitoring: Cost Explorer, Trusted Advisor, CloudHealth. Tagging: cost allocation, showback. Use case: budget control, FinOps, resource accountability.

### 444. VM Networking Deep Dive

Connect VMs. Subnets: isolate resources, public (internet gateway), private (NAT gateway). Security groups: instance-level firewall, stateful. NACLs: subnet-level, stateless. Routing: route tables, custom routes. Load balancers: distribute traffic (ALB/NLB/CLB for AWS, Azure LB/App Gateway, GCP LB). Private connectivity: VPN (site-to-site, client), Direct Connect (AWS), ExpressRoute (Azure), Interconnect (GCP). DNS: Route 53 (AWS), Azure DNS, Cloud DNS (GCP). Use case: multi-tier apps, hybrid cloud, security isolation, HA.

### 445. VM Storage Types

Persistent storage. Block storage: EBS (AWS), Azure Disk, GCP Persistent Disk, attached to VM, SSD (gp3, io2) or HDD (st1, sc1). Shared storage: EFS (AWS), Azure Files, GCP Filestore, NFS/SMB, multiple VMs. Object storage: S3 (AWS), Azure Blob, GCS (GCP), not mounted, API access. Ephemeral: instance store (AWS), temporary disk (Azure), local SSD (GCP), lost on stop. Snapshots: backups, incremental. Performance: IOPS, throughput, size. Use case: databases (io2, high IOPS), shared config (EFS), logs/backups (S3).

### 446. Infrastructure as Code for VMs

Manage VMs with code. Terraform: provision VMs, networks, storage, cross-cloud. CloudFormation (AWS), ARM/Bicep (Azure), Deployment Manager (GCP): cloud-native IaC. Modules: reusable VM templates. State: track resources, detect drift. Immutable: replace VMs instead of updating. Provisioners: avoid (use user-data or Packer). Best practice: version control, CI/CD pipelines, code review. Example: Terraform creates VPC, subnet, security group, EC2 instance from AMI. Use case: reproducible infrastructure, disaster recovery, multi-environment (dev/stage/prod).

### 447. VM Security Hardening

Reduce attack surface. OS: apply patches, disable unnecessary services. Users: no root login, SSH keys (no passwords), sudo for privilege escalation. Firewall: iptables, nftables, cloud security groups (least privilege). Encryption: disk encryption (LUKS, BitLocker), EBS encryption, TLS for traffic. Secrets: no hardcoded, use Parameter Store, Secrets Manager, Vault. Monitoring: fail2ban (block brute force), auditd (log access), intrusion detection (OSSEC, Wazuh). Hardening guides: CIS benchmarks, STIG. Use case: compliance, prevent breaches, secure production workloads.

### 448. VM High Availability

Minimize downtime. Multi-AZ: deploy across availability zones (AWS), availability sets/zones (Azure), zones (GCP). Load balancer: health checks, failover to healthy instances. Auto-scaling: replace failed instances. Redundancy: database replication, shared storage. Stateless: no local state, can terminate any instance. Health checks: application-level (not just ping). RTO/RPO: recovery time/point objectives, design for targets. Use case: mission-critical apps, SLA requirements, customer-facing services. Architecture: active-active (all instances serve traffic) or active-passive (standby for failover).

### 449. VM Performance Tuning

Optimize workload. CPU: choose right instance type (compute optimized c5, memory optimized r5, general purpose m5). Placement groups: cluster (low latency), partition (isolated failures), spread (max availability). Enhanced networking: SR-IOV (higher bandwidth, lower latency). Storage: provisioned IOPS (io2), multiple EBS volumes (RAID), local NVMe. Kernel: tune network stack (sysctl), increase file descriptors (ulimit). Monitoring: CloudWatch, top, iostat, sar. Profiling: perf, flamegraphs. Use case: databases, HPC, latency-sensitive apps.

### 450. VM Migration Strategies

Move workloads. Lift-and-shift: move VMs as-is (minimal changes), quick but not cloud-native. Re-platform: minor optimizations (managed DB, auto-scaling). Re-architect: redesign for cloud (microservices, serverless). Tools: AWS MGN (Application Migration Service), Azure Migrate, Migrate for Compute Engine (GCP), CloudEndure. Strategies: pilot (small workload first), phased (app by app), big-bang (all at once). Discovery: inventory on-prem (dependencies, sizing). Testing: validate functionality, performance, cost. Use case: datacenter exit, modernization, cost reduction.

### 451. Spot/Preemptible Instances

Low-cost compute. Spot instances (AWS): up to 90% off, can be terminated with 2 min notice. Preemptible VMs (GCP): similar, max 24h runtime. Spot VMs (Azure): flexible pricing. Use cases: batch jobs, CI/CD, big data, fault-tolerant apps. Strategies: spot fleets (request multiple instance types/AZs), spot instances + on-demand (hybrid), checkpointing (save state periodically). Interruption: handle gracefully (trap SIGTERM, save work). Pricing: variable market price, set max price (spot requests). Not suitable for: stateful apps, databases, customer-facing (without redundancy).

### 452. VM Orchestration

Manage fleets. Cloud orchestration: CloudFormation (AWS), ARM (Azure), Deployment Manager (GCP), Terraform (multi-cloud). Compute services: EC2 Auto Scaling (AWS), Scale Sets (Azure), Instance Groups (GCP). Configuration: Ansible, Puppet, Chef (post-provisioning). Serverless: Lambda (AWS), Functions (Azure), Cloud Functions (GCP), alternative to VMs. Containers: ECS (AWS), AKS (Azure), GKE (GCP), lighter than VMs. Workflow: Terraform provisions infrastructure → Packer builds images → Auto-Scaling deploys → Ansible configures. Use case: large-scale deployments, dynamic environments, automation.

### 453. VM Tagging & Resource Management

Organize resources. Tags: key-value pairs (Environment:prod, CostCenter:engineering, Owner:team-a). Uses: cost allocation, automation (tag-based policies), search/filter. Best practices: mandatory tags (enforce with policies), naming convention, automation (tag on creation). AWS: tag EC2, EBS, AMIs, `aws ec2 describe-instances --filters "Name=tag:Environment,Values=prod"`. Azure: tags on resources/RGs, cost analysis by tag. GCP: labels (similar), billing export. Automation: tag instances from launch template, Lambda to enforce tags. Use case: cost tracking, environment separation, compliance, lifecycle management.

### 454. VM Patching & Update Management

Keep systems secure. Manual: SSH to VM, `apt update && apt upgrade` (Debian), `yum update` (RHEL). Automated: AWS Systems Manager Patch Manager (patch baselines, maintenance windows), Azure Update Management, GCP OS Patch Management. Configuration: patch on schedule (weekly), test patches (staging first), reboot if required. Golden images: bake patches into AMI (Packer), replace VMs (immutable). Windows: WSUS, Azure Update Management. Compliance: report patch status, remediate. Use case: security patches, compliance (PCI-DSS), reduce vulnerabilities. Best practice: automate patching, test before prod, monitor for drift.

### 455. Hybrid Cloud & On-Prem VMs

Connect cloud and datacenter. Connectivity: VPN (IPsec, site-to-site), dedicated connection (Direct Connect, ExpressRoute, Interconnect). Use cases: migration (gradual), bursting (scale to cloud), disaster recovery (backup region), compliance (keep data on-prem). Hybrid platforms: AWS Outposts (AWS hardware on-prem), Azure Stack (Azure on-prem), Anthos (GCP multi-cloud). Networking: extend VPC to on-prem, routing, DNS resolution. Authentication: hybrid identity (AD Federation, Azure AD Connect). Management: unified control plane (AWS Console, Azure Portal). Use case: regulated industries, legacy apps, data residency.

### Category 27: Kubernetes Basics I: Core Concepts (18 concepts)

### 456. Cluster Architecture

Distributed system for containers. 

**Control plane:** manages cluster, runs on master nodes, components: API server (kube-apiserver, REST API, auth, admission), etcd (distributed key-value store, cluster state), Scheduler (kube-scheduler, assigns pods to nodes), Controller manager (kube-controller-manager, reconciliation loops), Cloud controller manager (cloud-specific, optional). 

**Worker nodes:** run pods, components: kubelet (node agent, manages pods, reports to API server), kube-proxy (network proxy, iptables/ipvs rules for services), Container runtime (containerd, CRI-O). 

**Communication:** all components talk to API server (not each other), TLS encrypted, RBAC auth. 

**HA:** multiple masters (odd number, typically 3 or 5), load balancer in front, etcd quorum.

---

### 457. Kubernetes API

RESTful HTTP API. 

**Resources:** pods, services, deployments, etc., API groups: core (no group in URL), apps/v1, batch/v1, etc. 

**URL format:** `/api/v1/namespaces/{ns}/pods` (core), `/apis/apps/v1/namespaces/{ns}/deployments` (apps). 

**Methods:** GET (read), POST (create), PUT (replace), PATCH (update), DELETE (delete). 

**Authentication:** client cert, bearer token, OIDC. 

**Authorization:** RBAC (roles, bindings). 

**Admission:** validating/mutating webhooks (modify/validate before persisting). 

**Watch:** WebSocket stream, real-time updates (`watch=true`). 

**kubectl:** CLI, talks to API, `kubectl get pods` → `GET /api/v1/namespaces/default/pods`. 

**Client libraries:** client-go (Go), Python, Java. 

**API discovery:** `/api`, `/apis` (list groups/versions).

---

### 458. Pod Abstraction

Smallest deployable unit. 

**Definition:** group of one or more containers, shared network (IP, port space), shared volumes, scheduled together, co-located. 

**Use cases:** sidecar (logging, proxy), init containers (setup before main), multi-container (tightly coupled). 

**Lifecycle:** Pending (scheduling), Running, Succeeded (completed), Failed, Unknown. 

**Pod spec:** YAML, `apiVersion: v1`, `kind: Pod`, `metadata`, `spec` (containers, volumes, etc.). 

**Single container:** most common, one app per pod. 

**Networking:** all containers in pod share localhost, use different ports. 

**Storage:** volumes mounted to containers. 

**Ephemeral:** pods are cattle, not pets, can be killed anytime. 

**IP:** each pod gets unique IP (CNI assigns). 

**View:** `kubectl get pods`, `kubectl describe pod`.

---

### 459. Pod Lifecycle

Phases and conditions. 

**Phases:** Pending (accepted, not running, waiting for scheduling/image pull), Running (at least one container running), Succeeded (all containers exited 0), Failed (containers exited non-zero), Unknown (communication error). 

**Conditions:** PodScheduled (assigned to node), ContainersReady (all ready), Initialized (init containers complete), Ready (pod ready to serve). 

**Init containers:** run before app containers, sequentially, must succeed, use: setup, fetch secrets, wait for dependencies. 

**Container states:** Waiting (not running, ImagePullBackOff, CrashLoopBackOff), Running, Terminated (exited). 

**Restart policy:** Always (default), OnFailure, Never. 

**Hooks:** postStart (after container starts), preStop (before termination, grace period). 

**Termination:** SIGTERM → grace period (default 30s) → SIGKILL. 

**Status:** `kubectl get pod -o yaml` (status field).

---

### 460. Controllers & Reconciliation

Ensure desired state. 

**Controller pattern:** watch API server for resource changes, compare actual vs desired state, take action to converge. 

**Reconciliation loop:** watch → compare → act → repeat. 

**Level-triggered:** check full state, not just changes (idempotent). 

**Built-in controllers:** Deployment, ReplicaSet, DaemonSet, StatefulSet, Job, CronJob, etc. 

**Custom controllers:** operator pattern, watch CRDs, implement domain logic. 

**Informers:** client-go mechanism, watch resources, local cache, event handlers (add/update/delete). 

**Work queue:** process events asynchronously, retries on failure. 

**Lease:** leader election for HA controllers (only one active). 

**Code:** `k8s.io/client-go`, `sigs.k8s.io/controller-runtime`. 

**Example:** ReplicaSet controller ensures replica count matches spec.

---

### 461. ReplicaSet

Maintains pod replicas. 

**Purpose:** ensure N pods running, replace failed pods, scale up/down. 

**Spec:** replicas (desired count), selector (label selector to match pods), pod template (blueprint). 

**Scaling:** `kubectl scale rs myrs --replicas=5`. 

**Selectors:** matchLabels (equality), matchExpressions (set-based). 

**Ownership:** RS creates pods with ownerReferences, deletes on RS delete (unless `--cascade=orphan`). 

**Rarely used directly:** Deployment manages RS. 

**Use case:** if you need manual control (no rolling updates). 

**Status:** replicas, readyReplicas, availableReplicas. 

**View:** `kubectl get rs`, `kubectl describe rs`.

---

### 462. Deployment

Declarative updates for pods. 

**Manages ReplicaSets:** creates RS, rolling updates create new RS + scale down old RS. 

**Spec:** replicas, selector, template (pod spec), strategy (RollingUpdate, Recreate). 

**Rolling update:** maxUnavailable (max pods down during update), maxSurge (max extra pods during update). 

**Rollout:** `kubectl rollout status deployment`, `kubectl rollout history deployment`, `kubectl rollout undo deployment` (rollback). 

**Revision history:** revisionHistoryLimit (default 10), old RS kept for rollback. 

**Pause/resume:** `kubectl rollout pause/resume` (manual control). 

**Strategy:** RollingUpdate (default, gradual), Recreate (kill all, then create, downtime). 

**Use:** stateless apps, most common. 

**View:** `kubectl get deploy`, YAML: `kubectl get deploy -o yaml`.

---

### 463. StatefulSet

Stateful applications. 

**Ordered deployment:** pods created sequentially (0, 1, 2, ...), deleted in reverse. 

**Stable network ID:** `pod-0.service.namespace.svc.cluster.local` (predictable DNS). 

**Persistent storage:** volumeClaimTemplates (each pod gets PVC, PVC retained on pod delete). 

**Use:** databases, distributed systems (Kafka, Cassandra, etcd). 

**Headless service:** `clusterIP: None`, DNS for each pod (no load balancing). 

**Update strategies:** RollingUpdate (ordered), OnDelete (manual). 

**Partition:** RollingUpdate can update subset (`spec.updateStrategy.rollingUpdate.partition`). 

**Scaling:** ordinal-based, safe for stateful apps. 

**Pod identity:** pod name + ordinal, stable across reschedule. 

**No guarantee:** not for all stateful apps, consider operators for complex apps.

---

### 464. DaemonSet

One pod per node. 

**Use cases:** node-level agents (logging: Fluentd, monitoring: node-exporter, networking: CNI, storage: CSI drivers). 

**Scheduling:** ignores taints by default (unless tolerations specified), runs even on masters (if toleration added), schedules to new nodes automatically. 

**Update:** RollingUpdate (default, one node at a time), OnDelete (manual). 

**Node selector:** nodeSelector field to target specific nodes. 

**Tolerations:** run on tainted nodes (e.g., master: `node-role.kubernetes.io/master:NoSchedule`). 

**Eviction:** DS pods not evicted (unless node drained). 

**Use:** cluster-wide services. 

**View:** `kubectl get ds`, typical in kube-system namespace.

---

### 465. Job & CronJob

Batch workloads. 

**Job:** run pod to completion, retries on failure, tracks completions. 

**Spec:** completions (total), parallelism (concurrent pods), backoffLimit (max retries, default 6), activeDeadlineSeconds (timeout). 

**Completion modes:** NonIndexed (default, any pod completes), Indexed (pods numbered 0..N-1). 

**Pod failure:** Job creates new pod (up to backoffLimit), respects restartPolicy: OnFailure (restart container) or Never (new pod). 

**CronJob:** creates Jobs on schedule. 

**Schedule:** cron syntax, `0 2 * * *` (2 AM daily), `*/5 * * * *` (every 5 minutes). 

**Concurrency:** concurrencyPolicy (Allow, Forbid, Replace). 

**History:** successfulJobsHistoryLimit, failedJobsHistoryLimit (retain completed Jobs). 

**Use:** batch processing, data pipelines, reports. 

**View:** `kubectl get jobs`, `kubectl get cronjobs`.

---

### 466. Service Types

Expose pods. 

**ClusterIP (default):** internal IP, accessible within cluster only, `http://service.namespace.svc.cluster.local`. 

**NodePort:** exposes on each node's IP at static port (30000-32767), accessible externally via `NodeIP:NodePort`. 

**LoadBalancer:** cloud provider creates external load balancer, assigns external IP, routes to NodePort. 

**ExternalName:** CNAME to external service, `spec.externalName: example.com`, no proxy, DNS resolution. 

**Headless (ClusterIP: None):** no load balancing, returns pod IPs directly, used with StatefulSet. 

**Selector:** label selector to target pods. 

**Endpoints:** list of pod IPs + ports backing service, auto-updated by Endpoints controller. 

**View:** `kubectl get svc`, `kubectl describe svc`.

---

### 467. Service Discovery (K8s)

Find services. 

**DNS:** CoreDNS (kube-dns), each service gets DNS record, `service.namespace.svc.cluster.local` resolves to ClusterIP, SRV records for ports. 

**Environment variables:** injected into pods at creation, `SERVICE_HOST`, `SERVICE_PORT` (for services created before pod). 

**Endpoints API:** watch endpoints object to get pod IPs dynamically (client-side load balancing). 

**Headless service:** DNS returns pod IPs (A records), no ClusterIP. 

**External services:** ExternalName (DNS CNAME), or Endpoints without selector (manual IPs). 

**Service mesh:** Envoy/Linkerd sidecars intercept traffic, discover via control plane. 

**Use DNS for most cases,** environment variables for legacy, endpoints API for advanced (load balancing, health).

---

### 468. kube-proxy Modes

Implement services. 

**iptables (default most clusters):** creates iptables rules for each service, DNAT to pod IPs, random pod selection, kernel packet processing, handles thousands of services, connection-level load balancing. 

**IPVS (IP Virtual Server):** kernel load balancer, supports more algorithms (rr, lc, wrr, etc.), better performance at scale (>1000 services), requires kernel modules (ip_vs). 

**userspace (legacy):** kube-proxy proxies traffic in user space, slow, deprecated. 

**kernelspace (Windows):** similar to iptables/IPVS but for Windows. 

**Mode selection:** `--proxy-mode` flag to kube-proxy, auto-detects if not specified. 

**Check:** `iptables-save | grep <service>` (iptables mode), `ipvsadm -Ln` (IPVS mode). 

**eBPF (Cilium):** replaces kube-proxy, eBPF programs, more efficient.

---

### 469. Ingress Controllers

L7 routing. 

**Ingress resource:** defines HTTP/HTTPS routing rules (host, path → backend service). 

**Ingress controller:** watches Ingress resources, configures load balancer/proxy (nginx, Traefik, HAProxy, Envoy). 

**Spec:** rules (host, paths), backend (service, port), TLS (secret with cert). 

**Example:** `host: example.com`, `path: /api` → `api-service:80`, `path: /` → `web-service:80`. 

**TLS termination:** tls section with secret (TLS cert/key). 

**Annotations:** controller-specific config, `nginx.ingress.kubernetes.io/rewrite-target: /`. 

**Default backend:** 404 handler for unmatched requests. 

**Multiple controllers:** use ingressClassName to specify which controller. 

**Install:** nginx-ingress (helm chart), Traefik Operator. 

**External access:** LoadBalancer service for controller (cloud), NodePort (on-prem).

---

### 470. Ingress Resources

Define L7 rules. 

**Spec:** rules (list of hosts), each rule has `http.paths` (path matching, pathType: Prefix/Exact/ImplementationSpecific), backend (service name, port). 

**Host-based:** `host: api.example.com` → api-service, `host: web.example.com` → web-service. 

**Path-based:** `path: /api` → api-service, `path: /web` → web-service (same host). 

**TLS:** tls section, hosts, secretName (TLS secret). 

**Default backend:** fallback, `spec.defaultBackend`. 

**Annotations:** controller-specific, rewrites, timeouts, rate limiting. 

**Example:** `apiVersion: networking.k8s.io/v1`, `kind: Ingress`. 

**IngressClass:** select controller, `spec.ingressClassName`. 

**View:** `kubectl get ingress`, `kubectl describe ingress`.

---

### 471. Network Plugins (CNI)

Container Network Interface, K8s networking. 

**CNI:** standard interface, plugin manages pod networking (IP allocation, routing). 

**Implementations:** Calico (L3, BGP, network policies, scalable), Cilium (eBPF, fast, network policies, service mesh), Flannel (simple, overlay, no network policies), Weave (mesh, encryption), Canal (Flannel + Calico policies). 

**Requirements:** pod-to-pod (all pods can communicate), pod-to-service, external-to-service (ingress). 

**IPAM:** IP Address Management, CNI allocates pod IPs from pool. 

**Network policies:** Calico/Cilium support, enforce L3/L4 rules. 

**Choose:** Calico (most features, battle-tested), Cilium (eBPF, modern), Flannel (simple, learning). 

**Install:** typically via manifest or helm, configures each node. 

**Config:** `/etc/cni/net.d/` on nodes, CNI binary in `/opt/cni/bin/`.

---

### 472. ConfigMap

Store configuration. 

**Key-value pairs:** env vars, command-line args, config files. 

**Create:** `kubectl create configmap myconfig --from-literal=key=value`, `--from-file=config.properties`, `--from-file=/path/to/dir/` (all files in dir). 

**Use in pod:** 
- **env** (`valueFrom.configMapKeyRef`)
- **envFrom** (all keys as env vars)
- **volume** (mount as files)

**Example env:** 
```yaml
env:
  - name: DB_HOST
    valueFrom:
      configMapKeyRef:
        name: myconfig
        key: DB_HOST
```

**Volume:** 
```yaml
volumes:
  - name: config
    configMap:
      name: myconfig
volumeMounts:
  - name: config
    mountPath: /etc/config
```

**Immutable:** `immutable: true` (prevent updates, better performance, cache-friendly). 

**Update:** edit ConfigMap, pods need restart (unless app watches files). 

**Size limit:** 1MB per ConfigMap. 

**Use:** app config, feature flags, environment-specific settings. 

**View:** `kubectl get cm`, `kubectl describe cm myconfig`, `kubectl get cm myconfig -o yaml`.

---

### 473. Secret

Store sensitive data. 

**Base64 encoded:** not encrypted in etcd by default (enable encryption at rest). 

**Types:** Opaque (generic), `kubernetes.io/service-account-token`, `kubernetes.io/dockerconfigjson` (image pull), `kubernetes.io/tls` (TLS cert/key), `kubernetes.io/ssh-auth`, `kubernetes.io/basic-auth`. 

**Create:** `kubectl create secret generic mysecret --from-literal=password=abc123`, `--from-file=ssh-key=~/.ssh/id_rsa`, TLS: `kubectl create secret tls tls-secret --cert=cert.pem --key=key.pem`. 

**Use:** same as ConfigMap (env, envFrom, volume). 

**Volume:** files permissions 0400. 

**Image pull secret:** `imagePullSecrets: [{ name: regcred }]`, create: `kubectl create secret docker-registry regcred --docker-server=... --docker-username=... --docker-password=...`. 

**Encryption at rest:** EncryptionConfiguration, kube-apiserver flag `--encryption-provider-config`. 

**External secrets:** External Secrets Operator syncs from Vault/AWS Secrets Manager. 

**Best practice:** use external secret store, rotate regularly, RBAC restrict access. 

**View:** `kubectl get secret`, decode: `kubectl get secret mysecret -o jsonpath='{.data.password}' | base64 -d`.

---

### Category 28: Kubernetes Basics II: Workloads (18 concepts)

### 474. Resource Requests

Guaranteed resources for scheduling. 

**Requests:** minimum resources pod needs, scheduler uses to place pod, node must have available. 

**Spec:** `resources.requests.cpu`, `resources.requests.memory`. 

**CPU:** millicores, `500m` = 0.5 core, `1` = 1 core. 

**Memory:** bytes, `128Mi` (mebibyte), `1Gi` (gibibyte). 

**Scheduling:** scheduler sums requests of all pods on node, schedules only if node has capacity. 

**No request:** pod considered BestEffort QoS, can run on any node. 

**Overcommit:** sum of requests can exceed node capacity (kubernetes allows), but not guaranteed. 

**Example:** `requests: { cpu: 100m, memory: 128Mi }`. 

**Burstable:** requests < limits, can use more if available. 

**View:** `kubectl describe node` (allocated resources), `kubectl top pod` (actual usage).

---

### 475. Resource Limits

Maximum resources pod can use. 

**Limits:** upper bound, cgroup enforcement, pod killed if exceeded (OOM for memory). 

**Spec:** `resources.limits.cpu`, `resources.limits.memory`. 

**CPU throttling:** if pod exceeds CPU limit, throttled (not killed), `cpu.cfs_period_us`, `cpu.cfs_quota_us` in cgroups. 

**Memory:** if pod exceeds memory limit, OOMKilled, container restarted (if restartPolicy allows). 

**No limit:** pod can use all node resources (dangerous, noisy neighbor). 

**Ratio:** typically limits = 2-4x requests, depends on app. 

**LimitRange:** namespace-level defaults/constraints, `kubectl create limitrange`. 

**Example:** `limits: { cpu: 500m, memory: 512Mi }`. 

**Best practice:** always set requests, set limits for memory (prevent OOM cascade), optional limits for CPU (allow bursting). 

**View:** `kubectl describe pod` (limits), cgroups: `/sys/fs/cgroup/kubepods/...`.

---

### 476. Quality of Service (QoS)

Pod eviction priority. 

**Classes:** 
- **Guaranteed** (requests = limits for all containers, all resources), highest priority, last evicted. 
- **Burstable** (at least one container has request or limit, not Guaranteed), medium priority. 
- **BestEffort** (no requests/limits), lowest priority, first evicted. 

**Eviction:** kubelet evicts pods when node resources critical (memory, disk pressure), evicts BestEffort first, then Burstable (lowest usage relative to request), then Guaranteed. 

**Node pressure:** MemoryPressure, DiskPressure, PIDPressure. 

**Thresholds:** `--eviction-hard` (immediate), `--eviction-soft` (grace period), e.g., `memory.available<100Mi`. 

**View QoS:** `kubectl get pod -o jsonpath='{.status.qosClass}'`. 

**Design:** critical pods Guaranteed, batch BestEffort, most apps Burstable. 

**PodDisruptionBudget:** protect from voluntary evictions (drain, upgrade).

---

### 477. Liveness Probes

Restart unhealthy containers. 

**Purpose:** detect deadlocks, restart stuck containers, self-healing. 

**Types:** HTTP (`httpGet`, path, port, httpHeaders), TCP (`tcpSocket`, port), Exec (`exec.command`, exit 0 = healthy). 

**Config:** `initialDelaySeconds` (wait after start), `periodSeconds` (check frequency), `timeoutSeconds` (probe timeout), `successThreshold` (consecutive successes), `failureThreshold` (consecutive failures to restart, default 3). 

**Failure:** kubelet restarts container (restartPolicy). 

**Example:** `livenessProbe: { httpGet: { path: /healthz, port: 8080 }, initialDelaySeconds: 15, periodSeconds: 10 }`. 

**Caution:** don't restart on dependency failure (DB down), only on app deadlock. 

**Startup probe:** separate for slow-starting apps, disables liveness until healthy. 

**View:** `kubectl describe pod` (events show probe failures).

---

### 478. Readiness Probes

Control traffic routing. 

**Purpose:** remove pod from service endpoints if not ready, prevents sending traffic to initializing/unhealthy pods. 

**Same types as liveness:** HTTP, TCP, Exec. 

**Failure:** pod marked not ready, removed from service load balancing, not restarted. 

**Use cases:** app initialization (loading cache, connecting to DB), dependency checks (DB unavailable), graceful degradation. 

**Example:** `readinessProbe: { httpGet: { path: /ready, port: 8080 }, periodSeconds: 5 }`. 

**Different from liveness:** readiness = "can I serve traffic?", liveness = "am I alive?". 

**Rolling updates:** new pods must be ready before old pods terminated. 

**Best practice:** always implement readiness, different endpoint from liveness. 

**View:** `kubectl get pod` (READY column shows ready/total containers).

---

### 479. Startup Probes

Handle slow-starting apps. 

**Purpose:** give apps long startup time without interfering with liveness probes, separate probe for startup phase. 

**Overrides liveness:** liveness probe disabled until startup succeeds. 

**Config:** same as liveness/readiness, but failureThreshold can be much higher (e.g., 30), `periodSeconds` 10s → 300s max startup time. 

**Example:** `startupProbe: { httpGet: { path: /healthz, port: 8080 }, failureThreshold: 30, periodSeconds: 10 }`. 

**After success:** startup probe stops, liveness/readiness probes take over. 

**Use:** legacy apps (slow boot), JVM apps (long class loading), data loading apps. 

**Without startup probe:** set high `initialDelaySeconds` on liveness (but delays detecting failure after restart). 

**Added:** Kubernetes 1.16+. 

**View:** `kubectl describe pod` (events show startup probe).

---

### 480. Horizontal Pod Autoscaler (HPA)

Scale pods based on metrics. 

**Metrics:** CPU utilization (built-in), memory (built-in), custom metrics (from Prometheus via adapter). 

**Spec:** scaleTargetRef (Deployment/RS/StatefulSet), minReplicas, maxReplicas, metrics (type, target). 

**CPU example:** `targetAverageUtilization: 50` (scale to keep avg CPU at 50% of requests). 

**Algorithm:** `desiredReplicas = ceil(currentReplicas * currentMetric / targetMetric)`. 

**Cooldown:** `--horizontal-pod-autoscaler-downscale-stabilization` (default 5min, prevent flapping). 

**Custom metrics:** Prometheus adapter exposes metrics to K8s, HPA uses them, e.g., `type: Pods`, `pods.metric.name: http_requests_per_second`. 

**Create:** `kubectl autoscale deployment myapp --cpu-percent=50 --min=2 --max=10`. 

**Requirements:** metrics-server installed, resource requests set (for CPU/memory %). 

**View:** `kubectl get hpa`, `kubectl describe hpa`. 

**v2:** supports multiple metrics, behavior configuration.

---

### 481. Vertical Pod Autoscaler (VPA)

Right-size resource requests/limits. 

**Purpose:** automatically adjust requests based on actual usage, avoid under/over-provisioning. 

**Modes:** Auto (update running pods, evicts/recreates), Recreate (apply on pod restart only), Initial (set requests at creation), Off (recommend only, no updates). 

**Components:** Recommender (analyzes usage, suggests values), Updater (evicts pods if needed), Admission controller (applies recommendations at creation). 

**Metrics:** historical usage from metrics-server or Prometheus. 

**Spec:** targetRef (Deployment), updatePolicy.updateMode, resourcePolicy (which containers/resources to update). 

**Limitations:** can't use with HPA on CPU/memory (conflict), pod eviction (recreates pods). 

**Use:** apps with variable usage, batch jobs, cost optimization. 

**Install:** manifest or helm. 

**View:** `kubectl get vpa`, recommendations in status.

---

### 482. Cluster Autoscaler

Scale nodes based on pending pods. 

**Purpose:** add nodes when pods can't be scheduled (insufficient resources), remove nodes when underutilized. 

**Scale up:** pending pods → CA requests new node from cloud provider → node joins → pods scheduled. 

**Scale down:** node utilization low (< 50% by default, configurable), no non-daemonset pods (or all can be moved), PodDisruptionBudget allows, waits 10min (configurable) → drains node → deletes node. 

**Protected pods:** local storage, non-replicated, PDB violated. 

**Cloud provider:** AWS Auto Scaling Groups, GCP Managed Instance Groups, Azure VMSS. 

**Config:** `--scale-down-enabled`, `--scale-down-utilization-threshold`, `--scale-down-delay-after-add`, node group min/max. 

**Annotations:** `cluster-autoscaler.kubernetes.io/safe-to-evict: "true"` (force allow eviction). 

**Install:** deployment in cluster, IAM permissions to manage nodes. 

**Monitor:** logs, events. 

**Challenges:** startup time (minutes), costs, IP exhaustion.

---

### 483. PersistentVolume (PV)

Cluster-level storage resource. Lifecycle independent from Pods. Types: hostPath (local, testing only), NFS, iSCSI, cloud (AWS EBS, Azure Disk, GCP PD), CSI (Container Storage Interface). Capacity: storage size. Access modes: ReadWriteOnce (RWO, single node), ReadOnlyMany (ROX, multiple nodes read), ReadWriteMany (RWX, multiple nodes read/write). Reclaim policy: Retain (manual cleanup), Delete (auto-delete), Recycle (deprecated). Provisioning: static (admin pre-creates PV) or dynamic (StorageClass auto-creates). Example: `kubectl get pv`, `kubectl describe pv pv-name`. Use case: databases, shared storage.

### 484. PersistentVolumeClaim (PVC)

Request for storage by user. Binds to PV that matches requirements. Spec: storage size, access mode, StorageClass (optional). Binding: finds PV with >= size and compatible access mode. Dynamic provisioning: if no PV matches, StorageClass creates new PV. Pod usage: mount PVC as volume. Example: `spec.volumes.persistentVolumeClaim.claimName`, `kubectl get pvc`. States: Pending (no matching PV), Bound (PV assigned), Lost (PV deleted). Use case: app requests storage without knowing infrastructure details.

### 485. StorageClass

Define storage types (fast SSD, slow HDD, replicated). Dynamic provisioning: creates PV automatically when PVC requests. Provisioner: plugin that creates volumes (kubernetes.io/aws-ebs, pd.csi.storage.gke.io, azure-disk). Parameters: provisioner-specific (type: gp3, iops: 3000, fsType: ext4). Reclaim policy: default Delete. Volume binding mode: Immediate (create PV now) or WaitForFirstConsumer (create when Pod scheduled). Example: `kubectl get sc`, default StorageClass (annotation). Use case: multi-tier storage (gold/silver/bronze), cloud-agnostic apps.

### 486. StatefulSet Storage

Stable storage for Pods. volumeClaimTemplates: creates PVC per Pod (web-0 → pvc-web-0, web-1 → pvc-web-1). Persistence: PVCs retained when Pod deleted (unless manually deleted). Pod identity: stable hostname and storage. Example: database cluster (each replica has own disk). Scaling: new Pods get new PVCs, scale down doesn't delete PVCs. Delete StatefulSet: `kubectl delete sts` (keeps PVCs), manually delete PVCs if needed. Use case: databases (MySQL, Cassandra), stateful applications.

### 487. Volume Types Deep Dive

Pod storage options. emptyDir: ephemeral, shared between containers in Pod, lost on Pod delete, use case: scratch space, cache. hostPath: mount host directory, dangerous (security, portability), use case: node logs, Docker socket. configMap/secret: mount as files, read-only. downwardAPI: expose Pod metadata as files (labels, annotations). projected: combine multiple sources (secret + configMap). ephemeral: CSI inline volumes, lifecycle tied to Pod. Use case: choose based on persistence needs and access patterns.

### 488. CSI (Container Storage Interface)

Standard for storage plugins. Benefits: vendor-neutral, out-of-tree (not in K8s core), single plugin for multiple orchestrators. Components: CSI Controller (provisioning, attach), CSI Node (mount, unmount), identity service. Drivers: AWS EBS CSI, Azure Disk CSI, GCP PD CSI, Ceph, Portworx, many others. Features: snapshots, clone, resize, topology (zone awareness). Install: Helm chart or manifest. StorageClass: use CSI provisioner. Use case: advanced storage features, multi-cloud.

### 489. Volume Snapshots

Point-in-time copy of volume. VolumeSnapshotClass: defines snapshot provider (CSI driver). VolumeSnapshot: user request for snapshot, references PVC. Restore: create new PVC from snapshot (spec.dataSource.kind: VolumeSnapshot). Use case: backup before upgrade, clone environment, disaster recovery. Requirements: CSI driver with snapshot support. Example: `kubectl get volumesnapshot`, `kubectl describe volumesnapshotclass`. Cloud: uses native snapshots (EBS snapshots, Azure snapshots).

### 490. Volume Expansion

Resize volumes. Requirements: StorageClass with allowVolumeExpansion: true, CSI driver support. Process: edit PVC (increase spec.resources.requests.storage), controller resizes PV, file system expanded (may require Pod restart). Online: some drivers support without Pod restart, others need recreation. Limitations: cannot shrink, not all drivers support. Example: `kubectl edit pvc`, verify `kubectl get pvc` (capacity updated). Use case: database growth, increased usage.

### 491. Ephemeral Volumes

Temporary storage lifecycle tied to Pod. Generic ephemeral: volume created with Pod, deleted with Pod, uses PVC under the hood, supports snapshots/resize. CSI ephemeral: inline CSI volume, driver-specific. Use case: scratch space with features (snapshots), secrets from external sources. Example: spec.volumes.ephemeral.volumeClaimTemplate. Difference from emptyDir: supports PVC features, separate from Pod storage.

### Category 29: Kubernetes Intermediate: Networking & Storage (18 concepts)

### 492. Pod Disruption Budgets (PDB)

Protect availability during voluntary disruptions. 

**Voluntary:** node drain, cluster upgrade, node delete. 

**Involuntary:** hardware failure, kernel panic, node OOM. 

**Spec:** minAvailable (number or %), or maxUnavailable. 

**Example:** `minAvailable: 2` (at least 2 pods must be available), `maxUnavailable: 1` (at most 1 pod can be unavailable). 

**Selector:** label selector for pods. 

**Enforcement:** `kubectl drain` respects PDB, eviction API checks PDB. 

**Use:** ensure high availability during maintenance, rolling updates (deployment respects PDB). 

**Create:** `kubectl create pdb myapp-pdb --selector=app=myapp --min-available=2`. 

**View:** `kubectl get pdb`, `kubectl describe pdb`. 

**Status:** disruptionsAllowed (how many pods can be evicted), currentHealthy, desiredHealthy. 

**Note:** doesn't prevent involuntary disruptions (use replicas across zones).

---

### 493. Taints & Tolerations

Node scheduling constraints. 

**Taint:** applied to node, repels pods without matching toleration, `key=value:effect`. 

**Effects:** NoSchedule (don't schedule new pods), PreferNoSchedule (avoid if possible), NoExecute (evict existing pods without toleration). 

**Add taint:** `kubectl taint nodes node1 key=value:NoSchedule`. 

**Toleration:** pod spec, allows scheduling on tainted nodes. 

**Example:** `tolerations: [{ key: key, operator: Equal, value: value, effect: NoSchedule }]`. 

**Operator:** Equal (match key=value), Exists (match key, any value). 

**Use cases:** dedicated nodes (GPU, high-memory), node conditions (not ready, disk pressure), node maintenance. 

**Master nodes:** tainted `node-role.kubernetes.io/master:NoSchedule` (kube-system pods tolerate). 

**Remove taint:** `kubectl taint nodes node1 key:NoSchedule-` (trailing `-`). 

**View:** `kubectl describe node` (Taints section).

---

### 494. Node Affinity

Prefer/require nodes with labels. 

**Types:** 
- `requiredDuringSchedulingIgnoredDuringExecution` (hard requirement, like nodeSelector but more expressive)
- `preferredDuringSchedulingIgnoredDuringExecution` (soft preference, weight-based)

**Operators:** In, NotIn, Exists, DoesNotExist, Gt, Lt. 

**Example required:** 
```yaml
requiredDuringSchedulingIgnoredDuringExecution:
  nodeSelectorTerms:
    - matchExpressions:
        - key: disktype
          operator: In
          values: [ssd]
```
(require SSD nodes). 

**Example preferred:** 
```yaml
preferredDuringSchedulingIgnoredDuringExecution:
  - weight: 100
    preference:
      matchExpressions:
        - key: zone
          operator: In
          values: [us-west-1a]
```
(prefer zone, but not required). 

**Weights:** 1-100, scheduler sums weights, highest score wins. 

**Use:** zone preference, hardware requirements, multi-tenant separation. 

**View:** node labels: `kubectl get nodes --show-labels`.

---

### 495. Pod Affinity/Anti-Affinity

Co-locate or spread pods. 

**Pod affinity:** schedule pods together (same node/zone), use cases: reduce latency (app + cache), data locality. 

**Pod anti-affinity:** spread pods apart, use cases: high availability (replicas across zones), avoid resource contention. 

**Topology key:** defines "together" scope, `kubernetes.io/hostname` (same node), `topology.kubernetes.io/zone` (same zone). 

**Types:** required (hard), preferred (soft, weighted). 

**Example affinity:** 
```yaml
podAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchExpressions:
          - key: app
            operator: In
            values: [cache]
      topologyKey: kubernetes.io/hostname
```
(co-locate with cache pod). 

**Example anti-affinity:** 
```yaml
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          app: web
      topologyKey: topology.kubernetes.io/zone
```
(spread replicas across zones). 

**Performance:** expensive, limit use in large clusters. 

**View:** `kubectl describe pod` (events show scheduling decisions).

---

### 496. Custom Resource Definitions (CRDs)

Extend Kubernetes API. 

**Purpose:** define custom resources, domain-specific objects, operators use CRDs. 

**Create:** YAML, `apiVersion: apiextensions.k8s.io/v1`, `kind: CustomResourceDefinition`, `spec.group`, `spec.names` (kind, plural, singular, shortNames), `spec.scope` (Namespaced/Cluster), `spec.versions` (schema, OpenAPI v3). 

**Schema:** validate structure, required fields, types, defaults. 

**Example:** CRD for Database resource, operator watches Database objects, provisions actual databases. 

**Apply:** `kubectl apply -f crd.yaml`. 

**Use:** `kubectl get databases`, `kubectl apply -f database-instance.yaml`. 

**Versions:** support multiple versions, conversion webhooks for migration. 

**Subresources:** `/status` (status updates), `/scale` (HPA integration). 

**Validation:** OpenAPI schema (structural), admission webhooks (custom logic). 

**Storage:** etcd, just like built-in resources. 

**View:** `kubectl get crd`, `kubectl describe crd`.

---

### 497. Operators

Kubernetes-native applications. 

**Pattern:** CRD + custom controller, encodes operational knowledge (install, upgrade, backup, recovery). 

**Controller:** watches CRD instances, reconciles state (creates pods, services, configmaps, etc.). 

**Examples:** Prometheus Operator (manages Prometheus instances), etcd Operator, PostgreSQL Operator. 

**Operator SDK:** framework for building operators (Go, Ansible, Helm-based). 

**Lifecycle:** Day 1 (install/configure), Day 2 (upgrade, scale, backup, failover). 

**State machine:** operator implements desired state logic, handles edge cases. 

**Benefits:** automate complex apps, self-healing, upgrades, best practices codified. 

**OperatorHub:** registry of operators. 

**Install:** typically via `kubectl apply -f operator.yaml`, then create CR. 

**Example:** create Prometheus CR → operator deploys StatefulSet, Service, ConfigMap. 

**View:** `kubectl get all -l app.kubernetes.io/name=<operator>`.

---

### 498. Helm

Package manager for Kubernetes. 

**Chart:** bundle of YAML templates, metadata (`Chart.yaml`), default values (`values.yaml`), templates (`templates/` dir with Go templates). 

**Release:** installed instance of chart, named. 

**Install:** `helm install myrelease mychart`, `helm install myrelease mychart --values custom-values.yaml`. 

**Upgrade:** `helm upgrade myrelease mychart`, rollback: `helm rollback myrelease`. 

**Template:** `{{ .Values.replicaCount }}`, `{{ .Release.Name }}`, `{{ include "mychart.fullname" . }}`. 

**Helpers:** `_helpers.tpl` for reusable templates. 

**Hooks:** pre-install, post-install, pre-delete, etc., for Jobs (DB migration). 

**Repositories:** `helm repo add stable https://charts.helm.sh/stable`, `helm search repo nginx`. 

**Create chart:** `helm create mychart`. 

**Package:** `helm package mychart` (creates `.tgz`). 

**List releases:** `helm list`. 

**Values precedence:** CLI (`--set`) > custom file > `values.yaml`. 

**Helm 3:** no Tiller, CRD support, library charts.

---

### 499. Kustomize

Template-free customization. 

**Base + overlays:** base (common config), overlays (environment-specific, dev/staging/prod). 

**Kustomization file:** `kustomization.yaml`, lists resources, patches, configMapGenerator, etc. 

**Resources:** `resources: [deployment.yaml, service.yaml]`. 

**Patches:** strategic merge patch or JSON patch, modify resources. 

**Example:** base defines Deployment, overlay changes replicas, image tag. 

**ConfigMapGenerator:** generate ConfigMap from files/literals, automatic hash suffix (triggers pod restart on change). 

**No templating:** plain YAML, overlays merge/patch. 

**Built-in:** `kubectl apply -k <dir>` (applies kustomization), `kubectl kustomize <dir>` (view generated). 

**Bases:** reference other kustomizations (local or remote), `bases: [github.com/user/repo//path?ref=v1.0.0]`. 

**Use:** GitOps (Argo CD, Flux), avoid Helm complexity. 

**vs Helm:** Kustomize simpler (no templates), Helm more features (hooks, dependencies).

---

---

### 500. Network Policies Deep Dive

Firewall rules for Pods. Default: all traffic allowed. Policy types: Ingress (incoming), Egress (outgoing). Selectors: podSelector (which Pods), namespaceSelector (which namespaces), ipBlock (CIDR ranges). Rules: from/to + ports. Example: allow only from Pods with label app=frontend on port 8080. CNI requirement: Calico, Cilium, Weave (not Flannel alone). Deny-all: empty podSelector + policyTypes. Best practice: default deny, explicit allow. Use case: multi-tenancy, compliance, defense in depth.

### 501. Ingress Deep Dive

L7 load balancing. Components: Ingress Controller (nginx, Traefik, HAProxy, cloud LBs), Ingress Resource (rules). Routing: host-based (api.example.com → api-service), path-based (/api → api-service, /web → web-service). TLS: terminate SSL at Ingress, secret with cert/key. Annotations: controller-specific (rewrites, timeouts, rate limiting). IngressClass: select which controller handles Ingress. Multiple controllers: different IngressClass per Ingress. Example: `kubectl get ingress`, `kubectl describe ingress`. Use case: expose multiple services, HTTP routing, SSL termination.

### 502. Service Mesh Basics

Manage service-to-service communication. Features: traffic management (routing, retries, timeouts), security (mTLS), observability (metrics, tracing). Architecture: data plane (sidecar proxies, Envoy), control plane (configure proxies). Popular: Istio (feature-rich), Linkerd (simple, lightweight), Consul Connect. Without mesh: apps handle retries, circuit breakers, mTLS (complexity). With mesh: proxies handle (transparent to app). Use case: microservices, security, observability. Trade-offs: complexity, resource overhead.

### 503. Init Containers

Run before app containers. Use cases: setup (download config, run migrations), wait for dependencies (check if DB is ready). Sequential: run one at a time, in order. Failure: Pod restarts if init container fails. Differences from app containers: always run to completion, no probes (liveness/readiness), separate resource limits. Example: wait for service `until nslookup mydb; do sleep 1; done`. Spec: spec.initContainers (array). Use case: database migrations, secrets fetching, dependency checks.

### 504. Sidecar Containers

Helper containers alongside app. Use cases: logging (collect logs, forward to centralized system), proxies (Envoy sidecar in Istio), adapters (format conversion), sync (git-sync for config updates). Pattern: multi-container Pod, sidecar shares volumes/network with app. Example: main container writes logs to /var/log, sidecar reads and ships to ELK. Lifecycle: run alongside app, restart together. Service mesh: automatically inject sidecar (Istio uses mutating webhook). Use case: separation of concerns, reusable components.

### 505. Pod Priority & Preemption

Schedule critical Pods. PriorityClass: define priority (higher = more important). Pod: reference PriorityClass. Preemption: if no resources, evict lower priority Pods to schedule higher priority. Use cases: critical services (control plane, monitoring) over batch jobs. Global default: PriorityClass with globalDefault: true. System priority: system-cluster-critical, system-node-critical (K8s components). Example: `kubectl get priorityclass`, create PriorityClass with value (integer). Limitations: doesn't guarantee resources, only scheduling order.

### 506. Pod Overhead

Resource overhead for runtime (not app containers). Use case: Kata Containers (VM overhead), gVisor (sandboxing). RuntimeClass: define overhead (cpu, memory). Scheduler: adds overhead to Pod resource requirements. Example: Pod requests 1 CPU, overhead 0.2 CPU, total 1.2 CPU. Configured: RuntimeClass with overhead field. Use case: accurate resource accounting for alternative runtimes. Without: scheduler doesn't account for runtime overhead (overcommit node).

### 507. ResourceQuota

Limit resources per namespace. Compute: CPU requests/limits, memory requests/limits. Storage: PVC count, storage requests. Objects: Pods, Services, ConfigMaps, Secrets count. Scopes: BestEffort, NotBestEffort, Terminating, NotTerminating. Example: limit namespace to 10 Pods, 20 CPU, 40Gi memory. Enforcement: admission controller rejects requests exceeding quota. View: `kubectl get resourcequota`, `kubectl describe resourcequota`. Use case: multi-tenancy, prevent resource exhaustion, cost control.

### 508. LimitRange

Default and enforce resource limits per object. Defaults: if Pod/container doesn't specify requests/limits, use default. Min/Max: enforce minimum and maximum (reject if outside range). Ratio: max limit/request ratio. Scope: per namespace. Example: default 100m CPU request, 200m limit, max 2 CPU per container. View: `kubectl get limitrange`. Use case: prevent unbounded resource usage, consistent defaults, guardrails for developers.

### 509. Pod Security Standards

Secure Pod configurations. Levels: Privileged (unrestricted), Baseline (minimally restrictive, prevent known privilege escalations), Restricted (hardened, follows pod hardening best practices). Enforcement modes: enforce (reject), audit (log), warn (warning to user). Implementation: Pod Security Admission (built-in), OPA/Gatekeeper (policy engine), Kyverno (K8s-native policies). Example: enforce Restricted in prod namespace, warn in dev. Policies: no privileged, no host namespaces, restricted capabilities, seccomp/apparmor. Use case: security baseline, compliance.

### Category 30: Kubernetes Advanced I: Operators & CRDs (17 concepts)

### 510. CRD Deep Dive

Extend Kubernetes API. Define: custom resource schema (OpenAPI v3), versions, scope (Namespaced or Cluster), names (singular, plural, kind). Validation: schema validation (required fields, types, regex). Defaulting: set default values. Subresources: status (separate endpoint for status updates), scale (HPA integration). Versioning: multiple versions, conversion webhook (convert between versions). Printing: additionalPrinterColumns (what to show in kubectl get). Example: `kubectl get crd`, `kubectl explain <custom-resource>`. Use case: operators, custom abstractions (Application, Database).

### 511. Operator Pattern

Automate application management. Concept: encode operational knowledge in software. Controller: watch resources, reconcile desired state. Reconciliation loop: observe → analyze → act. Custom controller: watches CRDs, manages resources (Deployments, Services, PVCs). Example: database operator creates DB pods, backups, restores. Operator SDK: framework to build operators (Go, Ansible, Helm). Kubebuilder: alternative SDK. Use case: complex stateful apps, reduce operational toil, consistent deployment.

### 512. Controller-Runtime

Library for building controllers. Features: caching (watch resources, cache in-memory), reconciliation queue (events trigger reconcile), leader election (HA controllers). Manager: runs controllers, webhooks, health checks. Client: read/write K8s objects (cached reads, direct writes). Predicates: filter events (only reconcile on label change). Use case: build operators, framework handles boilerplate (watches, queues). Example: Kubebuilder uses controller-runtime. Reconcile function: `func (r *Reconciler) Reconcile(ctx context.Context, req Request) (Result, error)`.

### 513. Admission Webhooks

Intercept API requests. Types: MutatingAdmissionWebhook (modify objects, e.g., inject sidecar), ValidatingAdmissionWebhook (accept/reject, e.g., enforce policies). Webhook server: HTTPS endpoint, receives AdmissionReview, returns patch or decision. Registration: MutatingWebhookConfiguration or ValidatingWebhookConfiguration. Rules: which resources/operations to intercept. Failure policy: Fail (reject if webhook fails) or Ignore (allow). Use case: inject defaults, enforce policies, custom validation. Example: Istio injects Envoy sidecar via mutating webhook.

### 514. Kubebuilder

SDK for building operators. Scaffold: `kubebuilder init`, `kubebuilder create api`. Components: API types (Go structs with CRD tags), controller (reconcile logic), webhook (validation/defaulting). Code generation: `make manifests` (CRD YAML), `make generate` (DeepCopy methods). Deployment: `make docker-build`, `make deploy`. Testing: envtest (run control plane locally). RBAC: generate RBAC rules with markers. Use case: build production operators quickly. Example: controller-runtime + code generation + best practices.

### 515. Operator Lifecycle Manager (OLM)

Manage operator installation. Concepts: Operator (packaged as bundle), CatalogSource (registry of operators), Subscription (install operator, update channel), InstallPlan (execution plan), ClusterServiceVersion (CSV, operator metadata). Channels: stable, beta, alpha (update streams). Upgrades: automatic or manual approval. Dependencies: operator requires other operators. UI: OperatorHub (find/install operators). Use case: install operators (Prometheus, Strimzi, etc.), manage upgrades, dependency resolution. Platforms: OpenShift includes OLM, can install on any K8s.

### 516. RBAC for CRDs

Control access to custom resources. ClusterRole: define permissions on CRD (get, list, create, update, delete). RoleBinding/ClusterRoleBinding: grant to users/groups/serviceAccounts. Aggregation: ClusterRole with aggregationRule (combine permissions). Example: allow developers to read custom resources, only admins can delete. Subresources: separate permissions for status or scale. Best practice: least privilege, separate read/write roles. Use case: multi-tenancy, delegation (let app teams manage their CRs).

### 517. Finalizers

Pre-delete hooks. Concept: block resource deletion until finalizer removed. Use case: cleanup external resources (cloud VMs, DNS records), cascade deletion. Process: resource marked for deletion (deletionTimestamp set), controller sees finalizer, performs cleanup, removes finalizer, resource deleted. Example: PVC finalizer prevents deletion if attached to Pod. Custom: operator adds finalizer, removes after cleanup. Danger: stuck finalizers (resource never deletes), manually remove: `kubectl patch --type json -p '[{"op": "remove", "path": "/metadata/finalizers"}]'`.

### 518. Owner References

Establish parent-child relationships. Garbage collection: when owner deleted, dependents deleted automatically. Set: metadata.ownerReferences (uid, apiVersion, kind, name). Controller: true (only one owner is controller). Cascade delete: background (async), foreground (wait for dependents), orphan (leave dependents). Example: Deployment owns ReplicaSet, ReplicaSet owns Pods. Use case: automatic cleanup, lifecycle management. View: `kubectl get <resource> -o jsonpath='{.metadata.ownerReferences}'`.

### 519. Controller Best Practices

Build reliable operators. Idempotency: reconcile creates same result regardless of calls. Error handling: return error (requeue), or Result{Requeue: true} (backoff). Observability: metrics (reconcile duration, errors), logs (structured). Status: update status subresource (separate from spec). Events: emit events (kubectl describe shows). Testing: unit tests (reconcile logic), integration tests (envtest). Leader election: HA controllers (only one reconciles). Use case: production-grade operators, reduce incidents.

### 520. Helm Operator

Operator using Helm charts. Concept: CRD represents Helm release, controller installs/upgrades chart. Operator SDK: `operator-sdk init --plugins helm`, generate from existing chart. Reconciliation: watches CR, runs `helm install/upgrade`. Values: CR spec → Helm values. Use case: package operator with Helm (simpler than Go), GitOps (CR in Git, operator applies). Limitations: less flexible than Go (no custom logic). Example: deploy MySQL via CR `kind: MySQL`, operator runs Helm chart.

### 521. Ansible Operator

Operator using Ansible playbooks. Concept: CRD triggers Ansible playbook. Operator SDK: `operator-sdk init --plugins ansible`. Playbook: receives CR as variables, tasks create K8s resources. Watches: map CR to playbook. Use case: existing Ansible automation, no Go knowledge. Example: database operator (playbook creates StatefulSet, Service, PVC). Reconciliation: playbook runs on CR create/update. Status: update CR status from playbook. Trade-offs: slower than Go, but reuses Ansible modules.

### 522. Operator Capability Levels

Maturity model. Level 1 (Basic Install): operator installs app, no automation. Level 2 (Seamless Upgrades): automated updates, version management. Level 3 (Full Lifecycle): backups, failure recovery, scaling. Level 4 (Deep Insights): metrics, alerts, tuning. Level 5 (Auto Pilot): self-healing, auto-tuning, predictive analytics. Use case: understand operator maturity, set development goals. Example: basic operator creates Deployment, advanced operator handles failover, backups, monitoring.

### 523. Custom Metrics & HPA

Autoscale on custom metrics. Metrics server: default (CPU, memory), custom metrics (Prometheus, Datadog). Adapter: expose custom metrics to K8s API (prometheus-adapter, keda). HPA: reference custom metric (pods metric: app_requests_per_second, external metric: SQS queue length). Example: scale based on HTTP requests/sec, queue depth. Configuration: prometheus-adapter configures queries (PromQL → K8s metric). Use case: application-specific scaling, event-driven. Alternative: KEDA (event-driven autoscaling, many sources).

### 524. KEDA (Kubernetes Event Driven Autoscaling)

Scale workloads based on events. Scalers: 60+ sources (Kafka, RabbitMQ, AWS SQS, Azure Queue, Redis, HTTP, Prometheus, cron). ScaledObject: HPA for Deployments, ReplicaSets. ScaledJob: create Jobs based on events. Scale to zero: unlike HPA (min 1), KEDA can scale to 0 (no Pods when idle). Example: scale consumer based on Kafka lag, create Jobs for SQS messages. Architecture: KEDA operator (creates HPA), metrics server (expose external metrics). Use case: event-driven, cost optimization, bursty workloads.

### 525. Operator Testing

Ensure reliability. Unit tests: reconcile logic, mocked client. Integration tests: envtest (real API server, etcd, no kubelet), test CRD create/update/delete. E2E tests: real cluster, deploy operator, verify behavior. Chaos testing: inject failures (pod deletion, network partition). Tools: Ginkgo/Gomega (Go testing), envtest (controller-runtime), kind/k3s (local clusters). CI: run tests in GitHub Actions, fail PR on errors. Use case: prevent regressions, safe refactors, confidence in releases.

### 526. Operator SDK

Framework for operators. Plugins: Helm, Ansible, Go (Kubebuilder). CLI: `operator-sdk init`, `create api`, `create webhook`, `run`, `build`, `deploy`. Scorecard: test operator (OLM integration, CRD presence, best practices). Bundle: package for OLM (CSV, CRD, metadata). Use case: standardized operator development, faster time to production, OLM integration. Generate: boilerplate code, manifests, Dockerfiles. Migration: from Kubebuilder (Operator SDK uses Kubebuilder for Go).

### Category 31: Kubernetes Advanced II: Multi-cluster (17 concepts)

### 527. Multi-Cluster Strategies

Manage multiple K8s clusters. Reasons: isolation (dev/stage/prod), availability (region failure), compliance (data residency), scale (limits per cluster). Architectures: fleet management (centralized control), federation (distribute resources), service mesh (cross-cluster traffic). Tools: Cluster API, Rancher, Anthos, GitOps (ArgoCD for multi-cluster). Use case: large orgs, multi-region apps, disaster recovery. Challenges: networking, identity, resource distribution.

### 528. Cluster API

K8s-native cluster management. Concept: manage clusters as CRDs. Components: Management cluster (runs Cluster API), Workload clusters (managed clusters). CRDs: Cluster, Machine, MachineDeployment (like Deployment but for nodes). Providers: infrastructure (AWS, Azure, GCP, vSphere), bootstrap (kubeadm, k3s), control plane. Workflow: create Cluster CR, Cluster API provisions infrastructure, bootstraps K8s. Use case: cluster lifecycle (create, scale, upgrade, delete), multi-cluster, self-service. Example: `kubectl get clusters`, `kubectl scale machinedeployment`.

### 529. KubeFed (Federation v2)

Distribute resources across clusters. CRDs: FederatedDeployment, FederatedService (multi-cluster resources). Placement: which clusters to deploy (labels, cluster selector). Overrides: customize per cluster (replicas, env vars). Propagation: controller syncs resources to member clusters. Use case: multi-region app (same deployment in all regions), DRaaS (standby in DR region), global service. Limitations: complexity, not widely adopted. Alternatives: GitOps per cluster, service mesh.

### 530. Multi-Cluster Service Mesh

Connect services across clusters. Istio multi-primary: shared control plane, east-west gateway (cross-cluster traffic). Linkerd multi-cluster: gateway + service mirroring (remote services appear local). Service discovery: DNS resolution across clusters. mTLS: secure cross-cluster communication. Use case: microservices spanning regions, failover to remote cluster, split traffic (canary across clusters). Example: service in cluster A calls service in cluster B (via gateway, transparent to app).

### 531. Cross-Cluster Networking

Connect cluster networks. VPC peering: AWS/GCP/Azure (private IPs, no transit internet). VPN: IPsec between clusters. CNI: Cilium Cluster Mesh (native multi-cluster), Submariner (VXLAN tunnels). Load balancer: global LB routes to multiple clusters (GSLB). Service: ClusterIP (single cluster), LoadBalancer (cloud LB), multi-cluster service (mesh or submariner). Use case: hybrid cloud, multi-region, disaster recovery. Challenges: IP address conflicts (non-overlapping CIDRs), firewall rules.

### 532. GitOps Multi-Cluster

Manage clusters with Git. Pattern: Git repo per cluster or monorepo with folders. ArgoCD: ApplicationSet (template apps for multiple clusters), cluster generator (create app per cluster). Flux: Kustomization per cluster, multi-tenancy. Propagation: changes pushed to Git, controllers pull and apply. Use case: consistent configuration, audit trail, declarative, disaster recovery (recreate from Git). Example: cluster bootstrap (install operators, configure RBAC), app deployment.

### 533. Cluster Bootstrapping

Initialize new cluster. Tools: kubeadm (official), k3s (lightweight), kind (local), managed (EKS/AKS/GKE auto-bootstrap). Steps: install CNI (Calico, Cilium), storage (CSI drivers), ingress controller, cert-manager, monitoring (Prometheus), logging (Loki), GitOps (ArgoCD/Flux). Cluster API: automates bootstrap. Configuration: Git repo (ArgoCD syncs), Helm charts, manifests. Use case: self-service clusters, consistent setup, disaster recovery.

### 534. Cluster Autoscaler Multi-Cluster

Scale node pools across clusters. Architecture: Cluster Autoscaler per cluster (independent). Coordination: external tool (custom logic, scale cluster with most available capacity). Cloud: ASGs (AWS), Scale Sets (Azure), Instance Groups (GCP) per cluster. Use case: cost optimization (scale down unused), handle spikes. Challenges: cross-cluster scheduling (no native support), manual coordination. Alternative: Cluster API MachineDeployment scaling, Karpenter.

### 535. Multi-Cluster Monitoring

Observe multiple clusters. Centralized Prometheus: Thanos (aggregate metrics from all clusters), Cortex (multi-tenant Prometheus). Federation: Prometheus federation (pull from cluster Prometheus). Grafana: dashboards across clusters, data source per cluster or aggregated. Logs: centralized (ELK, Loki), ship from all clusters. Tracing: Jaeger/Tempo (cross-cluster traces). Alerts: aggregated alerting, PagerDuty/Slack. Use case: global view, capacity planning, incident response.

### 536. Multi-Cluster Security

Secure fleet of clusters. Identity: centralized (OIDC, LDAP, Okta), federate across clusters. RBAC: consistent policies (GitOps), enforce with admission webhooks. Network policies: isolate namespaces within cluster, firewalls between clusters. Secrets: HashiCorp Vault (central secret store), External Secrets Operator. Compliance: policy engine (OPA, Kyverno), audit logs (central SIEM). Supply chain: sign images (Cosign), admit only signed (policy). Use case: zero trust, compliance, reduce blast radius.

### 537. Cluster Upgrades at Scale

Upgrade multiple clusters. Strategy: canary (upgrade one cluster, validate, roll out), blue/green (parallel clusters, switch traffic), rolling (one cluster at a time). Control plane: upgrade first, then nodes. Validation: smoke tests, end-to-end tests, monitoring. Rollback: keep old version available (blue/green), restore from backup. Cluster API: MachineDeployment rolling update. Managed: AWS EKS (one-click upgrade), AKS, GKE. Use case: minimize downtime, reduce risk, consistent versions.

### 538. Disaster Recovery Multi-Cluster

Survive cluster loss. Strategies: active-active (all clusters serve traffic, scale up on failure), active-passive (standby cluster, failover). Backup: Velero (backup/restore cluster resources, volumes), etcd snapshots (control plane state). Failover: DNS switch (Route 53, Traffic Manager), global LB. Data replication: cross-region databases, object storage replication. RTO/RPO: test DR regularly, measure recovery times. Use case: region failure, critical apps, compliance.

### 539. Cost Optimization Multi-Cluster

Reduce spend across clusters. Right-size: analyze resource usage, resize clusters. Spot instances: batch workloads on spot, save 70-90%. Unused clusters: delete dev/test after hours, ephemeral (recreate from Git). Shared services: centralized (monitoring, logging, registry), reduce duplication. Reserved capacity: commit for production clusters. Monitoring: Kubecost (per-cluster cost), aggregate across fleet. Use case: FinOps, budget control, accountability.

### 540. Cluster DNS & Service Discovery

Resolve services across clusters. Within cluster: CoreDNS (ClusterIP → IP). Cross-cluster: external DNS (Route 53, Cloud DNS), service mesh (Istio ServiceEntry for remote services), KubeFed (federated services). Pattern: global service name resolves to local or remote (proximity, health). Multi-cluster ingress: global LB routes to nearest cluster. Use case: microservices, latency optimization, failover.

### 541. Cluster Resource Management

Allocate resources across clusters. Placement: schedule workloads to clusters with capacity, affinity (prefer certain clusters). Quotas: ResourceQuota per cluster, aggregate tracking. Over-provisioning: spread workloads, leave buffer for spikes. Bin packing: consolidate workloads, fewer clusters. Monitoring: Grafana dashboards (cluster capacity, usage). Scheduler: custom logic (external scheduler, reads cluster metrics, deploys to optimal cluster). Use case: efficient utilization, cost control.

### 542. Service Mesh Federation

Connect service meshes across clusters. Istio: shared control plane (istiod), trust domain, gateway for cross-cluster. Linkerd: service mirroring (expose remote services), gateway. Consul Connect: mesh gateways, WAN federation. Use case: microservices spanning clusters, consistent policies, observability. Architecture: east-west gateway (inter-cluster), north-south gateway (external). Security: mTLS (trust between clusters), RBAC (authorize cross-cluster calls).

### 543. Multi-Cluster CI/CD

Deploy to multiple clusters. GitOps: Git → ArgoCD/Flux → all clusters (eventually consistent). Pipelines: build once (image), deploy to dev cluster → staging clusters → prod clusters (promotion). Progressive delivery: canary one cluster, roll out to all. Rollback: revert Git commit (all clusters roll back). Testing: E2E tests per cluster, smoke tests after deployment. Tools: ArgoCD ApplicationSet, Flux Kustomization, Spinnaker. Use case: consistent deployments, reduce drift, safe rollouts.

### Category 32: Service Mesh & Istio (17 concepts)

### 544. Service Mesh Architecture

Service-to-service communication layer. Components: data plane (sidecar proxies, handle traffic), control plane (configure proxies, collect telemetry). Proxies: Envoy (Istio, Consul), Linkerd2-proxy (Rust, lightweight). Features: traffic management (routing, retries, timeouts), security (mTLS, authz), observability (metrics, traces, logs). Deployment: sidecar injection (automatic or manual), CNI plugin (alternative to iptables). Use case: microservices, zero trust, canary deployments. Trade-offs: complexity, latency (proxy hop), resource overhead (proxy per Pod).

### 545. Istio Basics

Feature-rich service mesh. Components: Istiod (control plane, runs pilot, citadel, galley), Envoy (data plane, sidecar proxy), Ingress/Egress Gateway (edge proxies). Installation: istioctl, Helm, Operator. Injection: automatic (namespace label `istio-injection=enabled`), manual (istioctl kube-inject). Configuration: VirtualService (routing rules), DestinationRule (traffic policy), Gateway (ingress/egress), ServiceEntry (external services). Use case: traffic management, security, observability. Alternatives: Linkerd (simpler), Consul Connect (multi-platform).

### 546. Istio Traffic Management

Control request routing. VirtualService: match conditions (headers, URI), route to subsets (version: v1), weights (90% v1, 10% v2). DestinationRule: define subsets (labels), load balancing (ROUND_ROBIN, LEAST_REQUEST), connection pool (max connections, retries). Timeouts: prevent long waits (timeout: 5s). Retries: retry failed requests (attempts: 3, perTryTimeout: 2s). Circuit breaking: max connections, detect failures, shed load. Use case: canary deployments, A/B testing, fault tolerance.

### 547. Istio Security

Zero trust networking. mTLS: automatic between services (Envoy terminates TLS, mutual auth). PeerAuthentication: mTLS mode (STRICT, PERMISSIVE, DISABLE). AuthorizationPolicy: allow/deny requests (source, operation, conditions), L7 (HTTP methods, paths), L4 (IP, ports). Certificates: Citadel issues certificates (short-lived, auto-rotation). Trust: trust domain, cross-cluster trust. Use case: encryption in transit, service-to-service auth, fine-grained access control. Example: allow only frontend to call backend on POST /api/*.

### 548. Istio Observability

Metrics, logs, traces. Metrics: request count, duration, error rate (exported to Prometheus), standard dashboards (Grafana). Distributed tracing: Envoy propagates trace headers (Jaeger, Zipkin), visualize request flow across services. Access logs: Envoy logs requests (enable: Telemetry CRD), ship to logging backend. Service graph: Kiali (visualize services, traffic flow, health). Use case: troubleshoot latency, identify failures, understand dependencies. Example: trace request from frontend → backend → database.

### 549. Istio Ingress Gateway

Edge proxy for external traffic. Gateway: define ports, protocols, TLS (SNI for multiple domains). VirtualService: bind to Gateway, route external traffic to internal services. TLS: terminate at Gateway (certificate in K8s Secret), pass-through (TLS to backend). Example: HTTPS on port 443, route api.example.com/api → api-service. Comparison: Kubernetes Ingress (L7, simpler), Istio Gateway (more features, mesh integration). Use case: expose services, SSL termination, traffic shaping at edge.

### 550. Istio Egress Gateway

Control outbound traffic. Use case: regulate external API calls, audit, apply policies (only allow certain domains). Configuration: ServiceEntry (define external service), Gateway (egress), VirtualService (route to Gateway). Example: allow traffic only to api.external.com, block others. TLS origination: plain HTTP internally, Gateway originates TLS to external. Monitoring: track external calls (which services, how often). Comparison: without egress gateway (pods call directly, hard to monitor).

### 551. Istio Multi-Cluster

Service mesh across clusters. Topologies: single network (shared VPC, flat network), multi-network (separate VPCs, gateways). Deployment: multi-primary (istiod in each cluster), primary-remote (single istiod, remote clusters agent). Service discovery: cross-cluster (service in cluster A calls cluster B). East-west gateway: traffic between clusters. mTLS: shared trust domain, certificates valid across clusters. Use case: multi-region, disaster recovery, failover. Setup: install Istio in each cluster, configure trust, expose services via gateway.

### 552. Linkerd Basics

Lightweight service mesh. Components: control plane (Linkerd controller, destination, identity), data plane (linkerd2-proxy, Rust, fast). Installation: linkerd install, linkerd inject (automatic via annotation). Features: mTLS (automatic), traffic split (SMI spec, canary), retries, timeouts. Observability: Prometheus metrics, Tap (live request view), dashboard (Linkerd Viz). Comparison: simpler than Istio (fewer features), lower resource usage, Rust proxy (vs Envoy). Use case: lightweight mesh, less complexity, good defaults.

### 553. Envoy Proxy

L7 proxy and communication bus. Features: HTTP/1.1, HTTP/2, gRPC, WebSocket, load balancing, health checks, retries, timeouts, circuit breaking, rate limiting, shadowing, observability (metrics, tracing, logs). Configuration: xDS APIs (CDS: clusters, EDS: endpoints, LDS: listeners, RDS: routes). Control planes: Istio, Consul, Gloo, custom. Filters: extensible (add auth, logging, custom logic). Use case: data plane for service mesh, API gateway, edge proxy. Language: C++, performant. Deployment: sidecar or standalone.

### 554. Service Mesh Interface (SMI)

Standard API for service meshes. Specs: TrafficTarget (authorization), TrafficSplit (weighted routing, canary), TrafficMetrics (expose metrics). Benefits: mesh-agnostic (Istio, Linkerd, Consul), tooling compatibility (Flagger, Argo Rollouts). Implementations: Linkerd (native), Istio (adapter), Consul (adapter). Use case: avoid vendor lock-in, reusable tooling. Example: Flagger uses SMI to manage canary across meshes. Limitations: not all features (subset of mesh capabilities).

### 555. mTLS in Service Mesh

Mutual TLS authentication. Process: client and server present certificates, verify identity. Mesh: automatically inject certificates (sidecar), rotate (short-lived, auto-renewal). Istio: Citadel issues certs, 24h TTL. Linkerd: identity controller, 24h TTL. Benefits: encryption in transit, authentication (verify caller identity), no code changes (transparent). Modes: STRICT (enforce mTLS), PERMISSIVE (allow plaintext, migration mode). Use case: zero trust, compliance, prevent MITM. View: istioctl authn tls-check (Istio), linkerd check --proxy (Linkerd).

### 556. Service Mesh and Observability

Deep insights into traffic. Metrics: golden signals (latency, traffic, errors, saturation), per-service, per-route. Tracing: automatic span creation (proxy injects headers), distributed traces (Jaeger, Zipkin, Tempo). Logs: access logs (every request), error logs. Service graph: Kiali (Istio), Linkerd dashboard (topology, live traffic). Integration: Prometheus (metrics), Grafana (dashboards), Jaeger (tracing). Use case: troubleshoot, SLOs, capacity planning. Example: detect slow services, error spikes, dependency changes.

### 557. Canary Deployments with Service Mesh

Progressive rollout. Strategy: deploy v2 (small %), monitor metrics, gradually increase (10% → 50% → 100%), rollback if errors. Implementation: TrafficSplit (SMI), VirtualService (Istio), TrafficSplit (Linkerd). Metrics: error rate, latency (compare v1 vs v2). Automation: Flagger (automates canary, integrates with mesh + Prometheus). Example: 90% traffic to stable, 10% to canary, if success increase, else rollback. Use case: reduce risk, safe deployments, faster feedback.

### 558. Service Mesh vs Ingress

Different layers. Ingress: L7 (north-south traffic, external → cluster), simple routing, SSL termination. Service mesh: east-west (service-to-service), mTLS, advanced routing, retries, observability. Combination: Ingress for external, mesh for internal. Istio Gateway: can replace Ingress (same Envoy, more features). Use case: ingress for edge, mesh for internal security/observability. Overlap: both do L7 routing, but mesh adds mTLS, metrics, circuit breaking.

### 559. Service Mesh Performance

Overhead considerations. Latency: sidecar adds ~1-3ms per hop (proxy processing). Throughput: CPU cost (Envoy is efficient, but uses resources). Resource usage: proxy per Pod (50-100MB memory, 0.1-0.5 CPU). Optimization: use HTTP/2 (multiplexing), tune Envoy (connection pools, buffer limits), sidecar resource limits. Benchmarking: test with/without mesh, measure impact. Trade-off: features vs overhead. Lightweight: Linkerd (less overhead than Istio), Cilium eBPF (no sidecar, kernel-level). Use case: latency-sensitive apps, evaluate before production.

### 560. Service Mesh Adoption

Migration strategy. Phases: deploy mesh (control plane), inject sidecars (gradually), enable mTLS (PERMISSIVE → STRICT), add policies (authz, traffic management). Start: non-critical services, validate, expand. Challenges: complexity (new concepts), debugging (more components), resource usage. Training: team education, documentation, runbooks. Rollback: disable injection, remove mesh. Use case: microservices at scale, security requirements, observability gaps. Success: start small, iterate, measure value.

### Category 33: Networking Advanced (15 concepts)

### 561. Proxy Protocol

Preserve client IP through proxy/load balancer. 

**Problem:** backend sees proxy IP, not client IP. 

**Solutions:** X-Forwarded-For header (HTTP only, can be spoofed), Proxy Protocol (TCP/UDP, prepends client info to connection, v1 text, v2 binary). 

**HAProxy Proxy Protocol:** `send-proxy` on frontend, backend must support (nginx `proxy_protocol` in listen, parse with `$proxy_protocol_addr`). 

**AWS NLB:** optionally adds Proxy Protocol v2. 

**Use:** when L4 load balancer or TCP proxy hides client IP. 

**Enable:** listener/backend must both support. 

**Security:** trust only from known proxies (configure allowed sources).

---

### 562. Virtual Network Interfaces

Software network devices. 

**veth (virtual Ethernet):** pair of connected interfaces, like virtual cable, `ip link add veth0 type veth peer name veth1`, move to namespace: `ip link set veth1 netns ns1`. 

**bridge:** software switch, connect multiple interfaces, `ip link add br0 type bridge`, `ip link set veth0 master br0`. 

**dummy:** placeholder interface, `ip link add dummy0 type dummy`. 

**tun/tap:** user-space networking, tun (L3, IP packets), tap (L2, Ethernet frames), used by VPNs (OpenVPN). 

**macvlan:** assign MAC address to virtual interface, appears as separate device on network. 

**ipvlan:** similar to macvlan, shares MAC (modes: L2, L3). 

**Use:** containers (veth + bridge), VPNs (tun), testing, network namespaces.

---

### 563. Linux Bridge

L2 switch in software. 

**Connect multiple interfaces** (physical, veth, etc.). 

**Packets forwarded based on MAC address,** learns MAC table. 

**Create:** `ip link add br0 type bridge`, `ip link set br0 up`. 

**Add interface:** `ip link set eth0 master br0` (eth0 becomes bridge port, no IP). 

**Bridge gets IP:** `ip addr add 192.168.1.1/24 dev br0` (for routing/host access). 

**STP (Spanning Tree Protocol):** prevent loops, enabled by default, `bridge link set dev eth0 priority 32`. 

**View:** `bridge link show`, `bridge fdb show` (forwarding database, MAC table). 

**Use:** libvirt (VM networking), Docker bridge network, connect containers to host network. 

**Containers:** each container has veth, one end in container, other in bridge, bridge routes between containers and to host/internet.

---

### 564. VXLAN (Overlay Networks)

Virtual eXtensible LAN, L2 over L3 tunneling. 

**Encapsulation:** Ethernet frame → UDP packet, outer IP header (underlay network), inner Ethernet header (overlay network). 

**VNI (VXLAN Network Identifier):** 24-bit, ~16M segments, isolates tenants. 

**VTEP (VXLAN Tunnel Endpoint):** encaps/decaps, bridge or router. 

**Multicast:** discover VTEPs (original), or unicast (static config). 

**Setup:** `ip link add vxlan0 type vxlan id 42 dev eth0 remote 10.0.0.2 local 10.0.0.1 dstport 4789`, `ip link set vxlan0 up`, `bridge link set dev vxlan0 master br0`. 

**Port:** UDP 4789. 

**Use:** Kubernetes networking (Flannel, Calico), Docker overlay networks, multi-host containers, cloud overlays (AWS VPC), SDN. 

**Benefits:** scalability (4096 VLANs → 16M VNIs), multi-DC, existing network infrastructure.

---

### 565. Network Namespaces

Isolate network stack. 

**Separate:** interfaces, routing tables, iptables rules, sockets. 

**Each namespace:** independent configuration. 

**Create:** `ip netns add ns1`. 

**Execute:** `ip netns exec ns1 command`, e.g., `ip netns exec ns1 ip addr`. 

**List:** `ip netns list`. 

**Delete:** `ip netns del ns1`. 

**veth pair:** connect namespaces, `ip link add veth0 type veth peer name veth1`, `ip link set veth1 netns ns1`, assign IPs, test: `ip netns exec ns1 ping 10.0.0.1`. 

**Mount:** `/var/run/netns/ns1` (symlink to `/proc/[pid]/ns/net`). 

**Use:** containers (each container in namespace), testing, network isolation. 

**Docker:** `docker run` creates new network namespace per container. 

**Default:** `ip netns exec ns1 ip link set lo up` (enable loopback).

---

### 566. iptables/nftables

Packet filtering firewall. 

**iptables:** tables (filter, nat, mangle, raw), chains (INPUT, OUTPUT, FORWARD, PREROUTING, POSTROUTING), rules (match + target). 

**Rules:** `iptables -A INPUT -p tcp --dport 22 -j ACCEPT` (allow SSH), `iptables -A INPUT -j DROP` (default drop). 

**NAT:** `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE` (SNAT). 

**List:** `iptables -L -v -n`, `iptables -t nat -L`. 

**Persist:** iptables-persistent package, `netfilter-persistent save`. 

**nftables:** modern replacement, unified (replaces iptables, ip6tables, arptables), better performance, syntax: `nft add table ip filter`, `nft add chain ip filter input { type filter hook input priority 0; policy drop; }`, `nft add rule ip filter input tcp dport 22 accept`. 

**nft list ruleset** (view). 

**Use:** firewall (host/network), NAT, port forwarding, Docker/Kubernetes networking.

---

### 567. Connection Tracking (conntrack)

Stateful firewall, track connections. 

**Conntrack:** kernel module, table of connections (IP, port, state). 

**States:** NEW (new connection), ESTABLISHED (existing), RELATED (related to existing, e.g., FTP data), INVALID (doesn't match any). 

**iptables:** `-m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT` (allow return traffic). 

**NAT:** relies on conntrack to map back (public IP:port → private IP:port). 

**View:** `conntrack -L` (list connections), `conntrack -S` (stats). 

**Tuning:** `/proc/sys/net/netfilter/nf_conntrack_max` (max entries), `nf_conntrack_tcp_timeout_established` (timeout). 

**Exhaustion:** too many connections, increase max or reduce timeouts. 

**Use:** stateful firewall, NAT, load balancing (track connections for stickiness).

---

### 568. Service Discovery

Find services dynamically. 

**DNS-based:** SRV records, `dig _http._tcp.example.com SRV`, A records for multiple IPs (round-robin DNS). 

**API-based:** Consul (K/V store, health checks, DNS interface), etcd (K/V, watch for changes), Zookeeper. 

**Kubernetes:** service DNS (`my-service.namespace.svc.cluster.local`), endpoints (pod IPs), watch endpoints API. 

**Client-side:** client queries service registry, caches, balances load. 

**Server-side:** proxy discovers backends (Envoy, nginx with dynamic upstreams). 

**Health-aware:** remove unhealthy instances from pool. 

**Benefits:** dynamic environments (containers, auto-scaling), no hardcoded IPs. 

**Patterns:** DNS (simple, caching), API (flexible, real-time), sidecar (Envoy service mesh).

---

### 569. Service Mesh Concepts

Layer for microservices communication. 

**Sidecar proxy:** each pod has proxy (Envoy), intercepts traffic, enforces policies. 

**Control plane:** configures proxies (Istio pilot), collects telemetry. 

**Data plane:** proxies (Envoy). 

**Features:** mTLS (automatic, transparent), observability (metrics, traces), traffic management (retries, timeouts, circuit breaker, canary), policy (rate limiting, access control). 

**Implementations:** Istio (feature-rich, complex), Linkerd (simple, fast), Consul Connect. 

**Injection:** sidecar injected automatically (admission webhook), or manual. 

**Config:** Istio CRDs (VirtualService, DestinationRule), Linkerd ServiceProfile. 

**Benefits:** move logic out of app, consistent policies, zero-trust. 

**Drawbacks:** complexity, resource overhead (sidecar per pod), latency (extra hop).

---

### 570. mTLS (Mutual TLS)

Both client and server authenticate. 

**TLS:** server presents cert, client verifies. 

**mTLS:** both present certs, both verify. 

**Use:** service-to-service auth, zero trust, no passwords. 

**Certificates:** each service has cert (identity), signed by CA (or service mesh CA), short-lived (auto-rotation). 

**Service mesh:** Istio/Linkerd auto-manages certs (SPIFFE/SPIRE), transparent to app. 

**Manual:** configure server to request client cert (`ssl_verify_client on` in nginx), client provides cert. 

**Verification:** check cert chain, CN/SAN (Subject Alternative Name), revocation. 

**Benefits:** strong authentication, encrypted, no shared secrets. 

**Challenges:** cert management (service mesh simplifies), performance (extra handshake).

---

### 571. Traffic Shaping & QoS

Control bandwidth and prioritization. 

**Traffic shaping:** limit/smooth traffic, prevent bursts. 

**QoS (Quality of Service):** prioritize traffic types. 

**Linux tc (traffic control):** `tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms` (token bucket filter, limit to 1Mbps). 

**HTB (Hierarchical Token Bucket):** complex shaping, classes (priority), `tc qdisc add dev eth0 root handle 1: htb default 10`, `tc class add dev eth0 parent 1: classid 1:1 htb rate 10mbit`. 

**prio:** priority queuing, multiple bands. 

**fq_codel (Fair Queuing, Controlled Delay):** default, reduces latency. 

**Use:** ISP bandwidth control, data center QoS, WAN optimization. 

**Cloud:** network QoS (AWS EBS IOPS, GCP network tiers).

---

### 572. DNS-based Service Discovery

Service discovery using DNS. 

**SRV records:** `_http._tcp.example.com. SRV 0 5 80 web1.example.com.`, priority, weight, port, target. 

**A/AAAA records:** round-robin DNS, multiple IPs for one name, client gets list, uses first or random. 

**TTL:** cache duration, shorter = more current but more queries. 

**Kubernetes:** service creates DNS record (`my-service.namespace.svc.cluster.local`), resolves to ClusterIP, kube-dns/CoreDNS. 

**Consul:** registers services, DNS interface (`web.service.consul`), health checks remove unhealthy. 

**Dynamic DNS:** update DNS on service change (ddclient, Route53 API). 

**Pros:** standard protocol, client library support. 

**Cons:** caching (stale data), no health info (unless removed), limited metadata.

---

### 573. API Gateway

Single entry point for APIs. 

**Features:** routing (path-based), authentication (OAuth, JWT), rate limiting, transformation (request/response), caching, analytics, versioning. 

**Examples:** Kong (nginx-based, plugins), AWS API Gateway (managed), Tyk, Apigee. 

**Use:** microservices (hide backend complexity), public APIs (auth, throttle), legacy modernization (adapter). 

**vs Reverse Proxy:** gateway = L7, API-focused, more features; reverse proxy = simpler. 

**vs Service Mesh:** gateway = north-south (external → internal), service mesh = east-west (internal ↔ internal). 

**Config:** Kong declarative config (YAML), plugins (key-auth, rate-limiting), routes. 

**Performance:** caching (Redis), async processing, horizontal scaling.

---

### 574. Edge Computing & CDN

Compute and cache at edge. 

**CDN (Content Delivery Network):** cache static assets (images, CSS, JS) at edge locations (geographically distributed), reduce latency, offload origin. 

**Edge computing:** run code at edge (Cloudflare Workers, Lambda@Edge), personalize content, process data close to users. 

**How CDN works:** user requests, edge checks cache (hit = return, miss = fetch from origin, cache, return), cache key (URL, headers). 

**Cache headers:** Cache-Control, ETag, origin sets. 

**Invalidation:** purge cache on update, cache tags (Cloudflare), versioned URLs (`style.v123.css`). 

**Use:** global apps, video streaming, image optimization (resize at edge). 

**Benefits:** performance (latency), availability (origin down, serve cached), cost (reduce origin bandwidth).

---

### 575. Network Performance Tuning

Optimize TCP/IP stack. 

**TCP buffers:** `sysctl net.core.rmem_max=16777216 net.core.wmem_max=16777216`, `net.ipv4.tcp_rmem="4096 87380 16777216"`, `tcp_wmem` (min, default, max). 

**Congestion control:** `net.ipv4.tcp_congestion_control=bbr` (Google BBR, better throughput). 

**Window scaling:** `net.ipv4.tcp_window_scaling=1`. 

**TCP fast open:** `net.ipv4.tcp_fastopen=3` (reduce latency, 0-RTT). 

**Backlog:** `net.core.somaxconn=4096` (listen queue), `net.ipv4.tcp_max_syn_backlog=4096` (SYN queue). 

**Connection reuse:** `net.ipv4.tcp_tw_reuse=1` (reuse TIME_WAIT sockets). 

**Offloading:** `ethtool -K eth0 gso on tso on` (Generic/TCP Segmentation Offload, NIC handles). 

**Jumbo frames:** MTU 9000 (data center), reduce overhead. 

**Ring buffers:** `ethtool -G eth0 rx 4096 tx 4096`. 

**Interrupt coalescing:** `ethtool -C eth0 rx-usecs 50`. 

**Test:** `iperf3 -c server`.

---

### 576. Network Debugging

Troubleshoot connectivity. 

**Connectivity:** `ping host` (ICMP reachability), `traceroute host` (path), `mtr host` (continuous traceroute). 

**DNS:** `dig example.com`, `nslookup example.com`, `host example.com`. 

**TCP:** `telnet host port` (test port, old), `nc -zv host port` (netcat, port scan), `curl -v http://host` (HTTP). 

**Packet capture:** `tcpdump -i eth0 host 192.168.1.10`, `tcpdump -i any port 80 -w capture.pcap`, analyze with Wireshark. 

**Socket stats:** `ss -tunap` (all sockets, processes), `ss -tan` (TCP, numeric). 

**Routes:** `ip route get 8.8.8.8` (route for IP). 

**Interfaces:** `ip link show`, `ip addr show`. 

**Firewall:** `iptables -L -v -n` (check rules). 

**DNS issues:** check `/etc/resolv.conf`, `systemd-resolved status`. 

**MTU:** `ping -M do -s 1472 host` (test MTU, adjust size). 

**TLS:** `openssl s_client -connect host:443` (test TLS).

---

### 577. BGP (Border Gateway Protocol)

Internet routing protocol. Autonomous Systems (AS): network under single administration, AS number (ASN). Path vector: advertise routes with full AS path (prevents loops). Types: eBGP (between ASes, external), iBGP (within AS, internal). Peering: neighbors exchange routes, sessions over TCP port 179. Route selection: prefer shortest AS path, local preference, origin type. Use cases: ISP routing, multi-homed networks, anycast. Kubernetes: MetalLB uses BGP to announce LoadBalancer IPs (bare metal). Configuration: routers (Cisco, Juniper), software (BIRD, FRR). Metrics: AS path length, MED (multi-exit discriminator).

### 578. eBPF Networking

In-kernel networking with eBPF. eBPF programs: bytecode loaded into kernel, JIT compiled, safely executed. Hooks: XDP (eXpress Data Path, packet processing before network stack), tc (traffic control), socket filters. Use cases: Cilium (CNI with eBPF), load balancing (katran), DDoS mitigation, observability (packet tracing). Benefits: kernel speed without kernel modules, safe (verified programs), flexible (update without reboot). XDP: drop/redirect packets (firewall, LB), nanosecond latency. Comparison: iptables (slow, sequential), eBPF (fast, parallel, programmable). Tools: bpftool, cilium, bcc.

### Category 34: CI/CD Basics: Pipelines & GitHub Actions (18 concepts)

### 579. Continuous Integration Concepts

Automated testing on every commit. 

**Goal:** fast feedback, catch bugs early, prevent broken main branch. 

**Practices:** commit frequently, automated build, automated tests (unit, integration), fix failures immediately, keep build fast (< 10 min). 

**Trunk-based development:** merge to main daily, short-lived feature branches (< 1 day), no long-running branches. 

**Build pipeline:** triggered on push, checkout code, install dependencies, build, test, report. 

**Test pyramid:** many unit tests (fast), fewer integration tests, few E2E tests (slow). 

**Code quality:** linting, formatting, coverage, static analysis. 

**Artifacts:** build produces binaries, images, packages. 

**Notifications:** Slack, email on failure. 

**Tools:** GitLab CI, GitHub Actions, Jenkins, CircleCI, Travis CI. 

**Key metric:** build time, failure rate, time to fix.

---

### 580. Continuous Delivery vs Deployment

Automated pipeline to production-ready. 

**Continuous Delivery (CD):** every commit can be deployed to production, manual approval before production deploy, automated deploy to staging. 

**Continuous Deployment:** fully automated to production, no manual gate, every commit (that passes tests) goes live. 

**Deployment pipeline:** CI → build image → push registry → deploy to staging → [manual approval] → deploy to production. 

**Confidence:** requires comprehensive testing, monitoring, rollback capability. 

**Benefits:** fast time-to-market, small batches (easier to debug), frequent releases. 

**Challenges:** cultural (trust automation), testing (need good coverage), monitoring (detect issues quickly). 

**Production-ready:** code merged, tests pass, artifact versioned, ready to deploy anytime. 

**Choose:** CD if regulatory/risk requires approval, Continuous Deployment for mature teams.

---

### 581. Pipeline as Code

Version-controlled pipelines. 

**Benefits:** reproducible, reviewable (PR), versioned (rollback), shareable (templates), testable. 

**Formats:** YAML (GitLab CI, GitHub Actions), Groovy (Jenkins), HCL (Terraform). 

**Co-located:** pipeline file in same repo as code (`.gitlab-ci.yml`, `.github/workflows/`, `Jenkinsfile`). 

**Stages:** logical grouping (build, test, deploy), sequential or parallel. 

**Jobs:** individual tasks, run in containers/VMs. 

**Matrix builds:** test multiple versions (Go 1.21, 1.22, 1.23). 

**Conditionals:** run job if branch = main, or tag, or manual trigger. 

**Secrets:** injected as env vars, masked in logs. 

**Caching:** dependencies (`node_modules`, Go modules), speeds up builds. 

**Artifacts:** pass between jobs/stages. 

**Example:** GitHub Actions workflow defines jobs with steps.

---

### 582. GitLab CI/CD Basics

`.gitlab-ci.yml` in repo root. 

**Structure:** stages (define order), jobs (what to run). 

**Job:** `job_name: { stage: test, script: [go test ./...], only: [main] }`. 

**Stages:** `stages: [build, test, deploy]`, jobs in same stage run parallel. 

**Runners:** agents that execute jobs, shared (GitLab-provided), specific (self-hosted, registered with token). 

**Docker executor:** job runs in container, `image: golang:1.21`, isolated. 

**Script:** shell commands, multi-line with `|`. 

**Variables:** `variables: { GO_VERSION: 1.21 }`, use: `$GO_VERSION`. 

**Artifacts:** `artifacts: { paths: [bin/], expire_in: 1 week }`, download or pass to next stage. 

**Cache:** `cache: { paths: [.cache/], key: $CI_COMMIT_REF_SLUG }`, per branch. 

**only/except:** control when job runs, `only: [main, tags]`. 

**needs:** DAG, job dependency, run before stage completes. 

**Includes:** reuse config, `include: [local: 'templates/build.yml']`.

---

### 583. GitLab Runners

Execute CI jobs. 

**Types:** shared (all projects), group (group projects), specific (single project). 

**Executors:** Docker (most common, job in container), Shell (directly on runner, less isolation), Kubernetes (job as pod), SSH, VirtualBox, Docker Machine (auto-scale). 

**Registration:** `gitlab-runner register --url https://gitlab.com --token <token>`, configure executor. 

**Tags:** `tags: [docker, linux]`, job specifies required tags, runner with matching tags picks job. 

**Concurrent jobs:** `concurrent = 10` in `/etc/gitlab-runner/config.toml`. 

**Autoscaling:** Docker Machine executor, creates VMs on demand, destroys when idle. 

**Caching:** S3/GCS for distributed cache. 

**Security:** run as non-root, use Docker socket carefully (privileged). 

**Monitoring:** Prometheus metrics, job queue length. 

**Install:** Linux package, Docker image, Kubernetes (helm chart).

---

### 584. Pipeline Stages

Organize jobs. 

**Sequential:** stages run in order (build → test → deploy), next stage starts after all jobs in previous stage complete. 

**Parallel:** jobs in same stage run concurrently (test-unit, test-integration in parallel). 

**DAG:** Directed Acyclic Graph, `needs` keyword bypasses stage order, `deploy-staging: { needs: [build] }` (runs after build, doesn't wait for test stage). 

**Example:** `stages: [build, test, deploy]`, `build-job: { stage: build }`, `test-job: { stage: test }`, `deploy-job: { stage: deploy, only: [main] }`. 

**Conditional stages:** run stage only if condition (branch, tag, manual). 

**Fail fast:** stop pipeline on first failure (or continue). 

**Manual stages:** `when: manual`, requires approval (button in GitLab UI). 

**Retries:** `retry: 2` (retry failed job). 

**View:** GitLab pipeline graph shows stages/jobs, duration, status.

---

### 585. Artifact Management

Build outputs. 

**Purpose:** store binaries, images, reports, pass between stages. 

**Storage:** GitLab artifacts (S3/GCS backend), Artifactory, Nexus, cloud storage. 

**Upload:** job artifacts config, paths, expire (auto-delete old artifacts). 

**Download:** subsequent jobs auto-download artifacts from previous stages, or explicit: `dependencies: [build-job]`. 

**Example:** `artifacts: { paths: [dist/, reports/], reports: { junit: reports/junit.xml } }`, JUnit report parsed, shown in MR. 

**Versioning:** semantic versioning, tag artifacts with version. 

**Retention:** expire artifacts after N days (save storage), keep release artifacts indefinitely. 

**Access:** download from pipeline page, API, or CI variables point to URL. 

**Size limit:** GitLab default 100MB (configurable). 

**Use:** binaries (pass to deploy stage), test reports (display in UI), coverage (badges), Docker images (registry = special artifact).

---

### 586. Container Registry Integration

Build and push images. 

**GitLab Container Registry:** built-in, per project/group, `registry.gitlab.com/group/project`. 

**Login:** `docker login $CI_REGISTRY -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD` (variables auto-provided). 

**Build:** `docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHORT_SHA .`. 

**Push:** `docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHORT_SHA`. 

**Multi-stage:** build in CI (GitLab runner with Docker), push image, deploy using image. 

**Tags:** `latest` (not recommended for production, use SHA or version), `$CI_COMMIT_TAG` (git tag), `$CI_COMMIT_SHORT_SHA` (immutable). 

**Cleanup:** registry cleanup policy, delete old tags (keep last 10, or regex). 

**Security:** scan images in CI (Trivy), fail on critical CVEs. 

**Other registries:** ECR, GCR, Harbor (configure credentials). 

**Example job:** `docker-build: { script: [docker build -t $CI_REGISTRY_IMAGE:latest ., docker push $CI_REGISTRY_IMAGE:latest] }`.

---

### 587. Environment Management

Separate dev/staging/prod. 

**GitLab Environments:** track deployments, `environment: { name: production, url: https://prod.example.com }`, shown in Deployments page. 

**Dynamic environments:** review apps, `environment: { name: review/$CI_COMMIT_REF_SLUG, on_stop: stop-review }`, creates environment per branch, auto-delete on merge. 

**Variables per environment:** `variables: { DB_HOST: prod-db.example.com }` (protected for prod). 

**Approvals:** protected environments, require approval before deploy (merge request approval, or manual job). 

**Stop environment:** delete resources, `when: manual`, `environment: { name: review/$CI_COMMIT_REF_SLUG, action: stop }`. 

**Example:** `deploy-staging: { stage: deploy, script: [kubectl apply -f k8s/], environment: { name: staging } }`. 

**Monitoring:** integrate with monitoring tools, show metrics per environment. 

**Kubernetes integration:** GitLab Agent, auto-deploy, environment tied to namespace.

---

### 588. Deployment Strategies

How to release. 

**Recreate:** stop old version, deploy new version, downtime, simple, use for dev/staging. 

**Rolling update (default K8s):** gradually replace pods, maxUnavailable, maxSurge, no downtime. 

**Blue/Green:** two identical environments, switch traffic (load balancer/DNS), instant rollback, doubles resources. 

**Canary:** deploy to small % of users, monitor, gradually increase, Flagger/Argo Rollouts. 

**A/B testing:** route based on user attributes (feature flags), not deployment strategy but related. 

**Shadow:** deploy new version, mirror traffic (don't respond to users), test under real load. 

**Feature flags:** deploy code disabled, enable feature remotely (LaunchDarkly, Unleash, custom). 

**Choose:** rolling for most apps, blue/green for critical (zero downtime guarantee), canary for risk mitigation, feature flags for gradual rollout at code level.

---

### 589. GitOps Principles

Git as single source of truth. 

**Principles:** (1) declarative config, (2) versioned in Git, (3) pulled automatically, (4) continuously reconciled. 

**Push vs Pull:** traditional CI pushes to cluster, GitOps operator pulls from Git. 

**Benefits:** audit trail (Git history), rollback (git revert), access control (Git permissions), disaster recovery (recreate from Git). 

**Workflow:** commit YAML → Git → operator detects change → applies to cluster. 

**Tools:** Argo CD (K8s-native, UI), Flux (CNCF, CLI), Jenkins X (opinionated). 

**Repo structure:** app code repo (Dockerfile, CI), config repo (YAML manifests, Helm values). 

**Promotion:** dev → staging → prod via PR, merge promotes. 

**Drift:** operator detects manual changes, reverts to Git state. 

**Secrets:** external secrets operator, sealed secrets, SOPS. 

**Multi-cluster:** one repo per cluster, or monorepo with directories.

---

### 590. ArgoCD Architecture

GitOps operator. 

**Components:** API Server (UI, gRPC API), Repository Server (clones Git, generates manifests), Application Controller (watches resources, reconciles state). 

**CRDs:** Application (defines source repo, destination cluster, sync policy), AppProject (group apps, RBAC). 

**Workflow:** Application CR points to Git repo → repo server fetches, renders templates (Helm/Kustomize) → app controller compares live state vs desired → syncs if out of sync. 

**UI:** web interface, visualize apps, sync manually, view diff, logs, events. 

**CLI:** `argocd app list`, `argocd app sync myapp`, `argocd app get myapp`. 

**Install:** `kubectl create namespace argocd`, `kubectl apply -n argocd -f install.yaml`, access UI via port-forward or ingress. 

**HA:** run multiple replicas, Redis for cache.

---

### 591. ArgoCD Applications

Define what/where to deploy. 

**Spec:** source (repoURL, path, targetRevision), destination (server, namespace), syncPolicy. 

**Example:** 
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp
spec:
  source:
    repoURL: https://github.com/user/repo
    path: k8s/
    targetRevision: main
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

**Automated sync:** poll Git (default 3 min), auto-apply changes. 

**Prune:** delete resources not in Git. 

**Self-heal:** revert manual changes. 

**Manual sync:** button in UI, or `argocd app sync`. 

**Sync status:** Synced, OutOfSync, Unknown. 

**Health:** Healthy, Progressing, Degraded, Suspended, Missing. 

**App of Apps pattern:** Application that creates other Applications, manage all apps from one root.

---

### 592. ArgoCD Sync Strategies

Control deployment. 

**Sync policies:** automated (auto-sync on Git change), syncOptions (customize behavior). 

**Options:** Prune (delete extra resources), SelfHeal (revert manual changes), CreateNamespace (auto-create namespace), ApplyOutOfSyncOnly (apply only changed resources). 

**Sync phases:** PreSync (run first, e.g., DB migration Job), Sync (main resources), PostSync (run after, e.g., smoke test Job), SyncFail (on failure). 

**Hooks:** Jobs/Pods with annotations `argocd.argoproj.io/hook: PreSync`, `argocd.argoproj.io/hook-delete-policy: HookSucceeded` (delete after success). 

**Sync waves:** order resources within phase, annotation `argocd.argoproj.io/sync-wave: "1"`, lower wave first. 

**Example:** wave 0 = ConfigMap, wave 1 = Deployment. 

**Replace:** `syncOptions: [Replace=true]` (use kubectl replace instead of apply, for resources that don't support strategic merge). 

**Selective sync:** sync specific resources, `argocd app sync myapp --resource Deployment:myapp`.

---

### 593. Progressive Delivery

Gradual rollout with metrics. 

**Canary:** new version to small subset, monitor metrics, proceed if healthy. 

**Flagger:** controller for progressive delivery, works with Istio/Linkerd/Nginx/App Mesh, CRD Canary. 

**Workflow:** Flagger detects Deployment change → creates canary Deployment → shifts traffic gradually (5% → 10% → 50% → 100%) → monitors metrics (success rate, latency) from Prometheus → rollback if metrics fail → promote if success. 

**Canary analysis:** define metrics, thresholds, `metrics: [{ name: request-success-rate, thresholdRange: { min: 99 } }]`. 

**Argo Rollouts:** alternative, native K8s, supports blue/green, canary, analysis. 

**AnalysisTemplate:** define queries, thresholds, frequency. 

**Traffic management:** Istio VirtualService/DestinationRule, nginx ingress weights. 

**Manual approval:** pause rollout, require approval, `pause: { duration: 1h }` or manual. 

**Rollback:** auto if metrics fail, or manual. 

**Use:** high-risk releases, production safety.

---

### 594. Feature Flags

Runtime feature control. 

**Purpose:** deploy code disabled, enable features remotely, A/B testing, gradual rollout, kill switch. 

**Implementation:** config file, database, or service (LaunchDarkly, Unleash, Split), app queries flag before executing code. 

**Example:** `if featureFlags.isEnabled("new-checkout") { newCheckout() } else { oldCheckout() }`. 

**Types:** release toggles (temporary, remove after rollout), experiment toggles (A/B tests), ops toggles (circuit breaker), permission toggles (per-user features). 

**Best practices:** remove old toggles (technical debt), default off, audit who changes flags, version flags with code. 

**User targeting:** % of users, specific user IDs, attributes (location, plan). 

**Metrics:** track feature usage, impact. 

**vs Deployment strategies:** feature flags = code-level, canary = infrastructure-level, combine for max control. 

**Challenges:** complexity (many flags = spaghetti), testing (test all combinations?), cleanup. 

**Tools:** LaunchDarkly (SaaS), Unleash (open-source, self-hosted), custom (Redis, config).

---

### 595. Semantic Versioning

Version format. 

**Format:** MAJOR.MINOR.PATCH (e.g., 2.3.1). 

**MAJOR:** incompatible API changes, breaking. 

**MINOR:** new functionality, backward-compatible. 

**PATCH:** bug fixes, backward-compatible. 

**Pre-release:** `-alpha.1`, `-beta.2`, `-rc.1` (release candidate). 

**Build metadata:** `+20230615`. 

**Initial development:** 0.y.z (anything may change), 1.0.0 = stable API. 

**Rules:** increment MAJOR resets MINOR/PATCH to 0, increment MINOR resets PATCH to 0. 

**Git tags:** `v2.3.1`, automated via CI. 

**Benefits:** communicate change impact, dependency management (npm, Go modules honor semver). 

**Challenges:** requires discipline, accidental breaking changes. 

**Conventional Commits:** automate versioning, `feat:` (MINOR), `fix:` (PATCH), `BREAKING CHANGE:` (MAJOR).

---

### 596. Release Automation

Automate release process. 

**Steps:** version bump, changelog generation, Git tag, GitHub/GitLab release, artifact upload, deploy. 

**Tools:** semantic-release (npm, auto-version based on commits), goreleaser (Go, build multi-arch, release to GitHub/GitLab/Docker), release-please (Google, generates release PRs). 

**Changelog:** auto-generate from commits (conventional commits), group by type (features, fixes). 

**Git tags:** CI triggers on tag push, `git tag v1.2.3`, `git push --tags`. 

**GitHub Releases:** attach binaries, Docker images, notes. 

**Helm chart release:** update Chart.yaml version, publish to registry. 

**Communication:** post to Slack, update docs, email customers. 

**Rollback:** automated revert on failure, git revert tag, redeploy previous. 

**Example workflow:** commit → CI tests → semantic-release bumps version → tag → CI builds release artifacts → pushes to registry → creates GitHub release → posts to Slack.

---

### Category 35: CI/CD Advanced: Jenkins & Complex Workflows (17 concepts)

### 597. Test Automation

Automate quality checks. 

**Unit tests:** test functions/methods in isolation, fast (ms), many (100s-1000s), mock dependencies, run on every commit. 

**Integration tests:** test components together (app + DB), slower (seconds), fewer, use test DB, run in CI. 

**End-to-end (E2E) tests:** test full system from UI/API, slowest (minutes), fewest, flaky, run on deploy to staging. 

**Contract tests:** verify API contracts (Pact), consumer/provider tests. 

**Performance tests:** load testing (k6, Locust), benchmarks. 

**Security tests:** SAST (static analysis), dependency scanning, container scanning. 

**Test pyramid:** many unit (base), some integration (middle), few E2E (top). 

**Coverage:** measure code coverage, 70-90% good target, 100% not necessary. 

**Mutation testing:** change code, tests should fail (verify test quality). 

**CI integration:** run tests in pipeline, fail build on failure. 

**Parallel execution:** speed up tests, split across multiple runners.

---

### 598. Security Scanning in CI

Shift left security. 

**SAST (Static Application Security Testing):** analyze source code for vulnerabilities, tools: SonarQube, Semgrep, CodeQL, Snyk Code. 

**Dependency scanning:** check libraries for CVEs, tools: Snyk, Dependabot, npm audit, Go vulnerability DB. 

**Container scanning:** scan Docker images, tools: Trivy, Grype, Clair, Snyk Container. 

**Secrets detection:** find hardcoded secrets, tools: GitLeaks, TruffleHog, detect-secrets. 

**Infrastructure scanning:** IaC security, tools: tfsec, Checkov, KICS. 

**License compliance:** check open-source licenses, tools: FOSSA, WhiteSource. 

**CI integration:** run scanners as pipeline jobs, fail build on high/critical findings (or create tickets). 

**Results:** upload to security dashboard, track trends, assign to devs. 

**False positives:** triage, suppress, don't ignore all. 

**Remediation:** auto-PR with updates (Dependabot), or manual fix. 

**Example job:** `security-scan: { script: [trivy image --severity CRITICAL,HIGH myimage, exit $?] }`.

---

### 599. Code Quality Gates

Enforce quality standards. 

**Metrics:** code coverage (%, lines/branches covered), complexity (cyclomatic, cognitive), duplication (%), bugs, vulnerabilities, code smells. 

**Tools:** SonarQube (comprehensive, quality profiles), CodeClimate, Codacy. 

**Quality gates:** thresholds, must pass to merge/deploy, examples: coverage > 80%, no critical bugs, duplication < 3%. 

**SonarQube integration:** scanner in CI, results to SonarQube server, API to check gate status, fail pipeline if failed. 

**GitHub/GitLab integration:** status check on PR, require passing before merge. 

**Benefits:** prevent technical debt, enforce standards, improve maintainability. 

**Configure:** define rules per language, set thresholds, adjust to team maturity. 

**Trends:** track quality over time, new code quality gate (stricter on new code vs existing). 

**Challenges:** false positives, developer friction (too strict), need buy-in.

---

### 600. Pipeline Optimization

Speed up CI/CD. 

**Caching:** dependencies (npm, pip, go mod), Docker layers, Gradle/Maven cache, key by lock file hash. 

**Parallelization:** run tests in parallel (split by file/suite), parallel stages (test + lint). 

**Incremental builds:** only build changed code, Docker layer cache, build tools (Bazel, Buck). 

**Smaller images:** multi-stage Dockerfile, alpine base, minimize layers. 

**Fast tests first:** unit tests before slow E2E, fail fast. 

**Reduce checkout:** shallow clone (`--depth=1`), sparse checkout. 

**Hosted runners:** use powerful machines, or scale self-hosted. 

**Skip jobs:** conditional execution, skip if no code changes (`[skip ci]` in commit message). 

**Matrix builds:** test multiple versions concurrently, not sequentially. 

**Artifacts:** only upload needed artifacts, compress. 

**Monitoring:** measure build time, identify bottlenecks, optimize slowest jobs. 

**Target:** < 10 min build, < 5 min feedback for devs.

---

### 601. Secrets in CI/CD

Secure sensitive data. 

**Storage:** CI/CD secret storage (GitLab CI variables, GitHub Secrets), Vault, cloud secret managers (AWS Secrets Manager, GCP Secret Manager). 

**Injection:** as environment variables, masked in logs, `${{ secrets.DB_PASSWORD }}` (GitHub), `$DB_PASSWORD` (GitLab masked variable). 

**Protected secrets:** only available to protected branches/tags, require permissions. 

**Rotation:** rotate regularly, automate. 

**Never commit:** use pre-commit hooks (GitLeaks), scan repos. 

**Access control:** RBAC, least privilege, audit who accessed. 

**Dynamic secrets:** Vault generates short-lived credentials, revoke after use. 

**Kubernetes:** use secrets, External Secrets Operator, sealed secrets. 

**Example:** Vault agent in CI pod, fetches secret, injects into app. 

**Best practices:** one secret per environment, encrypt at rest, use secret managers, avoid long-lived tokens.

---

### 602. Pipeline Triggers

When to run. 

**Push:** default, run on every commit to branch. 

**Merge request:** run on MR creation/update, show results in MR. 

**Tag:** run on git tag push, for releases. 

**Schedule:** cron, nightly builds, periodic security scans. 

**Manual:** button in UI, for deploy to prod. 

**API:** trigger via webhook/API, external systems. 

**Upstream pipeline:** trigger after another pipeline completes, multi-project pipelines. 

**Rules:** GitLab `rules:`, GitHub `on:`, complex conditions (branch + changes in path). 

**Example:** `only: [main, tags]`, `except: [schedules]`, `rules: [{ if: '$CI_COMMIT_BRANCH == "main"', when: always }]`. 

**Debounce:** prevent duplicate runs, cancel in-progress if new commit pushed. 

**Filters:** path filters (only run if files in path changed), `paths: [src/**, tests/**]`.

---

### 603. Deployment Rollback

Revert to previous version. 

**Kubernetes:** `kubectl rollout undo deployment` (previous RS), `kubectl rollout undo deployment --to-revision=2` (specific revision). 

**Helm:** `helm rollback myrelease` (previous release), `helm rollback myrelease 3` (revision 3). 

**ArgoCD:** UI or `argocd app rollback myapp`, revert to previous Git commit, or manually edit Application to point to old commit. 

**Blue/Green:** switch traffic back to blue (instant). 

**Canary:** halt rollout, shift traffic back to stable. 

**Database migrations:** more complex, need backward-compatible schema changes, separate data migration from code deploy. 

**Testing rollback:** periodically test rollback procedure, chaos engineering. 

**Fast forward:** if rollback not possible, fix forward (hotfix). 

**Monitoring:** detect need for rollback (error rate, latency), automate with Flagger. 

**Communication:** inform team, postmortem why rollback needed.

---

### 604. Infrastructure Deployment

Deploy infra changes. 

**Terraform:** `terraform apply` in CI/CD, remote state (S3 + DynamoDB lock), `terraform plan` on MR for review. 

**Atlantis:** Terraform automation for PRs, PR comments trigger plan/apply, approval workflow. 

**GitLab Terraform integration:** managed state, `.gitlab-ci.yml` jobs for plan/apply. 

**Example job:** 
```yaml
terraform-plan:
  script:
    - terraform init
    - terraform plan -out=plan.tfplan
  artifacts:
    paths: [plan.tfplan]

terraform-apply:
  script:
    - terraform apply plan.tfplan
  when: manual
```

**Challenges:** long-running applies (timeouts), drift (manual changes), secrets (use Vault provider). 

**Testing:** terratest, checkov, tfsec in CI. 

**Multi-environment:** separate state per env, workspaces or directories. 

**Dependencies:** infra deployed before apps, or App-of-Apps pattern (ArgoCD).

---

### 605. Kubernetes Deployment in CI

Deploy apps to K8s. 

**Methods:** kubectl apply (simple), Helm (templating), Kustomize (overlays), GitOps (ArgoCD/Flux). 

**kubectl:** `kubectl apply -f k8s/` in CI, requires kubeconfig, service account. 

**Helm:** `helm upgrade --install myapp chart/ --values values-prod.yaml`, namespace, wait for rollout. 

**GitOps:** CI builds image, pushes to registry, updates Git repo (image tag in YAML), ArgoCD syncs. 

**Image tag:** use commit SHA or version, update Deployment YAML. 

**Image updater:** automate image tag update (ArgoCD Image Updater, Flux). 

**Rollout status:** `kubectl rollout status deployment` (wait for completion), fail job if fails. 

**Secrets:** don't store in Git, use External Secrets, Sealed Secrets, or inject from Vault. 

**Example GitOps workflow:** CI → build image → push → update k8s/deployment.yaml (image: v1.2.3) → commit to Git → ArgoCD detects → applies.

---

### 606. Blue/Green Deployment

Two identical environments. 

**Setup:** blue (current), green (new), load balancer switches traffic. 

**Deployment:** deploy to green (idle), test green, switch LB to green (instant cutover), blue becomes idle (keep for rollback). 

**Rollback:** switch LB back to blue (instant). 

**K8s implementation:** two Deployments (blue, green), Service selector switches (`kubectl patch service myapp -p '{"spec":{"selector":{"version":"green"}}}'`), or Ingress weight. 

**Traffic management:** Istio VirtualService 100% to green, or nginx ingress annotation. 

**Benefits:** zero downtime, instant rollback, test in production-like env. 

**Drawbacks:** 2x resources, database migrations tricky (both versions may access), stateful apps harder. 

**Use cases:** critical apps, releases with high risk, compliance (must have rollback). 

**Automation:** Flagger supports blue/green, or custom scripts.

---

### 607. Canary Deployment

Gradual traffic shift. 

**Phases:** deploy canary (new version), route small % traffic (5%), monitor metrics, increase % (10%, 25%, 50%, 100%), promote or rollback. 

**K8s implementation:** two Deployments (stable v1, canary v2), Service selects both, use Istio/Linkerd/nginx to control traffic weight. 

**Istio VirtualService:** 
```yaml
http:
  - match: [{ uri: { prefix: / } }]
    route:
      - destination: { host: myapp, subset: v1 }
        weight: 95
      - destination: { host: myapp, subset: v2 }
        weight: 5
```

**Flagger:** automates canary, defines Canary CR (steps, metrics), monitors Prometheus, shifts traffic gradually, promotes or rolls back. 

**Metrics:** request success rate, latency, custom (business metrics from Prometheus). 

**Manual approval:** pause canary, require approval before proceeding. 

**Use cases:** gradual risk, validate in production with real users, high-traffic services. 

**vs A/B testing:** canary = deployment risk, A/B = feature validation, can combine.

---

### 608. Immutable Deployments

Never modify running infrastructure. 

**Principle:** never patch/update running servers/containers, always replace with new version. 

**Benefits:** predictable (same artifact everywhere), rollback (redeploy old version), eliminates drift (no manual changes), easier debugging (known state). 

**Containers:** naturally immutable (image is read-only), Kubernetes recreates pods on update. 

**VMs:** immutable images (Packer), deploy new VMs, delete old (auto-scaling groups). 

**Configuration:** baked into image, or injected at runtime (ConfigMap), no SSH to modify. 

**Blue/Green:** fits immutable model (never modify blue, always deploy green). 

**Databases:** challenge (stateful), use migrations, backups, separate lifecycle. 

**vs Mutable:** traditional = SSH in, apt-get install, patch; immutable = build new image, deploy. 

**Phoenix servers:** regularly rebuild from scratch, prevent drift. 

**Tools:** Kubernetes, Packer, Terraform, cloud auto-scaling.

---

---

### 609. Jenkins Pipeline Syntax

Jenkinsfile: declarative or scripted. Declarative: structured, easier, `pipeline { agent, stages, steps }`. Scripted: Groovy code, flexible. Stages: logical sections (Build, Test, Deploy), parallel stages. Steps: sh (shell), bat (Windows), echo, git, docker. Agent: where to run (any, label, docker, kubernetes). Post: always, success, failure (cleanup, notifications). Environment: variables, credentials. When: conditional execution (branch, changelog). Input: manual approval. Example: `stage('Build') { steps { sh 'make build' } }`. Best practice: declarative for most, scripted for complex logic.

### 610. Jenkins Shared Libraries

Reusable pipeline code. Structure: vars/ (global functions), src/ (Groovy classes), resources/ (files). Load: `@Library('my-lib') _`, use functions in Jenkinsfile. Versioning: Git tags, branches (pin to version or use latest). Example: common deploy function `deploy(env: 'prod', app: 'web')`, used across pipelines. Benefits: DRY (don't repeat yourself), consistency, centralized updates. Configuration: Jenkins → Manage → Configure System → Global Pipeline Libraries. Use case: standardize CI/CD, enforce best practices, reduce duplication.

### 611. Multi-Branch Pipelines

Separate pipeline per branch. Jenkinsfile in repo: pipeline defined in source. Branch discovery: scans repo, creates job per branch (feature/*, main, develop). PR builds: test pull requests before merge. Branch indexing: periodic scan, webhook trigger. Cleanup: delete jobs for deleted branches. Use case: feature branch testing, consistent pipeline across branches. Configuration: multibranch pipeline job, SCM (GitHub, GitLab), Jenkinsfile path. GitHub integration: status checks, PR comments. Best practice: same Jenkinsfile, environment-specific configs via parameters.

### 612. Pipeline as Code Best Practices

Maintainable pipelines. Version control: Jenkinsfile in Git (auditability, rollback). Parameterization: environment, version, flags (reusable). Idempotency: safe to re-run (don't duplicate resources). Secrets: Jenkins credentials, avoid hardcoding. Modular: shared libraries, small functions. Testing: test pipelines in dev branch, validate Jenkinsfile syntax. Documentation: comments, README. Fast feedback: fail fast, parallel stages. Observability: logs, metrics, notifications. Reproducibility: Docker agents (consistent environment). Use case: scale CI/CD, team collaboration, reliability.

### 613. Blue Ocean

Modern Jenkins UI. Features: visual pipeline editor (drag-drop), pipeline visualization (stages, steps), personalized dashboard, GitHub/Bitbucket integration. View: branch-based, PR integration, run logs. Editor: create Jenkinsfile without Groovy knowledge (declarative only). Installation: plugin (Blue Ocean). Use case: easier onboarding, visual debugging, better UX. Limitations: not all Jenkins features (classic UI still needed), declarative pipelines only. Access: `/blue` endpoint. Best practice: use for visualization, editor for simple pipelines, Jenkinsfile for complex.

### Category 36: GitOps I: ArgoCD Basics (15 concepts)

### 614. GitOps Principles Deep Dive

Git as single source of truth. Declarative: describe desired state (YAML, Helm, Kustomize), not imperative steps. Version controlled: all changes in Git (audit trail, rollback). Automatic: controllers sync Git → cluster (reconciliation loop). Observable: drift detection, diff between Git and cluster. Benefits: auditability, rollback (git revert), collaboration (PR review), security (RBAC on Git), disaster recovery (recreate from Git). Tools: ArgoCD, Flux, Jenkins X. Use case: Kubernetes deployments, infrastructure as code, multi-environment.

### 615. ArgoCD Architecture Deep Dive

Components: API Server (gRPC/REST, UI, CLI endpoint), Repo Server (clone Git, render manifests), Application Controller (reconcile loop, sync Git to cluster), Redis (cache, app state). Deployment: Kubernetes (Deployment, StatefulSet), namespace (argocd). Access: web UI (port-forward or Ingress), CLI (argocd login). RBAC: projects (group apps), roles (read-only, admin). High availability: multiple replicas (controller, server), Redis HA. Scaling: repo server replicas (many repos), sharding (application controller). Monitoring: Prometheus metrics, logs.

### 616. ArgoCD Application CRD

Defines deployment. Spec: source (repoURL, path, targetRevision), destination (server, namespace), syncPolicy (automated/manual, prune, selfHeal). Example: deploy from Git repo 'main' branch, folder 'manifests/', to namespace 'production'. Target revision: branch, tag, commit SHA. Directory: plain YAML, Helm chart, Kustomize. Multiple sources: combine (e.g., Helm chart + values from another repo). App of Apps: Application that deploys other Applications (pattern for many apps). View: `kubectl get application -n argocd`, ArgoCD UI.

### 617. ArgoCD Sync Strategies Deep Dive

Manual sync: user triggers (button or CLI). Auto-sync: reconcile on Git change, interval (3 min default). Prune: delete resources not in Git (cleanup). Self-heal: revert manual changes (drift correction). Sync options: RespectIgnoreDifferences (ignore certain fields), Validate (check before apply), CreateNamespace, ApplyOutOfSyncOnly (skip in-sync resources). Sync phases: PreSync (hooks, DB migration), Sync (apply resources), PostSync (tests, notifications). Sync windows: allow/deny sync during time windows (maintenance windows). Use case: auto-sync for dev, manual for prod, self-heal to prevent drift.

### 618. ArgoCD Projects

Multi-tenancy and access control. Project: logical grouping, restrict source repos, destination clusters/namespaces, allowed K8s resources. RBAC: roles per project (read-only, deployer, admin), bind to users/groups. Default project: unrestricted (not recommended for production). Example: team-a project → only deploy from team-a repo → only to team-a-* namespaces. Cluster resources: allow/deny (e.g., disallow ClusterRole). Orphaned resources: resources not in Git. Use case: multi-team, security boundaries, prevent accidents. Create: `argocd proj create team-a`, CLI or UI.

### 619. ArgoCD App of Apps Pattern

Manage multiple apps. Bootstrap: root Application deploys child Applications. Structure: apps/ folder with Application manifests, root app points to apps/. Benefits: add app by committing file (self-service), single source of truth, consistent deployment. Example: root app → app1.yaml, app2.yaml → app1 deploys microservice A, app2 deploys microservice B. Recursive: apps can deploy other apps (tree structure). Use case: microservices, multi-environment (dev/stage/prod), platform teams. Best practice: combine with ApplicationSets for dynamic generation.

### 620. ArgoCD ApplicationSet

Generate multiple Applications. Generators: Git (files in repo), Cluster (registered clusters), List (static list), Matrix (combine generators). Use case: deploy to multiple clusters (dev, stage, prod), deploy multiple microservices (from list), deploy per tenant (folder per customer). Example: Git generator finds all apps/*/ folders, creates Application per folder. Template: Application spec with parameters from generator. Sync waves: order ApplicationSets (install operators before apps). Dynamic: add cluster → ApplicationSet auto-creates Application. Best practice: use for patterns (many similar apps).

### 621. ArgoCD Sync Waves & Hooks

Order resource creation. Sync waves: annotation `argocd.argoproj.io/sync-wave: "1"`, lower numbers first (default 0). Example: namespace (wave 0), CRDs (wave 1), operator (wave 2), app (wave 3). Hooks: PreSync (before sync), Sync (during), PostSync (after sync), SyncFail (on failure). Hook deletion: HookSucceeded, HookFailed, BeforeHookCreation. Use case: database migrations (PreSync), smoke tests (PostSync), dependencies (sync waves). Example: Job as PostSync hook (run tests after deployment). Best practice: use waves for dependencies, hooks for one-time tasks.

### 622. ArgoCD Health Checks

Determine app status. Built-in: Deployments (replicas ready), StatefulSets, DaemonSets, Services, Ingress. Custom: Lua script for CRDs (define health logic). States: Healthy (ready), Progressing (rolling out), Degraded (failures), Suspended (paused). Example: Deployment healthy when `status.availableReplicas == spec.replicas`. CRD health: operator sets status.conditions, ArgoCD checks. Missing health: Unknown status. Use case: visual status in UI, block sync on unhealthy, alerts. Configuration: ConfigMap `argocd-cm`, add custom health check.

### 623. ArgoCD SSO Integration

Enterprise authentication. Providers: OIDC (Okta, Auth0, Keycloak), SAML, LDAP, GitHub, GitLab. Configuration: `argocd-cm` ConfigMap, set OIDC issuer, client ID/secret. RBAC: map groups to roles, policy.csv (g, mygroup, role:admin). Example: Okta login, user in 'platform-team' group → admin role. Local accounts: fallback (admin user), disable in production. CLI login: `argocd login --sso`. Use case: centralized identity, enforce MFA, compliance. Best practice: SSO + RBAC, disable local admin.

### 624. ArgoCD Notifications

Alert on app events. Triggers: on-sync-succeeded, on-sync-failed, on-deployed, on-health-degraded. Destinations: Slack, email, webhook, Grafana, Opsgenie, PagerDuty. Templates: customize message (Markdown, HTML). Configuration: ConfigMap `argocd-notifications-cm`, Secret for credentials. Subscriptions: per Application (annotation), per Project. Example: notify Slack on production deployment. Conditions: filter (only prod apps, only failures). Use case: deployment visibility, incident alerting, audit trail. Integration: Slack bot, GitHub status checks.

### 625. ArgoCD Image Updater

Auto-update images. Strategy: poll registry, update Git (new commit), ArgoCD syncs. Policies: semver (update to latest minor), latest tag, digest (SHA). Annotations: on Application (image to track, update strategy). Write-back: commit to Git (branch, PR). Use case: dev environments (auto-update to latest), staging (test new images). Production: not recommended (manual approvals). Example: track myapp:1.x, auto-update to 1.2 when released. Install: separate controller (argocd-image-updater). Best practice: use for non-prod, combine with PR approval for prod.

### 626. ArgoCD Multi-Cluster

Manage multiple K8s clusters. Add cluster: `argocd cluster add context`, stores credentials in Secret. Deploy: Application destination (cluster URL, namespace). Cluster list: UI shows all clusters, health, version. In-cluster: ArgoCD in cluster A deploys to cluster A (default). Remote: ArgoCD in cluster A deploys to cluster B (API access). Hub-spoke: central ArgoCD manages edge clusters. Use case: multi-region, multi-environment, disaster recovery. RBAC: restrict users to certain clusters (project destinations). Best practice: label clusters (env, region), use projects for isolation.

### 627. ArgoCD CLI

Command-line interface. Login: `argocd login <server>`, `--sso`, `--username/password`. Apps: `argocd app list`, `argocd app get <app>`, `argocd app sync <app>`, `argocd app diff <app>`, `argocd app set <app> --parameter key=value`. Clusters: `argocd cluster list`, `argocd cluster add <context>`. Projects: `argocd proj create`, `argocd proj role` (RBAC). Logs: `argocd app logs <app>`, `--follow`. Wait: `argocd app wait <app>` (CI/CD integration, wait for healthy). Use case: scripting, CI/CD pipelines, automation. Install: brew, binary, container image.

### 628. ArgoCD Best Practices

Production deployment. Git structure: monorepo or multi-repo, folder per environment (dev/, stage/, prod/). Projects: isolate teams, environments, restrict destinations. Auto-sync: enable for dev, manual for prod, self-heal to prevent drift. Sync waves: order dependent resources (CRDs, operators, apps). Health checks: define for CRDs, ensure accurate status. Secrets: use External Secrets Operator or Sealed Secrets (not plaintext in Git). Notifications: alert on failures, deployments. RBAC: SSO + groups, least privilege. HA: multiple replicas, Redis HA. Monitoring: Prometheus metrics, Grafana dashboards. Backup: export apps, disaster recovery from Git.

### Category 37: GitOps II: Flux & Progressive Delivery (15 concepts)

### 629. Flux Architecture

GitOps toolkit. Components: Source Controller (sync Git/Helm repos), Kustomize Controller (apply Kustomizations), Helm Controller (manage Helm releases), Notification Controller (alerts), Image Reflector/Automation (update images). CRDs: GitRepository, Kustomization, HelmRelease, HelmRepository, Bucket (S3-compatible). Reconciliation: controllers watch CRDs, sync to cluster, interval (1m default). Install: flux bootstrap (Git, GitHub, GitLab), creates flux-system namespace. Comparison: ArgoCD (monolithic, UI), Flux (modular, GitOps Toolkit). Use case: Kubernetes GitOps, Helm management, multi-tenancy.

### 630. Flux GitRepository

Git source. Spec: URL, ref (branch, tag, commit), interval (sync period), secret (auth). Git providers: GitHub, GitLab, Bitbucket, generic Git. Authentication: SSH key, HTTPS token, deploy key. Status: artifact (tarball of repo), ready condition. Reconciliation: clone repo, package as artifact, other controllers consume. Example: `flux create source git myapp --url=https://github.com/org/repo --branch=main`. Use case: source for Kustomization, HelmRelease. Multiple sources: different repos for different apps.

### 631. Flux Kustomization

Apply manifests from Git. Spec: sourceRef (GitRepository), path (folder), interval, prune (delete removed resources), healthChecks (wait for resources). Kustomize: overlays, patches, common labels. Dependencies: dependsOn (apply after other Kustomization). Validation: server-side apply, dry-run. Decryption: SOPS (decrypt secrets). Example: `flux create kustomization webapp --source=myapp --path=./deploy --prune=true`. Use case: deploy apps, manage infrastructure, multi-environment (base + overlays). Status: last applied revision, conditions.

### 632. Flux HelmRelease

Manage Helm charts. Spec: chart (HelmRepository, version), values (inline or valuesFrom), interval, install/upgrade/rollback config. Dependencies: dependsOn (install after dependencies). Tests: Helm test hooks. Drift detection: check deployed vs desired. Reconciliation: install or upgrade chart, rollback on failure. Example: `flux create helmrelease nginx --source=HelmRepository/bitnami --chart=nginx --version=9.x`. Use case: deploy Helm charts, GitOps for Helm, multi-tenancy. Values: override defaults, from Secret/ConfigMap (external values). Best practice: version pin (avoid 'latest').

### 633. Flux Image Automation

Auto-update images in Git. Components: Image Reflector (scan registries, find tags), Image Policy (filter tags, semver), Image Automation (update Git, commit). Workflow: reflector scans registry → policy selects tag → automation updates YAML → commits to Git → Kustomization syncs. Markers: `# {"$imagepolicy": "namespace:policy"}` in YAML. Example: update image tag to latest 1.x version, commit to Git. Use case: dev environments (auto-deploy latest), staging (test new images). Not for prod: manual control. Install: flux bootstrap --components-extra=image-reflector-controller,image-automation-controller.

### 634. Flux Multi-Tenancy

Isolate teams. Tenant: namespace, GitRepository (team repo), Kustomization (deploy team apps), ServiceAccount (RBAC). Lockdown: impersonation (Kustomization runs as ServiceAccount), network policies, resource quotas. Structure: platform team bootstraps tenant namespaces, tenants manage own apps. Example: team-a namespace, GitRepository → team-a repo, Kustomization applies team-a/apps/. RBAC: tenants can't access other namespaces, platform admins manage Flux CRDs. Use case: SaaS platforms, shared clusters, team isolation. Best practice: separate Git repos per tenant, enforce policies (OPA, Kyverno).

### 635. Flux Notifications

Alerts on reconciliation. Providers: Slack, Microsoft Teams, Discord, webhook, Prometheus Alertmanager. Alerts: reconciliation failure, drift detected, new artifact. Example: notify Slack when Kustomization fails. Filter: severity (info, error), eventSources (GitRepository, Kustomization, HelmRelease). Configuration: Provider (endpoint, secret), Alert (event types, summary). Use case: deployment visibility, incident response. Integration: Slack bot, Grafana annotations. Create: `flux create alert-provider slack --type=slack --address=https://hooks.slack.com/...`, `flux create alert myapp --provider=slack --event-source=Kustomization/myapp`.

### 636. Flux vs ArgoCD

GitOps tool comparison. Flux: modular (GitOps Toolkit), no UI (use Weave GitOps), multi-tenancy by design, Helm first-class, SOPS integration, CLI-centric. ArgoCD: monolithic, rich UI (dashboards, visualizations), App of Apps pattern, ApplicationSets, SSO, Projects. Similarities: Git as source, reconciliation, health checks, drift detection. Use case: Flux for Helm-heavy, multi-tenant, no UI requirement. ArgoCD for UI, visualization, easier onboarding. Both: production-ready, CNCF projects. Migration: possible both ways. Best practice: choose based on team needs, UI requirements.

### 637. Flagger (Progressive Delivery)

Automate canary/blue-green. Canary: gradual traffic shift (10% → 50% → 100%), analyze metrics (error rate, latency), rollback on failure. Blue-green: deploy new version (green), switch traffic, rollback if issues. A/B testing: route based on headers. Architecture: Flagger controller watches Canary CRD, adjusts weights, queries metrics (Prometheus), decides promote/rollback. Integrations: Istio, Linkerd, App Mesh, NGINX, Gloo (traffic shaping), Prometheus (metrics). Example: Canary with 3 steps (10%, 50%, 100%), 1 min per step, check error rate < 1%. Use case: safe deployments, reduce blast radius, automatic rollback.

### 638. Flagger Canary CRD

Define progressive rollout. Spec: targetRef (Deployment), service (primary, canary), analysis (metrics, thresholds, interval), canaryAnalysis (steps, webhooks). Metrics: Prometheus query, threshold. Example: request-success-rate > 99%, request-duration < 500ms. Steps: weight progression (10, 25, 50, 100), iterations (repeat before proceed). Webhooks: pre-rollout (load test), post-rollout (notify). Rollback: automatic on threshold breach. Status: phase (Initializing, Progressing, Succeeded, Failed). Use case: gradual rollout, metric-driven, automatic rollback. Best practice: define meaningful metrics (business metrics, not just CPU).

### 639. Flagger Metrics Analysis

Evaluate deployment health. Metric providers: Prometheus, Datadog, New Relic, CloudWatch, Graphite. Metrics: built-in (request-success-rate, request-duration from Istio/Linkerd), custom (PromQL queries). Thresholds: max (upper bound, e.g., error rate < 1%), min (lower bound, e.g., requests > 10/s), range. Interval: analysis period (1m), iterations (repeat N times before promote). Webhooks: external checks (Selenium tests, smoke tests), gate conditions. Example: query `sum(rate(requests_total{status!~"5.."}[1m])) / sum(rate(requests_total[1m])) * 100 > 99`. Use case: metric-driven rollouts, avoid bad deployments. Best practice: multiple metrics (errors, latency, saturation).

### 640. Flagger with Istio

Progressive delivery with service mesh. Traffic shifting: VirtualService weights (canary: 10%, primary: 90%). Metrics: Istio telemetry (request count, duration, errors), scraped by Prometheus. Configuration: Canary references Deployment, Flagger creates canary Deployment, adjusts VirtualService. Rollout: Flagger increments canary weight, waits, analyzes metrics, promotes or rolls back. Rollback: reset VirtualService to 100% primary. Example: canary 3 steps (5%, 10%, 50%), 1 min analysis, promote if success rate > 99%. Use case: microservices, Istio users, safe rollouts. Install: Flagger + Istio + Prometheus.

### 641. Flagger with Linkerd

Lightweight progressive delivery. Traffic splitting: TrafficSplit CRD (SMI spec), weights. Metrics: Linkerd Prometheus (success rate, latency). Configuration: similar to Istio, Flagger manages TrafficSplit. Benefits: simpler than Istio, lower overhead. Example: canary 2 steps (50%, 100%), check request-success-rate. Use case: Linkerd users, canary with minimal setup. Install: Flagger + Linkerd + Prometheus. Best practice: enable Linkerd Viz for metrics.

### 642. Blue-Green Deployments

Zero-downtime switchover. Strategy: deploy new version (green) alongside old (blue), run tests, switch traffic, rollback if issues. Implementation: two environments (blue, green), load balancer or DNS switch. Kubernetes: two Deployments, Service selector switches. Flagger: mirroring (send copy of traffic to green), no user impact, validate, switch. Argo Rollouts: BlueGreen strategy, autoPromotionEnabled. Use case: risk-averse deployments, quick rollback, validate before traffic. Comparison: canary (gradual), blue-green (instant switch). Trade-off: double resources during rollout.

### 643. Feature Flags in GitOps

Decouple deploy from release. Feature flags: toggle features at runtime (LaunchDarkly, Unleash, Flagsmith, custom). GitOps: deploy code (flags off), enable via flag (no redeploy). Use case: trunk-based development (merge to main, features disabled), gradual rollout (enable for 10% users), A/B testing, kill switches. Example: deploy v2 with flag 'new-ui' off, enable for beta users. Integration: app reads flags (SDK), flag service manages state. Best practice: flags for risky features, clean up old flags (technical debt). Progressive delivery: combine with canary (deploy + enable flag gradually).

### Category 38: GitOps Advanced: Multi-env & Patterns (15 concepts)

### 644. GitOps Repository Patterns

Organize Git repos. Monorepo: all apps/envs in one repo, simple, single source, scaling challenges. Multi-repo: repo per app, isolation, complex coordination. Hybrid: shared infra repo + app repos. Structure: folder per environment (dev/, stage/, prod/), base + overlays (Kustomize), values per env (Helm). Best practice: environment branching (branch per env) or folder-based (main branch, env folders). Use case: choose based on team size, number of apps. Example: monorepo with apps/app1/base, apps/app1/overlays/prod.

### 645. Environment Promotion

Move changes between environments. Strategies: Git flow (dev branch → stage branch → main), folder-based (update dev/ folder, then stage/, then prod/), image promotion (change image tag in prod manifests). Automation: PR from dev to prod (review required), scripts (copy manifests, update tags), tools (ArgoCD image updater, Flux automation). Testing: validate in dev, smoke tests in stage, deploy to prod. Approvals: manual gate (PR approval) or automated (metrics-based). Use case: safe production deployments, compliance, auditability. Best practice: immutable artifacts (same image across envs), test in stage before prod.

### 646. GitOps Secrets Management

Secure secrets in Git. Problem: can't commit plaintext secrets. Solutions: Sealed Secrets (encrypt with public key, controller decrypts in cluster), SOPS (encrypt files with KMS/PGP, Flux/ArgoCD decrypt), External Secrets Operator (fetch from Vault/AWS Secrets Manager, sync to K8s Secret), Helm Secrets (encrypt Helm values). Example: encrypt secret.yaml with kubeseal, commit sealed-secret.yaml, controller creates Secret. Best practice: encrypt in Git (auditability), use KMS (AWS KMS, GCP KMS, Azure Key Vault). Rotation: update encrypted secret, sync. Comparison: Sealed Secrets (K8s-native), SOPS (flexible), ESO (external sources).

### 647. SOPS with Flux

Encrypt secrets in Git. SOPS: encrypts YAML/JSON values (not keys), supports KMS, PGP, age. Flux integration: Kustomization decrypts SOPS files on apply. Setup: create KMS key (AWS, GCP, Azure), configure SOPS (.sops.yaml), encrypt files (`sops -e secret.yaml > secret.enc.yaml`), commit encrypted file, configure Flux Kustomization with decryption provider. Example: SOPS encrypts `data` in Secret, Flux decrypts during reconciliation. Use case: GitOps with secrets, auditability, encryption at rest. Best practice: use KMS (no key management), rotate keys periodically.

### 648. Sealed Secrets

K8s-native secret encryption. Architecture: controller generates key pair, public key encrypts secrets (kubeseal CLI), controller decrypts with private key, creates Secret. Workflow: `kubeseal < secret.yaml > sealed-secret.yaml`, commit sealed-secret.yaml, apply (controller creates Secret). Scopes: strict (namespace + name), namespace-wide, cluster-wide. Key rotation: controller generates new key, re-encrypt secrets. Backup: private key (disaster recovery). Use case: encrypt secrets for Git, no external dependencies. Limitations: re-encrypt on namespace/name change. Comparison: SOPS (more flexible), Sealed Secrets (simpler, K8s-only).

### 649. External Secrets Operator

Sync secrets from external stores. Providers: AWS Secrets Manager/Parameter Store, Azure Key Vault, GCP Secret Manager, HashiCorp Vault, 1Password, Doppler. CRDs: SecretStore (provider config, auth), ExternalSecret (which secrets to sync, target Secret). Workflow: ExternalSecret references SecretStore, operator fetches from provider, creates Secret in K8s. Refresh: automatic (poll interval), immediate (webhook). Use case: centralized secrets (Vault), avoid secrets in Git, secret rotation (external tool handles). Example: fetch DB password from AWS Secrets Manager, sync to K8s Secret. Best practice: use for production, combine with GitOps (ExternalSecret in Git, Secret created dynamically).

### 650. GitOps Multi-Environment Strategies

Manage dev/stage/prod. Strategies: branch per environment (dev branch, prod branch, promote via PR), folder per environment (main branch, dev/, prod/), repo per environment (separate repos). Kustomize: base + overlays (common base, env-specific overlays). Helm: values per env (values-dev.yaml, values-prod.yaml). ArgoCD: Application per env (different targetRevision or path). Flux: Kustomization per env. Approval: manual for prod (PR review), automatic for dev. Use case: isolated environments, different configs (replicas, resources). Best practice: folder-based (single source, easy promotion), immutable images (tag, not 'latest').

### 651. GitOps Application Dependencies

Order deployments. Methods: Sync waves (ArgoCD, annotations), Kustomization dependencies (Flux, dependsOn), Helm dependencies (Chart.yaml). Example: deploy CRDs (wave 0), operator (wave 1), app (wave 2). Flux: Kustomization A depends on Kustomization B (waits for B to be ready). Use case: operators before CRs, database before app, shared infra before apps. Best practice: minimal dependencies (loose coupling), health checks (ensure dependencies ready).

### 652. GitOps Rollback Strategies

Recover from bad deployments. Git revert: revert commit, GitOps syncs old version. Tag-based: deploy from Git tags, rollback by changing tag. ArgoCD: sync to previous revision (UI or CLI), history shows past versions. Flux: suspend auto-sync, manually apply old version. Database migrations: backward-compatible changes (add column, don't drop), separate rollback migration. Testing: smoke tests (detect issues), automated rollback (Flagger). Use case: bad deployment, critical bug, customer impact. Best practice: test rollback procedures, blue-green for instant rollback.

### 653. GitOps for Multi-Cluster

Manage multiple clusters. Patterns: repo per cluster (cluster-a/, cluster-b/), ApplicationSet (ArgoCD, generator per cluster), Flux Kustomization per cluster. Hub-spoke: central GitOps cluster manages remote clusters. Propagation: same app to multiple clusters (different configs per cluster). Example: deploy app to dev cluster (1 replica), stage (3 replicas), prod (10 replicas). Cluster-specific: overlay per cluster, values per cluster. Use case: multi-region, multi-tenant, disaster recovery. Best practice: label clusters (env, region), use generators (ApplicationSet, Flux cluster generator).

### 654. GitOps Compliance & Auditing

Track changes. Auditability: Git log (who changed what when), PR review (approval trail), signed commits (verify author). Compliance: RBAC on Git (who can merge to main), policies (OPA, deny non-compliant manifests), drift detection (alerts on manual changes). Reporting: Git history, ArgoCD/Flux notifications (deployment events). Immutable infrastructure: replace, don't modify (no SSH, all changes via Git). Use case: SOC2, HIPAA, PCI-DSS, regulatory requirements. Best practice: require PR reviews, signed commits, enforce policies, alert on drift.

### 655. Progressive Delivery Patterns

Advanced deployment strategies. Canary: gradual rollout (5% → 100%), metric-based promotion. Blue-green: instant switch, quick rollback. Mirroring (shadowing): copy traffic to new version (no user impact), validate, switch. A/B testing: route based on user (headers, cookies), measure business metrics. Feature flags: deploy code (flag off), enable gradually. Ring deployments: deploy to rings (internal → early adopters → everyone). Use case: reduce risk, validate changes, fast rollback. Tools: Flagger, Argo Rollouts, Istio/Linkerd (traffic shaping). Best practice: combine strategies (canary + feature flags).

### 656. GitOps Disaster Recovery

Recover cluster from Git. Scenario: cluster lost (region failure, accidental deletion), recreate from Git. Prerequisites: Git has all manifests (apps, infra, configs), external state (databases backed up elsewhere). Steps: create new cluster, bootstrap GitOps (ArgoCD/Flux), sync from Git, restore external state. Testing: DR drills, recreate in test cluster. RTO: time to recreate cluster (minutes to hours), RPO: latest Git commit. Backups: etcd snapshots (cluster state), Velero (backup PVs), Git (manifests). Use case: business continuity, compliance. Best practice: automate bootstrap (script), test regularly, document runbook.

### 657. GitOps Scalability

Handle large-scale deployments. Challenges: many apps (hundreds), many clusters (multi-region), large Git repos (slow clones). Solutions: sharding (ArgoCD application controller per shard), repo caching (ArgoCD repo server, Flux Source Controller), monorepo optimization (Git sparse checkout, shallow clones), distributed repos (repo per team). Flux: scale Source/Kustomize controllers (more replicas). ArgoCD: shard by app label, dedicate controller per shard. Use case: large orgs, microservices (100+ apps), multi-cluster (10+ clusters). Best practice: measure (reconciliation lag, Git clone time), scale horizontally (more controllers), optimize Git (smaller repos).

### 658. GitOps Best Practices Summary

Production guidelines. Git structure: folder per env or branch per env, monorepo vs multi-repo (choose based on scale). Secrets: Sealed Secrets, SOPS, External Secrets (never plaintext). Multi-env: Kustomize overlays or Helm values, promote dev → stage → prod. RBAC: control Git access (PR reviews), ArgoCD/Flux projects/RBAC. Drift detection: alert on manual changes, auto-heal or manual review. Dependencies: sync waves, dependsOn, health checks. Notifications: Slack alerts (failures, deployments). Disaster recovery: test cluster recreation from Git. Monitoring: GitOps controller metrics, app health. Auditability: signed commits, PR approvals. Progressive delivery: Flagger or Argo Rollouts for critical apps.

### Category 39: Release Strategies & Deployment (20 concepts)

### 659. A/B Testing

Compare two versions. Strategy: route traffic based on criteria (user segment, headers, cookies), measure business metrics (conversion, engagement, revenue), choose winner. Implementation: service mesh (Istio, Linkerd), API gateway, feature flags. Traffic split: 50/50 or weighted. Duration: days to weeks (statistical significance). Example: new UI design (A vs B), measure click-through rate. Difference from canary: A/B tests hypothesis, canary validates stability. Tools: Optimizely, LaunchDarkly, Split.io. Use case: product features, UI changes, pricing experiments.

### 660. Shadow Deployments

Mirror traffic to new version. Strategy: copy production traffic to shadow (no user impact), validate behavior (errors, latency, correctness), promote when confident. Implementation: service mesh (Istio traffic mirroring), proxy (Envoy), load balancer. Shadow receives traffic but responses discarded. Use case: high-risk changes, validate at scale, no user impact. Example: rewrite from Python to Go, shadow to verify correctness. Tools: Istio (VirtualService mirroring), Envoy (request shadowing). Best practice: monitor shadow errors, don't shadow sensitive operations (payments).

### 661. Rolling Updates

Gradual replacement. Strategy: update Pods one at a time (or in batches), wait for health checks, continue. Kubernetes: Deployment rolling update (maxUnavailable, maxSurge). Zero downtime: old Pods serve traffic while new Pods start. Rollback: `kubectl rollout undo`. Example: maxUnavailable=1, maxSurge=1 → maintain capacity, update gradually. Speed: adjust update speed (maxSurge higher = faster). Use case: default strategy, simple, works for most apps. Limitations: both versions running simultaneously (database compatibility required).

### 662. Recreate Deployments

Stop old, start new. Strategy: delete all Pods, create new Pods. Downtime: between old termination and new ready. Use case: can't run multiple versions (database migrations break compatibility), dev environments (downtime acceptable). Kubernetes: strategy: Recreate. Fast: no gradual rollout. Simple: no complexity. Example: major DB schema change (incompatible versions). Best practice: avoid in production, use maintenance window.

### 663. Ring Deployments

Progressive rollout to user groups. Rings: internal (employees), early adopters (beta users), general availability (all users). Strategy: deploy to ring 1, monitor, promote to ring 2, etc. Duration: hours to weeks per ring. Rollback: at ring boundary. Use case: large user base, staged rollout, risk mitigation. Implementation: feature flags (enable per ring), separate clusters/namespaces, DNS/routing. Example: Ring 0 (dev team), Ring 1 (10% users), Ring 2 (50%), Ring 3 (100%). Windows Update: classic example (insiders → general).

### 664. Dark Launches

Deploy disabled features. Strategy: deploy code with feature disabled (flag off), enable for testing (internal users, logs), gradually enable. Benefits: decouple deployment from release, test in production (no user impact), safe rollback (flip flag). Use case: high-risk features, gather metrics before GA, incremental enablement. Implementation: feature flags (LaunchDarkly, Split.io, custom). Example: deploy payment system v2 (flag off), enable for 1% (monitor), ramp to 100%. Best practice: separate deployment (code) from release (feature).

### 665. Deployment Pipelines

Automate path to production. Stages: build → test → deploy dev → deploy stage → deploy prod. Gates: manual approval (prod), automated tests (smoke tests, integration), policy checks (security scans). Artifacts: immutable (same binary/image across envs). Promotion: same artifact, different configs. Example: commit → CI builds image → deploy to dev (auto) → stage (auto) → prod (manual approval). Tools: Jenkins, GitLab CI, GitHub Actions, Spinnaker, ArgoCD. Best practice: fast feedback (fail early), idempotent (safe to retry), observable (logs, metrics).

### 666. Deployment Validation

Verify successful deployment. Smoke tests: basic functionality checks (HTTP 200, DB connection), fast (< 1 min). Integration tests: validate interactions (API tests, end-to-end), slower (5-10 min). Synthetic monitoring: simulate user behavior (Selenium, Playwright), continuous. Metrics: error rate, latency, throughput (compare to baseline). Rollback triggers: error rate > threshold, tests fail, health checks fail. Example: deploy → smoke test (API responds) → integration test (user flow) → monitor metrics (5 min) → promote or rollback. Tools: pytest, k6, Grafana alerts. Best practice: automated validation, clear thresholds.

### 667. Deployment Frequency

DORA metric. Definition: how often deploy to production. Elite: multiple times per day. High: daily to weekly. Medium: monthly. Low: less than monthly. Enable: CI/CD, small changes, trunk-based development, feature flags, automated tests. Measure: count deployments (Git tags, ArgoCD sync events, CI/CD runs). Benefits: faster feedback, smaller blast radius, competitive advantage. Use case: assess DevOps maturity, set improvement goals. Best practice: increase frequency (not at expense of quality), monitor change failure rate.

### 668. Change Failure Rate

DORA metric. Definition: % of deployments causing failure (rollback, hotfix, degradation). Elite: 0-15%. High: 16-30%. Calculate: failures / total deployments. Reduce: automated tests (unit, integration, E2E), canary deployments (catch issues early), feature flags (instant rollback), observability (detect issues fast). Measure: incident tracking (PagerDuty, Jira), deployment logs. Use case: balance speed and stability, improve quality. Best practice: blameless postmortems (learn from failures), address root causes.

### 669. Lead Time for Changes

DORA metric. Definition: time from commit to production. Elite: < 1 hour. High: 1 day to 1 week. Measure: commit timestamp to deployment timestamp. Reduce: automate CI/CD, reduce batch size (small PRs), eliminate wait times (manual approvals), parallelize (tests, builds). Use case: measure agility, identify bottlenecks. Best practice: optimize pipeline (fast tests, caching), trunk-based development (no long-lived branches), GitOps (automated sync).

### 670. Time to Restore Service

DORA metric. Definition: time from incident start to resolution. Elite: < 1 hour. High: < 1 day. Reduce: automated rollback, canary (detect issues early), good observability (fast diagnosis), runbooks (documented procedures), on-call rotation (expert available). Measure: incident management tools (PagerDuty, Opsgenie). Use case: measure reliability, improve incident response. Best practice: practice incident response (game days), automate common fixes, blameless postmortems.

### 671. Continuous Deployment

Auto-deploy after tests. Strategy: commit → CI → tests pass → deploy to production (no human gate). Requirements: high test coverage, confidence in tests, automated rollback, feature flags (disable bad features). Benefits: fastest deployment (minutes), no manual bottleneck, forces quality (tests must be good). Use case: mature teams, SaaS products, high deployment frequency. Example: Netflix, Etsy, Amazon. Comparison: Continuous Delivery (can deploy anytime, manual trigger), Continuous Deployment (always deploy). Risk mitigation: canary, feature flags, rollback automation.

### 672. Deployment Strategies Comparison

Choose right strategy. Blue-Green: instant switch, double resources, easy rollback. Canary: gradual, metrics-driven, less resources. Rolling: default, simple, zero downtime. Recreate: downtime, incompatible versions. A/B: test hypothesis, business metrics. Shadow: no user impact, validate at scale. Use case: Blue-Green (risk-averse, quick rollback), Canary (metrics validation), Rolling (most apps), A/B (product experiments), Shadow (high-risk changes). Complexity: Recreate (simple), Rolling (moderate), Canary/Blue-Green (complex, needs mesh). Best practice: start with Rolling, add Canary for critical services.

### 673. Feature Toggle Lifecycle

Manage feature flags. States: permanent (kill switches, config), release (new feature, remove after GA), experiment (A/B test, remove after decision), ops (circuit breaker, keep). Lifecycle: create flag → deploy (flag off) → enable gradually (ring deployments) → 100% enabled → remove flag (clean up code). Debt: old flags (complexity, code paths), cleanup regularly. Example: flag for new payment system (release toggle), enable for beta users, ramp to 100%, remove flag in 3 months. Tools: LaunchDarkly (track flag age, alert on stale), Split.io. Best practice: expire flags, code review (remove flag branches after GA).

### 674. Trunk-Based Development

Merge to main frequently. Strategy: work on main branch (or short-lived branches < 1 day), commit multiple times per day, no long-running branches. Feature flags: merge incomplete features (flag off), enable when ready. Benefits: reduce merge conflicts, faster integration, continuous deployment friendly. Comparison: Git Flow (long branches, delayed integration, merge conflicts). Requirements: automated tests (catch regressions), feature flags (hide work in progress), CI (validate on every commit). Use case: high deployment frequency, continuous delivery. Best practice: small commits, pair programming, fast CI.

### 675. Hotfix Processes

Urgent production fixes. Strategy: branch from production tag, apply fix, test, deploy (skip stages), merge back to main. Speed: prioritize speed (skip some checks), but don't skip tests. Communication: notify team, update incident ticket. Example: production down (P0), create hotfix branch, fix bug, deploy directly to prod, post-fix retrospective. Rolling forward: prefer fix forward vs rollback (if fast enough). Post-deployment: merge hotfix to main (prevent regression), update monitoring (why didn't catch it?), postmortem. Best practice: automate hotfix pipeline (fast), have runbook, practice regularly.

### Category 40: Observability I: Metrics & Prometheus (18 concepts)

### 676. Observability Pillars

Three pillars: metrics, logs, traces. 

**Metrics:** numerical data over time (CPU, requests/sec, latency), aggregatable, good for dashboards/alerts. 

**Logs:** discrete events (errors, requests), detailed context, searchable, debug specific issues. 

**Traces:** request path through system (distributed tracing), shows latency per service, identify bottlenecks. 

**Combination:** metrics alert, logs investigate, traces understand flow. 

**Cardinality:** metrics = low (count, gauge), logs = high (unique events), traces = high (unique requests). 

**Storage:** metrics = time-series DB (Prometheus), logs = search index (Loki, Elasticsearch), traces = specialized (Jaeger, Tempo). 

**Correlation:** link metrics → logs → traces, e.g., alert fires → query logs → find trace ID → view trace. 

**OpenTelemetry:** unified standard for all three, instrument once, export to multiple backends.

---

### 677. Metrics Collection

Gather numerical data. 

**Push vs Pull:** push (app pushes to collector, StatsD, Graphite), pull (collector scrapes app, Prometheus). 

**Instrumentation:** client libraries (prometheus/client_golang, prom-client for Node), instrument code (counters, gauges, histograms). 

**Exporters:** convert non-Prometheus metrics, e.g., node_exporter (Linux metrics), postgres_exporter, blackbox_exporter (probing). 

**Service discovery:** Prometheus scrapes targets from Kubernetes API, Consul, file. 

**Scrape interval:** typically 15-60s, balance freshness vs cardinality. 

**High cardinality:** avoid (labels with many values, e.g., user ID), causes memory issues. 

**Aggregation:** pre-aggregate in app (reduce cardinality), recording rules (Prometheus). 

**Formats:** Prometheus exposition format (text), OpenMetrics (standard). 

**Example:** instrument HTTP handler, increment request counter, observe duration histogram.

---

### 678. Prometheus Architecture

Time-series database and monitoring. 

**Components:** Prometheus server (scrape, store, query), Alertmanager (alert routing), Pushgateway (for short-lived jobs, optional). 

**Storage:** local time-series DB, data kept for retention period (15d default), compaction. 

**Scraping:** HTTP pull from `/metrics` endpoint, job/instance labels added. 

**PromQL:** query language, powerful, real-time aggregation. 

**Federation:** Prometheus scrapes other Prometheus, hierarchical setup. 

**HA:** multiple Prometheus instances scrape same targets, dedup in Thanos/Cortex. 

**Remote storage:** write to remote (Thanos, Cortex, Mimir, Grafana Cloud), long-term retention. 

**Config:** `prometheus.yml`, scrape_configs (targets), alerting rules, recording rules. 

**Service discovery:** kubernetes_sd_configs (scrape pods/services), static_configs, file_sd_configs. 

**Relabeling:** modify labels before scrape, filter targets.

---

### 679. Prometheus Metrics Types

Four types. 

**Counter:** monotonic increasing, resets to 0 on restart, use: request count, error count, bytes sent. Functions: rate(), increase(). Example: `http_requests_total`. 

**Gauge:** value can go up/down, use: CPU usage, memory, queue length, temperature. Example: `memory_usage_bytes`. 

**Histogram:** samples observations (request duration), buckets (le labels), sum, count. Use: latency distribution, percentiles. Functions: histogram_quantile(). Example: `http_request_duration_seconds_bucket{le="0.1"}`. 

**Summary:** similar to histogram, pre-calculated quantiles on client, less flexible. Use: legacy, prefer histogram. 

**Choosing:** counter for totals, gauge for current values, histogram for distributions. 

**Cardinality:** histogram adds buckets (multiple series per metric), summary adds quantiles. 

**Example:** `http_requests_total` (counter), `process_resident_memory_bytes` (gauge), `http_request_duration_seconds` (histogram).

---

### 680. PromQL Basics

Query metrics. 

**Instant vector:** set of time series at single time, `up`, `http_requests_total`. 

**Range vector:** set of time series over time range, `http_requests_total[5m]`. 

**Scalar:** single numeric value. 

**Operators:** arithmetic (+, -, *, /), comparison (==, !=, >, <), logical (and, or, unless). 

**Functions:** rate(), increase(), sum(), avg(), max(), min(), histogram_quantile(). 

**Aggregation:** `sum by (job) (http_requests_total)` (sum per job), `avg without (instance)` (avg, drop instance label). 

**Filters:** `http_requests_total{job="api", status="200"}` (label matching). 

**Rate:** `rate(http_requests_total[5m])` (per-second rate over 5min). 

**Quantile:** `histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))` (95th percentile latency). 

**Examples:** error rate: `rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m])`.

---

### 681. PromQL Advanced

Complex queries. 

**Subqueries:** `rate(http_requests_total[5m])[10m:1m]` (rate over 5m, evaluated every 1m for 10m window). 

**Predict:** `predict_linear(node_filesystem_avail_bytes[1h], 3600*4)` (predict value in 4 hours). 

**Joins:** multiply vectors with matching labels, `sum by (pod) (rate(container_cpu_usage_seconds_total[5m])) * on (pod) group_left kube_pod_labels`. 

**Vector matching:** one-to-one (default), many-to-one (`group_left`), one-to-many (`group_right`). 

**Absent:** `absent(up{job="api"})` (1 if no series, 0 if exists), use for alerting (target down). 

**Changes:** `changes(up[10m])` (how many times value changed). 

**Deriv:** `deriv(http_requests_total[5m])` (per-second derivative, for gauges). 

**Resets:** `resets(counter[1h])` (number of counter resets, detect restarts). 

**Recording rules:** pre-compute expensive queries, `rate(http_requests_total[5m])` → `http:requests:rate5m`. 

**Examples:** memory usage %: `(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes * 100`.

---

### 682. Metric Labels

Key-value metadata. 

**Purpose:** dimensions, filter/group metrics, `http_requests_total{method="GET", status="200", handler="/api/users"}`. 

**Label matching:** `{job="api"}`, `{job=~"api|web"}` (regex), `{job!="batch"}` (not equal). 

**Cardinality:** labels create new time series, high cardinality (many unique values) = memory issues, limit label values. 

**Best practices:** use static labels (job, instance, env), avoid dynamic (user ID, IP, trace ID), use exemplars for linking. 

**Relabeling:** modify labels, Prometheus config, `relabel_configs` (before scrape), `metric_relabel_configs` (after scrape), drop, keep, replace. 

**Example relabel:** drop high-cardinality label: `action: labeldrop, regex: user_id`. 

**Aggregation:** `sum by (status) (http_requests_total)` (sum per status, drop other labels). 

**Label limits:** Prometheus default 1000 unique label values per metric name (configurable).

---

### 683. Grafana Dashboards

Visualize metrics. 

**Datasources:** Prometheus, Loki, Tempo, Elasticsearch, InfluxDB, CloudWatch, etc. 

**Panels:** graph (time series), gauge, stat (single value), table, heatmap, logs. 

**Variables:** dropdown to filter, `$namespace`, query from datasource. 

**Templating:** reuse dashboards, `node_cpu_seconds_total{instance=~"$instance"}`. 

**Time range:** picker, relative (last 1h), absolute. 

**Annotations:** mark events on graph (deployments, alerts). 

**Alerts:** define in Grafana (or Prometheus), notify via Slack, PagerDuty. 

**Dashboards as code:** export JSON, commit to Git, provision via ConfigMap. 

**Folders:** organize dashboards, permissions per folder. 

**Example dashboard:** API latency (p50, p95, p99), request rate, error rate, per endpoint. 

**Grafana Loki:** logs panel, query logs with LogQL, view alongside metrics. 

**Grafana Tempo:** traces panel, visualize distributed traces.

---

### 684. Alertmanager

Alert routing and notification. 

**Alerts:** Prometheus evaluates rules, sends to Alertmanager if firing. 

**Routing:** route alerts based on labels, `route: { receiver: team-a, matchers: [team="a"] }`. 

**Receivers:** notification destinations (email, Slack, PagerDuty, webhook, OpsGenie). 

**Grouping:** combine related alerts, `group_by: [alertname, cluster]`, reduce noise. 

**Inhibition:** suppress alerts if higher-priority alert fires, e.g., suppress node alerts if cluster down. 

**Silences:** temporarily mute alerts, for maintenance, via UI or API. 

**Repeat interval:** how often to resend if still firing. 

**Config:** `alertmanager.yml`, routes, receivers, inhibit rules. 

**HA:** multiple Alertmanager instances, gossip to dedup (same alert not sent multiple times). 

**Example:** route critical to PagerDuty, warning to Slack, group by service, wait 5min before sending.

---

### 685. Alert Design

Effective alerting. 

**Principles:** alert on symptoms (latency high, errors) not causes (disk full), actionable (clear fix), low false positives. 

**SLO-based:** alert when error budget at risk, not arbitrary thresholds. 

**Severity:** critical (page on-call), warning (ticket/email), info (log). 

**Runbooks:** alert includes link to runbook (how to fix), document common causes. 

**Alert fatigue:** too many alerts → ignored, reduce noise (tune thresholds, group, inhibit). 

**For clause:** wait before firing, avoid flapping, `for: 5m` (alert must be true for 5min). 

**Example rule:** 
```yaml
- alert: HighErrorRate
  expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.05
  for: 5m
  labels: { severity: critical }
  annotations:
    summary: High error rate on {{ $labels.service }}
    runbook_url: https://wiki/runbooks/high-error-rate
```

**Test alerts:** inject failures, verify alerts fire, tune. 

**On-call:** rotate, avoid burnout, respect response times.

---

### 686. Logging Architecture

Centralized logging. 

**Flow:** app → agent (Fluent Bit, Fluentd, Promtail) → aggregator/storage (Loki, Elasticsearch) → query (Grafana, Kibana). 

**App logging:** write to stdout/stderr (containers), structured JSON, include context (request ID, user ID, trace ID). 

**Agent:** runs as DaemonSet (K8s), sidecar, or host process, reads logs from `/var/log/pods`, parses, ships. 

**Aggregation:** parse, filter, enrich, route, buffer. 

**Storage:** Loki (lightweight, indexes only labels), Elasticsearch (full-text index, heavy), S3 (archive). 

**Retention:** old logs deleted or archived, balance cost vs compliance. 

**Query:** Grafana Explore (Loki), Kibana (Elasticsearch), LogQL/Lucene query. 

**Use cases:** debugging (search by request ID), security (audit logs), compliance. 

**Cost:** Elasticsearch expensive (index everything), Loki cheaper (index labels).

---

### 687. Structured Logging

JSON logs. 

**Format:** `{"timestamp":"2023-06-15T10:00:00Z","level":"error","message":"failed to connect","service":"api","request_id":"abc123","error":"connection refused"}`. 

**Benefits:** parseable (machine-readable), filter/search by fields, consistent schema. 

**vs Plain text:** text = `[ERROR] failed to connect: connection refused`, hard to parse. 

**Fields:** timestamp, level (debug, info, warn, error), message, service, environment, trace_id, span_id, user_id, request_id, duration, status, error. 

**Libraries:** logrus (Go), pino (Node), structlog (Python), zap (Go, fast). 

**Log levels:** debug (verbose, dev), info (normal), warn (potential issue), error (failure), fatal (crash). 

**Context:** include relevant fields, avoid high cardinality (not every unique value). 

**Log aggregation:** agents parse JSON, extract fields, index. 

**Example:** `log.WithFields(log.Fields{"request_id": reqID, "user_id": userID}).Info("request processed")`.

---

### 688. Loki Architecture

Logs like Prometheus. 

**Components:** Promtail (agent, scrapes logs), Loki (storage, query), Grafana (UI). 

**Index:** only labels (not content), streams identified by label set, chunks stored in object storage (S3, GCS). 

**Labels:** low cardinality, `{job="api", namespace="production", pod="api-123"}`, content not indexed (unlike Elasticsearch). 

**Query:** LogQL, filter by labels, then grep content, `{job="api"} |= "error"` (streams for job=api, lines containing "error"). 

**Storage:** chunks (compressed logs), index (label → chunk IDs), object storage (cheap, durable). 

**Scalability:** horizontally scalable (multiple ingesters, queriers), stateless (object storage backend). 

**Retention:** per-stream retention, delete old chunks. 

**Cost:** much cheaper than Elasticsearch (no full-text index). 

**Use:** Kubernetes logging (label by namespace/pod), filter by labels, search content. 

**Deployment:** single binary (all components), or microservices (distributed).

---

### 689. LogQL Queries

Query Loki logs. 

**Stream selector:** `{job="api", env="prod"}` (label matching). 

**Operators:** `|=` (contains), `!=` (not contains), `|~` (regex), `!~` (not regex). 

**Filters:** `{job="api"} |= "error" | json | status_code > 500` (parse JSON, filter field). 

**Parser:** `| json` (parse JSON), `| logfmt` (parse key=value), `| regexp` (extract fields). 

**Aggregation:** `rate({job="api"}[5m])` (log rate), `count_over_time({job="api"} |= "error" [5m])` (error count). 

**Unwrap:** `sum(rate({job="api"} | json | unwrap duration [5m]))` (sum durations). 

**Example:** error rate: `sum by (service) (rate({job="api"} |= "level=error" [5m]))`. 

**Comparison:** LogQL similar to PromQL (same aggregation functions), but for logs. 

**Visualization:** Grafana Logs panel, show log lines, table, time series (if aggregated).

---

### 690. Log Aggregation

Collect and process logs. 

**Fluent Bit:** lightweight, low memory, C, plugins, DaemonSet in K8s, forward to Loki/Elasticsearch/Kafka. 

**Fluentd:** Ruby, more plugins, heavier, aggregation layer, parse, filter, route. 

**Promtail:** Loki-specific, scrapes logs, labels, pushes to Loki. 

**Vector:** Rust, fast, observability pipelines, alternative to Fluent Bit. 

**Config:** inputs (files, systemd journal, Kubernetes logs), filters (parse, enrich, drop), outputs (Loki, Elasticsearch, S3). 

**Example Fluent Bit:** read `/var/log/pods`, parse JSON, add labels (namespace, pod), ship to Loki. 

**Enrichment:** add metadata (node, namespace, labels from Kubernetes API). 

**Multiline logs:** stack traces, combine into single event. 

**Buffer:** memory or disk buffer, prevent log loss on network issues. 

**Backpressure:** slow output, buffer full, drop or block (configurable).

---

### 691. Distributed Tracing

Track request across services. 

**Trace:** full request path, root span (entry point), child spans (each service/function). 

**Span:** single operation, start time, duration, tags (metadata), logs (events within span), parent span ID. 

**Context propagation:** pass trace context (trace ID, span ID) between services, via HTTP headers (X-B3-TraceId), gRPC metadata. 

**Sampling:** trace % of requests (all traces = too much data), head-based (decide at start), tail-based (decide after, keep interesting traces). 

**Use cases:** debug latency, identify bottlenecks, understand dependencies, error tracking. 

**Example:** user request → API gateway (100ms) → auth service (20ms) → DB (50ms) → cache (10ms), total 100ms, breakdown visible. 

**Waterfall diagram:** visualize spans over time. 

**Tools:** Jaeger, Zipkin, Tempo, AWS X-Ray, Google Cloud Trace.

---

### 692. OpenTelemetry

Unified observability standard. 

**Components:** API (instrument code), SDK (collect data), Collector (receive, process, export), exporters (backends). 

**Languages:** Go, Java, Python, JavaScript, .NET, many more. 

**Signals:** traces, metrics, logs (upcoming), all in one library. 

**Auto-instrumentation:** frameworks (HTTP, gRPC, database) auto-traced, manual for custom spans. 

**Context propagation:** automatic, W3C Trace Context standard, propagates trace/span IDs. 

**Exporters:** send to Jaeger, Tempo, Prometheus, Loki, vendors (DataDog, New Relic). 

**Example:** `tracer := otel.Tracer("myapp")`, `ctx, span := tracer.Start(ctx, "operation")`, `defer span.End()`, span recorded, exported. 

**Collector:** sidecar or agent, receives traces, batches, exports, offloads from app. 

**Benefits:** vendor-neutral, one instrumentation, multiple backends, community-driven. 

**Migration:** from Jaeger/Zipkin clients, use OpenTelemetry, same backends.

---

### 693. Jaeger Architecture

Distributed tracing. 

**Components:** Client (instrument app, generate spans), Agent (sidecar, buffers spans), Collector (persists to storage), Query (UI, API), Storage (Cassandra, Elasticsearch, in-memory). 

**Flow:** app → agent (UDP or gRPC) → collector → storage → query/UI. 

**Sampling:** client decides, probabilistic (0.1% of traces), rate-limiting (100 traces/sec), remote (collector decides). 

**Storage:** Cassandra (scalable), Elasticsearch (search), Kafka (buffer), Badger (local dev). 

**UI:** visualize traces, search (by service, operation, tag), compare traces, dependencies graph (service mesh). 

**Integration:** Jaeger client or OpenTelemetry SDK → Jaeger backend. 

**Deployment:** Kubernetes, all-in-one (dev), production (collector, query, agent separate). 

**Retention:** old traces deleted (storage size). 

**Backends:** all-in-one collector for small setups, Cassandra for production scale.

---

### Category 41: Observability II: Logging & Tracing (18 concepts)

### 694. Trace Instrumentation

Add tracing to code. 

**Manual spans:** `span := tracer.StartSpan("fetch-user")`, `defer span.Finish()`, set tags: `span.SetTag("user.id", userID)`. 

**Auto-instrumentation:** middleware for HTTP, gRPC, SQL, Redis, auto-creates spans. 

**Example HTTP:** 
```go
import "github.com/opentracing-contrib/go-stdlib/nethttp"
handler := nethttp.Middleware(tracer, http.HandlerFunc(myHandler))
```
(every request traced). 

**Context propagation:** pass `context.Context` with span, child spans inherit trace ID. 

**Baggage:** key-value pairs propagated to all child spans, use sparingly (overhead). 

**Logs:** add events to span, `span.LogKV("event", "cache miss")`. 

**Errors:** mark span as error, `span.SetTag("error", true)`, `span.LogFields(log.Error(err))`. 

**Database queries:** instrument ORM/driver, see query duration, statement. 

**Best practices:** trace high-level operations (API calls, handlers), not every function (too noisy), meaningful span names, useful tags.

---

### 695. Golden Signals

Four key metrics. 

**Latency:** time to serve request, percentiles (p50, p95, p99), distinguish success vs error latency. 

**Traffic:** requests per second, throughput, load. 

**Errors:** rate of failed requests (4xx, 5xx), % of total. 

**Saturation:** how full the service is, CPU/memory usage, queue length, thread pool utilization, closest to limits. 

**Alerts:** latency p99 > threshold, error rate > threshold, saturation > 80%. 

**Dashboard:** four graphs, at-a-glance health, quick diagnosis. 

**Use cases:** general services (API, web), less for batch jobs (use different metrics). 

**Origin:** Google SRE book. 

**Example:** API service, latency p99 spiking → check saturation (CPU high) → scale up.

---

### 696. RED Method

Similar to Golden Signals, for request-based services. 

**Rate:** requests per second, `rate(http_requests_total[5m])`. 

**Errors:** errors per second, % of requests, `rate(http_requests_total{status=~"5.."}[5m])`. 

**Duration:** latency, histogram, percentiles, `histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m]))`. 

**Comparison to Golden Signals:** RED is subset (latency, traffic, errors), excludes saturation, simpler. 

**Use:** microservices, every service dashboard has RED metrics, quick health check. 

**Instrumentation:** Prometheus histogram for duration, counter for requests/errors. 

**Standardization:** consistent metrics naming (`http_requests_total`, `http_request_duration_seconds`).

---

### 697. USE Method

For resources (CPU, disk, network). 

**Utilization:** % of time resource busy, average over time, `avg(rate(node_cpu_seconds_total{mode!="idle"}[5m]))`. 

**Saturation:** work queued, beyond capacity, queue length, wait time, swap usage. 

**Errors:** error events, packet drops, disk errors, `rate(node_disk_io_time_seconds_total[5m])`. 

**Resources:** CPU, memory, disk, network, each resource has U, S, E. 

**Example CPU:** U = CPU usage %, S = run queue length, E = (usually none). 

**Example Network:** U = bandwidth usage, S = drops (buffer full), E = errors (CRC). 

**Use:** infrastructure monitoring, identify bottlenecks, capacity planning. 

**Origin:** Brendan Gregg. 

**Complementary:** RED for services, USE for resources.

---

### 698. SLIs (Service Level Indicators)

Metrics for SLOs. 

**Definition:** quantitative measure of service level, e.g., request latency, error rate, availability. 

**Choose:** user-centric, measurable, relevant to user experience. 

**Examples:** 
- Latency SLI: % of requests < 200ms
- Availability SLI: % of requests succeeded (not 5xx)
- Throughput SLI: requests served per second

**Measurement:** from metrics (Prometheus), logs, load balancer, synthetic checks. 

**Granularity:** per-minute, per-hour (for SLO calculations). 

**Multiple SLIs:** service may have several (latency, availability), each with SLO. 

**Good SLI:** simple, actionable, understood by stakeholders. 

**Bad SLI:** internal metric (CPU usage), not directly user-facing.

---

### 699. SLOs (Service Level Objectives)

Target for SLIs. 

**Definition:** target value for SLI, e.g., 99.9% availability, 95% of requests < 200ms. 

**Setting:** balance user expectations, cost, engineering effort, 100% = impossible/expensive. 

**Example:** "99.9% of requests will complete successfully in past 30 days", "99% of requests < 300ms in past 7 days". 

**Time window:** rolling (last 30 days), calendar (this month). 

**Error budget:** 100% - SLO, allowed failures, if 99.9% SLO → 0.1% error budget, out of 1M requests, 1000 can fail. 

**Consequences:** exceed error budget → slow down releases, focus on reliability, under budget → can take more risks. 

**Multiple SLOs:** per-service, per-customer tier (premium = stricter SLO). 

**Review:** regularly (quarterly), adjust based on incidents, user feedback. 

**Communication:** publish SLOs, dashboard, status page.

---

### 700. Error Budgets

Allowable failures. 

**Calculation:** (1 - SLO) * total, e.g., 99.9% SLO, 30 days, 43200 minutes → 43.2 minutes downtime allowed. 

**Tracking:** burn rate, how fast consuming budget, dashboard shows remaining %, trend. 

**Policy:** if budget exhausted → freeze deploys (only critical fixes), incident review, postmortem. 

**Benefits:** balance innovation vs reliability, align incentives (SRE and dev), data-driven decisions. 

**Fast burn:** major incident, consumes budget quickly, trigger incident response. 

**Slow burn:** small issues add up, fix gradually. 

**Alerts:** alert on fast burn (budget will be exhausted in X hours), multiwindow multiblevel alerting. 

**Example:** 30-day error budget 99.9%, current error rate → will exhaust in 7 days → alert: slow down releases. 

**Review:** postmortems analyze budget impact, learn, improve.

---

### 701. Alerting Best Practices

Reduce noise, increase signal. 

**Actionable:** every alert requires action, if not → remove or lower severity. 

**Low false positives:** tune thresholds, use `for` clause, avoid flapping. 

**Clear severity:** critical (page), warning (ticket), info (log). 

**Runbook:** every alert links to runbook (how to fix, triage steps). 

**Context:** alert message includes useful info (service, threshold, current value), `{{ $labels.service }} error rate {{ $value }}%`. 

**Escalation:** tiered on-call, L1 → L2 → L3 if not resolved. 

**Testing:** chaos engineering, inject failures, verify alerts fire, test runbooks. 

**Continuous improvement:** postmortem after incidents, identify missed alerts, false positives, update. 

**On-call:** reasonable load (not paged every night), compensate, rotate. 

**SLO-based:** alert on error budget burn, not arbitrary thresholds.

---

### 702. Performance Profiling

Identify bottlenecks. 

**CPU profiling:** sample stack traces, identify hot functions, tools: pprof (Go), perf (Linux), Py-Spy (Python). 

**Memory profiling:** heap allocations, identify leaks, pprof (heap), valgrind (C/C++). 

**Flame graphs:** visualize profiling data, x-axis = time, y-axis = stack depth, wide bar = CPU-intensive. 

**Go pprof:** `import _ "net/http/pprof"`, `http://localhost:6060/debug/pprof/`, `go tool pprof http://localhost:6060/debug/pprof/profile` (CPU 30s), `go tool pprof -http :8080 profile.pb.gz` (view). 

**Continuous profiling:** always-on, minimal overhead (1-5%), tools: Pyroscope, Parca, Google Cloud Profiler. 

**Optimizations:** guided by profiling, avoid premature optimization, benchmark changes. 

**Tracing:** broader (distributed), profiling = deeper (within service). 

**Use cases:** performance regression, optimize hot paths, reduce costs (CPU/memory).

---

### 703. Application Performance Monitoring (APM)

End-to-end monitoring. 

**Features:** distributed tracing, metrics, errors, profiling, real user monitoring (RUM), synthetic checks. 

**Tools:** Datadog APM, New Relic, Dynatrace, AppDynamics, Elastic APM, open-source (Jaeger + Prometheus + Grafana). 

**Auto-instrumentation:** agents inject bytecode (Java), monkey-patch (Python), minimal code changes. 

**Metrics:** RED metrics per service, dependencies, database query performance. 

**Errors:** stack traces, frequency, affected users, group similar errors. 

**RUM:** client-side metrics (page load, JS errors), user experience. 

**Synthetic:** scheduled checks (health, API), uptime monitoring. 

**Alerts:** based on APM metrics, anomaly detection (ML-based), context-rich (link to traces). 

**Use:** production apps, full visibility, diagnose issues quickly. 

**Cost:** commercial APM expensive (per-host or per-transaction), open-source cheaper but more effort.

---

### 704. Infrastructure Monitoring

Monitor servers, containers, nodes. 

**Metrics:** CPU, memory, disk, network, processes, uptime. 

**node_exporter:** Linux metrics for Prometheus, `/proc`, `/sys`, metrics: `node_cpu_seconds_total`, `node_memory_MemAvailable_bytes`, `node_disk_io_time_seconds_total`. 

**cAdvisor:** container metrics, memory/CPU per container, built into kubelet. 

**kube-state-metrics:** Kubernetes resource metrics, deployment status, pod phases, not resource usage. 

**Dashboards:** Grafana, per-node CPU/memory, per-namespace/pod resource usage, cluster capacity. 

**Alerts:** node down, disk full, memory high, node not ready. 

**Cloud:** CloudWatch (AWS), Stackdriver (GCP), Azure Monitor, agents collect metrics. 

**Logs:** systemd journal, syslog, ship to Loki/Elasticsearch. 

**Use:** detect hardware failures, capacity planning, performance issues.

---

### 705. Synthetic Monitoring

Proactive checks. 

**Purpose:** test from outside, user perspective, detect issues before users report. 

**Types:** uptime checks (ping, HTTP GET), API checks (POST, auth, response validation), E2E tests (Selenium, Playwright). 

**Blackbox exporter:** Prometheus exporter, probes endpoints (HTTP, TCP, ICMP, DNS), metrics: `probe_success`, `probe_duration_seconds`. 

**Tools:** Pingdom, UptimeRobot, StatusCake, blackbox_exporter + Prometheus, Checkly. 

**Frequency:** every 1-5 minutes, balance coverage vs cost. 

**Locations:** multiple (regions, providers), detect regional issues, check from where users are. 

**Validation:** response code (200), content (contains text), headers, latency < threshold, certificate validity. 

**Alerts:** probe fails → page, includes location, error. 

**Use:** critical paths (login, checkout), public APIs, SSL cert expiration. 

**vs Real User Monitoring:** synthetic = scripted, RUM = actual users, both useful.

---

---

### 706. Log Parsing and Analysis

Extract insights from logs. Parsing: structure unstructured logs (regex, grok patterns), extract fields (timestamp, level, message, trace ID). Analysis: aggregate (count by error type), search (find related logs), correlation (trace ID links logs). Tools: Loki (LogQL), Elasticsearch (KQL), Splunk (SPL). Example: parse nginx logs → extract status code, latency → dashboard (requests by status). Use case: troubleshooting (find errors), dashboards (request rate), alerts (error spike). Best practice: structured logging (JSON), consistent format, include trace IDs.

### 707. Log Retention and Archival

Manage log lifecycle. Hot storage: recent logs (7-30 days), fast queries, expensive (SSD, Elasticsearch). Warm storage: older logs (30-90 days), slower, cheaper (HDD). Cold storage: archive (90+ days to years), rare access, cheapest (S3, Glacier). Tiering: automatic (Loki, Elasticsearch ILM), move old logs to cheaper storage. Compliance: retention requirements (GDPR, HIPAA), delete after period. Cost: logs expensive (volume, storage, queries), optimize (sampling, filtering). Example: keep 30 days in Loki (queries), archive 1 year to S3 (compliance). Best practice: define retention policy, automate archival, query cold storage (Athena, S3 Select).

### 708. Trace Sampling

Reduce trace volume. Problem: 100% traces expensive (storage, processing). Sampling: record subset of traces. Head-based: decide at request start (sample 1%), simple but misses errors. Tail-based: decide after request completes (sample all errors + 1% success), requires buffering. Adaptive: adjust rate dynamically (higher on errors). Example: sample 10% of requests, 100% of errors. Tools: OpenTelemetry Collector (sampler), Jaeger (adaptive sampling). Use case: high traffic (millions of requests), cost control. Best practice: always trace errors, increase rate for slow requests.

### 709. Correlation IDs

Link related events. Trace ID: unique per request, propagated across services (HTTP header X-Trace-Id, B3 propagation). Logs: include trace ID (structured field), search logs for trace. Traces: spans share trace ID. Metrics: exemplars (link metric to trace). Example: request comes in (trace ID 123) → service A logs (trace_id: 123) → calls service B (propagate header) → service B logs (trace_id: 123). Use case: troubleshoot request (see all logs + spans), correlate metrics and logs. Best practice: generate at edge (API gateway, ingress), propagate everywhere, structured logging (trace_id field).

### 710. Observability in Microservices

Challenges at scale. Distributed: request spans multiple services, traces essential. Volume: many services, logs/metrics/traces explode. Cardinality: unique label combinations (service, pod, endpoint), expensive queries. Solutions: traces (follow request), correlation IDs (link logs), service mesh (automatic metrics), sampling (reduce volume), aggregation (summary metrics). Example: 50 services, 1000 pods, 1M requests/min → traces show bottlenecks, logs debug failures, metrics alert. Best practice: standardize (OpenTelemetry), centralized (single Prometheus, Loki, Jaeger), auto-instrumentation (service mesh, agents).

### 711. Cost of Observability

Balance visibility and expense. Costs: storage (metrics, logs, traces), ingestion (bandwidth, processing), queries (compute). Metrics: cardinality explosion (high-cardinality labels like user_id), use recording rules (pre-aggregate). Logs: volume (filter at source, drop verbose logs), compression, tiered storage. Traces: sampling (1-10%, not 100%), tail-based (errors + sample). Tools: Grafana Cloud, Datadog (expensive), self-hosted (cheaper, more ops). ROI: observability pays off (faster incident resolution, prevent outages). Use case: optimize without losing visibility. Best practice: monitor observability costs (dashboards), set budgets, optimize high-cost queries.

### Category 42: Observability III: Advanced Patterns (14 concepts)

### 712. SLI Implementation

Define and measure indicators. Choose: critical user journeys (login, search, checkout), define success (latency < 200ms, availability > 99.9%). Measure: from service perspective (API latency, error rate), not synthetic only. Instrumentation: add metrics (histogram for latency, counter for errors), labels (endpoint, method). Query: PromQL (calculate SLI), dashboard (current SLI value). Example: SLI = successful requests / total requests, query: `sum(rate(http_requests_total{status!~'5..'}[5m])) / sum(rate(http_requests_total[5m]))`. Best practice: few SLIs (3-5 per service), user-centric, measurable.

### 713. SLO Setting and Tracking

Define objectives. Set target: SLI >= threshold (e.g., 99.9% availability), time window (30 days). Error budget: 100% - SLO = allowed failures (99.9% SLO → 0.1% budget → 43 min downtime/month). Track: dashboard (SLO compliance, remaining budget), alert (budget exhausted). Consequences: budget exhausted → freeze releases (focus on reliability). Review: quarterly (adjust SLO based on user needs, cost). Example: API latency SLO (p99 < 200ms, 99% of time), track with Grafana, alert if p99 > 200ms for 10 min. Best practice: achievable SLO (not 100%), balance reliability and velocity, involve product team.

### 714. Error Budget Policies

Enforce reliability. Policy: if error budget > 0 → deploy freely, if exhausted → halt deployments (until budget replenishes), focus on reliability (fix bugs, improve tests). Calculate: (1 - SLO) * total requests = allowed errors. Example: 99.9% SLO, 1M requests/month → 1,000 errors allowed. Tracking: dashboard (budget remaining %), burn rate (how fast consuming budget). Enforcement: gate deployments (CI/CD checks budget), manual override (urgent fixes). Benefits: balance velocity and reliability, objective criteria (no subjective 'too many bugs'). Use case: high-traffic services, manage risk. Best practice: monthly budget, involve product in SLO setting.

### 715. Burn Rate Alerting

Detect fast SLO consumption. Burn rate: how quickly consuming error budget. Example: 10x burn rate → will exhaust budget in 1/10 of window (3 days instead of 30). Alert: high burn rate (> 10x for 1 hour → page), medium burn rate (> 5x for 6 hours → ticket). Multi-window: short window (fast burn, immediate), long window (slow burn, trending). Example: `(1 - SLI) / (1 - SLO) > 10` (10x burn). Benefits: early warning (before SLO breach), prioritize incidents (high burn = urgent). Best practice: multi-window alerts (1h, 6h), adjust thresholds (reduce noise). Tools: Prometheus alerts, Sloth (SLO generator).

### 716. Observability as Code

Version control observability. Infrastructure: dashboards (Grafana JSON, Jsonnet, Terraform), alerts (Prometheus rules YAML, Terraform), SLOs (Sloth spec). Benefits: version control (Git), code review (PR), rollback (git revert), consistency (apply to all services). Example: Grafana dashboards in Git → deploy via Terraform → team reviews changes. Tools: Terraform (Grafana provider), Jsonnet (templatize), Grizzly (manage Grafana). Best practice: automate dashboard creation (generator from service annotations), standard templates, CI/CD (validate before apply).

### 717. Continuous Profiling

Always-on profiling. Collect: CPU profiles (flamegraphs), memory (heap), goroutines, mutex. Continuous: profile in production (low overhead <5%), store profiles (Pyroscope, Parca, Polar Signals). Use case: identify regressions (compare profiles), optimize hotspots (CPU-intensive functions), debug memory leaks. Example: deploy new version → CPU usage increases → compare profiles → identify inefficient function. Tools: Pyroscope (open source, pull/push), pprof (Go), perf (Linux), eBPF (low overhead). Best practice: enable in production, alert on anomalies (sudden CPU spike), flamegraphs (visualize).

### 718. Exemplars

Link metrics to traces. Exemplar: metric datapoint with trace ID. Example: histogram bucket for latency → includes trace ID → click metric → view trace. Benefits: metric shows issue (latency spike) → exemplar provides example trace → debug specific request. Prometheus: experimental support, Grafana displays. Instrumentation: add trace ID to metrics (OpenTelemetry auto-attaches). Use case: bridge metrics and traces, faster troubleshooting. Best practice: enable in critical metrics (latency, errors), use with tempo/Jaeger (trace backend).

### 719. Service Dependency Mapping

Visualize microservices. Automatic: from traces (spans show service calls), service mesh (Istio Kiali, Linkerd Viz). Manual: define in code (annotations), graph databases. Visualization: nodes (services), edges (calls), metrics (request rate, error rate, latency). Use case: understand architecture, identify bottlenecks (slow downstream service), blast radius (what depends on this service). Example: frontend → API gateway → user service → database. Tools: Jaeger (service graph), Kiali (Istio), Grafana Tempo (service graph). Best practice: automated generation, update on service changes.

### 720. Proactive Monitoring

Prevent issues before users report. Strategies: anomaly detection (ML models, Z-score), trend analysis (growing latency, disk filling), capacity monitoring (predict when full). Alerts: warn before critical (disk 80% → alert, not 95%). Forecasting: based on trends (predict traffic, scale preemptively). Example: disk usage growing 10% per week → alert 2 weeks before full. Tools: Prometheus (predict_linear), Grafana (ML plugin), commercial (Datadog anomaly detection). Use case: prevent outages, reduce MTTR. Best practice: tune thresholds (avoid false positives), combine with SLOs.

### 721. Observability for Batch Jobs

Monitor non-HTTP workloads. Challenges: no request/response, long-running (hours), scheduled (cron). Metrics: job duration (gauge), success/failure (counter), processed items (counter), last run time (gauge). Logs: structured (job ID, status), errors. Traces: may not apply (alternative: logs with correlation ID). Alerts: job failed, duration too long (SLO), missed run (expected schedule). Example: nightly ETL job (success counter, duration histogram), alert if > 4 hours or failed. Tools: Prometheus Pushgateway (push metrics), cron job exporter. Best practice: idempotent jobs (safe to retry), emit metrics at end, dead man's switch (alert if job didn't run).

### 722. Dead Man's Switch

Alert on missing activity. Concept: service expected to emit heartbeat (metric, log), alert if silent (job didn't run, service crashed). Implementation: Prometheus query (up == 0, or absent(metric)), alert if metric missing. Example: daily backup job → pushes metric backup_last_success_timestamp → alert if not updated in 25 hours (grace period). Use case: cron jobs, heartbeat monitoring, catch silent failures (job hangs, cron misconfigured). Tools: Prometheus (absent() function), Alertmanager (group by job). Best practice: set reasonable interval (don't alert immediately), test (intentionally skip job, verify alert).

### 723. Log-Based Metrics

Derive metrics from logs. Extract: parse logs → count occurrences → expose as metric. Example: parse error logs → count by type → metric `errors_total{type='db_connection'}`. Tools: Loki (LogQL, count_over_time), Elasticsearch (aggregations), mtail (tail logs, export metrics), promtail (Loki agent, extract metrics). Use case: when app doesn't expose metrics, legacy systems, custom log formats. Limitations: less efficient than native metrics, parsing overhead. Best practice: prefer native metrics, use log-based as fallback, aggregate at ingestion (don't query raw logs repeatedly).

### 724. Tracing in Asynchronous Systems

Trace across queues. Challenge: request → queue → worker (async, later), trace ID must propagate via message. Implementation: include trace ID in message payload (header or body), worker extracts and continues trace. Example: API publishes to Kafka (message includes trace ID) → consumer reads (creates span with parent trace ID). Tools: OpenTelemetry (context propagation), Kafka headers, RabbitMQ headers. Best practice: standardize propagation (OpenTelemetry), test (verify traces link), visualize (see full flow including async steps).

### 725. Observability Testing

Validate instrumentation. Unit tests: verify metrics emitted (mock exporter, assert counter incremented). Integration tests: call service, check traces (Jaeger API), verify logs (parse output). Chaos testing: inject failures (kill pods), verify alerts fire. Load testing: generate traffic (k6, Locust), verify metrics scale linearly, dashboards show expected values. Example: test endpoint → assert `http_requests_total` incremented, trace created (Jaeger query API). Use case: prevent instrumentation bugs (forgot to emit metric), validate alerts (test alert fires). Best practice: test critical metrics/traces, CI/CD (fail if metrics missing).

### Category 43: Distributed Systems Patterns (20 concepts)

### 726. Consensus Algorithms

Agreement in distributed systems. 

**Problem:** nodes agree on value (leader election, log replication), despite failures. 

**Raft:** leader-based, simpler than Paxos, used by etcd, Consul. 

**Phases:** Leader election (candidate requests votes, majority wins), Log replication (leader appends entries, followers replicate). 

**Quorum:** majority (N/2+1), ensures at most one leader, prevents split-brain. 

**Terms:** monotonic counter, each term has at most one leader. 

**Safety:** committed entries never lost, logs consistent. 

**Paxos:** older, complex, Multi-Paxos for multiple values. 

**Use cases:** etcd (K8s state), Raft for consensus, leader election, configuration management. 

**Limitations:** requires majority (N/2+1) available, slow if network latency high, not partition-tolerant (minority unavailable).

---

### 727. etcd Internals

Distributed key-value store. 

**Consensus:** Raft, ensures consistency, leader handles writes. 

**Storage:** BoltDB (embedded key-value DB), B+tree on disk. 

**MVCC:** multi-version concurrency control, keeps old versions (revisions), reads don't block writes. 

**Transactions:** mini-transactions (compare-and-swap), ACID within single key. 

**Watch:** clients watch keys/prefixes, get notified on changes, uses gRPC streams. 

**Lease:** time-based, keys with TTL, keep-alive extends lease, used for ephemeral keys (leader election). 

**Compaction:** delete old revisions (save space), configurable retention. 

**Snapshots:** periodic snapshots for faster recovery. 

**Linearizable reads:** read from leader (default), or quorum read (majority acknowledgment). 

**Distributed:** cluster of 3 or 5 nodes (odd number), quorum required. 

**Use in K8s:** stores all cluster state (pods, services, etc.), critical (etcd down = cluster down). 

**Operations:** backup (etcdctl snapshot save), restore, defrag.

---

### 728. Distributed Transactions

Coordinate multiple operations. 

**2PC (Two-Phase Commit):** coordinator asks participants "can you commit?" (Prepare), if all yes → commit, else abort, blocking (coordinator fails = participants wait). 

**Problems:** coordinator SPOF, blocking (locks held during prepare), not partition-tolerant. 

**3PC (Three-Phase Commit):** adds pre-commit phase, non-blocking, but complex. 

**Saga:** long-running transactions, compensating transactions (undo), eventual consistency, choreography (events) or orchestration (coordinator). 

**Example Saga:** order service creates order → payment service charges card (if fails, order service cancels order). 

**Event sourcing:** append-only log of events, replay to get state, no 2PC. 

**Avoid distributed transactions:** prefer eventual consistency, design for idempotency, use asynchronous messaging. 

**Use cases:** microservices, where 2PC impractical, financial systems (need correctness).

---

### 729. Event Sourcing

Events as source of truth. 

**Concept:** store all changes as events (append-only log), current state = replay all events. 

**Example:** bank account, events: AccountOpened, Deposited($100), Withdrawn($20), balance = replay events. 

**Benefits:** full audit trail, temporal queries (state at any point in time), replayable (rebuild projections), debugging (replay to reproduce). 

**Event store:** append-only, EventStoreDB, Kafka, custom. 

**Projections:** read models, derived from events, e.g., current balance (sum deposits - withdrawals). 

**Snapshots:** performance optimization, store state at point in time, replay from snapshot forward (not from beginning). 

**Challenges:** schema evolution (events immutable), event versioning, replay time (large log), projections out of sync. 

**CQRS:** Command Query Responsibility Segregation, often paired, separate write (commands) and read (queries) models. 

**Use cases:** audit-heavy (finance, compliance), collaborative editing, undo/redo.

---

### 730. Message Queues

Asynchronous communication. 

**Purpose:** decouple services, buffer (producer fast, consumer slow), persistence (messages not lost), retry. 

**Patterns:** Point-to-Point (queue, one consumer per message), Pub/Sub (topic, multiple consumers). 

**RabbitMQ:** AMQP, exchanges (fanout, direct, topic, headers), queues, bindings, ack/nack (message acknowledgment). 

**Ordering:** single consumer = ordered, multiple consumers = no order guarantee (unless partitioned). 

**Delivery guarantees:** at-most-once (fire and forget), at-least-once (retry, may duplicate), exactly-once (hard, requires idempotency or deduplication). 

**Dead Letter Queue (DLQ):** failed messages (max retries exceeded), manual inspection. 

**Backpressure:** consumer slow, queue fills, producer must slow down (block or drop). 

**Use cases:** background jobs (email, image processing), event-driven architecture, microservices communication. 

**Alternatives:** Kafka (high-throughput, log-based), AWS SQS/SNS, Google Pub/Sub, Redis Streams.

---

### 731. Apache Kafka

Distributed streaming platform. 

**Architecture:** topics (log), partitions (sharding), brokers (servers), producers, consumers, consumer groups. 

**Topics:** ordered log, append-only, immutable, partitioned for scale. 

**Partitions:** each partition ordered, replicated (leader + followers), ISR (in-sync replicas). 

**Producers:** write to topic, specify key (hash to partition), acks (0, 1, all). 

**Consumers:** read from topic, offset (position in log), consumer group (load balancing, each partition consumed by one consumer in group). 

**Retention:** time-based (default 7 days) or size-based, log compaction (keep latest per key). 

**Replication:** configurable (default 3), leader handles reads/writes, followers replicate. 

**Durability:** replicated, persisted to disk, acks=all waits for all ISR replicas. 

**Performance:** high throughput (millions/sec), low latency (ms), zero-copy, page cache. 

**Use cases:** event streaming, log aggregation, real-time analytics, CDC (change data capture). 

**Kafka Connect:** integrate with databases, systems, Kafka Streams (stream processing). 

**Zookeeper:** Kafka dependency (pre-3.0), stores metadata, KRaft (3.0+, Kafka-native, replaces Zookeeper).

---

### 732. Pub/Sub Pattern

One-to-many messaging. 

**Publisher:** sends messages to topic, doesn't know subscribers. 

**Subscribers:** subscribe to topic, receive all messages (or filtered). 

**Decoupling:** publisher/subscriber independent, can add/remove subscribers without code changes. 

**Filtering:** attribute-based (only messages matching filter), content-based. 

**Delivery:** push (message sent to subscriber) or pull (subscriber polls). 

**Examples:** RabbitMQ (exchange type: fanout, topic), Kafka (consumer groups for load balancing, all groups get messages), AWS SNS, Google Pub/Sub, Redis Pub/Sub. 

**Use cases:** notifications (one event, multiple handlers), fan-out (one write, many readers), event-driven microservices. 

**Ordering:** no global order across subscribers (unless single partition/subscriber). 

**Reliability:** durable topics (messages persisted), retries, DLQ.

---

### 733. Sharding Strategies

Partition data across nodes. 

**Shard key:** determines which shard, choose key with even distribution. 

**Hash-based:** hash(key) % N, uniform distribution, adding nodes requires rehash (move lots of data), consistent hashing reduces movement. 

**Range-based:** key ranges (A-M on shard1, N-Z on shard2), easy to add shards (split range), but hot spots (popular range overloaded). 

**Directory-based:** lookup table (key → shard), flexible, but lookup overhead and directory is SPOF. 

**Consistent hashing:** hash keys and nodes onto ring, key assigned to next node clockwise, adding node only affects neighbors (minimal data movement), used by DynamoDB, Cassandra. 

**Rebalancing:** adding/removing nodes, migrate data, avoid downtime. 

**Hot shards:** uneven load, repartition, choose better shard key, add more granular shards. 

**Use cases:** databases (MongoDB sharding, Cassandra), caches (Redis Cluster), distributed systems.

---

### 734. Database Replication

Copy data to multiple nodes. 

**Primary-Replica (Master-Slave):** one primary (writes), multiple replicas (reads), primary replicates to replicas. 

**Synchronous replication:** primary waits for replica acknowledgment, no data loss, but slower writes, reduced availability (replica down = writes blocked). 

**Asynchronous replication:** primary doesn't wait, faster writes, but replica lag (stale reads), potential data loss (primary fails before replica syncs). 

**Semi-synchronous:** wait for at least one replica, balance. 

**Replica lag:** time between primary write and replica sync, monitoring (seconds, minutes), read from primary if need latest. 

**Failover:** primary fails → promote replica to primary, manual or automatic, check replica is up-to-date. 

**Multi-primary:** multiple nodes accept writes, conflict resolution needed (last-write-wins, CRDTs), complex, used in multi-region. 

**Use cases:** scale reads (add replicas), HA (failover to replica), backups (replica for snapshot). 

**Tools:** PostgreSQL streaming replication, MySQL replication, MongoDB replica sets.

---

### 735. Quorum Consensus

Majority voting. 

**Quorum:** minimum votes needed for operation, typically N/2+1 (majority). 

**Read quorum (R):** read from R replicas, write quorum (W): write to W replicas, R + W > N ensures overlap (at least one replica has latest). 

**Example:** N=3, W=2, R=2, writes to 2 replicas, reads from 2, at least 1 has latest. 

**Tunable consistency:** W=N, R=1 (strong write consistency, fast reads), W=1, R=N (fast writes, strong read consistency), W=1, R=1 (eventual consistency, fast). 

**Quorum size:** larger quorum = stronger consistency, but lower availability (need more nodes). 

**Dynamo-style:** Amazon DynamoDB, Cassandra, tunable (set W/R per request). 

**Split-brain prevention:** quorum ensures at most one set of nodes can make progress. 

**Use cases:** distributed databases, leader election, configuration stores.

---

### 736. Split Brain

Multiple leaders after network partition. 

**Problem:** network partition divides cluster, each side elects leader, both accept writes, data diverges. 

**Example:** 2-node cluster, partition, each thinks other is down, both become primary. 

**Prevention:** quorum (require majority to elect leader, N/2+1, partition with minority can't elect), fencing (force stop old leader before starting new, STONITH - shoot the other node in the head). 

**Even number of nodes:** bad (2+2 partition, neither has majority), always use odd number (3, 5). 

**Witness node:** tiebreaker, doesn't store data, just votes. 

**Lease:** time-limited leadership, old leader lease expires, can't write. 

**Detection:** inconsistent data, duplicate IDs, conflict resolution (last-write-wins, CRDTs, manual). 

**Resolution:** stop one side, merge data (complex). 

**Best practice:** always use quorum, odd number of nodes, monitor network partitions.

---

### 737. Leader Election

Select coordinator. 

**Purpose:** one node coordinates (primary in DB, active in HA pair, master in distributed lock). 

**Algorithms:** Raft (consensus-based), Paxos, Bully algorithm, Ring algorithm. 

**Raft:** election timeout, candidate requests votes, majority wins, becomes leader. 

**Zookeeper:** ephemeral sequential nodes, lowest = leader, watchers notify on change. 

**etcd:** similar to ZooKeeper, campaigns for leadership, uses Raft. 

**Kubernetes:** leader election for controllers, coordination.k8s.io/v1/Lease resource, controller updates lease (heartbeat), holds lock, others watch. 

**Health checks:** leader periodically renews lease/heartbeat, fails → new election. 

**Split-brain:** quorum prevents, only one leader elected. 

**Use cases:** database primary, job scheduler (one node schedules jobs), distributed locks. 

**Libraries:** etcd client (Go), ZooKeeper client, Kubernetes client-go (leaderelection package).

---

### 738. Distributed Locking

Mutual exclusion across nodes. 

**Purpose:** ensure only one process accesses resource (e.g., cron job runs on one node). 

**Redlock (Redis):** acquire lock on majority of Redis instances (N=5, acquire on 3+), set TTL, if acquired → hold lock, if TTL expires → release. 

**Challenges:** clock skew (nodes' clocks differ), long GC pause (process thinks holds lock but expired), network delay. 

**Fencing tokens:** monotonically increasing token, lock includes token, resource checks token (reject if stale). 

**Alternatives:** etcd lease (acquire key with lease, renew periodically), ZooKeeper ephemeral nodes (disappear when session ends), database (row lock, SELECT ... FOR UPDATE). 

**Use cases:** distributed cron (one instance runs job), leader election, singleton services. 

**Safety:** use fencing tokens, don't rely solely on lock validity (defensive programming). 

**Martin Kleppmann:** critique of Redlock, recommends fencing tokens or consensus-based locks (etcd, ZooKeeper). 

**Best practice:** etcd or ZooKeeper for critical locks, Redis for less critical.

---

### 739. Clock Synchronization

Time in distributed systems. 

**Problem:** clocks drift, no global time, impossible to order events by timestamp alone. 

**NTP (Network Time Protocol):** synchronize clocks, ~milliseconds accuracy, hierarchical (stratum 0 = atomic clock, stratum 1 = NTP servers). 

**Drift:** clocks drift apart, NTP corrects periodically (slew or step). 

**Monotonic vs Wall clock:** wall clock (gettimeofday, affected by NTP adjustments, can go backward), monotonic (clock_gettime(CLOCK_MONOTONIC), only goes forward, used for measuring durations). 

**Logical clocks:** Lamport clocks (counter, happens-before relation), Vector clocks (array of counters, per-node). 

**Hybrid logical clocks:** combine physical time + logical counter, TrueTime (Google Spanner, GPS + atomic clocks, uncertainty interval). 

**Happens-before:** event A happened before B if A → B (causal relationship), partial order. 

**Use logical clocks for ordering,** physical clocks for timestamps. 

**Skew:** difference between clocks, NTP minimizes but not eliminates.

---

### 740. Strong Consistency

Linearizable, behaves like single copy. 

**Definition:** appears as if only one copy, all operations ordered, reads return latest write. 

**Linearizability:** strongest consistency, all operations have global real-time order. 

**Sequential consistency:** weaker, operations in program order per process, but no global real-time order. 

**Implementation:** consensus (Raft, Paxos), quorum with R+W>N, single-leader (all reads/writes to leader). 

**Cost:** higher latency (coordination), reduced availability (network partition → can't guarantee), not partition-tolerant (CP system). 

**Use cases:** financial transactions (can't have inconsistent balances), inventory management (overselling), booking systems. 

**Examples:** etcd, Consul, ZooKeeper (reads from leader), Google Spanner (TrueTime), CockroachDB. 

**Trade-off:** consistency + partition tolerance (or availability), sacrifice one of CAP.

---

### 741. Circuit Breaker Pattern

Fail fast, prevent cascading failures. 

**States:** Closed (normal, requests flow), Open (failure threshold exceeded, requests immediately fail), Half-Open (trial, limited requests to test recovery). 

**Thresholds:** failure rate (50% of requests fail), consecutive failures (5 in a row), time-based (10 failures in 1 minute). 

**Open state:** return error immediately, don't wait for timeout, protect downstream. 

**Half-Open:** after timeout (e.g., 30s), allow limited requests, if succeed → Closed, if fail → Open again. 

**Benefits:** prevent cascading failures (one service down doesn't bring down others), fast failure (user sees error quickly), give downstream time to recover. 

**Monitoring:** circuit breaker state, failure rate, alert if circuit open. 

**Libraries:** Hystrix (Netflix, archived), resilience4j (Java), gobreaker (Go), polly (.NET). 

**Use with:** timeouts, retries (limited), fallback (return cached data or default).

---

### 742. Bulkhead Pattern

Isolate failures. 

**Concept:** separate resource pools, like ship bulkheads (watertight compartments), if one fails, others unaffected. 

**Example:** separate thread pools per dependency (DB, cache, external API), DB pool has 10 threads, cache pool has 5, if DB slow, only DB pool exhausted, cache still works. 

**Kubernetes:** resource limits per pod, node pools (critical services on separate nodes), namespaces. 

**Connection pools:** separate pools per upstream, limit connections. 

**Benefits:** limit blast radius, prevent one failing component from exhausting all resources, maintain partial availability. 

**Trade-off:** more complexity, resource overhead (more pools). 

**Combine with:** circuit breaker, rate limiting, quotas. 

**Use cases:** microservices (isolate per service), multi-tenant (isolate per tenant), priority queues (high-priority separate from low).

---

### 743. Retry Strategies

Handle transient failures. 

**Exponential backoff:** wait increases exponentially (1s, 2s, 4s, 8s, ...), prevents thundering herd. 

**Jitter:** add randomness (0-1s), desynchronize retries, avoid all clients retrying at same time. 

**Max retries:** limit attempts (e.g., 5), then fail. 

**Idempotency:** safe to retry (same request produces same result), HTTP GET, PUT, DELETE idempotent, POST not (without idempotency key). 

**Timeout:** set timeout per retry, don't wait forever. 

**Retry conditions:** only retry transient errors (network timeout, 503, 429), don't retry permanent errors (400, 401, 404). 

**Circuit breaker:** stop retrying if circuit open (service down). 

**Libraries:** exponential backoff libraries (most languages), tenacity (Python), backoff (Go). 

**Example:** `wait = min(max_wait, base * 2^attempt + random(0, jitter))`. 

**Use cases:** API calls, message processing, database queries. 

**Avoid:** retry without backoff (hammering failing service), infinite retries (leak resources).

---

### Category 44: SRE Practices & Reliability (20 concepts)

### 744. Timeout Management

Prevent hanging. 

**Types:** Connection timeout (time to establish connection), Read/Write timeout (time to read/write data), Request timeout (total time for request). 

**Setting timeouts:** realistic (measure p99 latency in prod), shorter than caller's timeout (avoid cascading timeouts), allow retries within caller timeout. 

**Context propagation:** pass context.Context (Go), propagate timeout to downstream calls, deadline = original deadline - time elapsed. 

**Example:** API gateway timeout 30s, calls service A timeout 10s, service A calls service B timeout 3s. 

**Failure modes:** timeout too short (false failures), too long (slow to detect failures, resources held). 

**Monitoring:** track timeout rate, p99 latency, adjust timeouts. 

**Libraries:** context.WithTimeout (Go), requests timeout (Python), http.Client.Timeout (Go). 

**Load balancers:** health checks with timeout, remove unresponsive backends. 

**Databases:** query timeout, connection timeout, prevent long-running queries from blocking. 

**Best practice:** always set timeouts, never infinite, fail fast.

---

### 745. Graceful Degradation

Reduce functionality under load. 

**Purpose:** maintain core functionality, degrade non-critical features. 

**Strategies:** Shed load (rate limit, reject low-priority requests), Disable features (turn off recommendations, comments), Serve stale data (cached, slightly outdated), Reduce quality (lower resolution images, summary instead of full). 

**Example:** high load → disable personalized recommendations (CPU-intensive), serve static content. 

**Feature flags:** quickly disable features (kill switch), remotely toggle. 

**Priority levels:** critical (always on), high (degrade under severe load), low (first to disable). 

**Auto-scaling:** scale up if possible, degrade if scaling not fast enough. 

**Monitoring:** track load, error rate, decide when to degrade, alert. 

**User experience:** inform users (banner "Some features limited"), degrade gracefully (don't crash). 

**Recovery:** restore features when load decreases, gradually (not all at once). 

**Use cases:** Black Friday sales, DDoS attack, service dependencies down.

---

### 746. Health Checks Deep Dive

Liveness vs Readiness vs Startup. 

**Liveness:** is app alive? if not, restart, detect deadlocks, frozen processes. 

**Readiness:** can app serve traffic? if not, remove from load balancer, prevents traffic to initializing/unhealthy pods. 

**Startup:** separate probe for slow-starting apps, disables liveness until app ready. 

**Probe types:** HTTP (GET endpoint, 200-399 = healthy), TCP (connect to port), Exec (run command, exit 0 = healthy). 

**Shallow health check:** liveness, simple (app responding, ping endpoint), fast (< 1s). 

**Deep health check:** readiness, check dependencies (DB, cache, external API), slower (2-5s), if dependency down, return not ready. 

**Failure handling:** liveness failure → restart pod, readiness failure → remove from service, don't route traffic. 

**Best practices:** separate liveness and readiness, liveness shallow (only check app, not dependencies), readiness deep (check dependencies), startup probe for slow apps (Java, large apps). 

**Avoid:** liveness checks dependencies (DB down → restart loop, makes worse). 

**Graceful shutdown:** readiness false during shutdown, drain connections, then exit.

---

### 747. Capacity Planning

Forecast resource needs. 

**Metrics:** CPU, memory, disk, IOPS, network bandwidth, request rate, concurrent users. 

**Historical data:** collect months of data, identify trends (growth rate, seasonality), peaks (Black Friday, end of month). 

**Growth rate:** calculate (linear, exponential), project future (1 year, 2 years). 

**Load testing:** simulate peak load, find breaking point, identify bottlenecks. 

**Headroom:** buffer for spikes (20-30% extra capacity), don't run at 100%. 

**Scaling strategy:** vertical (larger instances), horizontal (more instances), auto-scaling (dynamic). 

**Cost vs performance:** balance, overprovisioning wastes money, underprovisioning impacts users. 

**Capacity models:** per-request cost (CPU, memory per request), multiply by request rate. 

**Reviews:** quarterly, adjust based on growth, incidents. 

**Example:** current 1000 req/s, growing 50%/year, peak 2x average → need 3000 req/s capacity in 1 year → provision for 4000 req/s (30% headroom).

---

### 748. Chaos Engineering

Proactively inject failures. 

**Purpose:** test resilience, find weaknesses before production issues, validate recovery procedures. 

**Principles:** define steady state (normal metrics), hypothesize (system handles failure), run experiment (inject failure), observe (metrics, logs), learn (improve). 

**Experiments:** Kill pods/nodes (Chaos Mesh killPod), Network latency/partition (netem, tc), Resource stress (CPU, memory, disk), Dependency failures (block external API). 

**Tools:** Chaos Mesh (K8s-native, CRDs), Litmus (CNCF, K8s), Gremlin (commercial), Chaos Monkey (Netflix, terminates instances). 

**Start small:** non-production, small blast radius, gradually increase scope. 

**Game days:** scheduled chaos experiments, team participates, practice incident response. 

**Continuous:** integrate into CI/CD, automated chaos, steady state. 

**Metrics:** observe error rate, latency, recovery time, user impact. 

**Safety:** abort mechanism, limit blast radius (single AZ, canary), monitor closely. 

**Examples:** Netflix terminates instances randomly, test auto-scaling and failover.

---

### 749. High Availability Architecture

Minimize downtime. 

**Redundancy:** no single point of failure, multiple instances, multiple AZs, multiple regions. 

**Load balancing:** distribute traffic, automatic failover if instance down. 

**Health checks:** detect failures, route away from unhealthy. 

**Auto-scaling:** replace failed instances, scale up under load. 

**Multi-AZ:** deploy across availability zones (separate data centers in region), survive AZ failure. 

**Multi-region:** deploy to multiple regions, survive region failure, active-passive or active-active. 

**Database:** replication (primary-replica), automatic failover (promote replica), backups. 

**Stateless:** prefer stateless services, state in external store (DB, cache), easy to replace instances. 

**Chaos engineering:** test failover, validate HA setup. 

**RTO/RPO:** Recovery Time Objective (max downtime), Recovery Point Objective (max data loss), design to meet targets. 

**Example:** 99.99% availability = 52 min downtime/year, need multi-AZ, auto-scaling, monitoring, fast incident response.

---

### 750. Disaster Recovery

Plan for catastrophic failure. 

**Scenarios:** region failure, data center fire, ransomware, accidental deletion, corruption. 

**Backup strategy:** regular backups (hourly, daily), offsite (different region), test restores (quarterly). 

**RTO:** Recovery Time Objective, max acceptable downtime (minutes, hours, days). 

**RPO:** Recovery Point Objective, max acceptable data loss (minutes, hours). 

**Strategies:** Backup/Restore (cheapest, slowest), Pilot Light (minimal running, scale up on disaster), Warm Standby (scaled-down replica, scale up fast), Multi-Region Active-Active (no downtime, expensive). 

**DR plan:** documented procedures, contact info, runbooks, assign roles, test regularly (annually). 

**Testing:** DR drills, simulate failure, measure RTO/RPO, identify gaps. 

**Automation:** scripts to restore, IaC to recreate infrastructure, minimize manual steps. 

**Data replication:** cross-region replication (S3, RDS), asynchronous (lag, but cost-effective). 

**Communication:** status page, stakeholder notifications, predefined templates. 

**Example:** database backup every 6 hours (RPO=6h), restore time 30 min (RTO=30m), store backups in separate region.

---

### 751. Caching Strategies

Reduce load, improve latency. 

**Cache-aside (lazy loading):** app checks cache, miss → fetch from DB → store in cache, simple, stale data possible. 

**Write-through:** write to cache + DB synchronously, cache always up-to-date, slower writes. 

**Write-behind (write-back):** write to cache, async write to DB, faster writes, risk of data loss (cache failure). 

**Refresh-ahead:** proactively refresh before expiration, reduce cache misses, complexity. 

**Eviction policies:** LRU (Least Recently Used), LFU (Least Frequently Used), FIFO, TTL (time-to-live), size limit. 

**Cache invalidation:** hardest problem, on update (delete cache entry), TTL (expire after time), publish-subscribe (notify on change). 

**Layers:** L1 (in-process, fast), L2 (Redis, shared), L3 (CDN), multiple layers. 

**Cache keys:** unique per resource, include version (cache busting). 

**Thundering herd:** cache expires, many requests hit DB, mitigate (lock on cache miss, refresh before expiration). 

**Use cases:** database query results, API responses, computed values, sessions. 

**Metrics:** hit rate (cache hits / total requests), target 80-90%, miss latency.

---

### 752. eBPF (Extended Berkeley Packet Filter)

Kernel programmability. 

**Purpose:** run sandboxed programs in Linux kernel, without kernel modules, safe and efficient. 

**Use cases:** Observability (tracing syscalls, network, functions), Networking (XDP for fast packet processing, load balancing, firewalls), Security (syscall filtering, runtime enforcement). 

**How it works:** write eBPF program (C), compile to bytecode, load into kernel (bpf() syscall), verifier checks safety (no crashes, bounded execution), JIT compiles to native code, attaches to events (syscall, kprobe, tracepoint, XDP). 

**bpftrace:** high-level tracing language, one-liners, `bpftrace -e 'tracepoint:syscalls:sys_enter_open { printf("%s %s
", comm, str(args->filename)); }'`. 

**BCC (BPF Compiler Collection):** toolkit, pre-built tools (execsnoop, tcptracer, biolatency). 

**Cilium:** eBPF-based networking for Kubernetes, fast data plane, L3/L4/L7 policies, no iptables. 

**Falco:** uses eBPF for runtime security, detects suspicious syscalls. 

**Performance:** near-native speed, minimal overhead (< 5%), in kernel (no context switches). 

**Safety:** verifier prevents crashes, bounded loops, no arbitrary memory access. 

**Future:** replacing iptables (eBPF-based firewalls faster), network optimization, observability without sidecars.

---

---

### 753. Site Reliability Engineering Principles

Google SRE practices. Core tenets: treat operations as software problem (automate toil), SLOs/SLIs/error budgets (balance reliability and velocity), blameless postmortems (learn from failures), reduce toil (< 50% manual work), gradual rollouts (canary, feature flags), monitoring/alerting (proactive). Culture: dev and ops collaborate, shared responsibility, incident response rotation. Metrics: availability (uptime), latency (response time), throughput (requests/sec), error rate. Use case: large-scale systems, high reliability requirements. Books: Google SRE books (free online). Best practice: start with SLOs, automate runbooks, measure toil.

### 754. Toil Reduction

Eliminate repetitive work. Toil: manual, repetitive, automatable, no lasting value, scales linearly with service growth. Examples: manual deployments, ticket-driven changes, password resets, log diving. Automation: scripts (Bash, Python), CI/CD pipelines, self-service platforms, runbooks (automated or documentation). Target: < 50% toil (SRE time), rest on engineering (new features, reliability improvements). Measure: track time on toil (tickets, manual work), set reduction goals. Example: automate certificate renewal (manual → cron + Let's Encrypt), saved 5 hours/month. Best practice: prioritize high-frequency toil, automate incrementally, involve team.

### 755. On-Call Practices

Incident response. Rotation: primary (first responder), secondary (escalation), weekly rotation (not too frequent). Handoff: document ongoing issues, transfer knowledge. Runbooks: step-by-step guides (diagnose, mitigate, escalate), keep updated. Escalation: clear escalation path (who to page, when). Balance: limit on-call load (sustainable, avoid burnout), compensate (time off, pay). Alerts: actionable (not noisy), clear severity (page for critical, ticket for warning). Tools: PagerDuty, Opsgenie, VictorOps. Best practice: blameless culture, postmortems after incidents, improve runbooks continuously, rotate fairly.

### 756. Incident Management

Respond to outages. Roles: incident commander (coordinates), communications lead (updates stakeholders), tech lead (fixes issue). Phases: detection (alert fires), triage (assess severity, assign commander), mitigation (restore service, workarounds), resolution (root cause fix), postmortem (learn, prevent). Severity: SEV1 (critical, page immediately), SEV2 (major, next business hours), SEV3 (minor, ticket). Communication: status page (external users), Slack (internal), regular updates (every 30 min). Example: API down (SEV1) → page on-call → incident commander takes over → mitigation (rollback) → postmortem (why deploy broke). Tools: incident.io, Jeli, Rootly. Best practice: clear roles, practice (game days), blameless postmortems.

### 757. Postmortem Process

Learn from failures. Trigger: all SEV1, select SEV2 (patterns), near-misses (almost failed). Structure: timeline (what happened when), root cause (5 whys, not blame), impact (downtime, users affected), action items (prevent recurrence). Blameless: no blame individuals, focus on systems/processes. Review: team reviews (within 48 hours), async (document first), action items tracked (Jira, GitHub issues). Share: publish (engineering blog, wiki), learn from others' postmortems. Example: deploy broke production → rollback took 30 min → action: automate rollback, improve tests. Best practice: timely (fresh memory), honest (psychological safety), track action items (ensure completion).

### 758. Runbook Automation

Codify operations. Runbook: documented procedure (diagnose disk full, restart service, failover database). Manual: step-by-step (check X, run command Y). Automated: script executes steps, triggered by alert or command. Example: disk full runbook → manual (SSH, df -h, delete old logs) → automated (script checks disk, cleans logs, restarts service if needed). Tools: Ansible (playbooks), Python scripts, Kubernetes Jobs (triggered by alerts). Benefits: faster mitigation (seconds vs minutes), consistent (no human error), 24/7 (no need for human). Best practice: start with frequent tasks, test runbooks (dry-run), version control (Git), alert-driven automation (Alertmanager triggers script).

### 759. SRE vs DevOps

Similar but different. SRE: Google's implementation of DevOps, prescriptive (SLOs, error budgets, toil reduction), role (dedicated SRE team or embedded). DevOps: cultural movement, principles (automation, collaboration, CI/CD), no specific practices. Overlap: both reduce silos, automate, shared responsibility, measure everything. Difference: SRE provides framework (how to do DevOps), DevOps is philosophy (what to achieve). Example: DevOps says 'automate deployments', SRE says 'use SLOs to balance velocity and reliability, automate to reduce toil < 50%'. Use case: SRE for large scale (Google, Netflix), DevOps for all sizes. Best practice: adopt SRE practices regardless of title.

### 760. Disaster Recovery Planning

Prepare for worst case. RTO (Recovery Time Objective): max acceptable downtime (4 hours). RPO (Recovery Point Objective): max acceptable data loss (1 hour). Strategies: backups (restore from backup, slow), warm standby (secondary region, quick failover), active-active (multi-region, instant failover). Testing: DR drills (quarterly, validate procedures), chaos engineering (inject failures). Documentation: runbooks (step-by-step recovery), contact list (escalation). Example: database backup (daily, RPO 24h, RTO 2h), DR plan (restore DB, redirect DNS, test). Best practice: automate recovery, test regularly, document clearly, measure RTO/RPO.

### 761. Game Days

Practice incident response. Concept: simulate production incidents, test procedures, train team. Scenarios: service down, database failover, DDoS attack, region failure. Participants: on-call team, SREs, devs. Execution: inject failure (kill pods, block network), team responds (diagnose, mitigate), debrief (what went well, improve). Benefits: build muscle memory, identify gaps (missing runbooks, unclear escalation), improve confidence. Frequency: quarterly or after major changes. Example: kill production database → team fails over to replica → measures MTTR (target < 5 min). Tools: Chaos Monkey (random failures), Gremlin (controlled chaos), manual injection. Best practice: realistic scenarios, blameless debrief, track improvements.

### Category 45: Security Basics: Auth & Encryption (18 concepts)

### 762. Defense in Depth

Layered security. 

**Principle:** multiple security layers, if one fails, others protect, no single point of failure. 

**Layers:** physical (data center), network (firewall, segmentation), host (OS hardening, patching), application (input validation, auth), data (encryption). 

**Example:** attacker bypasses firewall → still needs to exploit app → still needs to escalate privileges → still encrypted data. 

**Redundancy:** overlap controls, e.g., firewall + network policies + app auth. 

**Controls:** preventive (firewall), detective (IDS, logs), corrective (patch), deterrent (warnings). 

**Kubernetes:** network policies, pod security, RBAC, secrets encryption, admission control, multiple layers. 

**vs Single barrier:** single firewall = breach exposes everything, layered = slows attacker, buys time. 

**Cost:** more complexity, balance security vs usability/cost.

---

### 763. Principle of Least Privilege

Minimum necessary access. 

**Users:** only permissions needed for job, no admin unless required. 

**Services:** service account with minimal RBAC, not cluster-admin. 

**Processes:** run as non-root, drop capabilities. 

**Network:** firewall allows only needed ports/IPs. 

**Data:** read-only unless write needed. 

**Temporary:** grant permissions temporarily (JIT), revoke after. 

**Review:** regularly review permissions, remove unused. 

**Example:** app needs to read ConfigMap → give `get` on ConfigMap, not `*` on all resources. 

**Kubernetes RBAC:** Role with specific verbs/resources, RoleBinding to service account. 

**IAM:** cloud IAM roles, fine-grained policies. 

**Benefits:** limit blast radius, reduce attack surface, compliance.

---

### 764. Zero Trust Architecture

Never trust, always verify. 

**Principles:** (1) assume breach, (2) verify explicitly, (3) least privilege, (4) micro-segmentation. 

**Traditional:** perimeter security (firewall), inside = trusted, outside = untrusted. 

**Zero Trust:** no implicit trust, even inside network, every request authenticated/authorized. 

**Components:** identity (strong auth, MFA), device (posture check), network (micro-segmentation), application (auth per request). 

**Implementations:** BeyondCorp (Google), service mesh (mTLS), software-defined perimeter. 

**Kubernetes:** network policies (default deny), mTLS (service mesh), RBAC (auth every API call), no trust between pods. 

**Benefits:** better for cloud/remote work (no perimeter), limits lateral movement. 

**Challenges:** complexity, performance (auth overhead), user experience.

---

### 765. Authentication vs Authorization

Who vs what. 

**Authentication:** verify identity (who are you?), mechanisms: password, cert, token, biometric. 

**Authorization:** verify permissions (what can you do?), mechanisms: RBAC, ABAC, ACL. 

**Flow:** authenticate first → then authorize. 

**Example:** user logs in (auth) → check if user can delete pod (authz). 

**Kubernetes:** authentication (client cert, token, OIDC) → authorization (RBAC, webhook). 

**Separation:** different systems, e.g., LDAP (auth) + app (authz), or OAuth (auth) + custom (authz). 

**Delegation:** OAuth2 (auth + authz delegation), user grants app permission to access API.

---

### 766. OAuth 2.0 Flows

Authorization framework. 

**Actors:** Resource Owner (user), Client (app), Authorization Server (issues tokens), Resource Server (API). 

**Flows:** 
- **Authorization Code** (most secure, server-side apps): redirect to auth server → user logs in → code returned → client exchanges code for token → token used for API.
- **Implicit** (deprecated, client-side apps): token returned directly, no code exchange, less secure.
- **Client Credentials** (service-to-service): client ID/secret → token, no user.
- **Resource Owner Password** (legacy, not recommended): username/password → token.
- **Device Code** (devices without browser): poll auth server with code, user approves on phone.

**Tokens:** access token (short-lived, 1 hour), refresh token (long-lived, renew access token). 

**Scopes:** permissions, `read:user write:repo`. 

**PKCE (Proof Key for Code Exchange):** for mobile/SPA, prevents code interception. 

**Use:** delegate API access, SSO, no passwords in client app.

---

### 767. OpenID Connect (OIDC)

Identity layer on OAuth 2.0. 

**Purpose:** authentication (who user is), OAuth 2.0 = authorization only. 

**ID Token:** JWT with user claims (sub, name, email), signed by auth server. 

**Flow:** Authorization Code flow + ID token returned with access token. 

**Claims:** sub (subject, user ID), iss (issuer), aud (audience, client ID), exp/iat (expiration, issued at), email, name, picture. 

**Discovery:** `/.well-known/openid-configuration` (metadata endpoint, keys URL, supported flows). 

**UserInfo endpoint:** get additional user info with access token. 

**Use cases:** SSO, Kubernetes OIDC auth (kubectl uses ID token), apps delegate auth to identity provider (Google, Okta, Keycloak). 

**vs SAML:** OIDC modern (JSON/REST), SAML legacy (XML), OIDC simpler. 

**Providers:** Google, Microsoft, Okta, Auth0, Keycloak (self-hosted).

---

### 768. JWT (JSON Web Token)

Self-contained tokens. 

**Structure:** three parts (base64url-encoded, separated by `.`): header (algorithm, type), payload (claims), signature. 

**Example:** `eyJhbGc...header.eyJzdWI...payload.SflKxw...signature`. 

**Claims:** registered (sub, iss, aud, exp, iat), public (custom, defined in registry), private (custom, application-specific). 

**Signature:** ensures integrity, HMAC (shared secret), RS256/ES256 (public/private key). 

**Verification:** decode header (get algorithm), verify signature with key, check exp (not expired), check iss/aud (valid issuer/audience). 

**Storage client-side:** httpOnly cookie (XSS protection), or localStorage (vulnerable to XSS). 

**Stateless:** no server-side session, all info in token, scales well. 

**Revocation:** no built-in, workarounds (short expiration + refresh, blacklist, check with auth server). 

**vs Opaque tokens:** JWT = self-contained (no DB lookup), opaque = reference (DB lookup, revocable).

---

### 769. JWT Best Practices

Secure JWT usage. 

**Algorithm:** RS256 or ES256 (asymmetric, public key to verify), avoid HS256 for public APIs (shared secret risky). 

**Expiration:** short-lived (15 min access token), long-lived refresh token (7 days, revocable). 

**Signature verification:** always verify, check `alg` header (prevent "none" attack), use trusted library. 

**Storage:** httpOnly cookie (web apps, CSRF protection needed), never localStorage for sensitive tokens. 

**Claims validation:** check `exp` (not expired), `iss` (trusted issuer), `aud` (intended audience), `nbf` (not before). 

**Sensitive data:** don't put secrets in payload (base64 is not encryption, visible to anyone). 

**Key rotation:** rotate signing keys regularly, support multiple keys (validate with any). 

**HTTPS only:** always transmit over TLS. 

**Refresh tokens:** store securely, use to get new access token. 

**Revocation:** use short expiration, or maintain blacklist/check with issuer.

---

### 770. API Authentication Methods

Authenticate API requests. 

**API Keys:** simple, static token in header/query, `X-API-Key: abc123`, rotate regularly, per-client. 

**Bearer Tokens:** OAuth 2.0, `Authorization: Bearer <token>`, short-lived, standard. 

**Basic Auth:** `Authorization: Basic <base64(user:pass)>`, HTTPS required, legacy. 

**mTLS:** client certificate, mutual authentication, strong but complex. 

**HMAC:** sign request with shared secret, AWS Signature v4, prevents tampering. 

**OAuth 2.0:** client credentials flow for service-to-service. 

**JWT:** self-contained, stateless. 

**Choosing:** API keys (simple, internal), OAuth (delegation, third-party), mTLS (service mesh), HMAC (high security). 

**Security:** always HTTPS, don't log keys, rate limit, rotate. 

**Rate limiting:** per API key, prevent abuse.

---

### 771. Kubernetes RBAC

Role-Based Access Control. 

**Roles:** permissions (verbs on resources), Role (namespaced), ClusterRole (cluster-wide). 

**RoleBinding:** grant Role to subjects (users, groups, service accounts), RoleBinding (namespace), ClusterRoleBinding (cluster). 

**Verbs:** get, list, watch, create, update, patch, delete, deletecollection. 

**Resources:** pods, services, deployments, secrets, configmaps, nodes, etc. 

**API groups:** core (`""`), apps, batch, networking.k8s.io, etc. 

**SubResources:** pods/log, pods/exec, pods/portforward, separate permissions. 

**Example Role:** 
```yaml
kind: Role
metadata: { name: pod-reader, namespace: default }
rules:
  - apiGroups: [""]
    resources: [pods]
    verbs: [get, list]
```

**Binding:** 
```yaml
kind: RoleBinding
metadata: { name: read-pods, namespace: default }
subjects:
  - kind: ServiceAccount
    name: myapp
    namespace: default
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

**Aggregation:** ClusterRole with aggregationRule, combines roles with labels. 

**Default roles:** view, edit, admin, cluster-admin. 

**Check access:** `kubectl auth can-i get pods --as=system:serviceaccount:default:myapp`.

---

### 772. Kubernetes Service Accounts

Pod identity for API access. 

**Purpose:** authenticate pods to Kubernetes API, every pod has service account. 

**Default:** namespace has `default` service account, auto-assigned to pods if not specified. 

**Token:** JWT, auto-mounted at `/var/run/secrets/kubernetes.io/serviceaccount/token`, used in API requests. 

**Create:** `kubectl create serviceaccount myapp`, reference in pod: `spec.serviceAccountName: myapp`. 

**RBAC:** grant permissions to service account via RoleBinding. 

**Disable auto-mount:** `automountServiceAccountToken: false` (pod spec or SA spec). 

**Token projection:** volume with token (audience, expiration), `serviceAccountToken` volume projection. 

**Image pull secrets:** attach to service account, auto-added to pods. 

**Use cases:** pod needs to call Kubernetes API (list pods, create jobs), operators, CI/CD. 

**Security:** principle of least privilege, minimal RBAC, disable auto-mount if not needed. 

**View token:** `kubectl exec pod -- cat /var/run/secrets/kubernetes.io/serviceaccount/token`.

---

### 773. Pod Security Admission

Admission controller for pod security. 

**Enabled by default:** Kubernetes 1.25+, validates pod specs against security standards. 

**Namespace labels:** 
```yaml
pod-security.kubernetes.io/enforce: restricted
pod-security.kubernetes.io/enforce-version: latest
pod-security.kubernetes.io/audit: restricted
pod-security.kubernetes.io/warn: restricted
```

**Exemptions:** namespaces, users, runtime classes, exempt from checks. 

**Audit annotations:** violations logged in audit logs. 

**Warnings:** violations shown in kubectl output. 

**Configuration:** PodSecurityConfiguration resource, define defaults, exemptions. 

**vs PodSecurityPolicy (deprecated):** PSA is simpler, standard levels, namespace-scoped. 

**Best practice:** enforce Restricted, audit all violations, fix pods before enforcing. 

**Check pod:** `kubectl label --dry-run=server --overwrite ns default pod-security.kubernetes.io/enforce=restricted`, see if pods would be rejected.

---

### 774. Network Policies

Kubernetes firewall. 

**Purpose:** control traffic to/from pods, default = all traffic allowed. 

**Spec:** podSelector (which pods), policyTypes (Ingress, Egress), ingress/egress rules (from/to, ports). 

**Selectors:** podSelector (by labels), namespaceSelector (pods in namespace), ipBlock (CIDR). 

**Example deny-all:** 
```yaml
kind: NetworkPolicy
metadata: { name: deny-all }
spec:
  podSelector: {}
  policyTypes: [Ingress, Egress]
```
(no rules = deny all). 

**Allow specific:** 
```yaml
spec:
  podSelector: { matchLabels: { app: web } }
  ingress:
    - from:
        - podSelector: { matchLabels: { app: api } }
      ports:
        - protocol: TCP
          port: 80
```
(web pods allow ingress from api pods on port 80). 

**Egress:** restrict outbound, e.g., allow DNS only. 

**CNI requirement:** Calico, Cilium, Weave support, Flannel doesn't. 

**Best practice:** default deny, whitelist needed traffic. 

**Testing:** `kubectl exec` to test connectivity, `netcat`, `curl`.

---

### 775. Service Mesh Security

mTLS and policies. 

**mTLS:** automatic mutual TLS between services, encrypts traffic, authenticates both sides. 

**Certificates:** service mesh CA issues certs to each pod (sidecar proxy), short-lived (hours), auto-renewed. 

**SPIFFE:** Secure Production Identity Framework for Everyone, standard for identity, X.509 certs with SPIFFE ID. 

**Authorization policies:** define who can call what, Istio AuthorizationPolicy, rules based on source/destination. 

**Example:** 
```yaml
kind: AuthorizationPolicy
metadata: { name: allow-api }
spec:
  selector: { matchLabels: { app: db } }
  action: ALLOW
  rules:
    - from:
        - source: { principals: ["cluster.local/ns/default/sa/api"] }
```
(only api service account can access db). 

**Encryption:** mTLS encrypts all service-to-service traffic, transparent to app. 

**Observability:** service mesh logs mTLS failures, connection attempts. 

**Benefits:** zero-trust (no implicit trust), strong auth (certs), no code changes. 

**Tools:** Istio, Linkerd, Consul Connect.

---

### 776. Secrets Management

Secure sensitive data. 

**Problems with K8s Secrets:** base64 (not encrypted), visible in YAML, etcd stores plaintext (unless encryption at rest enabled). 

**External secrets:** Vault, AWS Secrets Manager, GCP Secret Manager, fetch at runtime. 

**External Secrets Operator:** sync external secrets to K8s Secrets, CRD ExternalSecret points to external store. 

**Sealed Secrets:** encrypt Secret, safe to commit to Git, controller decrypts in cluster. 

**SOPS:** encrypt YAML files, AWS KMS/GCP KMS keys, decrypt with key. 

**Vault:** dynamic secrets (generate on-demand, revoke), lease-based, high security. 

**Vault Agent:** sidecar injects secrets into pod, auto-renews. 

**Best practices:** use external secret manager, rotate secrets, audit access, encrypt secrets at rest. 

**K8s encryption at rest:** EncryptionConfiguration, encrypt secrets in etcd with KMS.

---

### 777. Secrets Encryption at Rest

Encrypt secrets in etcd. 

**Problem:** K8s stores secrets base64 in etcd (plaintext if etcd compromised). 

**Solution:** kube-apiserver encrypts secrets before writing to etcd. 

**EncryptionConfiguration:** defines providers (aescbc, aesgcm, secretbox, kms). 

**Local encryption:** aescbc (AES-CBC), key in config (rotate regularly). 

**KMS:** cloud provider KMS (AWS KMS, GCP KMS, Azure Key Vault), key stored in cloud, more secure. 

**Example config:** 
```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
  - resources: [secrets]
    providers:
      - kms:
          name: aws-kms
          endpoint: unix:///var/run/kmsplugin/socket.sock
      - identity: {}
```

**Enable:** `kube-apiserver --encryption-provider-config=/path/to/config.yaml`. 

**Re-encrypt existing:** `kubectl get secrets --all-namespaces -o json | kubectl replace -f -`. 

**Verify:** etcd data is encrypted (not plaintext). 

**Best practice:** always enable for production, use KMS for key management.

---

### Category 46: DevSecOps I: Supply Chain Security (15 concepts)

### 778. Software Supply Chain Risks

Threats to code pipeline. Risks: compromised dependencies (malicious packages, typosquatting), insecure CI/CD (inject malicious code), stolen credentials (access to repos, registries), unsigned artifacts (can't verify integrity), vulnerable base images (CVEs in OS). Examples: SolarWinds (build system compromised), ua-parser-js (malicious npm package), codecov (bash uploader backdoor). Impact: wide blast radius (all downstream users affected). Mitigation: verify dependencies, sign artifacts, secure CI/CD, SBOM (Software Bill of Materials), scan images. Use case: prevent supply chain attacks. Standards: SLSA (Supply-chain Levels for Software Artifacts).

### 779. Dependency Scanning

Check for vulnerable packages. Tools: npm audit, pip-audit, Snyk, Dependabot, Trivy. Process: scan dependencies (package.json, requirements.txt), identify CVEs (Common Vulnerabilities and Exposures), report severity (critical, high, medium, low). Automation: CI/CD stage (fail build on critical), scheduled scans (daily), PR checks (block merge on new vulnerabilities). Fix: update dependency (if fix available), patch (workaround), accept risk (if low severity, no fix). Example: lodash CVE-2021-23337 (high severity) → update to 4.17.21. Best practice: automate scanning, prioritize critical/high, keep dependencies updated, use lock files (package-lock.json).

### 780. Container Image Scanning

Detect vulnerabilities in images. Layers: base image (OS packages), application dependencies, app code. Tools: Trivy, Grype, Clair, Snyk, Anchore. Scan: local (before push), registry (continuous), admission (block deployment). Findings: CVE in OS package (apt upgrade), vulnerable lib (update), secrets in image (remove, use external). Example: alpine:3.15 has openssl CVE (high) → update to alpine:3.17. Policies: block critical (admission controller), alert on high, report medium/low. Best practice: minimal base images (distroless, scratch), scan in CI/CD, continuous scanning (new CVEs), update regularly.

### 781. SBOM (Software Bill of Materials)

Inventory of components. Format: SPDX, CycloneDX (JSON/XML). Contents: packages (name, version, license), dependencies (tree), vulnerabilities (optional). Generate: syft (container images), CycloneDX Maven/npm plugins, go mod graph. Use cases: vulnerability tracking (which apps use vulnerable package), license compliance (identify GPL), incident response (rapid identification). Example: image sbom → contains log4j 2.14 → vulnerable to Log4Shell → prioritize patching. Tools: syft (generate), Dependency-Track (analyze, track), Grype (scan SBOM for CVEs). Best practice: generate in CI/CD, store with artifacts, update on changes.

### 782. Artifact Signing

Verify integrity and authenticity. Concept: sign artifacts (image, binary, manifest) with private key, verify with public key. Tools: Cosign (container images), Sigstore (keyless signing), GPG (files). Workflow: build image → sign with Cosign → push image + signature → Kubernetes admission controller verifies signature (only allow signed images). Keyless signing: Sigstore uses OIDC (GitHub Actions generates ephemeral key, signs, logs to transparency log). Example: `cosign sign myimage:v1`, `cosign verify myimage:v1`. Use case: prevent tampering, supply chain security, compliance. Best practice: sign all production artifacts, verify in admission, use transparency log (audit).

### 783. Image Provenance

Prove artifact origin. Provenance: metadata (who built, when, where, from what source). in-toto: framework for supply chain security, define steps (build, test, sign), attestations (signed metadata per step). SLSA: levels (L1: documentation, L2: signed, L3: hardened build, L4: reviewed source). Example: GitHub Actions builds image → generates provenance (repo, commit SHA, workflow, timestamp) → signs with Sigstore → upload to registry. Verify: check provenance (built from official repo, not forked). Tools: in-toto, Tekton Chains (K8s pipelines), SLSA. Use case: detect malicious builds, audit trail. Best practice: generate provenance in CI/CD, verify in admission, transparency log.

### 784. Private Package Registries

Secure internal dependencies. Types: npm (Verdaccio, Artifactory), PyPI (Artifactory, Nexus), Docker (Harbor, Artifactory). Use cases: host private packages, proxy public registries (caching, scanning), enforce policies (block unapproved packages). Features: access control (RBAC, SSO), scanning (CVE detection), caching (faster builds), immutability (can't overwrite published). Example: Harbor (Docker registry) → scan images on push → block if critical CVE → cache Docker Hub (reduce rate limits). Best practice: proxy public registries (control, visibility), scan all artifacts, implement retention policies (delete old versions).

### 785. Dependency Pinning

Lock to specific versions. Pin: exact version (lodash@4.17.21, not ^4.17.0). Lock files: package-lock.json (npm), poetry.lock (Python), Gemfile.lock (Ruby), go.sum (Go). Why: reproducible builds (same dependencies), prevent supply chain attacks (malicious update), control updates (review changes). Trade-off: security vs stability (pinned = stable but miss security updates, unpinned = updates but risk breakage). Example: package.json (^4.17.0 allows 4.x updates), package-lock.json (4.17.21 pinned). Best practice: use lock files (commit to Git), automated updates (Dependabot PRs), review updates (test before merge).

### 786. Typosquatting Protection

Prevent malicious package confusion. Typosquatting: malicious package with similar name (expresss, react-native-core). Protection: allowlist (approve packages before use), namespace (scoped packages @myorg/package), private registry (block external by default), scanning (detect suspicious). Example: developer types 'expresss' (typo) → installs malicious package → steals env vars. Tools: Socket.dev (detect typosquatting, malicious behavior), Snyk (dependency confusion detection). Best practice: use scoped packages, review new dependencies (check downloads, maintainer), private registry with allowlist.

### 787. CI/CD Pipeline Security

Secure build systems. Risks: secrets in logs (leaked credentials), insecure runners (compromised build agent), code injection (malicious PR), permission creep (overly broad permissions). Hardening: ephemeral runners (fresh per build, no persistence), least privilege (minimal secrets, scoped tokens), PR checks (untrusted code in isolated env), secret scanning (detect leaked secrets), signed commits (verify author). Example: GitHub Actions (ephemeral runner, OIDC tokens, Dependabot), GitLab CI (protected variables, SAST). Best practice: rotate secrets, audit permissions, use OIDC (not long-lived tokens), review third-party actions.

### 788. Build Reproducibility

Identical builds from same source. Reproducible: same source code + dependencies → same artifact (bit-for-bit). Why: verify official build (rebuild and compare), detect tampering. Challenges: timestamps, non-deterministic tools, host-specific paths. Solutions: Dockerfile (pin base image SHA, sorted layers), hermetic builds (isolated, no network), BuildKit (reproducible). Example: rebuild image from commit SHA → compare digest → match = verified. Tools: Reproducible Builds (project), Nix (reproducible package manager). Use case: verify binaries (match official release), supply chain security. Best practice: pin all dependencies (base image, packages), remove timestamps, deterministic ordering.

### 789. Third-Party Actions/Plugins

Vet external code. Risks: malicious action (steals secrets), vulnerable dependency (CVE), supply chain attack (compromised maintainer). Mitigation: pin to commit SHA (not tag, can be moved), review code (before use), limit permissions (GITHUB_TOKEN scoped), use trusted sources (verified publisher, high stars). Example: GitHub Action uses/actions/checkout@v3 → pin to SHA uses/actions/checkout@8e5e7e5. Scanning: Scorecard (OpenSSF project, assess action security). Best practice: audit actions (new and updates), pin SHA, minimize third-party usage, prefer official actions.

### 790. Infrastructure as Code Security

Scan IaC for misconfigurations. Tools: tfsec (Terraform), checkov (multi-format), kics, Snyk IaC. Checks: public S3 buckets, open security groups (0.0.0.0/0), unencrypted resources, missing logging. CI/CD: scan on PR (fail if high severity), scheduled scans (drift detection). Example: Terraform creates S3 bucket without encryption → tfsec detects → fail PR. Policies: custom rules (OPA, Rego), compliance (CIS benchmarks, NIST). Best practice: scan in CI/CD, fix before deploy, enable enforcement (admission controller for K8s manifests).

### 791. Software Composition Analysis (SCA)

Analyze open source usage. SCA: identify components (dependencies, licenses), detect vulnerabilities (CVEs), check licenses (GPL, MIT, Apache). Tools: Snyk, Black Duck, WhiteSource, FOSSA, Trivy. Use cases: vulnerability management (prioritize fixes), license compliance (avoid copyleft in proprietary), SBOM generation. Integration: CI/CD (fail on critical), IDE plugins (alert developers), continuous monitoring (new CVEs). Example: app uses 200 npm packages → SCA finds 5 with CVEs (3 high, 2 medium) → prioritize high. Best practice: automate scanning, track open source inventory (SBOM), license policy (allowlist/blocklist).

### Category 47: DevSecOps II: Policy as Code (15 concepts)

### 792. Policy as Code Principles

Define policies in code. Declarative: describe what's allowed/denied (YAML, Rego), not how to enforce. Version controlled: Git (audit trail, rollback). Automated: enforce at gates (CI/CD, admission, deployment). Benefits: consistency (no manual decisions), auditability (who changed what), scalability (enforce across thousands of resources). Tools: OPA (Open Policy Agent), Kyverno, Sentinel (HashiCorp), Cloud Custodian (cloud resources). Use case: enforce security policies, compliance, governance. Example: policy 'all pods must have resource limits' → OPA denies pods without limits. Best practice: test policies (unit tests), gradual rollout (audit mode → enforce).

### 793. Open Policy Agent (OPA) Deep Dive

General-purpose policy engine. Language: Rego (declarative, logic programming), query-based. Architecture: OPA as sidecar or webhook, receives request (JSON), evaluates policy (Rego), returns decision (allow/deny). Inputs: Kubernetes AdmissionReview, Terraform plan, HTTP request, custom. Data: policies (Rego files), external data (ConfigMaps, APIs). Outputs: boolean (allow), object (violations). Example: policy denies deployments without label 'team' → OPA webhook intercepts → checks label → denies if missing. Use case: Kubernetes admission control, API authorization, infrastructure validation. Tools: OPA Gatekeeper (K8s), Conftest (test IaC), Styra (commercial OPA).

### 794. OPA Gatekeeper

Kubernetes-native policy controller. CRDs: ConstraintTemplate (define policy in Rego), Constraint (instantiate policy with parameters). Architecture: validating webhook (intercepts requests), evaluates against Constraints, admits or denies. Example: ConstraintTemplate 'K8sRequiredLabels' → Constraint requires label 'app' on all Pods. Audit: scan existing resources (detect violations), no remediation (manual fix). Policies: policy library (common policies, requiredLabels, allowedRepos, noPrivileged). Best practice: start with audit mode (no blocking), review violations, enable enforcement, test policies (dry-run).

### 795. Kyverno

Kubernetes-native policy engine. Policies: YAML (no Rego), easier than OPA. Types: validate (admit/deny), mutate (modify resources, add labels), generate (create resources, default NetworkPolicy). Example: policy 'require resource limits' → validate rules → deny if missing. ClusterPolicy: cluster-wide. Policy: namespace-scoped. Background: scan existing resources (audit). Example: auto-add label 'env=prod' to all resources in namespace 'production' (mutate policy). Use case: simpler than OPA (YAML vs Rego), Kubernetes-specific. Best practice: validate in admission, mutate defaults (labels, resource limits), generate for security (NetworkPolicies).

### 796. Policy Testing

Validate policies before deploy. Unit tests: test policy logic (input → expected output), Conftest (test OPA policies), Kyverno CLI (test policies). Integration tests: deploy to test cluster, create resources, verify policies enforced. Example: OPA policy 'deny privileged pods' → unit test (input: privileged pod, output: denied), integration test (kubectl apply, expect error). CI/CD: run tests on policy changes (fail PR if tests fail). Coverage: test allow and deny paths, edge cases. Tools: OPA test command, Conftest, Gator (Gatekeeper testing). Best practice: test-driven policies (write test first), automate in CI/CD, regression tests (after bug fix).

### 797. Policy Reporting

Track compliance. Audit: periodic scan of resources, report violations. Metrics: compliance rate (% resources compliant), violations by policy, trends. Dashboards: Grafana (policy metrics), Kyverno/Gatekeeper reports. Remediation: manual (fix violations), automated (mutate policies). Example: scan cluster → 95% compliant → 50 pods missing resource limits (5%) → dashboard shows trend (improving). Alerting: Slack notifications (new violations), PagerDuty (critical policy breaches). Use case: continuous compliance, visibility, prioritize fixes. Best practice: regular audits (daily), track over time, integrate with incident management.

### 798. Admission Control Deep Dive

Kubernetes request interception. Flow: kubectl apply → API server → mutating webhooks (modify) → validating webhooks (allow/deny) → persisted to etcd. Built-in: PodSecurityPolicy (deprecated), PodSecurity Admission (replacement), LimitRanger, ResourceQuota. Custom: OPA Gatekeeper, Kyverno, custom webhooks. Failure policy: Fail (block if webhook unavailable, safer), Ignore (allow, less safe). Match rules: which resources/operations to intercept (pods, deployments, CREATE, UPDATE). Best practice: mutate first (add defaults), then validate (enforce rules), timeouts (fast response < 10s), HA webhooks (multiple replicas).

### 799. Policy Exemptions

Allow exceptions. Use cases: legacy apps (can't fix, temporary exemption), privileged pods (justified, documented), testing (dev environments). Implementation: annotations (policy ignores resources with annotation), namespace exclusions (skip certain namespaces), dedicated clusters (separate for special cases). Example: OPA policy allows privileged pods if annotation 'security.policy/privileged: true' present. Approval: require PR approval (two reviewers), expiration (time-limited exemptions), audit (report all exemptions). Best practice: minimize exemptions (fix root cause), document reason, time-bound (review quarterly).

### 800. Compliance as Code

Automate compliance checks. Frameworks: CIS benchmarks (K8s, Docker, cloud), PCI-DSS, HIPAA, SOC2. Policies: map controls to policies (CIS 5.2.1 'minimize privileged containers' → OPA policy deny privileged). Scanning: continuous (audit resources), scheduled (weekly compliance report). Reporting: compliance dashboard (% compliant per control), evidence (for auditors). Example: CIS Kubernetes Benchmark → 100 controls → 80 as OPA policies → automated enforcement + reporting. Tools: kube-bench (scan nodes), Compliance Operator (OpenShift), cloud-native tools (AWS Config, Azure Policy). Best practice: automate (no manual checklists), continuous scanning, auditability (logs + evidence).

### 801. Policy Versioning

Manage policy evolution. Challenges: breaking changes (old resources fail new policy), rollback (revert bad policy), testing (validate before production). Strategies: gradual rollout (audit → warn → enforce), versioning (v1, v2 policies, migrate gradually), canary (test policy on subset of resources). Example: new policy 'require securityContext' → deploy in audit mode (2 weeks, measure violations) → warn mode (alerts, no block) → enforce. Git: policies in Git (branches, tags, PRs), version control (who changed, why). Best practice: test thoroughly, gradual rollout, easy rollback (Git revert), communicate changes (deprecation notices).

### 802. Dynamic Admission Control

Context-aware policies. External data: query APIs (CMDB, cost service, vulnerability DB) during admission. Example: policy checks if image is scanned (query Harbor API for scan status) → deny if not scanned. OPA: external data via bundles (periodically fetched) or direct calls (http.send in Rego, slower). Kyverno: API calls (not in current version, roadmap). Use case: cost policies (deny if expensive instance type, check cost DB), security (only allow scanned images), compliance (check approved AMIs). Best practice: cache external data (avoid latency), timeout (webhook < 10s), fallback (if external service unavailable).

### 803. Policy-Based RBAC

Generate RBAC from policies. Concept: define access policies (declarative), generate RBAC resources (Roles, RoleBindings). Example: policy 'team-a can manage resources in namespace team-a' → generated: Role + RoleBinding. Tools: RBAC Manager (simplify RBAC), custom operators (watch policies, generate RBAC). Benefits: centralized (single source of truth), auditability (policy changes tracked), less manual (no individual Role creation). Use case: multi-tenant clusters, consistent RBAC, onboard teams (define policy, RBAC auto-generated). Best practice: define coarse-grained policies (team-level, not user-level), automate generation, test access (kubectl auth can-i).

### 804. Policy Enforcement Layers

Defense in depth. Layers: IDE (lint policies locally, fast feedback), CI/CD (scan IaC, fail PR), admission (runtime, block non-compliant), audit (detect drift, post-deployment). Example: privileged pod → IDE lint (warning) → CI/CD scan Dockerfile (fail if USER root) → admission webhook (deny if securityContext.privileged) → audit (report existing privileged pods). Redundancy: multiple layers (catch if one misses), shift left (fix early, cheaper). Best practice: enforce at all layers, shift left (early feedback), audit continuously (detect drift).

### 805. Policy Drift Detection

Identify manual changes. Drift: deployed resource doesn't match policy/IaC (manual kubectl edit, UI changes). Detection: periodic audit (scan resources, compare to expected), GitOps (compare Git vs cluster). Remediation: auto-revert (GitOps reconciliation), alert (manual review), delete (if unauthorized). Example: policy requires all pods have resource limits → audit finds 10 pods without limits → alert ops team. Tools: ArgoCD diff, Flux Kustomization (detect drift), OPA/Kyverno audit mode, Terraform plan (infrastructure drift). Best practice: continuous scanning (daily), alert on drift, root cause (why bypassed policy).

### 806. Policy Best Practices Summary

Production guidelines. Start simple: few critical policies (resource limits, privileged pods), expand gradually. Audit first: deploy in audit mode (report violations, no blocking), measure impact, then enforce. Test thoroughly: unit tests (policy logic), integration tests (real resources), CI/CD (automated). Document: policy intent (why exists), exemptions (approved exceptions), runbooks (how to fix violations). Communicate: deprecation notices (policy changes), training (dev teams understand policies), feedback loop (improve policies based on user input). Monitor: compliance dashboards, alert on violations, track trends. Best practice: gradual rollout, test before enforce, transparent (document), iterate (improve based on feedback).

### Category 48: DevSecOps III: Secrets & Scanning (17 concepts)

### 807. Secret Detection Tools

Scan for leaked secrets. Types: pre-commit (git-secrets, detect-secrets), repository scan (TruffleHog, GitLeaks, GitHub secret scanning), CI/CD (fail build if secrets detected). Patterns: API keys (regex), AWS keys, private keys (BEGIN RSA PRIVATE KEY), passwords (high entropy strings). Example: TruffleHog scans Git history → finds AWS access key in commit 3 months ago → alert. Remediation: revoke secret (rotate), rewrite history (git filter-repo, dangerous), prevent future leaks (pre-commit hooks). Best practice: pre-commit hooks (prevent commit), scan repos regularly, rotate on detection.

### 808. HashiCorp Vault

Centralized secrets management. Features: dynamic secrets (generate on-demand, short-lived), encryption as a service, leasing/renewal, revocation. Architecture: Vault server (stores secrets), clients (apps authenticate, fetch secrets). Auth methods: Kubernetes (service account), AWS IAM, AppRole (machine identity), OIDC (human users). Secrets engines: KV (static), database (dynamic DB credentials), PKI (certificates), SSH. Example: app requests DB credentials → Vault generates (postgres user, valid 1 hour) → app uses → credentials auto-expire. Use case: dynamic secrets, centralized management, audit logs. Best practice: short TTLs, auto-rotation, audit all access.

### 809. Kubernetes Secrets

Native secret storage. Data: base64 encoded (not encrypted), stored in etcd. Access: RBAC (which serviceAccounts can read), mounted as volume or env vars. Encryption at rest: enable in kube-apiserver (encrypt etcd), use KMS provider (AWS KMS, GCP KMS). Limitations: not truly encrypted (base64), no rotation, no audit. Alternatives: External Secrets Operator (sync from Vault), Sealed Secrets (encrypted in Git), CSI Secret Store (mount from external). Example: Secret with DB password → mounted to pod → app reads from file. Best practice: enable encryption at rest, use External Secrets for production, RBAC (least privilege).

### 810. Secret Rotation

Regularly change secrets. Frequency: 90 days (default), 30 days (high security), on breach (immediate). Automated: Vault (dynamic secrets auto-expire), AWS Secrets Manager (auto-rotate RDS passwords), scripts (rotate and update apps). Challenges: coordinating updates (multiple apps use same secret), zero-downtime (gradual rollout, old+new valid simultaneously). Example: rotate API key → generate new key → deploy apps with new key → revoke old key (after grace period). Best practice: automate rotation, test rotation process (game day), short-lived secrets (reduce rotation burden).

### 811. Secrets in GitOps

Handle secrets in Git-based workflows. Problem: can't commit plaintext secrets to Git. Solutions: Sealed Secrets (encrypt, commit encrypted), SOPS (encrypt files, Flux decrypts), External Secrets Operator (secrets stored externally, ESO syncs to cluster). Workflow: developer creates Secret → seals with kubeseal → commits SealedSecret YAML → GitOps applies → controller decrypts → creates Secret. Example: SOPS encrypts secret with KMS → commit to Git → Flux decrypts during apply → Secret created in cluster. Best practice: never commit plaintext, use KMS-backed encryption (Sealed Secrets, SOPS), External Secrets for highly sensitive (Vault).

### 812. SAST (Static Application Security Testing)

Scan code for vulnerabilities. Analysis: source code (no runtime), detect patterns (SQL injection, XSS, hardcoded secrets, insecure functions). Tools: SonarQube, Semgrep, Checkmarx, CodeQL (GitHub), Snyk Code. Integration: CI/CD (fail build on high severity), IDE plugins (real-time feedback), PR checks (comment on issues). Findings: ranked by severity (critical, high, medium, low), false positives (tune rules). Example: Semgrep detects SQL injection (user input in query) → fail PR → developer fixes (parameterized query). Best practice: shift left (early detection), tune rules (reduce false positives), track over time (security debt).

### 813. DAST (Dynamic Application Security Testing)

Test running applications. Runtime: black-box testing (no source code), simulates attacks (XSS, SQL injection, CSRF). Tools: OWASP ZAP, Burp Suite, Acunetix, Netsparker. Workflow: crawl application (map endpoints) → fuzz inputs (inject payloads) → detect vulnerabilities (error messages, response anomalies). Example: ZAP baseline scan (API) → attempts SQL injection → detects vulnerability (500 error + DB stacktrace). Use case: web apps, APIs, complement SAST (runtime issues). Best practice: scan staging (pre-production), automate in CI/CD, prioritize critical (authenticated endpoints).

### 814. Container Runtime Security

Protect running containers. Detection: anomalous behavior (unexpected syscalls, file access, network connections), runtime policies (allow/deny). Tools: Falco (eBPF/kernel module, detect anomalies), Sysdig Secure, Aqua, Prisma Cloud. Rules: detect shell in container (suspicious), unexpected outbound connection (data exfiltration), privilege escalation. Example: Falco alerts 'shell spawned in nginx container' (possible compromise). Response: alert (SOC team), kill container (auto-remediation), forensics (capture state). Best practice: define baseline (normal behavior), alert on deviations, integrate with SIEM.

### 815. Falco Rules

Detect runtime anomalies. Rule structure: condition (syscall, container name, process), output (alert message), priority (critical, warning). Example: 'Terminal shell in container' → condition (spawned_process == bash, container_id != host) → alert. Macros: reusable conditions (user_known_package_manager_in_container). Customization: add custom rules (business-specific), tune (reduce false positives). Outputs: stdout, file, Slack, webhook, SIEM. Example: detect cryptocurrency miner → condition (process.name in (xmrig, minerd)) → alert to Slack. Best practice: start with default rules, add custom for apps, tune thresholds.

### 816. Image Hardening

Reduce attack surface. Practices: minimal base (distroless, alpine, scratch), non-root user (USER 1000), read-only filesystem (readOnlyRootFilesystem: true), drop capabilities (drop ALL, add specific), no shell (remove /bin/sh), scan for vulnerabilities. Example: Dockerfile → FROM gcr.io/distroless/static → COPY binary / → USER 65532 → no shell, minimal CVEs. Distroless: no package manager, shell, or extraneous binaries (Google maintains). Best practice: multi-stage builds (smaller final image), scan images (Trivy), enforce policies (no root user).

### 817. Vulnerability Prioritization

Focus on critical issues. Factors: severity (CVSS score), exploitability (public exploit exists), exposure (internet-facing), business impact (critical service). CVSS: score 0-10 (critical 9-10, high 7-8.9, medium 4-6.9, low 0-3.9). EPSS (Exploit Prediction Scoring System): probability of exploitation (0-100%). Example: CVE with CVSS 9 (critical) but EPSS 5% (low probability) → prioritize lower than CVSS 7 with EPSS 80%. Use case: limited resources, prioritize high-impact fixes. Tools: Snyk (priority score), Trivy (filter by severity), VEX (Vulnerability Exploitability eXchange). Best practice: triage based on risk (not just CVSS), fix internet-facing first, track SLA (patch within X days).

### 818. Zero-Day Vulnerabilities

Unknown exploits. Definition: vulnerability without patch (0 days since disclosure). Impact: all users vulnerable (no fix available), high risk (actively exploited). Response: workarounds (disable feature, WAF rules), monitoring (detect exploitation attempts), compensating controls (network segmentation, least privilege). Example: Log4Shell (2021) → RCE in Log4j → no patch initially → mitigations (disable JNDI, WAF rules, upgrade when patch released). Best practice: defense in depth (reduce blast radius), rapid response plan (update within hours), threat intelligence (monitor for exploitation).

### 819. Security Champions

Embed security in teams. Role: developer advocate for security (not full-time security role), train team (secure coding, threat modeling), review code (security focus), liaise with security team (escalate issues). Benefits: scale security (can't hire enough security engineers), shift left (catch issues early), culture (security-aware developers). Activities: threat modeling sessions, security training, review PRs (identify SQL injection), participate in incident response. Best practice: volunteer-based (interested developers), supported by security team (training, tools), recognized (not extra unpaid work), rotate (avoid burnout).

### 820. Secure Coding Practices

Write secure code. Principles: validate input (whitelist, not blacklist), parameterize queries (prevent SQL injection), encode output (prevent XSS), least privilege (minimal permissions), fail securely (deny on error), don't trust external input. Patterns: OWASP Top 10 (common vulnerabilities), language-specific guides (Go, Python, JavaScript). Example: SQL injection → use prepared statements (SELECT * FROM users WHERE id = ?, [userId]), not string concatenation. Training: OWASP WebGoat (hands-on), secure code reviews (learn from mistakes). Best practice: security training (annual), linters (detect insecure patterns), code review (security checklist).

### 821. Threat Modeling

Identify security risks. Process: diagram system (data flows, trust boundaries), identify threats (STRIDE: Spoofing, Tampering, Repudiation, Information disclosure, Denial of service, Elevation of privilege), mitigations (how to address threats), validate (test security controls). Example: login system → threat (attacker steals JWT) → mitigation (short expiry, rotate signing key, HTTPS only). When: design phase (new features), major changes (new integrations), periodic (annual review). Tools: Microsoft Threat Modeling Tool, OWASP Threat Dragon. Best practice: involve diverse team (dev, ops, security), focus on high-risk areas (internet-facing, sensitive data), document (decisions, mitigations).

### 822. DevSecOps Culture

Security as shared responsibility. Principles: shift left (security early in SDLC), automate (scanning, policies), fast feedback (IDE warnings, PR comments), blameless (learn from incidents, not blame). Collaboration: security team provides tools/guidance, developers implement (own security), ops enforces (runtime controls). Metrics: MTTR for vulnerabilities, % scanned artifacts, policy compliance. Challenges: resistance to change (slow down deployments), false positives (alert fatigue), skill gaps (training needed). Best practice: start small (quick wins, build trust), tooling (reduce friction), training (upskill developers), celebrate successes (security as enabler, not blocker).

### Category 49: Cloud Security & IAM (15 concepts)

### 823. Image Security

Secure container images. 

**Base images:** official, minimal (alpine, distroless), avoid latest tag, use specific versions. 

**Vulnerability scanning:** Trivy, Grype, Clair, scan in CI, fail on critical CVEs. 

**Multi-stage builds:** separate build/runtime, final image smaller, no build tools. 

**Non-root user:** `USER 1000` in Dockerfile, don't run as root. 

**Read-only filesystem:** `readOnlyRootFilesystem: true`, write to emptyDir volumes. 

**Image signing:** Cosign, Notary, sign images, verify signature before deploy. 

**Admission controller:** validate signatures (Kyverno, OPA), enforce signed images only. 

**Immutable tags:** use digest (`image@sha256:abc123`), not mutable tags. 

**Private registry:** Harbor (scanning, replication, RBAC), ECR, GCR. 

**SBOM:** Software Bill of Materials, list all packages, formats (SPDX, CycloneDX). 

**Supply chain security:** SLSA, provenance, attestation.

---

### 824. Runtime Security

Detect threats at runtime. 

**Tools:** Falco (CNCF, eBPF/kernel module), Sysdig, Aqua. 

**Falco:** rules for suspicious behavior, e.g., shell spawned in container, sensitive file read, unexpected network connection. 

**Rules:** 
```yaml
- rule: Shell in container
  desc: Detect shell
  condition: container and proc.name in (bash, sh)
  output: Shell in container (user=%user.name container=%container.name)
  priority: WARNING
```

**Detection:** syscall monitoring, hooks into kernel, eBPF (performant, safe). 

**Alerts:** stdout (JSON), webhook (Slack, PagerDuty), SIEM. 

**Deployment:** DaemonSet on each node. 

**Use cases:** detect container escapes, privilege escalation, crypto mining, data exfiltration. 

**Response:** alert + investigate, or auto-remediate (kill pod, OPA admission). 

**Tuning:** customize rules per environment, reduce false positives.

---

### 825. Supply Chain Security

Secure software supply chain. 

**Threat:** compromised dependency, malicious image, tampered artifact. 

**SBOM (Software Bill of Materials):** list all components (packages, libraries), formats (SPDX, CycloneDX), tools (Syft, Trivy). 

**Provenance:** record of build (who, when, where, how), attest that artifact built from specific source. 

**SLSA (Supply-chain Levels for Software Artifacts):** framework, levels 0-4, increasing guarantees, level 3 = provenance + non-falsifiable. 

**Sigstore:** free signing/verification, Cosign (sign images), Rekor (transparency log, immutable), Fulcio (keyless signing with OIDC). 

**Attestation:** metadata about artifact, signed, in-toto format. 

**Verification:** admission controller checks signature + attestation before allowing pod. 

**Dependencies:** scan for CVEs, use lock files (package-lock.json, go.sum), Dependabot auto-updates. 

**Build security:** reproducible builds, isolated build environments, sign artifacts. 

**Challenges:** complexity, key management (Sigstore simplifies with keyless).

---

### 826. Admission Controllers

Intercept API requests before persistence. 

**Types:** Validating (approve/reject), Mutating (modify object), combination. 

**Built-in:** PodSecurityAdmission, LimitRanger, ResourceQuota, ServiceAccount, DefaultStorageClass. 

**Dynamic admission webhooks:** custom logic, ValidatingWebhookConfiguration, MutatingWebhookConfiguration. 

**Webhook flow:** kube-apiserver calls webhook (HTTPS), webhook returns admission response (allow/deny/patch). 

**Example webhook:** OPA Gatekeeper (policies), Kyverno (policies), custom (validate image registry). 

**Mutation:** inject sidecar (Istio), set labels, add init containers. 

**Validation:** enforce naming, require labels, validate image signature. 

**Timeout:** webhook must respond quickly (10s default), or request fails. 

**FailurePolicy:** Fail (reject if webhook down, secure), Ignore (allow, availability > security). 

**Ordering:** mutating before validating. 

**Security:** webhook can block malicious pods, enforce policies.

---

### 827. Open Policy Agent (OPA)

Policy as code. 

**Rego:** policy language, declarative, logic-based, `allow { ... }`. 

**Use cases:** admission control (K8s), API authorization, data filtering, configuration validation. 

**Gatekeeper:** OPA for Kubernetes, admission controller, CRDs (ConstraintTemplate, Constraint). 

**ConstraintTemplate:** defines policy template (Rego), parameters. 

**Constraint:** instantiates template with parameters, targets resources. 

**Example:** require labels, `template.spec.targets.rego` checks `input.review.object.metadata.labels`, Constraint sets required labels. 

**Audit:** scan existing resources for violations, report in Constraint status. 

**Enforcement:** validating webhook rejects non-compliant resources. 

**Policy library:** reusable policies, community-contributed. 

**Testing:** unit tests for policies (OPA test, rego playground). 

**Alternatives:** Kyverno (YAML policies, simpler), jsPolicy (JavaScript).

---

### 828. Network Segmentation

Isolate network zones. 

**Zones:** DMZ (public-facing), internal (apps), data tier (databases), management (admin access). 

**Implementation:** VLANs (physical), VPCs/subnets (cloud), namespaces + network policies (K8s), firewalls. 

**Kubernetes:** namespaces as zones (dev, staging, prod), network policies enforce (deny traffic between namespaces by default). 

**Micro-segmentation:** fine-grained, per-service/pod, zero-trust. 

**Service mesh:** Istio, policies control service-to-service traffic. 

**Benefits:** limit lateral movement (attacker in DMZ can't reach data tier), reduce blast radius, compliance. 

**Example K8s:** namespace `prod`, NetworkPolicy denies all ingress except from Ingress controller, denies all egress except to external APIs. 

**Cloud:** separate VPCs/subnets, security groups, route tables, peering for inter-VPC.

---

### 829. Firewall Rules

Control network traffic. 

**Stateful vs stateless:** stateful (tracks connections, allow return traffic), stateless (each packet independent, must allow return explicitly). 

**iptables:** Linux firewall, tables (filter, nat, mangle), chains (INPUT, OUTPUT, FORWARD), rules (match + target). 

**Example:** `iptables -A INPUT -p tcp --dport 22 -j ACCEPT` (allow SSH), `iptables -A INPUT -j DROP` (default deny). 

**Cloud:** Security Groups (AWS, stateful, instance-level), Network ACLs (AWS, stateless, subnet-level), NSGs (Azure). 

**Default deny:** best practice, explicitly allow only needed traffic. 

**Egress control:** restrict outbound (data exfiltration prevention). 

**Logging:** log dropped packets (debugging, intrusion detection). 

**Management:** automate with IaC (Terraform), don't manually edit. 

**Testing:** `telnet`, `nc`, packet capture.

---

### 830. Intrusion Detection/Prevention (IDS/IPS)

Detect and block attacks. 

**IDS:** passive monitoring, alerts on suspicious activity, doesn't block. 

**IPS:** active, blocks attacks, inline. 

**Detection methods:** signature-based (known attacks, fast, misses zero-days), anomaly-based (ML, detects novel attacks, false positives). 

**NIDS:** Network IDS, monitors network traffic (Snort, Suricata, Zeek). 

**HIDS:** Host IDS, monitors host (OSSEC, Wazuh, osquery). 

**Suricata:** open-source NIDS/NIPS, rules, multi-threaded, protocol detection. 

**Cloud:** AWS GuardDuty (anomaly detection, ML), Azure Security Center, GCP Security Command Center. 

**Kubernetes:** Falco (runtime), network IDS at ingress, SIEM integration. 

**Alerts:** SIEM (Splunk, ELK), SOC team, automated response (block IP, kill pod). 

**Tuning:** reduce false positives, custom rules, whitelist known-good behavior.

---

### 831. DDoS Protection

Defend against distributed denial-of-service. 

**Attack types:** volumetric (flood bandwidth, UDP/ICMP), protocol (SYN flood, exhaust connections), application (L7, HTTP GET flood). 

**Mitigation:** rate limiting (per IP, per user), IP reputation (block known bad IPs), geo-blocking, CAPTCHA. 

**Scrubbing centers:** route traffic to scrubbing (Cloudflare, Akamai, AWS Shield), filter attack traffic, return clean. 

**Anycast:** distribute traffic across multiple locations, absorb volumetric attacks. 

**Auto-scaling:** scale infrastructure to handle load (expensive). 

**Cloud services:** AWS Shield (Standard free, Advanced paid), Cloudflare (proxy), Akamai. 

**SYN cookies:** defend against SYN flood, kernel setting. 

**WAF:** Web Application Firewall, L7 protection, rate limit, block patterns. 

**Monitoring:** detect anomalies (traffic spike, unusual sources), alert. 

**Preventive:** overprovision bandwidth, CDN, distribute architecture.

---

### 832. Security Scanning (SAST/DAST)

Automated security testing. 

**SAST (Static Application Security Testing):** analyze source code, no execution, finds vulnerabilities (SQL injection, XSS, hardcoded secrets), tools: SonarQube, Semgrep, Checkmarx, Veracode, CodeQL, Snyk Code. 

**DAST (Dynamic Application Security Testing):** test running app, black-box, HTTP requests, tools: OWASP ZAP, Burp Suite, Acunetix. 

**Comparison:** SAST early (dev), fast, false positives, no runtime context; DAST later (staging), slower, real vulns, but can't see code. 

**Combination:** both SAST and DAST, complementary. 

**IAST (Interactive):** instruments app, monitors at runtime, hybrid. 

**CI integration:** run SAST in pipeline, fail on critical findings, create tickets. 

**Dependency scanning:** check libraries for CVEs (Snyk, Dependabot, npm audit), part of SAST. 

**Results:** prioritize by severity (critical, high, medium, low), remediation guidance. 

**False positives:** triage, suppress, tune scanner.

---

### 833. Vulnerability Management

Track and remediate vulnerabilities. 

**Process:** Discover (scan), Assess (severity, CVSS score, exploitability), Prioritize (risk-based, business impact), Remediate (patch, update, mitigate), Verify (rescan). 

**CVSS:** Common Vulnerability Scoring System, 0-10 score, critical (9-10), high (7-8.9), medium (4-6.9), low (0-3.9). 

**Databases:** CVE (Common Vulnerabilities and Exposures), NVD (National Vulnerability Database), vendor advisories. 

**Scanning:** Nessus, OpenVAS (infra), Trivy, Grype (containers), Snyk, Dependabot (dependencies). 

**Patch management:** automated patching (unattended-upgrades, yum-cron), test patches in staging, schedule maintenance windows. 

**SLA:** critical patches within 7 days, high within 30 days, etc. 

**Reporting:** dashboard, metrics (mean time to remediate, open vulns), executive summary. 

**Risk acceptance:** document if can't patch (legacy system), compensating controls. 

**Container images:** rebuild images with updated packages, rescan, redeploy.

---

### 834. Compliance & Auditing

Meet regulatory requirements. 

**Frameworks:** PCI-DSS (payment cards), HIPAA (healthcare), SOC 2 (service orgs), GDPR (privacy, EU), ISO 27001 (infosec), FedRAMP (US gov). 

**Controls:** technical (encryption, access control), administrative (policies, training), physical (data center security). 

**Audit logging:** who did what when, immutable logs, retention (years). 

**Kubernetes audit:** kube-apiserver audit logs, `--audit-log-path`, `--audit-policy-file`, records all API requests. 

**Audit policy:** define what to log (levels: None, Metadata, Request, RequestResponse), rules by resource/verb. 

**Log storage:** ship to SIEM (Splunk, ELK), S3 with S3 Object Lock (immutable), long retention. 

**Compliance as code:** OPA/Kyverno policies enforce (e.g., require encryption, deny public access), automated checks. 

**Attestation:** prove compliance, audits (annual), assessments. 

**Evidence:** logs, configs, screenshots, policies, training records. 

**Automation:** tools (AWS Audit Manager, Drata, Vanta), continuous compliance.

---

### 835. Incident Response

Handle security incidents. 

**Phases:** Preparation, Detection/Identification, Containment, Eradication, Recovery, Post-Incident (lessons learned). 

**Preparation:** plan (documented procedures), tools (forensics, SIEM), team (roles, on-call), drills (tabletop exercises). 

**Detection:** SIEM alerts, IDS, anomaly detection, user reports. 

**Identification:** confirm incident (not false positive), severity, scope, affected systems. 

**Containment:** isolate (quarantine infected systems, disable accounts, block IPs), prevent spread, short-term (immediate) and long-term (sustainable fix). 

**Eradication:** remove threat (malware, backdoors, vulnerabilities), patch systems. 

**Recovery:** restore systems, validate (no reinfection), monitor closely. 

**Post-incident:** blameless postmortem, timeline, root cause, lessons learned, action items (prevent recurrence). 

**Communication:** internal (stakeholders), external (customers, regulators if required), coordinated disclosure (security researchers). 

**Legal:** involve legal/compliance, evidence preservation (chain of custody). 

**Automation:** playbooks (SOAR), auto-containment (kill pod, block IP).

---

### 836. Security Information & Event Management (SIEM)

Centralized security monitoring. 

**Purpose:** aggregate logs, correlate events, detect threats, compliance reporting. 

**Components:** log collection (agents, syslog), normalization (parse, standardize), correlation (rules, ML), alerting, dashboards. 

**Tools:** Splunk (commercial, powerful), Elastic Stack (ELK + security, open-source), IBM QRadar, ArcSight, Azure Sentinel, Google Chronicle. 

**Data sources:** firewalls, IDS/IPS, servers (syslog), apps (logs), K8s (audit logs), cloud (CloudTrail, VPC Flow Logs), endpoint (EDR). 

**Use cases:** detect brute force (multiple failed logins), privilege escalation (user becomes admin), data exfiltration (large outbound transfer), compliance (audit trail). 

**Correlation rules:** if event A and event B within timeframe → alert, e.g., failed login + successful login from different IP → compromised account. 

**ML/UEBA:** User and Entity Behavior Analytics, detect anomalies (user accesses unusual resource, login from unusual location). 

**Incident workflow:** alert → investigate (pivot through logs) → escalate/resolve → document. 

**Retention:** logs retained months/years (compliance), archive old data (S3).

---

### 837. Encryption in Transit

Protect data over network. 

**TLS everywhere:** all network communication encrypted, HTTP → HTTPS, gRPC uses TLS, DB connections (SSL/TLS). 

**Kubernetes:** API server TLS (all components communicate via TLS), etcd TLS (peer and client), kubelet TLS. 

**Service mesh:** automatic mTLS between services (Istio, Linkerd), transparent to app. 

**Ingress:** TLS termination at Ingress controller, cert-manager for Let's Encrypt. 

**Internal traffic:** encrypt even inside cluster (zero trust), mTLS or TLS. 

**Certificate management:** automated renewal (cert-manager), rotate certs. 

**TLS version:** require TLS 1.2+ (disable 1.0, 1.1, SSL), strong cipher suites. 

**VPN:** for remote access, encrypts traffic over public internet. 

**IPsec:** network-layer encryption, tunnel mode (site-to-site VPN). 

**HTTPS enforcement:** redirect HTTP to HTTPS (301), HSTS header (force HTTPS in browser).

---

### 838. Encryption at Rest

Protect stored data. 

**Full disk encryption:** Linux LUKS (dm-crypt), BitLocker (Windows), FileVault (macOS), encrypts entire disk. 

**Database encryption:** TDE (Transparent Data Encryption, SQL Server, Oracle), encrypt tables/columns, keys in KMS. 

**Kubernetes secrets:** encryption at rest (etcd), EncryptionConfiguration, KMS provider. 

**Object storage:** S3 SSE (Server-Side Encryption, AES-256), SSE-KMS (with AWS KMS), SSE-C (customer-provided keys), GCS encryption (automatic). 

**Block storage:** EBS encryption (AWS), Persistent Disk encryption (GCP), Azure Disk Encryption. 

**Key management:** KMS (AWS KMS, GCP KMS, Azure Key Vault, HashiCorp Vault), envelope encryption (DEK encrypts data, KEK encrypts DEK, KEK in KMS). 

**Backup encryption:** encrypt backups, same key management. 

**Data at rest locations:** databases, file storage, backups, logs, object storage. 

**Compliance:** PCI-DSS requires encryption of cardholder data, GDPR requires appropriate security. 

**Performance:** minimal overhead (hardware-accelerated AES). 

**Key rotation:** rotate KEK regularly, re-encrypt DEKs.

---

---

### 839. Cloud IAM Best Practices

Secure cloud identity. Principles: least privilege (minimum permissions), no root/admin users (use IAM roles), MFA (multi-factor authentication), rotate keys (90 days), audit access (CloudTrail, monitor IAM changes). Roles vs users: prefer roles (temporary credentials, no keys), service accounts for apps. Policy evaluation: explicit deny overrides allow, check resource-based + identity-based policies. AWS: IAM policies (JSON), conditions (IP, MFA, time), service control policies (org-wide). Azure: RBAC (role assignments), Azure AD. GCP: IAM (roles, members, bindings), predefined roles (least privilege). Best practice: tag resources (track ownership), policy review (quarterly), use groups (not individual users).

### 840. Cloud Security Groups & Firewalls

Network security in cloud. AWS Security Groups: stateful (return traffic auto-allowed), instance-level, allow rules only (no deny), evaluate all rules. AWS NACLs: stateless (must allow return traffic), subnet-level, allow + deny rules, ordered (first match wins). Azure NSG: stateful, subnet or NIC level, priority (100-4096, lower wins). GCP Firewall Rules: stateless (specify ingress/egress), VPC-level, priority (0-65535). Best practice: default deny-all (explicit allow), principle of least privilege (specific ports/IPs), log denied connections (audit), use security group chaining (reference groups, not IPs).

### Category 50: Security Advanced: Zero Trust & Compliance (15 concepts)





### 841. Cloud Encryption Patterns

Protect data at rest and in transit. At rest: server-side encryption (SSE, cloud-managed keys), client-side encryption (app encrypts before upload), KMS (key management service), envelope encryption (DEK encrypted by KEK). In transit: TLS/HTTPS (certificate management), private connectivity (VPN, Direct Connect, ExpressRoute). Key management: AWS KMS, Azure Key Vault, GCP Cloud KMS, rotation (automatic yearly), audit (who accessed keys). Compliance: FIPS 140-2 (crypto module standard), GDPR (encryption requirement). Example: S3 bucket with SSE-KMS → KMS key per environment (dev, prod) → audit in CloudTrail. Best practice: encrypt everything (default), automate key rotation, separate keys per environment.

### 842. Cloud Compliance Automation

Enforce regulatory requirements. Frameworks: CIS benchmarks, NIST, PCI-DSS, HIPAA, SOC2. Tools: AWS Config (detect non-compliance), AWS Security Hub (aggregate findings), Azure Policy (enforce rules), GCP Security Command Center. Rules: public S3 buckets (deny), unencrypted RDS (alert), overly permissive SGs (flag). Remediation: auto-remediate (Lambda/Function, close port 22), manual workflow (Jira ticket). Reporting: compliance dashboards (% compliant), evidence collection (auditor artifacts). Example: AWS Config rule 'encrypted-volumes' → scans EBS → reports unencrypted (20/100 volumes) → auto-remediate (enable encryption). Best practice: automate checks (continuous), prioritize critical controls, document exceptions.

### 843. Cloud DDoS Protection

Mitigate distributed attacks. Layers: L3/L4 (network, SYN flood), L7 (HTTP flood). Services: AWS Shield (Standard free, Advanced paid), Azure DDoS Protection, GCP Cloud Armor. CloudFront/CloudFlare: CDN with DDoS protection, absorb traffic, rate limiting. WAF: filter malicious requests (IP blocklist, geo-blocking, rate limiting, signature detection). Auto-scaling: absorb traffic spikes (expensive). Monitoring: CloudWatch metrics (request rate spike), alerts. Example: API under attack (10k req/s) → CloudFront absorbs → WAF blocks bad IPs → Shield detects DDoS (Advanced notifies DRT team). Best practice: use CDN (distribute traffic), enable Shield Advanced (critical apps), test (simulate attacks).

### 844. Cloud Audit Logging

Track actions for security and compliance. Services: AWS CloudTrail (API calls), Azure Activity Log, GCP Cloud Audit Logs. Events: who (IAM user/role), what (action, CreateBucket), when (timestamp), where (IP, region), result (success/failure). Storage: S3/Blob/GCS (long-term), encrypt logs, integrity (log file validation). Analysis: Athena (SQL queries on logs), Log Analytics, BigQuery. Alerts: suspicious activity (root user login, unusual API calls, failed auth). Retention: compliance requirements (1-7 years). Example: CloudTrail → S3 → Athena query 'failed DeleteBucket attempts' → investigate. Best practice: enable in all regions, centralize (org trail), protect logs (prevent deletion), SIEM integration.

### 845. Cloud Shared Responsibility Model

Understand security split. Cloud provider: security OF the cloud (physical, network, hypervisor, managed services). Customer: security IN the cloud (data, apps, IAM, OS patches, network config, encryption). IaaS: customer manages more (OS, apps, data). PaaS: provider manages more (runtime, middleware). SaaS: provider manages most (only data, access). Example: EC2 (IaaS) → AWS secures hypervisor, customer patches OS. S3 (PaaS) → AWS manages storage, customer manages bucket policies, encryption. Compliance: customer's responsibility (demonstrate compliance, audit trail). Best practice: understand split (read docs), implement customer controls, don't assume provider does everything.

### 846. Cloud Secrets Management

Handle credentials in cloud. Solutions: AWS Secrets Manager (auto-rotate RDS passwords), Systems Manager Parameter Store (simpler, cheaper), Azure Key Vault, GCP Secret Manager. Features: encryption (KMS), versioning (rollback), rotation (automatic or manual), access control (IAM, RBAC). Application integration: SDK (fetch at runtime), environment variables (from secrets), Lambda (attach IAM role, no hardcoding). Example: Lambda function → IAM role → read secret from Secrets Manager → connect to database. Rotation: automatic (Secrets Manager + RDS, 30 days), custom Lambda (rotate API keys). Best practice: never hardcode secrets, use IAM for access (not secret keys), enable auto-rotation, audit access.

### 847. Cloud Identity Federation

Centralized authentication. SAML: enterprise SSO (Okta, Azure AD → AWS), assertion-based. OIDC: modern (Google, GitHub → cloud), token-based. Use case: employees use corporate credentials (no separate cloud accounts), temporary credentials (assume role via federation). AWS: IAM Identity Provider + IAM roles, trust policy (which IdP), role mapping (SAML assertion attributes → IAM role). Example: employee logs into Okta → SAML assertion → assume AWS role (PowerUser) → temporary credentials. Benefits: centralized management (disable user once), MFA enforcement (IdP level), audit trail. Best practice: federate (don't create IAM users), enforce MFA at IdP, least privilege roles.

### 848. Cloud Security Posture Management (CSPM)

Continuous cloud security assessment. Tools: Prisma Cloud, Wiz, Orca, AWS Security Hub, Azure Defender. Capabilities: misconfiguration detection (public S3, open SGs), compliance scoring (CIS benchmark), risk prioritization (attack paths), drift detection (IaC vs actual). Findings: critical (publicly exposed DB), high (no encryption), medium (logging disabled). Remediation: auto-remediate (close port), workflow (create ticket), ignore (accepted risk). Example: CSPM scans AWS account → finds 50 issues (5 critical, 20 high, 25 medium) → prioritize critical (public RDS) → auto-fix (modify SG). Best practice: continuous scanning (hourly), integrate with IaC (prevent misconfigs), track over time (trending down).

### 849. Service Mesh Security Deep Dive

Zero trust for microservices. mTLS: automatic (sidecar encrypts traffic), certificate management (Citadel issues certs, short-lived), identity (SPIFFE). Authorization: L7 policies (Istio AuthorizationPolicy, allow frontend → backend on POST /api/*), deny by default. Observability: traffic is visible (encrypted at network, decrypted by sidecar, proxy sees plaintext). Trust domain: cluster-level or cross-cluster (federated trust). Example: service A calls service B → Envoy sidecar (A) → mTLS handshake (verify cert) → Envoy sidecar (B) → AuthorizationPolicy (check if allowed) → allow. Best practice: enforce mTLS (STRICT mode), fine-grained authz (per-endpoint), observability (traces show auth decisions).

### 850. Supply Chain Levels for Software Artifacts (SLSA)

Framework for artifact integrity. Levels: L0 (no guarantees), L1 (provenance exists, build documented), L2 (provenance signed, version control), L3 (hardened build platform, auditable), L4 (reproducible, two-party review). Requirements: Build platform (ephemeral, isolated), Provenance (who, what, when, where), Verification (check before deploy). Example: L3 → GitHub Actions (hardened builder) → generates provenance (repo, commit, workflow) → signs with Sigstore → admission controller verifies. Benefits: prevent tampering, detect malicious builds, supply chain security. Best practice: aim for L3 (L4 difficult), generate provenance (in-toto), verify in admission.

### 851. Zero Trust Network Access (ZTNA)

Assume breach, verify always. Principles: never trust (verify every request), least privilege (minimum access), micro-segmentation (limit lateral movement), verify explicitly (device health, user identity, context). Implementation: BeyondCorp (Google model), identity-aware proxy (IAP), device certificates, continuous verification. No VPN: direct access to apps (not network), per-app access. Example: employee accesses internal app → IAP checks (user authenticated?, device compliant?, location allowed?) → proxies request to app. Tools: Google BeyondCorp, Cloudflare Access, Palo Alto Prisma Access. Use case: remote work (secure without VPN), reduce attack surface, assume breach. Best practice: start with critical apps, device management (certificates), MFA enforcement.

### Category 51: Platform Engineering I: IDP Concepts (15 concepts)

### 852. Internal Developer Platform (IDP)

Self-service for developers. Components: service catalog (what can I deploy), templates (golden paths), CI/CD (automated pipelines), environments (dev/stage/prod), observability (metrics, logs). Benefits: reduce cognitive load (dev focuses on code, not infra), standardization (consistent practices), faster onboarding, self-service (no tickets). Example: developer → selects 'Node.js microservice' template → Backstage creates repo + CI/CD → deploys to dev → self-service promote to prod. Tools: Backstage, Humanitec, Kratix, Port. Best practice: golden paths (easy defaults), escape hatches (allow customization), measure success (deployment frequency, lead time).

### 853. Golden Paths

Paved roads for developers. Concept: opinionated templates (best practices baked in), easy to use (one click), extensible (can customize). Example: 'Python API' golden path → includes (Dockerfile, CI/CD, Helm chart, observability, security scanning). Deviation: allow (not forced), but golden path is easiest. Benefits: consistency (all services similar), faster (no setup), secure by default (security baked in). Implementation: Backstage software templates, Cookiecutter, custom scripts. Best practice: start with one path (most common use case), iterate based on feedback, don't over-template (balance ease and flexibility).

### 854. Platform as Product

Treat platform as product. Mindset: developers are customers, platform team is product team. Product management: roadmap (prioritize features), backlog (user stories), feedback (surveys, interviews). Metrics: adoption (% teams using platform), satisfaction (NPS, CSAT), productivity (deploy frequency, lead time). Roadmap: based on user needs (not tech for tech's sake). Example: platform team builds IDP → surveys reveal 'slow CI/CD' pain → prioritizes caching, parallelization → satisfaction improves. Best practice: dedicated product manager, user research, iterate (MVP, gather feedback), dogfood (use your own platform).

### 855. Developer Self-Service

Empower developers to deploy. Capabilities: create environments (dev/stage/prod), deploy apps (self-service), manage configs (feature flags, secrets), monitor (dashboards, alerts), troubleshoot (logs, traces). Tools: Backstage, Humanitec, Heroku (PaaS model). Benefits: faster (no waiting for ops), ownership (dev responsible), scalability (ops team doesn't bottleneck). Guardrails: policies (prevent misconfigurations), cost limits (budget per team), security (scanning, policies). Example: developer → clicks 'Create environment' → automated (provisions infra, deploy app, setup monitoring) → dev owns it. Best practice: documentation (self-service docs), support (Slack channel), iterate (add capabilities based on requests).

### 856. Service Catalog

Discover and provision resources. Catalog: list of available services (API, database, queue, cache), metadata (owner, docs, dependencies, SLOs). Backstage: software catalog (component, API, system, domain), auto-discovery (annotations in repos). Provision: self-service (request via UI, API), automated (Terraform, Helm), approval workflows (for sensitive resources). Example: developer needs database → searches catalog → finds 'PostgreSQL managed' → clicks provision → database created, credentials in secret. Best practice: rich metadata (docs, runbooks, owner), self-service where possible, track usage (chargeback).

### 857. Platform Engineering Metrics

Measure platform success. DORA: deployment frequency (platform enables daily deploys?), lead time (faster with platform?), MTTR (platform observability helps?), change failure rate (golden paths reduce failures?). Platform-specific: adoption (% teams on platform), self-service rate (% requests self-served vs tickets), developer satisfaction (NPS, quarterly survey), time to production (new service from idea to prod). Costs: infra cost per team, platform team cost. Example: before platform (1 deploy/week, 3 days lead time), after (5 deploys/day, 2 hours lead time). Best practice: baseline before platform, track over time, correlate with business outcomes (features shipped).

### 858. Platform Team Structure

Organize for success. Team: platform engineers (build IDP), product manager (prioritize), SRE (reliability), DevEx engineers (tools). Skills: automation, Kubernetes, CI/CD, developer empathy. Ratio: 1 platform engineer per 10-20 developers. Embedding: some orgs embed platform engineers in product teams (hybrid). Responsibilities: build/maintain platform (IDP, CI/CD, observability), support developers (documentation, Slack), evangelize (onboard teams). Antipattern: platform team as ticket queue (goal is self-service). Best practice: cross-functional team, product mindset, measure success (developer metrics), rotate (platform engineers work on product temporarily, understand pain).

### 859. Infrastructure from Code

Generate infra from app code. Concept: app defines requirements (I need a database), platform generates infra (Terraform, Helm). Tools: Score (workload spec), Radius (app model, generates infra), Nitric (code-first, infers infra). Example: developer writes Score spec (need postgres), platform translates to cloud resources (RDS, credentials, network). Benefits: dev focuses on requirements (not Terraform), platform ensures consistency (standardized infra), portability (same spec, different clouds). Comparison: IaC (explicit infra), Infrastructure from Code (inferred from app needs). Best practice: abstract cloud differences, safe defaults (security, performance), allow overrides (advanced users).

### 860. Developer Experience (DevEx)

Optimize dev productivity. Dimensions: cognitive load (how much must dev know?), feedback loops (how fast see results?), flow state (interruptions?). Improvements: fast CI/CD (< 10 min), local dev (matches prod), documentation (searchable, up-to-date), self-service (no waiting), good defaults (golden paths). Measurement: SPACE framework (Satisfaction, Performance, Activity, Communication, Efficiency), surveys. Example: improve CI/CD from 30 min to 5 min → developer feedback 'can iterate faster', deploy frequency increases. Best practice: measure regularly (quarterly DevEx survey), prioritize top pain points, involve developers (user research).

### 861. Platform Documentation

Enable self-service. Content: getting started (onboard new team), how-to guides (common tasks), reference (API docs, CLI), architecture (how platform works), runbooks (troubleshooting). Organization: docs-as-code (Markdown in Git), searchable (Backstage TechDocs, Docusaurus), versioned. Quality: up-to-date (docs + code in same PR), examples (code snippets), screenshots, videos. Best practice: start with getting started (onboard quickly), search analytics (what do users search for?), feedback mechanism (thumbs up/down, suggest edits), docs champion (each feature owner writes docs).

### 862. Platform API Design

Consistent interfaces. REST APIs: platform services expose APIs (create environment, deploy app, get logs), consistent (same patterns across services), documented (OpenAPI/Swagger), versioned (v1, v2, deprecation). CLI: platform CLI (backstage-cli, humanitec CLI), commands (deploy, logs, scale), scriptable (CI/CD friendly). SDKs: language-specific (Python, Go, JavaScript), generated from OpenAPI. Example: `platform deploy --app myapp --env prod`, translates to API call. Best practice: consistency (verbs, naming), good defaults (minimal required params), error messages (actionable), rate limiting (prevent abuse).

### 863. Template Lifecycle

Manage golden paths. Creation: team needs (common patterns), security review (built-in best practices), documentation (how to use). Versioning: template v1, v2 (improvements), deprecation (sunset old versions). Update: templates evolve (new best practices), propagate updates (how to update existing services?). Challenges: template drift (services diverge from template), breaking changes (how to migrate?). Example: 'Python API' template v1 (Flask) → v2 (FastAPI + improved security) → notify teams (migrate guide). Best practice: semantic versioning, changelog, migration guides, allow customization (don't force updates).

### 864. Backstage Architecture

Platform built on Backstage. Core: frontend (React), backend (Node.js), database (Postgres), catalog (software catalog, YAML). Plugins: extend functionality (Kubernetes, CI/CD, cloud, custom), frontend + backend. Deployment: Kubernetes (Helm chart), Docker Compose (dev). Catalog: auto-discovery (annotations in repos, GitHub/GitLab integration), entities (Component, API, Resource, System, Domain). Example: developer views service in Backstage → sees (docs, dependencies, CI/CD status, cloud resources, incidents). Best practice: start with catalog (discoverability), add plugins incrementally (CI/CD, cloud, observability), customize (org-specific needs).

### 865. Backstage Software Templates

Scaffolding for new services. Template: cookiecutter-style (placeholders), steps (fetch template, generate files, publish repo, register in catalog). Example: 'Python Microservice' → inputs (name, description, owner) → generates (repo with code, CI/CD, Helm chart, docs) → registers in catalog. Customization: parameters (dropdown, text, boolean), conditionals (if language == Python, add Flask), custom actions (call APIs, create cloud resources). Example: template creates (GitHub repo, Kubernetes namespace, ArgoCD app, Datadog dashboard). Best practice: golden path templates (best practices), test templates (automated tests), evolve (feedback from users).

### 866. Platform Adoption Strategy

Onboard teams to platform. Phases: pilot (one team, iterate), early adopters (2-3 teams, gather feedback), general availability (all teams, support at scale). Incentives: mandates (all new services on platform), carrots (platform is easier, faster), support (office hours, docs, Slack). Metrics: adoption rate (% teams), satisfaction (surveys), support tickets (decreasing over time). Challenges: resistance (teams prefer current tools), migration (existing services), skill gaps (training). Example: pilot team (6 weeks) → feedback ('slow CI/CD') → improve → early adopters (3 months) → GA. Best practice: start with greenfield (new services), make platform better than alternatives, celebrate wins (case studies).

### Category 52: Platform Engineering II: Backstage (15 concepts)

### 867. Backstage Catalog Entities

Organize software. Entity types: Component (service, library, website), API (backend interface), Resource (database, S3 bucket), System (collection of components), Domain (business area), Group (team), User (person). Relationships: Component → API (provides), Component → Resource (dependsOn), Component → System (partOf). YAML: catalog-info.yaml in repo (metadata, annotations, links). Example: 'payment-api' Component → provides 'payment' API → dependsOn 'postgres' Resource → partOf 'checkout' System. Best practice: granular entities (one per microservice), rich metadata (owner, lifecycle, tags), keep updated (CI/CD syncs).

### 868. Backstage Plugins

Extend functionality. Architecture: frontend plugin (React component, rendered in UI), backend plugin (Express router, serves API). Built-in: Kubernetes (view pods, logs), GitHub (PRs, actions), Catalog (core). Community: CI/CD (CircleCI, GitLab), cloud (AWS, GCP, Azure), observability (Datadog, Prometheus). Custom: org-specific integrations (internal APIs, tools). Example: Kubernetes plugin → shows deployment status, pod health, logs → dev troubleshoots without kubectl. Installation: add to packages (frontend, backend), configure (credentials, endpoints). Best practice: leverage community plugins (don't rebuild), contribute back (share custom plugins), secure (handle credentials safely).

### 869. Backstage TechDocs

Docs-as-code platform. Concept: docs in repo (MkDocs, Markdown), Backstage renders (built in CI/CD, stored S3/GCS). Features: search (across all docs), versioning (docs match code version), auto-discovery (docs linked to entities). Workflow: developer writes docs (docs/ folder, mkdocs.yml), CI/CD builds (mkdocs build), pushes to storage, Backstage serves. Example: service 'payment-api' → TechDocs (getting started, API reference, runbooks) → searchable in Backstage. Benefits: discoverability (one place for all docs), freshness (docs alongside code), version sync (docs match service version). Best practice: enforce docs (required for new services), templates (starter docs in scaffolder), search analytics (what's missing).

### 870. Backstage Scorecards

Measure engineering standards. Concept: define checks (has CI/CD, has tests, has docs, uses approved libraries), score entities (0-100%), track over time. Rules: required (must have), recommended (nice to have), custom (org-specific). Example: 'payment-api' → CI/CD ✓, Tests ✓, Docs ✗ (missing runbook) → score 66%. Dashboard: lowest scores (prioritize improvements), trends (improving or declining?). Use case: engineering excellence, platform adoption (using golden paths?), compliance (all services scanned?). Best practice: start with few checks (don't overwhelm), gamify (leaderboard), tie to goals (OKRs), no punishment (encourage improvement).

### 871. Backstage Search

Unified search across platform. Indexing: catalog entities, TechDocs, custom (index APIs, cloud resources). Search backend: Elasticsearch, Postgres (simpler), Lunr (in-memory). Ranking: relevance (keyword match), entity type boost (Components > Resources), filters (by owner, domain, tag). Example: search 'payment' → finds (payment-api Component, payment API, payment-service docs, payment-related tickets). Integrations: search external (Confluence, Jira, Slack), results in Backstage. Best practice: rich metadata (searchable fields), synonym dictionary (API = service), analytics (what users search, improve discoverability).

### 872. Backstage Security

Secure internal platform. Auth: sign-in resolvers (GitHub, Google, Okta, custom), token-based (JWT). RBAC: permissions (catalog read, template use, plugin access), policies (can user delete entity?), plugins enforce (backend checks permissions). Network: internal only (VPN, ingress restricted), TLS (HTTPS). Secrets: backend config (env vars, secrets manager), plugin credentials (secure storage). Example: developer (authenticated via Okta) → views catalog (allowed), tries to delete entity (denied, only admins). Best practice: least privilege (default deny), audit logs (track actions), secure backend (credentials in secrets manager), regular updates (Backstage releases).

### 873. Backstage Integrations

Connect to external systems. GitHub/GitLab: catalog discovery (scan orgs for catalog-info.yaml), actions (trigger workflows), pull requests (show status). CI/CD: Jenkins, CircleCI, GitHub Actions (show pipeline status, trigger builds). Cloud: AWS, GCP, Azure (show resources, costs, security findings). Observability: Datadog, Prometheus, PagerDuty (show metrics, incidents, on-call). Ticketing: Jira, ServiceNow (create tickets, link to entities). Example: view 'payment-api' in Backstage → tabs (overview, CI/CD, K8s, cloud resources, incidents, docs). Best practice: centralize data (Backstage as portal), context (link to entity), actionable (trigger actions from Backstage).

### 874. Backstage Adoption Metrics

Track platform usage. Metrics: daily active users (developers logging in), entity growth (services registered), template usage (new services from templates), plugin usage (which plugins popular?), search queries (what users look for?). Surveys: NPS (would you recommend?), satisfaction (how helpful?), pain points (open-ended). Example: 100 developers, 50 daily active (50% adoption), 200 entities (growing 10/week), 80% new services from templates. Dashboard: Grafana (metrics over time), alerts (adoption drops). Best practice: baseline at launch, track trends (improving?), correlation (adoption → productivity?), act on feedback (prioritize based on pain points).

### 875. Backstage for Platform Teams

Operational excellence. Monitoring: Backstage health (uptime, error rate, latency), plugin errors (logs, traces), catalog sync (how often, success rate). Scaling: horizontal (multiple backend replicas), caching (Redis for catalog), database (Postgres HA). Backup: database backups (Postgres), config (Git-backed). Upgrades: Backstage releases (quarterly major, monthly minor), test in staging, communicate breaking changes. Support: Slack channel (#backstage-help), office hours (weekly), docs (FAQ, troubleshooting). Best practice: treat Backstage as product (SLOs, incident response), automate ops (CI/CD for Backstage itself), dogfood (platform team uses Backstage).

### 876. Service Catalogs Comparison

Backstage vs alternatives. Backstage: open source (Spotify), extensible (plugins), opinionated (software catalog), community. Port: commercial, asset catalog (beyond software), automation. OpsLevel: service maturity (scorecards), service catalog. ServiceNow: ITIL/ITSM, CMDB, heavyweight. Compass (Atlassian): integrated with Jira/Confluence, newer. Use cases: Backstage (developer portal, extensible), Port (asset management), OpsLevel (maturity tracking), ServiceNow (enterprise ITSM), Compass (Atlassian shops). Best practice: choose based on needs (developer experience → Backstage, asset management → Port), evaluate (pilot, gather feedback), integrate (APIs, avoid vendor lock-in).

### 877. Platform Portal vs Service Mesh

Different layers. Portal (Backstage): developer interface, discoverability (what services exist?), self-service (deploy, manage), documentation (how to use?), visibility (ownership, status). Service mesh (Istio): runtime networking, traffic management (routing, retries), security (mTLS, authz), observability (metrics, traces). Overlap: both show service topology (dependencies), but different contexts (portal = static catalog, mesh = runtime traffic). Example: Backstage shows 'payment-api depends on postgres', Istio shows 'payment-api called checkout-api 1000 times, 99.9% success'. Best practice: use both (portal for developers, mesh for runtime), integrate (Backstage Kubernetes plugin shows mesh data).

### 878. Developer Portals Best Practices

Build successful IDP. Content: service catalog (complete, up-to-date), golden paths (common use cases), docs (searchable, versioned), self-service (no tickets). UX: intuitive (don't require training), fast (< 2s page load), mobile-friendly (on-call access). Adoption: greenfield first (new services), make better than current (easier, faster), support (help teams migrate), metrics (track adoption). Culture: platform as product (treat devs as customers), feedback loops (surveys, interviews), iterate (continuous improvement). Governance: standards (what should be in catalog?), policies (required metadata), exceptions (documented). Best practice: start small (catalog only), expand (add capabilities based on feedback), measure (adoption, satisfaction), leadership support (mandate or incentivize).

### 879. Platform Engineering Career Path

Grow platform engineers. Skills: systems thinking (how pieces fit), automation (scripting, IaC), empathy (developer needs), product sense (prioritization). Levels: junior (build features), mid (design solutions), senior (architecture, strategy), staff (org-wide impact). Career: IC track (principal engineer, distinguish technical work), management track (EM, director). Growth: mentorship (pair programming), projects (end-to-end ownership), cross-functional (work with product teams). Challenges: balance (build vs support), complexity (distributed systems), pace (innovation vs stability). Best practice: invest in learning (conferences, courses), internal knowledge sharing (tech talks), rotations (work on product team temporarily, understand pain).

### 880. Platform as Code

Infrastructure and platform as code. Everything in Git: Backstage config (app-config.yaml), catalog (YAML), templates (scaffolding), plugins (custom code), infrastructure (Terraform for platform infra). Benefits: version control (audit trail, rollback), review (PR for platform changes), automation (CI/CD for platform), reproducibility (disaster recovery, multi-environment). Example: update Backstage config → PR → review → merge → CI/CD applies → Backstage reloads. Best practice: GitOps (Git as source of truth), automated testing (validate config before merge), secrets externalized (not in Git), documentation (README per component).

### 881. Internal Tool Sprawl

Consolidate around platform. Problem: many tools (CI/CD, docs, catalog, cloud console, monitoring), context switching (cognitive load), duplication (multiple sources of truth). Solution: platform portal (Backstage centralizes), standard golden paths (reduce custom tools), plugin ecosystem (extend platform). Example: before (10 tools: GitHub, Jenkins, Confluence, Datadog, AWS Console, Jira, Slack, PagerDuty, Vault, Wiki), after (Backstage aggregates data, one interface). Trade-offs: not all tools integrate (custom plugins needed), learning curve (new platform). Best practice: start with high-value integrations (CI/CD, docs, catalog), measure (time saved from context switching), sunset redundant tools (migrate users).

### Category 53: Developer Experience & Tooling (15 concepts)

### 882. IDE Integration

Enhance developer workflow. Features: code completion (LSP), debugging (DAP), linting (inline errors), testing (run tests in IDE), Git integration (commit, PR, code review), cloud extensions (AWS Toolkit, Azure Extension). IDEs: VS Code (popular, extensions), JetBrains (powerful, language-specific), Vim/Neovian (terminal-based). Remote development: SSH (edit on remote server), Docker containers (dev in container, matches prod), GitHub Codespaces (cloud IDEs). Best practice: standardize on IDE (team consistency), recommended extensions (curated list), dotfiles (share config in Git), onboarding docs (setup guide).

### 883. Local Development Environments

Match production locally. Challenges: dependencies (databases, queues, caches), configuration (env vars, secrets), compatibility (OS differences). Solutions: Docker Compose (multi-container), Tilt (K8s locally), devcontainers (IDE in container), Skaffold (continuous deploy to K8s). Example: docker-compose.yml (app, postgres, redis) → `docker-compose up` → local environment ready. Hot reload: code changes reflect immediately (no rebuild). Best practice: document setup (README), automate (one command to start), parity with prod (same versions, avoid 'works on my machine').

### 884. CI/CD for Developers

Fast feedback loops. Speed: < 10 min (ideal), parallelize tests (unit, integration, E2E), incremental builds (cache dependencies), matrix testing (multiple versions). Feedback: PR checks (status visible in GitHub/GitLab), notifications (Slack on failure), clear errors (actionable messages). Developer access: view logs (CloudWatch, Grafana), re-run pipelines (fix flakiness), debug (SSH into CI if needed). Best practice: fail fast (run fast tests first), flakiness (quarantine or fix flaky tests), self-service (dev can trigger, view logs), observability (pipeline metrics, bottlenecks).

### 885. Developer Onboarding

Get productive quickly. Day 1: laptop setup (automated, script or Ansible), accounts (GitHub, Slack, cloud, tools), codebase tour (architecture, key repos). Week 1: first commit (fix typo, small bug), mentor assigned (buddy), team intro (meet team). Month 1: ship feature (end-to-end), on-call shadow (learn incident response), feedback (what was hard?). Metrics: time to first PR, time to first deploy, onboarding satisfaction (survey). Best practice: automate setup (one script), documentation (comprehensive, searchable), buddy system (pair with senior), starter tasks (good first issues).

### 886. Code Review Best Practices

Effective collaboration. Size: small PRs (< 400 lines, easier to review), single concern (one feature/fix per PR), well-described (context, why, screenshots). Review: timely (< 24 hours), constructive (suggest, don't demand), nitpicks (mark as optional), test (does it work?). Author: self-review first (catch mistakes), respond to feedback (don't be defensive), tests included (CI passes). Tools: GitHub/GitLab (inline comments), automated checks (linting, tests, coverage), code owners (auto-assign reviewers). Best practice: define standards (style guide, review checklist), culture (everyone reviews, not just seniors), automate (linting, formatting, bots handle simple issues).

### 887. Developer Productivity Metrics

Measure without micromanaging. SPACE framework: Satisfaction (happiness, surveys), Performance (outcomes, bugs resolved), Activity (commits, PRs, careful with vanity metrics), Communication (collaboration, PR reviews), Efficiency (time to merge, CI duration). Avoid: lines of code (gameable), commits (encourages tiny commits), PRs merged (quantity over quality). Use: DORA metrics (deployment frequency, lead time, MTTR, change failure rate), developer surveys (quarterly, anonymous), qualitative (interviews, pain points). Best practice: focus on outcomes (features shipped, incidents reduced), developer-centric (improve their experience), anonymize (not for individual performance reviews), act on findings (prioritize improvements).

### 888. Developer Tool Selection

Choose the right tools. Criteria: does it solve problem? (avoid shiny object syndrome), ease of use (learning curve), integration (works with existing stack), cost (open source vs commercial), support (community or vendor), future (maintenance, roadmap). Process: research (read docs, trials), pilot (small team tests), feedback (gather from users), decide (champion or discontinue), rollout (train team, migrate). Example: choose CI/CD → evaluate (GitHub Actions, GitLab CI, Jenkins) → pilot GitHub Actions (2 teams, 2 months) → positive feedback → rollout. Best practice: involve users (not top-down decision), trial period (don't commit immediately), document decision (why chose this tool), revisit (annual review, still right tool?).

### 889. Inner Source

Open source practices internally. Practices: open repos (discoverability, anyone can view), contributions welcome (clear CONTRIBUTING.md), code review (transparency), documentation (README, API docs), ownership (CODEOWNERS, maintain quality). Benefits: reduce duplication (reuse components), quality (more eyes on code), collaboration (cross-team), innovation (ideas from anyone). Challenges: quality (not all contributions high-quality, code review burden), ownership (who maintains?), discoverability (how to find reusable code?). Example: team A builds auth library → open sourced internally → team B contributes LDAP support → both teams benefit. Best practice: curate (InnerSource commons, list reusable libraries), incentivize (recognize contributors), maintain (assign owners, SLO for responses).

### 890. Monorepo vs Polyrepo

Repository strategy. Monorepo: one repo for all code (Google, Facebook), pros (easy refactoring across projects, single CI/CD, unified versioning), cons (tooling challenges, large clones, permissions tricky). Polyrepo: one repo per project, pros (independent CI/CD, clear ownership, flexible tech stack), cons (code sharing hard, duplicate CI/CD, dependency management). Hybrid: shared libraries in separate repos, apps in monorepo. Tools: monorepo (Bazel, Nx, Turborepo, Pants), polyrepo (Git submodules, package managers). Best practice: choose based on team size (small = monorepo simpler, large = polyrepo scalable), consistency (monorepo enforces standards), use tooling (don't DIY monorepo management).

### 891. Trunk-Based Development Deep Dive

Continuous integration strategy. Concept: main branch always deployable, short-lived branches (< 1 day), merge frequently (multiple times per day), feature flags (hide incomplete work). Benefits: reduce merge conflicts, faster integration, enables continuous deployment. Branch strategy: main (protected, deployable), feature branches (branch off main, merge back same day), no long-lived branches (no develop, release branches). CI: run on every commit (main and branches), tests must pass before merge. Example: developer → branch from main → commits (3 times) → PR → CI passes → merge to main (same day). Best practice: small commits (easier to review), feature flags (decouple deploy from release), protect main (required reviews, passing tests).

### 892. Engineering Metrics Dashboard

Visualize team health. Metrics: DORA (deployment frequency, lead time, MTTR, change failure rate), quality (bug rate, incident rate, P0/P1 count), productivity (PR cycle time, code review time), system health (error rate, latency, saturation). Dashboard: Grafana, Datadog, custom (Backstage plugin). Granularity: team-level (not individual, avoid misuse), trend (week-over-week, month-over-month), targets (SLOs, not hard targets). Example: deployment frequency (10/day, green), lead time (4 hours, green), change failure rate (12%, yellow). Use case: identify trends (lead time increasing, investigate), celebrate wins (reduced MTTR), retrospectives (metrics-informed discussions). Best practice: contextualize (explain metrics, not just numbers), actionable (if metric red, what to do?), review regularly (weekly team review), don't punish (metrics for improvement, not blame).

### 893. Developer Advocate Role

Bridge between developers and platform. Responsibilities: evangelism (promote platform, internal talks), feedback (gather pain points, prioritize), content (docs, tutorials, blog posts), support (Slack, office hours, troubleshooting), training (onboarding, workshops). Skills: technical (understands dev needs), communication (write, speak, teach), empathy (developer frustrations), product (prioritization). Success metrics: adoption (teams using platform), satisfaction (NPS from developers), engagement (Slack activity, docs views), content (blog post views, talk attendance). Example: developer advocate notices common question (how to deploy?) → writes tutorial → Slack post → reduces support burden. Best practice: embedded (work closely with platform team), accessible (open door policy), data-driven (track pain points, measure impact), credible (technical expertise, not just marketing).

### 894. Tech Debt Management

Balance speed and quality. Definition: shortcut taken (to ship faster), creates future work (refactor, fix). Types: code (quick hacks, copy-paste), architecture (monolith, should be microservices), tests (low coverage), docs (outdated). Tracking: tickets (Jira, 'tech debt' label), scorecards (Backstage, debt score), time (reserve 20% sprint capacity). Prioritization: high impact + low effort (quick wins), blocks new features (unblocks team), security/performance (critical). Paydown: dedicated sprints (quarterly cleanup), reserve capacity (every sprint), as you go (boy scout rule, leave better than found). Best practice: track (make visible), prioritize (ruthlessly, not all debt is equal), prevent (avoid creating, good practices), communicate (educate team, debt is inevitable).

### 895. Developer Surveys

Gather feedback. Frequency: quarterly (not too often, survey fatigue), post-incident (specific pain point), annual (comprehensive). Questions: satisfaction (NPS, 1-10), pain points (open-ended, 'what frustrates you?'), priorities (rank feature requests), tools (which tools helpful?). Anonymous: honest feedback (no fear of retribution), aggregate results (not individual tracking). Analysis: quantitative (calculate NPS, trend over time), qualitative (themes from open-ended), action plan (top 3 improvements). Example: Q1 survey → NPS 40 (okay), top pain 'slow CI/CD' (30% mention) → prioritize → Q2 NPS 60 (improved). Best practice: act on feedback (share results, action plan, report progress), keep short (10 questions, < 5 min), incentivize (raffle, recognize participation), close loop (communicate what changed).

### 896. Developer Community Building

Foster collaboration. Activities: guilds (interest groups, frontend guild, security guild), tech talks (weekly, teams share), hackathons (quarterly, innovation), mentorship (junior/senior pairing), open source (encourage contributions). Communication: Slack channels (#engineering, #platform-help), wiki (Confluence, internal blog), newsletter (engineering updates). Recognition: shoutouts (weekly kudos), awards (engineer of the month), case studies (highlight wins). Best practice: leadership support (budget, time), grassroots (developer-led, not top-down), inclusive (everyone welcome), measure (engagement, satisfaction), sustain (rotate organizers, avoid burnout).

### Category 54: FinOps & Cost Optimization (15 concepts)

### 897. FinOps Principles

Financial accountability for cloud. Definition: cloud financial management, collaboration (finance, engineering, business). Principles: everyone owns cost (not just finance team), decisions driven by business value (cost vs benefit), take advantage of cloud (variable model, not fixed), centralized team (FinOps team, enable teams). Phases: Inform (visibility, what am I spending?), Optimize (reduce waste, right-size), Operate (continuous, feedback loops). Best practice: executive sponsorship (C-level support), cross-functional (finance + engineering + product), cultural shift (cost as metric, not afterthought), iterate (small wins, build momentum).

### 898. Cloud Cost Visibility

Know where money goes. Tagging: tag resources (cost center, team, env, app), enforce (policies, all resources tagged), consistent (naming convention, lowercase, no spaces). Cost allocation: showback (report cost per team, no chargeback), chargeback (teams pay for resources), shared costs (allocate by usage, per team). Dashboards: cloud-native (AWS Cost Explorer, Azure Cost Management, GCP Billing), third-party (CloudHealth, Datadog, Grafana). Granularity: daily (trends), resource-level (which EC2, S3 bucket), team-level (accountability). Example: tag all resources with 'team:platform' → report shows platform team costs $10k/month → identify top costs (RDS $4k, EC2 $3k). Best practice: enforce tagging (policies), automate (tag at creation), dashboards (accessible to all), education (teach teams to read dashboards).

### 899. Cloud Cost Anomaly Detection

Catch unexpected spending. Anomalies: unusual spend (spike or trend change), threshold alerts (> $X per day), budget alerts (80% of monthly budget). Tools: AWS Cost Anomaly Detection (ML-based), Azure Cost Alerts, GCP Budget Alerts, third-party (CloudHealth anomaly detection). Investigation: what changed? (new resources, scaling event, pricing change), who? (team, tagged resource), action (rightsize, delete, approve if intentional). Example: anomaly detected (EC2 cost $5k, usually $1k) → investigate (someone left 10 instances running) → terminate → $4k saved. Best practice: baseline costs (normal spend), ML anomalies (auto-detect), Slack alerts (notify immediately), runbooks (investigate playbook).

### 900. Cloud Rightsizing

Match resources to workload. Over-provisioned: paying for unused (CPU 10%, memory 20%), waste. Under-provisioned: performance issues (CPU 90%, throttling). Analysis: monitor metrics (CPU, memory, network, disk, 2-4 weeks), utilization patterns (peak vs avg). Recommendations: downsize (t3.large → t3.medium, save 50%), upsize (if bottlenecked), instance families (compute-optimized, memory-optimized, general-purpose). Tools: AWS Compute Optimizer, Azure Advisor, GCP Recommender, Datadog rightsizing. Implementation: test (stage environment first), gradual (blue-green, rollback if issues), repeat (quarterly review). Example: RDS db.m5.xlarge (20% CPU) → db.m5.large (40% CPU, $100/month savings). Best practice: monitor first (2-4 weeks data), test (verify performance), automate (scripts, IaC updates), repeat (continuous optimization).

### 901. Reserved Instances & Savings Plans

Commit for discounts. Reserved Instances (RI): commit 1-3 years, up to 72% savings, upfront (all/partial/none), specific instance type or flexible. Savings Plans: commit $/hour (1-3 years), up to 72% savings, flexible (any instance in family, region), compute or EC2. Strategy: analyze usage (stable workload → RI/SP, variable → on-demand/spot), coverage (aim 70-80%), blend (RI for base, on-demand for spikes). Monitoring: utilization (using reserved capacity?), coverage (% of spend covered), expiration (renew or let lapse?). Example: run 10 t3.large 24/7 → $730/month on-demand → $250/month with 3-year RI (66% savings). Best practice: start conservative (don't over-commit), analyze (6 months usage), blend (RI + Spot + on-demand), review (quarterly, adjust).

### 902. Spot Instances for Cost Savings

Use spare capacity. Spot: up to 90% discount, can be reclaimed (2-min warning), not for stateful. Use cases: batch jobs (Spark, data processing), CI/CD (ephemeral runners), dev/test (non-critical), stateless web (ASG with mixed on-demand + spot). Strategies: diversify (multiple instance types, AZs), fallback (on-demand if no spot), spot fleets (request multiple types), interruption handling (checkpointing, graceful shutdown). Example: CI/CD runners → spot instances (5 nodes, save $500/month), occasional interruption (job retries). Best practice: handle interruptions (listen to termination notice, save state), diversify (reduce interruption chance), blend (spot + on-demand for availability), not for critical (databases, long-running stateful).

### 903. S3 Cost Optimization

Optimize storage. Storage classes: Standard (frequent access, expensive), Intelligent-Tiering (auto-move between frequent/infrequent), Infrequent Access (IA, monthly access, cheaper), Glacier (archive, minutes to hours retrieval), Deep Archive (rarely accessed, 12h retrieval). Lifecycle policies: transition (Standard → IA after 30 days → Glacier after 90 days), expire (delete after 365 days). Versioning: keep old versions (costs add up), lifecycle old versions. Incomplete uploads: clean up multipart uploads (cost without benefit). Analytics: S3 Storage Lens (analyze usage, access patterns), identify (unused buckets, old data). Example: logs bucket (Standard, 1TB, $23/month) → lifecycle to Glacier after 30 days ($4/month after 30 days). Best practice: lifecycle policies (automate transitions), delete unused (audit buckets), Intelligent-Tiering (if unsure), monitor (Storage Lens).

### 904. Database Cost Optimization

Reduce DB spend. Rightsizing: too large (CPU/memory low, downsize), too small (bottleneck, upsize). Reserved capacity: RDS RI (1-3 years, up to 60% savings), Redshift RI, DynamoDB reserved (predictable throughput). Serverless: Aurora Serverless (scale to zero, pay per use), DynamoDB on-demand (no provisioned capacity). Storage optimization: compress data (smaller size), archive old data (S3 Glacier, cheaper than DB), delete unused (temp tables, test data). Read replicas: offload reads (cache, read replicas), cheaper than scaling writer. Example: RDS db.m5.2xlarge (30% CPU, $500/month) → db.m5.xlarge (60% CPU, $250/month). Best practice: monitor (CPU, connections, IOPS), reserved for stable (production DBs), serverless for variable (dev, staging), compress/archive (old data).

### 905. Network Cost Optimization

Reduce data transfer. Charges: out to internet (expensive, $0.09/GB), cross-region (moderate, $0.02/GB), cross-AZ (cheap, $0.01/GB), within AZ (free), VPC peering (cheaper than internet gateway). Optimization: CDN (CloudFront caches, reduces origin traffic), S3 Transfer Acceleration (optimized path, costs more but faster), region placement (users in US → US region, avoid cross-region), VPC endpoints (S3/DynamoDB access without internet gateway, free), compression (gzip responses, smaller transfer). Monitoring: Cost Explorer (data transfer costs), VPC Flow Logs (top talkers). Example: API serves 1TB/month → add CloudFront (caches 90%, origin traffic 100GB, save $81/month). Best practice: CDN for static/cacheable (images, videos, API responses), VPC endpoints for AWS services (S3, DynamoDB), compress (gzip), monitor (identify high-traffic sources).

### 906. Auto-Scaling for Cost Efficiency

Scale with demand. Horizontal: add/remove instances (scale out/in), elastic (pay for what you use), handle spikes. Vertical: bigger/smaller instances (scale up/down), requires restart (brief downtime), simpler for stateful. Policies: target tracking (maintain 50% CPU), step scaling (add 2 instances if CPU > 70%, add 5 if > 90%), scheduled (scale up at 8am, down at 6pm), predictive (ML forecasts demand). Metrics: custom (queue depth, request count, latency). Example: web app (baseline 5 instances, peak 20 instances) → auto-scale saves vs fixed 20 instances (75% cost reduction during off-peak). Best practice: start conservative (scale gradually), cooldown periods (avoid flapping), test (load test, verify scaling), right metrics (business metrics, not just CPU).

### 907. Container Cost Optimization

Efficient containerized workloads. Rightsizing: set requests/limits (CPU, memory), avoid over-provisioning (wastes cluster capacity), tools (VPA, Goldilocks). Bin packing: pack pods efficiently (resource requests guide scheduler), node types (mix of CPU/memory-optimized), consolidate (fewer larger nodes vs many small nodes). Spot: use for fault-tolerant (batch, stateless), node pools (mix on-demand + spot). Cluster autoscaler: scale nodes with demand, scale-down (remove empty nodes). Example: 100 pods (request 0.5 CPU, 1Gi memory) → overprovisioned (use 0.3 CPU) → right-size (request 0.3 CPU, save 40%). Best practice: set resource requests (accurate), enable autoscaler (cluster, HPA), use spot (where appropriate), monitor (Kubecost, track pod costs).

### 908. FinOps Team Structure

Organize cloud financial management. Team: FinOps lead (strategy, executive reporting), cloud finance analyst (cost analysis, reporting), engineers (automation, optimization tools), embedded (engineers in product teams, cost-aware). Responsibilities: visibility (dashboards, tagging), optimization (recommendations, execute), governance (policies, budgets), culture (education, cost-awareness). Ratio: 1 FinOps person per $10M cloud spend (approximate). Collaboration: regular meetings (finance, engineering, product), cost reviews (quarterly business reviews), action plans (top savings opportunities). Best practice: cross-functional (not just finance), engineering-heavy (automation, tools), embed (FinOps practices in teams), measure (cost savings, team engagement).

### 909. Cloud Cost Forecasting

Predict future spending. Methods: trend analysis (historical spend, extrapolate), driver-based (users, transactions predict infrastructure), budget (top-down, allocated to teams). Tools: spreadsheets (manual), cloud-native (AWS Cost Explorer forecast, GCP billing forecast), third-party (CloudHealth, Cloudability). Inputs: growth plans (marketing campaigns, new features), pricing changes (AWS announces price drop), efficiency (optimization initiatives). Output: monthly forecast (next 12 months), confidence intervals (best/worst case), variance analysis (actual vs forecast). Example: current $10k/month, 10% monthly growth, optimize 5% → forecast $12k/month in 6 months (without optimization $13k). Best practice: update monthly (re-forecast), driver-based (tie to business metrics), review accuracy (improve model), communicate (finance and business stakeholders).

### 910. Cost Allocation Tags

Track spending by dimension. Tagging strategy: required tags (team, env, app, cost-center), optional (owner, project), consistent (naming, lowercase, automation). Enforcement: policies (deny untagged resources, AWS Tag Policies, Azure Policy), automation (Lambda tags on creation, default tags in Terraform). Reporting: cost by team (showback/chargeback), cost by env (prod vs dev, optimize dev), cost by app (which apps expensive?). Shared costs: allocate proportionally (shared VPC, per team usage), flat split (Load Balancer, equal split), exclude (security scanner, not allocated). Example: EC2 tagged 'team:platform, env:prod, app:backstage' → cost report shows platform team prod Backstage costs. Best practice: define strategy (document), enforce (policies), automate (IaC tags resources), review (quarterly audit, fix untagged).

### 911. FinOps KPIs

Measure financial efficiency. Metrics: cost per customer (revenue / cost), cost per transaction (API call, order), unit economics (gross margin including infra cost), cost as % of revenue (target 20-30% for SaaS), waste (unused resources, unattached volumes). Trends: month-over-month change (growing?), year-over-year (seasonality), cost vs usage (linearly scaling?). Savings: realized savings (from optimizations), potential savings (recommendations not implemented). Efficiency: RI/SP coverage (70-80% target), spot usage (% of compute on spot). Best practice: business-aligned metrics (not just absolute cost), trend (track over time), target (set goals, cost per customer < $X), report (exec dashboards, quarterly).

### Category 55: Linux Advanced: systemd & Performance (18 concepts)

### 912. systemd Unit Types

**Service units (`.service`):** daemons, background processes, most common, manage with `systemctl`.

**Timer units (`.timer`):** scheduled tasks, replaces cron, paired with service units.

**Target units (`.target`):** group units, synchronization points, like runlevels, `multi-user.target`, `graphical.target`.

**Socket units (`.socket`):** IPC sockets, socket activation (start service on connection).

**Mount units (`.mount`):** mount points, auto-generated from `/etc/fstab`, can create manually.

**Device units (`.device`):** devices in `/dev`, auto-generated by udev.

**Path units (`.path`):** file/directory watchers, activate service on file changes.

**Slice units (`.slice`):** resource management hierarchy (cgroups), organize units.

**Swap units (`.swap`):** swap files/partitions, auto-generated from `/etc/fstab`.

**Scope units (`.scope`):** externally created processes (e.g., user sessions).

**List:** `systemctl list-units --type=service`, `systemctl list-unit-files`.

---

### 913. systemd Service Unit File Structure

**Location:** `/etc/systemd/system/` (custom, override), `/lib/systemd/system/` or `/usr/lib/systemd/system/` (package-provided).

**Override:** `systemctl edit service.service` (creates override in `/etc/systemd/system/service.service.d/`), or `systemctl edit --full service.service` (edits full copy in `/etc/systemd/system/`).

**Structure:**
```ini
[Unit]
Description=My Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/myservice
Restart=always
User=myuser

[Install]
WantedBy=multi-user.target
```

**[Unit] section:** `Description`, `Documentation`, `After` (start after these units), `Before`, `Requires` (hard dependency, fails if dependency fails), `Wants` (soft dependency), `Conflicts`.

**[Service] section:** service-specific, see next concept.

**[Install] section:** `WantedBy` (enable in which target), `RequiredBy`, `Also` (enable these units too).

**Reload:** `systemctl daemon-reload` after editing unit files (reads new config).

---

### 914. systemd Service Types

**Type=simple:** default, `ExecStart` process is main, systemd considers started immediately, most common.

**Type=forking:** service forks (daemonizes), parent exits, child continues, must set `PIDFile`, older daemons use this.

**Type=oneshot:** process exits after start, service considered active after exit, use with `RemainAfterExit=yes` (stays active), good for one-time setup tasks.

**Type=notify:** service sends readiness notification via `sd_notify()`, systemd waits for signal, use for services that need initialization time.

**Type=dbus:** service acquires D-Bus name, systemd waits for name on bus.

**Type=idle:** delays execution until all jobs dispatched, last to start, avoids console output clutter during boot.

**Choose:** `simple` for most, `forking` for traditional daemons, `oneshot` for scripts, `notify` for aware services.

---

### 915. systemd Service Restart Policies

**Restart=:** controls when service restarts after exit.

**no:** default, never restart (except manual `systemctl restart`).

**on-success:** restart only if exits cleanly (exit code 0).

**on-failure:** restart only if fails (non-zero exit, signal, timeout).

**on-abnormal:** restart on signal, timeout, watchdog (not clean exit).

**on-abort:** restart only on unclean signal (SIGILL, etc).

**on-watchdog:** restart on watchdog timeout.

**always:** always restart (regardless of exit status).

**RestartSec=:** delay before restart, default 100ms, `RestartSec=5s`.

**StartLimitBurst=:** max restarts in interval, default 5.

**StartLimitIntervalSec=:** interval for burst, default 10s, if exceeded, service enters failed state.

**Use:** `Restart=always` for critical services, `Restart=on-failure` for most, combined with `RestartSec` to avoid tight restart loops.

---

### 916. systemd Resource Limits

**Cgroups:** control groups, limit CPU, memory, I/O, systemd creates cgroup hierarchy.

**CPUQuota=:** CPU percentage, `CPUQuota=50%` (max 50% of one core), `200%` (max 2 cores).

**MemoryMax=:** hard memory limit, `MemoryMax=1G`, OOM killer if exceeded.

**MemoryHigh=:** soft limit, throttles before reaching, `MemoryHigh=800M`.

**TasksMax=:** max number of tasks (threads, processes), `TasksMax=100`.

**IOWeight=:** I/O priority, 1-10000, default 100, higher = more I/O.

**IOReadBandwidthMax=, IOWriteBandwidthMax=:** limit read/write throughput, `IOWriteBandwidthMax=/dev/sda 10M`.

**Slice=:** assign to cgroup slice, `Slice=user.slice` or custom slice.

**View:** `systemctl status service` shows cgroup, `systemd-cgtop` (like top for cgroups).

**Use cases:** prevent runaway processes, multi-tenancy, guaranteed resources for critical services.

---

### 917. systemd Dependencies

**After=:** start after these units (ordering only, not dependency).

**Before=:** start before these units.

**Requires=:** hard dependency, if dependency fails, this unit fails, starts dependency if not running.

**Wants=:** soft dependency, starts dependency if possible, but doesn't fail if dependency fails.

**Requisite=:** must be running before start, doesn't start dependency, fails if not running.

**BindsTo=:** like Requires but also stops when dependency stops.

**PartOf=:** stops/restarts with dependency, opposite of BindsTo.

**Conflicts=:** cannot run with these units, stops them when started.

**OnFailure=:** start these units if this unit fails, e.g., alert service.

**Example:** web app Requires database, After network, Wants logging service.

**Ordering vs dependency:** `After` doesn't start dependency, `Requires` starts but doesn't order, use both.

---

### 918. systemd Timers vs Cron

**Advantages over cron:**
- Integrated with systemd (same management, logging).
- Flexible scheduling (calendar + monotonic).
- Dependencies (After, Requires).
- Resource limits (CPUQuota, MemoryMax).
- Randomization (RandomizedDelaySec).
- Persistent (run missed executions).
- Logs in journalctl (not separate file).

**Calendar timers:** `OnCalendar=daily`, `OnCalendar=Mon *-*-* 00:00:00`, `OnCalendar=*:0/15` (every 15 min).

**Monotonic timers:** `OnBootSec=10min` (10 min after boot), `OnUnitActiveSec=1h` (1h after last activation), `OnActiveSec=5min` (5 min after timer activated).

**Persistent:** `Persistent=true` (run if missed due to downtime).

**Accuracy:** `AccuracySec=1s` (default 1 min, coalesces timers to save power), set lower for precise timing.

**Create:** `.timer` unit + `.service` unit (same name), enable timer `systemctl enable --now my.timer`.

**List:** `systemctl list-timers`, shows next/last run.

**Migration:** replace cron jobs with timers, better monitoring/logging.

---

### 919. systemd Journal (journalctl)

**Purpose:** centralized logging, captures stdout/stderr, syslog, kernel, systemd events.

**Storage:** `/var/log/journal/` (persistent) or `/run/log/journal/` (volatile, lost on reboot), configure in `/etc/systemd/journald.conf`.

**View all:** `journalctl` (paged), `-r` (reverse, newest first), `-f` (follow, like tail -f), `-n 50` (last 50 lines).

**Filter by unit:** `journalctl -u nginx.service`, `-u nginx -u mysql` (multiple units).

**Time range:** `journalctl --since "2024-01-01"`, `--since "1 hour ago"`, `--until "2024-01-10 10:00"`, `--since today`, `--since yesterday`.

**Priority:** `-p err` (error and above), `-p warning`, `-p info`, `-p debug`, levels 0-7 (emerg, alert, crit, err, warning, notice, info, debug).

**Boot:** `journalctl -b` (current boot), `-b -1` (previous boot), `--list-boots` (show all).

**Kernel:** `journalctl -k` (kernel messages only, like `dmesg`).

**Output format:** `-o json` (JSON), `-o json-pretty`, `-o cat` (no metadata, just message), `-o verbose` (full details).

**Follow specific:** `journalctl -u service -f --since "5 min ago"`.

**Disk usage:** `journalctl --disk-usage`, `journalctl --vacuum-size=100M` (clean to 100MB), `--vacuum-time=2weeks` (keep last 2 weeks).

---

### 920. systemd User Services

**Purpose:** user-level services, run as user (not root), per-user systemd instance.

**Location:** `~/.config/systemd/user/` (user units), `/etc/systemd/user/` (system-wide user units).

**Commands:** `systemctl --user status service`, `systemctl --user enable service`, `--user` flag for user instance.

**Targets:** `default.target` (user default), custom user targets.

**Linger:** `loginctl enable-linger username` (keep user instance running after logout), useful for user services that should persist.

**Example use cases:** personal backup scripts, development servers, user-specific daemons, tmux/screen sessions.

**Environment:** `systemctl --user set-environment VAR=value`, or in service unit `Environment="VAR=value"`.

**Logs:** `journalctl --user -u service`.

---

### 921. systemd Sockets and Activation

**Socket activation:** systemd listens on socket, starts service when connection arrives, lazy loading.

**Benefits:** faster boot (don't start all services), parallel startup (start listening early), services can crash and restart on demand.

**Create `.socket` unit:**
```ini
[Unit]
Description=My Socket

[Socket]
ListenStream=8080

[Install]
WantedBy=sockets.target
```

**Paired `.service` unit:** same name, started by systemd when connection on socket.

**Socket types:** `ListenStream` (TCP), `ListenDatagram` (UDP), `ListenFIFO` (named pipe).

**Example:** OpenSSH uses socket activation, `sshd.socket` listens, `sshd.service` starts on connection.

**View:** `systemctl list-sockets`, shows listening sockets.

---

### 922. systemd Path Units

**Purpose:** monitor files/directories, activate service on changes.

**Path types:** `PathExists=` (path exists), `PathExistsGlob=` (glob pattern), `PathChanged=` (modification), `PathModified=` (content change), `DirectoryNotEmpty=` (directory has files).

**Create `.path` unit:**
```ini
[Unit]
Description=Watch for config changes

[Path]
PathChanged=/etc/myapp/config.yaml

[Install]
WantedBy=multi-user.target
```

**Paired `.service` unit:** activated when path condition met.

**Use cases:** config reloading, file processing (drop file, service processes), build triggers.

**View:** `systemctl list-units --type=path`.

---

### 923. systemd Mounts and Automount

**Mount units:** `.mount` units, auto-generated from `/etc/fstab`, or create manually.

**Manual mount unit:**
```ini
[Unit]
Description=Mount NFS share

[Mount]
What=server:/share
Where=/mnt/nfs
Type=nfs
Options=defaults

[Install]
WantedBy=multi-user.target
```

**Automount:** `.automount` unit, mount on access (lazy), unmount after idle.

**Automount unit:**
```ini
[Unit]
Description=Automount NFS

[Automount]
Where=/mnt/nfs
TimeoutIdleSec=300

[Install]
WantedBy=multi-user.target
```

**Benefits:** faster boot (don't mount unused filesystems), network shares (mount when available).

**View:** `systemctl list-units --type=mount`, `systemctl list-units --type=automount`.

---

### 924. systemd Troubleshooting

**Service won't start:** `systemctl status service` (shows error), `journalctl -u service` (logs), `systemctl cat service` (view unit file).

**Check syntax:** `systemd-analyze verify service.service` (validates unit file).

**Dependencies:** `systemctl list-dependencies service` (tree), `systemd-analyze dot service | dot -Tsvg > deps.svg` (graphical).

**Boot slow:** `systemd-analyze blame` (time per service), `systemd-analyze critical-chain` (bottleneck).

**Failed units:** `systemctl --failed`, `systemctl reset-failed` (clear failed state).

**Mask unit:** `systemctl mask service` (prevent start, even manually), `systemctl unmask service`.

**Emergency mode:** boot issue, dropped to emergency shell, `journalctl -xb` (boot log), fix issue, `systemctl default` (continue boot).

**Service restarts too fast:** check `StartLimitBurst` and `StartLimitIntervalSec`, increase `RestartSec`.

**Logs not persisting:** check `/var/log/journal/` exists, `Storage=persistent` in `/etc/systemd/journald.conf`.

---

### 925. systemd Best Practices

**Use systemd timers:** instead of cron, better logging, resource limits, dependencies.

**Restart policies:** `Restart=on-failure` for most services, `Restart=always` for critical.

**Resource limits:** set `MemoryMax`, `CPUQuota` to prevent resource exhaustion.

**Dependencies:** use `After` + `Wants` for soft, `After` + `Requires` for hard.

**User services:** for user-specific tasks, not root-level.

**Logging:** ensure services log to stdout/stderr (journald captures), not separate log files (or both).

**Testing:** `systemd-analyze verify`, test in dev environment, check logs after changes.

**Security:** `User=`, `Group=` (run as non-root), `ProtectSystem=`, `PrivateTmp=`, sandboxing options.

**Documentation:** `Description=`, `Documentation=` in unit files, helps others (and future you).

**Version control:** keep unit files in Git, track changes.

---

### 926. User Management

Users defined in `/etc/passwd` (format: name:x:uid:gid:comment:home:shell). Passwords in `/etc/shadow` (hashed, perms 640). 

Create: `useradd -m -s /bin/bash username` (-m creates home), `adduser` (interactive). 

Modify: `usermod -aG group user` (add to group), `usermod -s /bin/zsh user` (change shell). 

Delete: `userdel -r user` (-r removes home). 

Set password: `passwd user`. Lock account: `passwd -l user`. 

User namespaces: isolate UIDs, used in rootless containers. 

**Files:** `/etc/login.defs` for defaults, `/etc/skel/` for new user templates.

---

### 927. Group Management

Groups for permission management. Primary group (in `/etc/passwd`), supplementary groups (in `/etc/group`). 

**Format:** `groupname:x:gid:user1,user2`. 

Create: `groupadd groupname`, delete: `groupdel groupname`. 

View user's groups: `groups username`, `id username`. 

Add user to group: `usermod -aG group user` (-a append, without -a replaces groups). 

Current process groups: `id`. Use for shared file access, application permissions. 

**Special groups:** wheel/sudo (admin), docker (Docker access).

---

### 928. sudo & Privilege Escalation

Execute commands as another user (usually root). 

**Config:** `/etc/sudoers` (edit with `visudo` for syntax checking). 

**Syntax:** `user ALL=(ALL:ALL) ALL`, `%group ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart nginx`. 

Test: `sudo -l` (list privileges), `sudo -v` (validate credentials). 

Logging: `/var/log/auth.log` (Debian) or `/var/log/secure` (RHEL). 

Timeout: `timestamp_timeout` in sudoers. 

Alternatives: `doas` (simpler), `su -` (switch user, full login). 

Security: principle of least privilege, avoid NOPASSWD for production.

---

### Category 56: Advanced Networking: eBPF & CNI (16 concepts)

### 929. XDP (eXpress Data Path)

Ultra-fast packet processing. eBPF program runs at NIC driver (before sk_buff allocation), lowest latency. Actions: PASS (continue to stack), DROP (discard), TX (bounce back), REDIRECT (send to another NIC). Use cases: DDoS mitigation (drop malicious packets at line rate), load balancing (Katran, Facebook's LB), packet sampling (observability). Performance: millions of packets per second, CPU cycles minimal. Example: XDP program filters SYN flood → drops before kernel processing → protects from DDoS. Limitations: limited helper functions (vs tc eBPF), read-only packet (tx mode allows rewrite). Best practice: use for high-throughput (DDoS, LB), combine with tc eBPF (more features).

### 930. tc eBPF

Traffic control with eBPF. Attach to ingress/egress (qdisc layer), more features than XDP (can modify packets, access sk_buff). Actions: classify, police (rate limit), redirect, mirror, drop. Use cases: policy enforcement (drop by IP), QoS (prioritize traffic), encapsulation (VXLAN, GRE), observability (packet sampling). Cilium: uses tc eBPF for network policies, load balancing, encryption. Example: tc eBPF program enforces NetworkPolicy → drops packets not matching rules. Comparison: XDP (faster, limited), tc eBPF (flexible, slightly slower), iptables (slowest, more overhead). Best practice: use for L3/L4 policies, combine with XDP (drop early, tc for complex logic).

### 931. CNI Plugin Development

Create custom CNI plugins. CNI spec: stdin (network config JSON), environment variables (command ADD/DEL/CHECK, container ID, netns path), stdout (result JSON, IP allocated). Commands: ADD (setup networking), DEL (teardown), CHECK (verify config), VERSION (supported versions). Implementation: binary (Go common), reads config, creates veth pair, assigns IP (IPAM), sets routes, returns result. Example: simple CNI → creates veth pair (host/container), moves container end to netns, assigns IP from pool. IPAM: separate plugin (host-local, DHCP, custom). Best practice: handle errors (rollback on failure), idempotent (safe to retry), log (debug issues), test (use CNI tester).

### 932. Cilium Deep Dive

eBPF-powered CNI. Features: networking (route/VXLAN/Geneve), network policies (L3/L4/L7), load balancing (kube-proxy replacement, eBPF XDP/tc), observability (Hubble, flow logs), encryption (WireGuard, IPSec), service mesh (sidecar-free). Architecture: cilium-agent (runs on nodes, compiles eBPF), operator (cluster-wide management), Hubble (observability). IPAM: cluster-scope, delegate to host (cloud provider). Use case: high-performance (XDP LB), security (network policies, encryption), observability (flow logs). Best practice: enable Hubble (visibility), kube-proxy replacement (performance), WireGuard encryption (zero-trust).

### 933. Calico Deep Dive

BGP-based CNI. Architecture: Felix (agent, programs routes/iptables), BIRD (BGP daemon, distributes routes), confd (watches etcd, configures BIRD). Modes: IP-in-IP (overlay, encapsulate), VXLAN (overlay, Layer 2), native routing (no encap, BGP). Network policies: iptables-based (L3/L4), eBPF mode (faster). IPAM: block allocation (per node, CIDR block). Use case: BGP integration (on-prem, routers), network policies (enforcement), multi-cloud (GKE, EKS, AKS). Best practice: native routing (performance), eBPF mode (faster policies), Typha (scale to 1000+ nodes).

### 934. Service Mesh CNI Integration

Sidecar network setup. Problem: init container (requires NET_ADMIN capability), race condition (app starts before sidecar). CNI solution: CNI plugin configures iptables (redirect to sidecar), no init container needed, lower privilege. Istio: istio-cni plugin (replaces istio-init), creates iptables rules (redirect inbound/outbound to Envoy). Linkerd: linkerd-cni (similar, iptables rules). Example: pod starts → CNI plugin runs → iptables redirect traffic to port 15006 (Envoy) → app → sidecar intercepts. Best practice: use CNI plugin (avoid privileged init container), test (verify traffic redirection).

### 935. Multus CNI

Multiple network interfaces per pod. Use case: pod needs multiple networks (management network, data network, storage network). Architecture: meta-plugin (delegates to other CNIs), primary network (Flannel, Calico, cluster networking), secondary networks (SR-IOV, Macvlan, bridge). Configuration: NetworkAttachmentDefinition CRD (define secondary networks), pod annotation (request networks). Example: pod with two interfaces (eth0 from Calico, net1 from SR-IOV, high-performance data plane). Best practice: primary for cluster services (DNS, kube-apiserver), secondary for specialized (storage, high-throughput).

### 936. SR-IOV in Kubernetes

Single Root I/O Virtualization. Concept: NIC presents multiple virtual functions (VFs), each like separate NIC, direct access from VM/container (bypass host network stack). Performance: near-native (10-100 Gbps, low latency), kernel bypass. Kubernetes: SR-IOV device plugin (discovers VFs, advertises as resources), SR-IOV CNI (attaches VF to pod), Multus (secondary network). Use case: high-performance networking (HPC, NFV, real-time trading). Limitations: VF count limited (NIC hardware), pod pinned to node (VF can't migrate). Best practice: reserve for performance-critical (not all pods), combine with primary network (cluster networking).

### 937. DPDK in Containers

Data Plane Development Kit. Concept: userspace networking (bypass kernel), poll mode drivers (busy-wait, low latency), huge pages (reduce TLB misses). Kubernetes: device plugin (allocate huge pages, bind NICs), privileged pods (access hardware). Use case: packet processing (routers, firewalls, load balancers), low latency (<10us), high throughput (40-100 Gbps). Example: VPP (Vector Packet Processing, uses DPDK), OVS-DPDK (Open vSwitch with DPDK). Trade-offs: complexity (userspace, manual memory), CPU overhead (poll mode, dedicated cores). Best practice: dedicated nodes (DPDK pods), CPU pinning (exclusive cores), huge pages (2MB pages).

### 938. Network Observability

Visibility into traffic. Tools: Hubble (Cilium, eBPF flow logs), Weave Scope (topology), Goldpinger (mesh connectivity), kube-ops-view (cluster visualization). Metrics: flow logs (source, dest, ports, verdict), DNS requests (queries, latency), HTTP requests (L7, path, status), drops (why packets dropped). Visualization: service map (who calls who), flow table (top talkers), latency heatmaps. Use case: troubleshooting (why can't reach service?), security (unexpected connections), capacity planning (high-traffic pairs). Best practice: enable flow logs (Hubble), aggregate (centralize in Loki/Elasticsearch), alert on anomalies (unexpected traffic).

### 939. IPv6 in Kubernetes

Support IPv6. Modes: IPv4 only (default), IPv6 only (rare), dual-stack (both, recommended). Dual-stack: pod has IPv4 and IPv6 addresses, Services ClusterIP can be IPv4 or IPv6, external traffic (LoadBalancer, Ingress supports both). Implementation: CNI must support (Calico, Cilium, Flannel), kube-apiserver flags (--service-cluster-ip-range=10.0.0.0/16,fd00::/108). Use case: IPv6-only networks, hybrid (internal IPv4, external IPv6), future-proofing. Challenges: not all CNIs support, external services (cloud LB may not support IPv6). Best practice: test dual-stack (before prod), monitor (ensure both protocols work), prefer IPv4 for simplicity (unless IPv6 required).

### 940. Network Security in Depth

Layered network security. Layers: perimeter (firewall, DDoS protection), network segmentation (VLANs, VPCs, subnets), pod network (NetworkPolicies, service mesh authz), encryption (TLS, mTLS, WireGuard), egress control (allow-list external domains). Micro-segmentation: fine-grained policies (pod-to-pod), default deny (explicit allow). Zero trust: verify every connection (mTLS), no trust based on location. Tools: Cilium (network policies, encryption), Istio (mTLS, authz), Falco (runtime detection). Use case: compliance (PCI-DSS, HIPAA), prevent lateral movement (attacker can't pivot), data protection. Best practice: default deny (explicit allow), micro-segmentation (pod-level policies), encrypt (mTLS in service mesh), audit (flow logs).

### 941. Network Troubleshooting Tools

Debug connectivity. Tools: kubectl (exec, logs, port-forward), curl/wget (test HTTP), dig/nslookup (DNS), ping/traceroute (reachability), netcat (port check), tcpdump (packet capture), Wireshark (analyze captures), mtr (traceroute + ping). Kubernetes-specific: pod network (check CNI logs), DNS (CoreDNS logs, test kube-dns), service (endpoints, kube-proxy rules), ingress (controller logs). Example: can't reach service → kubectl exec debug pod → curl service.namespace.svc.cluster.local → DNS fails → check CoreDNS. Best practice: debug pod (ephemeral container with tools), structured approach (DNS → routing → service → pod), capture (tcpdump if network issue).

### 942. Bandwidth Management

Control traffic rates. QoS: traffic shaping (limit egress), policing (drop excess ingress), prioritization (latency-sensitive first). Kubernetes: pod annotations (bandwidth limit, kubernetes.io/ingress-bandwidth, egress-bandwidth), CNI enforces (tc rules). Cloud: EBS burst balance (IOPS), EC2 network limits (instance type), throttling (API rate limits). Monitoring: bandwidth metrics (sent/received bytes), throttling events (CloudWatch throttles). Use case: noisy neighbor (one pod consumes all bandwidth), cost control (egress traffic expensive), fair sharing (multiple tenants). Best practice: set limits (prevent single pod saturation), monitor (detect throttling), rightsizing (bandwidth matches need).

### 943. Advanced Load Balancing

Sophisticated traffic distribution. Algorithms: least connections (fewest active), weighted round robin (capacity-aware), least response time (latency-based), hash (consistent hashing, session affinity). L4 vs L7: L4 (TCP/UDP, fast, simple), L7 (HTTP, content-based routing, TLS termination). Health checks: active (periodic probes), passive (monitor responses, remove unhealthy). Sticky sessions: IP hash, cookies (for stateful apps). Example: API gateway (L7 LB) → routes /api/v1 to service A, /api/v2 to service B → TLS termination → backend connection pooling. Best practice: L4 for performance (low latency), L7 for features (routing, WAF), health checks (remove unhealthy quickly), avoid stickiness (prefer stateless).

### 944. Network Policy Best Practices

Secure pod communication. Default deny: deny all ingress/egress, explicit allow (principle of least privilege). Granular: namespace-level (isolate tenants), pod-level (app tiers), port-level (specific ports only). Egress: allow DNS (kube-dns), allow API server (if needed), deny internet (or allow-list specific domains). Labels: use consistent labels (app, tier, version), policies select by label. Testing: test policies (create test pods, verify connectivity), gradual rollout (monitor before enforce). Example: frontend can call backend on port 8080, backend can call DB on port 5432, deny all other traffic. Best practice: start with allow-all (don't break apps), incrementally tighten (add deny rules), monitor (flow logs, detect violations), document (why each policy exists).

### Category 57: Meta-Skills & Best Practices (5 concepts)

### 945. Systems Thinking

Holistic view. 

**Principles:** understand whole system (not just parts), interconnections (how components affect each other), feedback loops (positive amplify, negative stabilize), emergent behavior (complex arises from simple rules). 

**Feedback loops:** Positive (growth, compound, runaway), Negative (stabilizing, thermostat, error correction). 

**Example positive:** more users → more content → attracts more users. 

**Example negative:** high CPU → auto-scale → more capacity → CPU drops. 

**Leverage points:** small changes, big impact (Donella Meadows), e.g., change incentives, modify feedback loops, redesign architecture. 

**Mental models:** abstractions to understand systems, update when wrong, seek disconfirming evidence. 

**Unintended consequences:** changes ripple, second-order effects, think through implications. 

**Complexity:** simple rules → complex behavior (Conway's Game of Life), embrace, don't over-simplify. 

**Application:** design distributed systems, debug (trace through system), optimize (find bottlenecks), incident response (systemic issues, not individual failures).

---

### 946. Debugging Methodology

Systematic troubleshooting. 

**Steps:** 
1. **Reproduce:** consistent repro, minimize steps, isolate variables. 
2. **Gather evidence:** logs, metrics, traces, error messages, stack traces. 
3. **Form hypotheses:** multiple possibilities, prioritize likely. 
4. **Test hypotheses:** design experiments, change one variable, observe results. 
5. **Analyze:** evidence supports/refutes hypothesis, iterate. 
6. **Fix:** implement solution, verify fix, document. 

**Divide and conquer:** binary search (disable half, still broken? bug in other half), narrow scope. 

**Change one thing:** don't change multiple variables, isolate cause. 

**Rubber duck debugging:** explain problem aloud, often reveals solution. 

**Tools:** debugger (breakpoints, step through), strace (syscalls), tcpdump (network), logs (grep, structured), profiling (CPU, memory). 

**Avoid:** assumptions (verify), confirmation bias (seek disconfirming), giving up (take breaks, ask for help). 

**Document:** what worked, what didn't, solution, prevent similar issues.

---

### 947. Reading Source Code

Understand implementation. 

**Why:** code is truth (docs outdated), learn best practices, debug libraries, contribute to open-source. 

**Strategies:** Top-down (start main, follow execution), Bottom-up (start function, understand module), Feature-driven (pick feature, trace code path). 

**Tools:** IDE (jump to definition, find usages, call hierarchy), grep/ripgrep (search code), git blame (who wrote, why), git log (history, PRs). 

**Read tests:** understand expected behavior, usage examples, edge cases. 

**Comments:** read comments, but verify (may be outdated). 

**Patterns:** identify patterns (factory, singleton, observer), understand architecture. 

**Persistence:** takes time, read actively (take notes, experiment), don't read linearly (follow call graph). 

**Example:** debugging nginx → find request handling code → trace through modules → understand how proxying works. 

**Benefits:** deepen understanding, faster debugging, better design decisions.

---

### 948. Profiling Before Optimizing

Measure, don't guess. 

**Amdahl's Law:** speedup limited by slowest part, 90% of time in 10% of code, optimize that 10%. 

**Profile first:** measure where time/memory spent, avoid optimizing wrong thing. 

**Tools:** pprof (Go), Py-Spy (Python), perf (Linux), profilers built into languages. 

**CPU profiling:** sample stack traces, identify hot functions, visualize (flame graph). 

**Memory profiling:** track allocations, identify leaks, reduce GC pressure. 

**Benchmark:** measure before and after, ensure optimization works, avoid regressions. 

**Realistic workload:** profile production-like data, not toy examples. 

**Bottlenecks:** I/O (disk, network, often slowest), CPU (computations), locks (contention), database queries. 

**Micro-optimizations:** usually not worth it (compiler optimizes), focus on algorithms, architecture. 

**Trade-offs:** performance vs readability, maintainability, choose wisely. 

**Quote:** "Premature optimization is the root of all evil" (Donald Knuth).

---

### 949. Managing Complexity

Simplify systems. 

**Essential vs Accidental complexity:** Essential (inherent to problem, can't eliminate), Accidental (from implementation, can reduce). 

**Strategies:** YAGNI (You Aren't Gonna Need It, don't build unnecessary features), KISS (Keep It Simple, Stupid), DRY (Don't Repeat Yourself, but balanced with decoupling), Separation of concerns (modules, layers), Loose coupling (reduce dependencies). 

**Abstraction:** hide details, but not too much (leaky abstractions). 

**Avoid:** Over-engineering (fancy solutions to simple problems), Premature generalization (abstract too early), Trendy tech (use proven, boring tech for critical systems). 

**Code reviews:** catch complexity early, enforce standards. 

**Refactoring:** continuous, pay down tech debt, simplify incrementally. 

**Documentation:** explain "why", not just "what", decision records (ADRs). 

**Trade-offs:** every decision has trade-offs, document, revisit. 

**Quote:** "Simplicity is prerequisite for reliability" (Dijkstra).

---

### 950. Unix Philosophy

Do one thing well. 

**Principles:** 
1. **Do one thing well:** single responsibility, small tools. 
2. **Composable:** combine tools (pipes), text streams. 
3. **Portability:** work across systems. 

**Examples:** grep (search), sort (sort lines), uniq (remove duplicates), combine: `cat log | grep ERROR | sort | uniq -c` (count unique errors). 

**Text streams:** universal interface, parseable, human-readable. 

**Pipes:** connect tools, output of one → input of next, `|`. 

**Small tools:** easier to understand, test, reuse, maintain. 

**Application to systems:** Microservices (single responsibility), APIs (composable), libraries (focused). 

**Avoid:** monolithic tools (do everything), binary formats (hard to compose). 

**Modern:** JSON streams (jq), structured logs (grep + jq). 

**Benefits:** flexibility (combine tools in new ways), debuggability (inspect at each step), reusability.

---

### 951. Layered Architecture

Abstraction layers. 

**Layers:** each layer abstracts complexity of layers below, well-defined interfaces. 

**OSI model:** 7 layers (Physical, Data Link, Network, Transport, Session, Presentation, Application). 

**Software stack:** Hardware → OS → Runtime (JVM, Python) → Frameworks (Django, Spring) → Application. 

**Benefits:** modularity (replace layer without affecting others), reusability (layers used by multiple apps), testability (mock layers). 

**Debugging:** bottom-up (hardware issue?) or top-down (application bug?), identify layer. 

**Example:** web app, layers: DB → ORM → Service → Controller → View, each layer depends only on layer below. 

**Avoid:** layer violations (skip layers, tight coupling), too many layers (overhead). 

**Best practice:** clear boundaries, minimal coupling, document interfaces.

---

### 952. Trade-off Analysis

Every decision has trade-offs. 

**No perfect solution:** optimize for specific goals, constraints. 

**Examples:** Consistency vs Availability (CAP), Performance vs Readability, Speed vs Quality, Cost vs Features. 

**Framework:** identify options, list pros/cons per option, weight by importance, choose, document decision (ADR). 

**ADR (Architecture Decision Record):** document "what", "why", "alternatives considered", "trade-offs", "decision". 

**Revisit:** context changes, reevaluate decisions (annually, after incidents). 

**Example:** choose database, SQL (strong consistency, relational, mature) vs NoSQL (scalable, flexible schema, eventual consistency), depends on use case. 

**Context:** what's important? latency, scalability, cost, time-to-market, compliance. 

**Avoid:** dogma (always use X), cargo-culting (use because popular), ignoring trade-offs. 

**Communicate:** explain trade-offs to stakeholders, align on priorities.

---

### 953. Failure Mode Analysis

What can go wrong? 

**FMEA (Failure Modes and Effects Analysis):** for each component, list failure modes, effects (impact), severity, likelihood, mitigation. 

**Example:** load balancer, failure mode: "all instances down", effect: "service unavailable", severity: critical, mitigation: "health checks, auto-scaling". 

**Blast radius:** how far does failure propagate? isolate (bulkheads, circuit breakers). 

**Single Point of Failure (SPOF):** component whose failure brings down system, eliminate (redundancy, clustering). 

**Cascading failures:** one failure triggers others (domino effect), prevent (graceful degradation, circuit breakers, rate limiting). 

**Chaos engineering:** test failure modes, validate mitigations. 

**Redundancy:** N+1 (one extra), N+2 (two extra), active-passive, active-active. 

**Example:** web tier (stateless, N+1, any instance can fail), database (primary-replica, automatic failover). 

**Document:** failure scenarios, impact, mitigation, runbooks. 

**Regular reviews:** update as system evolves, after incidents.

---

### 954. Operational Excellence

Reliable operations. 

**Principles:** automate toil, monitor everything, incident response, blameless postmortems, continuous improvement. 

**Runbooks:** step-by-step procedures, troubleshooting, common tasks (deploy, rollback, scale), keep updated. 

**Playbooks:** incident response, escalation, communication templates. 

**On-call:** rotation, reasonable load (not paged every night), compensation, training. 

**Incident response:** defined process (detect, triage, mitigate, resolve, postmortem), roles (incident commander, scribe), tools (chat, video). 

**Postmortems:** blameless, timeline, root cause (5 whys), action items (prevent recurrence), share widely. 

**Continuous improvement:** learn from incidents, proactive fixes, reduce toil. 

**Automation:** deploy, scale, backup, restore, monitoring, reduce manual work. 

**Metrics:** MTTR (mean time to repair), MTBF (mean time between failures), incident frequency, toil %. 

**Culture:** psychological safety (speak up), learning (not blaming), collaboration.

---

### 955. Security Mindset

Assume breach. 

**Threat modeling:** identify assets (data, systems), threats (who wants to attack?), vulnerabilities (weaknesses), mitigations (controls). 

**STRIDE:** Spoofing (identity), Tampering (data), Repudiation (deny action), Information disclosure, Denial of service, Elevation of privilege. 

**Defense in depth:** multiple layers, if one fails, others protect. 

**Least privilege:** minimal permissions, reduce blast radius. 

**Zero trust:** never trust, always verify, even inside network. 

**Secure by default:** secure configs, encryption on, strong passwords. 

**Fail securely:** on error, deny access (not grant). 

**Input validation:** never trust user input, sanitize, escape, validate. 

**Security updates:** patch vulnerabilities promptly, monitor advisories. 

**Auditing:** log security events, monitor, alert on suspicious. 

**Training:** security awareness, phishing, social engineering. 

**Culture:** everyone responsible for security, not just security team.

---

### 956. Scalability Thinking

Design for growth. 

**Vertical vs Horizontal:** Vertical (bigger machine, limits, expensive), Horizontal (more machines, linear scaling, preferred). 

**Stateless:** prefer stateless services, state in external store (DB, cache, object storage), easy to scale (add instances). 

**Sharding:** partition data, scale beyond single DB, shard by key (user ID, region). 

**Caching:** reduce load, improve latency, multiple layers (in-process, Redis, CDN). 

**Async:** decouple, background jobs, queues (RabbitMQ, Kafka), scale producers/consumers independently. 

**Database:** read replicas (scale reads), sharding (scale writes), NoSQL (horizontal scaling built-in). 

**CDN:** offload static assets, edge locations, reduce latency. 

**Load balancing:** distribute traffic, detect failures, route to healthy. 

**Auto-scaling:** dynamic, scale based on metrics (CPU, requests), handle spikes. 

**Plan for 10x, then 100x:** design for next order of magnitude, identify bottlenecks early. 

**Measure:** load testing, identify capacity, plan ahead (don't scale reactively).

---

### 957. Documentation Practice

Knowledge sharing. 

**Types:** README (what, why, how to run), API docs (endpoints, parameters, examples), Architecture docs (diagrams, decisions), Runbooks (operational procedures), ADRs (decisions, trade-offs). 

**README:** every repo, sections: Description, Installation, Usage, Configuration, Contributing, License. 

**ADR (Architecture Decision Record):** document decisions, format: Title, Status, Context, Decision, Consequences. 

**Code comments:** "why" (not "what", code shows what), explain non-obvious, assumptions, trade-offs. 

**API docs:** OpenAPI/Swagger (auto-generate), examples (curl commands), error codes. 

**Diagrams:** C4 model (Context, Container, Component, Code), sequence diagrams, architecture diagrams. 

**Keep updated:** docs rot quickly, update with code changes, make updating easy (docs in code repo). 

**Audience:** write for target audience (developers, operators, users), appropriate level of detail. 

**Searchable:** wiki, docs site, version-controlled (Git). 

**Benefits:** onboarding (new team members), knowledge preservation (not in heads), reduce interruptions (self-service).

---

### 958. Infrastructure as Code Mindset

Everything as code. 

**Principle:** all infrastructure configuration in version control, no manual changes, reproducible. 

**Benefits:** version history (Git), review (pull requests), rollback (git revert), audit trail, documentation (code is spec), automation (CI/CD). 

**Declarative:** describe desired state (Terraform, K8s YAML), tool figures out how, idempotent. 

**Immutable:** don't modify infrastructure, replace (no drift), destroy and recreate. 

**Environments from code:** spin up dev/staging/prod from same code, configuration differences via variables. 

**Testing:** validate syntax (terraform validate), lint (tflint, tfsec), test (Terratest), policy (OPA). 

**Tools:** Terraform, CloudFormation, Pulumi, Ansible, Kubernetes manifests. 

**Culture shift:** from manual (clicking console) to code, training, discipline. 

**Continuous deployment:** infrastructure changes via CI/CD, same as app code. 

**Documentation:** code is documentation, clear, commented, well-structured.

---

### 959. GitOps Philosophy

Git as source of truth. 

**Principles:** (1) Declarative (describe desired state), (2) Versioned (in Git), (3) Pulled automatically (operator pulls from Git), (4) Continuously reconciled (operator ensures actual = desired). 

**Workflow:** change YAML → commit to Git → operator (Argo CD, Flux) detects → applies to cluster → reconciles continuously. 

**Benefits:** audit trail (every change in Git history), rollback (git revert), security (no direct cluster access, changes via Git), disaster recovery (recreate from Git). 

**Push vs Pull:** Traditional (CI pushes to cluster), GitOps (operator pulls from Git), pull = more secure (no cluster credentials in CI). 

**Repo structure:** separate app code repo (Dockerfile, CI) and config repo (K8s YAML, Helm values), or monorepo. 

**Promotion:** environments = branches or folders, promote via PR (merge dev → staging → prod). 

**Secrets:** external (Vault, Sealed Secrets), not in Git. 

**Drift:** operator detects manual changes, reverts to Git state (self-heal). 

**Tools:** Argo CD (UI, sync strategies), Flux (CNCF, CLI), Jenkins X.

---

### 960. Cloud-Native Principles

Design for cloud. 

**12-Factor App:** 
1. **Codebase:** one repo, many deploys. 
2. **Dependencies:** explicitly declared (package.json, go.mod). 
3. **Config:** in environment variables, not hardcoded. 
4. **Backing services:** treat as attached resources (DB, cache URLs in config). 
5. **Build, release, run:** strict separation. 
6. **Processes:** stateless, share-nothing. 
7. **Port binding:** export services via port. 
8. **Concurrency:** scale out via process model. 
9. **Disposability:** fast startup, graceful shutdown. 
10. **Dev/prod parity:** keep dev/staging/prod similar. 
11. **Logs:** treat as event streams (stdout, not files). 
12. **Admin processes:** run as one-off processes (migrations, console). 

**Microservices:** decompose monolith, single responsibility, independently deployable. 

**Containers:** packaging (Docker), immutable, portable. 

**Orchestration:** Kubernetes, declarative, self-healing. 

**APIs:** RESTful, gRPC, versioned. 

**Observability:** metrics, logs, traces, distributed tracing. 

**Automation:** CI/CD, IaC, GitOps. 

**Resilience:** retries, circuit breakers, graceful degradation.

---

### 961. DevOps Culture

Collaboration and automation. 

**DevOps:** development + operations, break down silos, shared responsibility. 

**Principles:** Collaboration (devs and ops work together), Automation (reduce manual toil), Continuous improvement (iterate, learn), Shared ownership (you build it, you run it). 

**Practices:** CI/CD (automate testing, deployment), IaC (infrastructure as code), Monitoring (shared dashboards), Blameless postmortems (learn from failures), ChatOps (ops in chat). 

**Culture:** trust, psychological safety, learning culture, fail fast, experiment. 

**Metrics:** DORA metrics (Deployment frequency, Lead time for changes, Time to restore, Change failure rate). 

**Benefits:** faster deployments, fewer failures, faster recovery, happier teams. 

**Anti-patterns:** "throw over the wall" (dev builds, ops runs, no collaboration), manual processes, blame culture. 

**Tools enable culture:** tools important (CI/CD, IaC, monitoring), but culture more important. 

**Evolution:** DevOps → SRE (Site Reliability Engineering, SLOs, error budgets) → Platform Engineering (self-service platforms).

---

### 962. SRE Principles

Site Reliability Engineering. 

**SRE:** Google's approach to operations, engineers apply software engineering to ops, automate toil, balance reliability vs velocity. 

**Principles:** SLIs/SLOs/SLAs (measure reliability, set targets, error budgets), Error budgets (1 - SLO, allowed unreliability, spend on innovation), Toil reduction (automate repetitive work, < 50% toil), Blameless postmortems (learn from incidents), Monitoring (SLI-based alerts, actionable), Capacity planning (stay ahead of demand). 

**SLI (Service Level Indicator):** metric (request latency, error rate, availability). 

**SLO (Service Level Objective):** target (99.9% availability, 95% of requests < 200ms). 

**SLA (Service Level Agreement):** contract with users, consequences if missed. 

**Error budget:** 100% - SLO, if 99.9% SLO → 0.1% error budget, if exceeded → freeze releases, focus on reliability. 

**Toil:** manual, repetitive, automatable, no lasting value, scales linearly, engineers spend < 50% on toil. 

**On-call:** sustainable (not paged every night), reasonable load, postmortem after incidents. 

**SRE team structure:** embedded (in product teams) or centralized (SRE team), hybrid. 

**Books:** "Site Reliability Engineering", "The Site Reliability Workbook" (Google).

---

### 963. Cost Optimization

Efficient resource usage. 

**Right-sizing:** match resources to needs, don't overprovision, monitor usage (CPU, memory), resize instances. 

**Reserved Instances:** commit 1-3 years, 30-75% discount (AWS RI, GCP CUD), use for predictable workloads. 

**Spot Instances:** unused capacity, up to 90% discount, can be interrupted, use for fault-tolerant (batch, stateless). 

**Auto-scaling:** scale down when idle, scale up under load, don't pay for unused capacity. 

**Storage optimization:** lifecycle policies (move old data to cheaper storage, S3 Glacier), compression, delete unused. 

**Serverless:** pay per use (Lambda, Cloud Functions), no idle cost, fits bursty workloads. 

**Database:** read replicas only when needed, downsize during off-hours, reserved instances. 

**Network:** reduce data transfer (expensive, use same region, CDN, compression), NAT gateway costs (use PrivateLink). 

**Monitoring:** cost dashboards (AWS Cost Explorer, GCP Billing), alerts on spikes, tagging (cost allocation). 

**FinOps:** financial operations, engineers aware of costs, cost-conscious culture, showback/chargeback. 

**Tools:** CloudHealth, CloudCheckr, Kubecost (Kubernetes), Infracost (Terraform cost estimates). 

**Trade-offs:** cost vs performance, reliability, availability, balance.

---

### 964. Continuous Learning

Stay current. 

**Rapidly evolving field:** new tools, frameworks, practices, constant learning required. 

**Learning sources:** Blogs (HackerNews, dev.to, Medium, vendor blogs), Conferences (KubeCon, AWS re:Invent, GopherCon, videos online), Books (classic: "Designing Data-Intensive Applications", "SRE books"), Courses (Udemy, Coursera, A Cloud Guru, Linux Academy), Podcasts (Software Engineering Daily, The Changelog), Papers (academic papers, Google, Amazon), Hands-on (build projects, labs, cloud free tiers). 

**Depth vs Breadth:** T-shaped (broad knowledge across stack, deep in few areas), generalists know enough to integrate, specialists go deep. 

**Hands-on practice:** reading not enough, build things, break things, fix things, learn by doing. 

**Labs and sandboxes:** Kubernetes clusters (kind, minikube), cloud free tiers (AWS, GCP, Azure), Terraform, Docker, Vagrant. 

**Open source:** read code, contribute (start small, docs, issues), learn from experts. 

**Community:** meetups (local user groups), Slack communities, Twitter (#DevOps, #Kubernetes), Stack Overflow, Reddit. 

**Share knowledge:** write blog posts, give talks, mentor juniors, teach to learn. 

**Pace yourself:** marathon not sprint, avoid burnout, focus on fundamentals (timeless knowledge). 

**Fundamentals:** Linux, networking, databases, distributed systems, these don't change as fast, strong foundation enables learning new tools faster.

---

### 965. Learning How to Learn

Continuous skill development. Techniques: spaced repetition (review over time), active recall (test yourself), Feynman technique (teach to understand), interleaving (mix topics), deliberate practice (focus on weak areas). Resources: books (DevOps Handbook, SRE books), courses (A Cloud Guru, Linux Academy), hands-on (labs, side projects), communities (CNCF Slack, Reddit /r/devops), conferences (KubeCon, DevOpsDays). Time: dedicate 5-10 hours/week, consistent (not binge). Example: learn Kubernetes → read docs (1 week) → labs (2 weeks) → side project (4 weeks) → teach colleague (solidify). Best practice: hands-on (don't just read), projects (apply knowledge), teach (explain to others), iterate (revisit topics).

---

### 966. Problem-Solving Methodology

Systematic debugging. Steps: reproduce (consistent repro steps), isolate (narrow down, binary search), hypothesize (possible causes), test (validate hypothesis), fix (implement solution), verify (confirm fixed), document (postmortem). Tools: logs (structured, searchable), metrics (identify spikes), traces (follow request), profiling (CPU, memory), debuggers (gdb, delve). Example: API slow → check metrics (latency spike at 2pm) → logs (database timeout errors) → hypothesis (DB overloaded) → query slow query log (cartesian join) → fix (add index) → verify (latency back to normal). Best practice: scientific method (hypothesis → test), document (runbook for next time), blameless (learn, not blame), share (postmortem, team learns).

---

### 967. Communication Skills

Collaborate effectively. Writing: clear (simple language), concise (no fluff), structured (intro, body, conclusion), visuals (diagrams, screenshots). Meetings: agenda (send beforehand), timeboxed (respect time), actionable (decisions, owners, deadlines), notes (document, share). Presentations: audience-aware (level, interests), storytelling (narrative arc), practice (rehearse), Q&A (anticipate questions). Async: prefer (respect time zones), documents (over meetings), threaded (Slack threads, email replies). Difficult: empathy (understand perspective), facts (not blame), propose solutions (not just problems). Best practice: write more (docs, RFCs, postmortems), over-communicate (err on side of more info), feedback (ask for feedback, improve).

---

### 968. Career Development

Grow as engineer. Skills: T-shaped (depth in one area, breadth across others), learn adjacent (if SRE, learn platform engineering), leadership (technical leadership, mentorship). Visibility: internal (tech talks, demos, RFC author), external (blog, conferences, open source). Networking: communities (meetups, Slack groups), mentors (find experienced engineers), peers (learn from colleagues). Promotions: document impact (metrics, incident resolutions, projects), feedback (seek from manager, peers), growth plan (skills needed for next level). Side projects: experiment (try new tech), portfolio (show skills), contribute (open source). Best practice: set goals (quarterly OKRs), track progress (document wins), seek feedback (360 reviews), invest in relationships (networking).

---

### 969. Work-Life Balance

Sustainable career. Boundaries: work hours (no always-on), on-call (limited, compensated), vacation (actually disconnect). Burnout signs: cynicism, exhaustion, reduced performance, recognize early. Prevention: breaks (pomodoro, walk), exercise (physical health), hobbies (non-tech interests), social (friends, family). On-call: sustainable rotation (1 week per month max), runbooks (reduce toil), escalation (don't hero), retrospectives (fix root causes, reduce alerts). Best practice: set boundaries (communicate), time off (use vacation), say no (prioritize, can't do everything), support (team, manager, mental health resources), recognize burnout (seek help early).
