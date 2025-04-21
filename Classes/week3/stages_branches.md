# 4 Stages in Git

## 1. Work Area / Untracked  
This is where you make changes to your files. These changes are not yet tracked by Git.  
```bash
git add .
```

## 2. Staging Area / Tracked  
Files are added to the staging area and are ready to be committed.  
```bash
git commit -m "<message>"
```

## 3. Local Repository  
Your changes are committed to your local repository.  
```bash
git push
```

## 4. Remote Repository  
Your changes are pushed to the remote repository.  

### Useful Commands:
- View commit history:  
    ```bash
    git log
    ```
- Check for remote repository:  
    ```bash
    git remote        # Output: origin
    git remote -v
    ```
- Clone a remote repository:  
    ```bash
    git clone <url>
    ```

---

# Git Branch

## Different Teams and Branches:
- **Development Team**: Works on new features or requirements.  
- **Testing Team**: Tests the code for bugs.  
- **DevOps Team**: Manages deployment and infrastructure.  

### Branching Strategy:
- `development` branch: For ongoing development.  
- `test` branch: For testing purposes.  
- `devops` branch: For deployment-related tasks.  
- `production` branch: Stable code ready for release.  

---

## Branch Management Commands:

### Create a New Branch:
```bash
git branch <branch-name>
```

### List Available Branches:
```bash
git branch
```

### Push a New Branch to Remote Repository:
```bash
git push --set-upstream origin <branch-name>
# Short version:
git push -u origin <branch-name>
```

### Switch to a New Branch:
```bash
git checkout <branch-name>
```

### Push Changes in a New Branch:
Ensure `HEAD` is pointing to the new branch:  
```bash
git push
```

---

## Checking Commits in Local Repository:
```bash
git log
git log --oneline
```

---

## Working with Remote Branches:

### List Remote Branches:
```bash
git branch -r
```

### Pull Changes from Remote to Local Repository:
```bash
git pull
```

---

## Real-Time Example:

1. **Create a Feature Branch**:  
     ```bash
     git branch feature/new-feature
     git checkout feature/new-feature
     ```

2. **Make Changes and Commit**:  
     ```bash
     git add .
     git commit -m "Added new feature"
     ```

3. **Push Feature Branch to Remote**:  
     ```bash
     git push -u origin feature/new-feature
     ```

4. **Merge Changes to Development Branch**:  
     ```bash
     git checkout development
     git merge feature/new-feature
     ```

5. **Push Development Branch to Remote**:  
     ```bash
     git push
     ```
