**GIT**

**Remove files**

*From both Git repo and filesystem:*

```bash
git rm file.txt
git commit -m "removed file.."
git push
```

*From only the Git repo:*

```bash
git rm --cached file.txt
git commit -m "removed file.."
git push
```

**Linux 'remote desktop'**

```bash
apt install freerdp2-x11

xfreerdp /u:Admin +clipboard /w:1366 /h:768 /v:SERVER_IP
```

**Alias**

```bash
alias update='sudo apt update && sudo apt upgrade -y'
alias ..='clear && cd'
```

