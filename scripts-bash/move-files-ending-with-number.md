---
description: How to move files ending with a number into folders ending with numbers
---

# Move files ending with number

Create folders ending with numbers (1 to 10 here)

```
mkdir folder_name_{01..10}
```

Create example files with different beginnings for copyiing

```
touch abc_here_{01..10}.tif
touch def_there_{01..10}.tif
```

Copy the files into the folders&#x20;

```
for file in *{01..10}.tif; do cp "$file" *"${file: -6:2}"/; done
```

Explanation:&#x20;

1. `{01...10}` generates sequence of numbers
2. `${string:offset:length}` with a caveat, negative offset needs to be separated by space from the colon
3.
