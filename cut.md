# cut

## get the cell area from the final table

```
for file in files; do cut -d, -f37 "${file}" > Cell_area_${file}; done
```
