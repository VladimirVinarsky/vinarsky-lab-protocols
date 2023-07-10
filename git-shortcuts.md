# git shortcuts

## Save the last commit hash to the variable

```
last=$(git log --oneline | head -n 1 | cut -d " " -f1)
```

## Show the dates of commits

```
git show -s --format=%ci <commit-hash>
```
