---
description: Find and copy files to selected destionations
---

# Find files by date



{% code title="find yesterdays csvs" %}
```bash
find . -name "*.csv" -ctime -1 -print | less 
```
{% endcode %}

{% code title="find& write paths into file" %}
```bash
find . -name "*.png" -ctime -1 -print | cat > files-paths.txt
```
{% endcode %}

{% code title="find&copy yesterdays csvs" %}
```
mkdir yesterday;
find . -name "*.csv" -ctime -1 -exec cp '{}' ./yesterday/ ';' 
```
{% endcode %}
