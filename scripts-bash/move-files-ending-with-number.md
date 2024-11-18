---
description: How to move files ending with a number into folders ending with numbers
---

# Move files ending with number

Create 36 files which have three different starts and 12 different ends followed by an extension

```
touch {first,second,third}_{01..12}.tif
```

Create example files with different beginnings for copyiing

```
```

Example 1: Copy the files with the same ending number into folders with such a number&#x20;

```
for file in *; do install -D "$file" "${file -6:2}/${file}"; done
```

Explanation:&#x20;

1. `{01...10}` generates sequence of numbers
2. `${string:offset:length}` with a caveat, negative offset needs to be separated by space from the colon
3. install -D is like a copy (cp) command, but enables you to create the folder at the same time (and also the permissions and ownerships)
