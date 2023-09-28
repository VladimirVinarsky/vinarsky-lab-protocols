# Reorganize daily images

## Info

1. Takes images from chronologically (dd-mm-yyyy) labelled folders
2. Groups them by CellLine ID (`#0001_rest-of-filename.tif`)
3. Saves them in `Reorganized` folder into CellLine ID folders (`CellLine_#0001`, `CellLine_#0002` ... ).
4. Renames files in folder with dates in (yyyy-mm-dd) format for better sorting

## Notes

* Works like a charm
* CellLine ID is the `#0001-#9999` beginning of file
* &#x20;`#` can be ommited
* accepts unequal padding of CellLineID (`#1` is  equal to`#0001`)
* accepts both dd-mm-yyyy and dd-mm-yy
* accepts names with a space inside `#003_this spaced name`

{% file src="../.gitbook/assets/reorg_daily_images.sh" %}
script to download
{% endfile %}
