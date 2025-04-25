# Understanding Merge, Rebase, and Squash in Git

Version Control Systems (VCS) like Git provide powerful tools to manage and streamline your codebase. Among these tools, **merge**, **rebase**, and **squash** are essential for maintaining a clean and organized commit history. Here's an overview of each:

## Merge
Merging is the process of integrating changes from one branch into another. It creates a new commit that combines the histories of both branches.

### Example:
```bash
git checkout main
git merge feature-branch
```

### Pros:
- Preserves the complete history of changes.
- Useful for collaborative workflows.

### Cons:
- Can lead to a cluttered commit history with many merge commits.

---

## Rebase
Rebasing rewrites the commit history by moving a branch to a new base commit. It applies changes from one branch on top of another.

### Example:
```bash
git checkout feature-branch
git rebase main
```

### Pros:
- Creates a linear and cleaner commit history.
- Ideal for keeping feature branches up-to-date.

### Cons:
- Can lead to conflicts if not used carefully.
- Avoid rebasing public/shared branches.

---

## Squash
Squashing combines multiple commits into a single commit. This is often used during pull requests to simplify the commit history.

### Example:
```bash
git rebase -i HEAD~n
# Choose "squash" for the commits you want to combine
```

### Pros:
- Reduces noise in the commit history.
- Useful for polishing feature branches before merging.

### Cons:
- Loses granular commit details.

---

## Best Practices
- Use **merge** for integrating completed features into the main branch.
- Use **rebase** to keep your branch updated with the latest changes.
- Use **squash** to clean up your commit history before merging.

By understanding and using these tools effectively, you can maintain a clean and efficient workflow in Git.