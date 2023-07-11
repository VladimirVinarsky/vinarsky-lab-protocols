---
description: useful sed commands
---

# sed

## Replace tabs with commas

```
sed -i 's/\t/,/g' file [file]... 
```

## Replace carriage return in files

To replace carriage return in .sh files trasnferred from windows to linux

```
for file in <files>; do sed 's/\r//g' "${file}" > "${file%.sh}-fixed.sh"; done
```

`s/\r//g` the whole sed pattern

`s/` substitute

`\r` carriage return

`//` by nothing

`/g` globally

`${file%.sh}` strip the `.sh`from the filename

