---
description: show the directory structure
---

# tree

```
tree -dfi --noreport rootDir
```

Next, let’s walk through the options we passed to the _tree_ command and understand what they mean:

* _-d_: We ask the _tree_ command to print directories only
* _-f_: The _tree_ command will print the full path for us
* _-i_: Usually, _tree_ outputs in a tree format. In other words, lines are well indented in the output. However, this option will prevent _tree_ from printing indentation lines
* _–noreport_: This flag suppresses the summary report at the end of the output, such as “_x directories, y files_“
