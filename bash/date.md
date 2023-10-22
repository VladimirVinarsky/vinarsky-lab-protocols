---
description: how to work with date on linux
---

# date

give the date command a string with a date and reformat it to a different format

```
reformatted_date=$(date -d '10/1/23' +%Y-%m-%d)
#2023-10-01
```

add several (3) days to the supplied date and output the forwarded date in the new format

```
forwarded_date=$(date '+%Y-%m-%d' -d "$reformatted_date+3 days")
```
