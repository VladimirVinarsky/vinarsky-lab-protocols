# Image Magick

So far useless

Rescale the gray to min/max

[`-normalize`](https://imagemagick.org/script/command-line-options.php?#normalize)  pragmatic

> pragmatic one out of range pixels will be ignored

```
#rescale the gray to min/max version 1
for image in *.tif; do magick "$image"  -normalize  "normalize_${image}"; done
```

[`-auto-level`](https://imagemagick.org/script/command-line-options.php?#auto-level) idealistic

> idealistic, single saturated pixels will be accounted for, good for mathematically generated images

```
# rescale to min/max version 2
for image in [^n]*.tif; do magick "$image"  -auto-level  "auto-level_${image}"; done
```

