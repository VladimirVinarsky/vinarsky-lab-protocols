---
description: How to move files ending with a number into folders ending with numbers
---

# Move files into folders based on patterns

Create 36 files which have three different starts and 12 different ends followed by an extension

```
touch {first,second,third}_{01..12}.tif
```

## Copy files with the same number ending into folder with the same numbers

```
for file in *; do install -D "$file" "${file: -6:2}/${file}"; done
```

Explanation:&#x20;

1. `{01...10}` generates sequence of numbers
2. `${string:offset:length}` with a caveat, negative offset needs to be separated by space from the colon
3. install -D is like a copy (cp) command, but enables you to create the folder at the same time (and also the permissions and ownerships)

## Copy the files with the same beginning (before underscore) into folders with the same beginning

```
regex='(.*)_(.*).tif';
for file in *;
do 
if [[ $file =~ $regex ]]
then install -D "$file" "${BASH_REMATCH[1]}/${file}";
fi
done
```

Explanation:

1. `(.*)` means any character folowed by anything
2. `$file` in the `[[`    ]]\` syntax does not need to be quoted, works with a space also when it is a file
3. `BASH_REMATCH` \[0] is the full string \[1] is the first bit recognized \[2] is the second bit recognized
