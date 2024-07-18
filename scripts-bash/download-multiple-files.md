---
description: This script reads a file with one link per line and downloads the files
---

# Download multiple files

```bash
!#/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file-with-links-to-download>"
else
    while IFS= read -r url; do
        curl -O "$url"
    done < $1
fi
```
