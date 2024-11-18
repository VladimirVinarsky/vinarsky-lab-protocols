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

Copy the files into the folders&#x20;

```
for file in *{01..10}.tif; do cp "$file" *"${file: -6:2}"/; done
```

Explanation:&#x20;

1. `{01...10}` generates sequence of numbers
2. `${string:offset:length}` with a caveat, negative offset needs to be separated by space from the colon
3.
