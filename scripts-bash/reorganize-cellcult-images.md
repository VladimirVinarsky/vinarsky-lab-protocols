# Reorganize daily images

## Info

1. Takes images from chronologically (dd-mm-yyyy) named folders(`03-12-2023` ,`04-12-2023`... ).
2. Groups them by CellLine ID as beginning of the filename (filename: `#0001_rest-of-filename.tif` , CellLineID: `0001` )
3. Saves them in `Reorganized` folder into CellLine ID named folders (`CellLine_#0001`, `CellLine_#0002` ... ).
4. Renames files in CellLine ID named folders for better chronological sorting (`CellLine_#0001/2023-12-03_rest-of-filename.tif`) format for better sorting

## Notes

* Works like a charm
* &#x20;`#` in the CellLine ID can be ommited&#x20;
* accepts unequal padding of CellLineID (`#1` is  equal to`#0001`)
* accepts both dd-mm-yyyy and dd-mm-yy
* accepts names with a space inside `#003_this spaced name`

{% file src="../.gitbook/assets/reorg_daily_images.sh" %}
script to download
{% endfile %}
