# Copy folder structure, but not the files

[resource](https://www.baeldung.com/linux/copy-directory-structure)

## See the folder structure first

[First install the tree utility into gitbash according to this tutorial](https://dev.to/flyingduck92/add-tree-to-git-bash-on-windows-10-1eb1)la

```
tree -dfi --noreport rootDir
```

Next, let’s walk through the options we passed to the _tree_ command and understand what they mean:

* _-d_: We ask the _tree_ command to print directories only
* _-f_: The _tree_ command will print the full path for us
* _-i_: Usually, _tree_ outputs in a tree format. In other words, lines are well indented in the output. However, this option will prevent _tree_ from printing indentation lines
* _–noreport_: This flag suppresses the summary report at the end of the output, such as “_x directories, y files_“

## Using rsync

{% code title="Using rsync" %}
```bash
rsync -av -f"+ */" -f"- *" "/path/to/the/source/rootDir" "/tmp/test"
```
{% endcode %}

The options we passed to the _rsync_ command look a bit obscure. Next, let’s go through them quickly.

The _-a_ option asks _rsync_ to do an “archive” copying. In other words, the copying will be done recursively and with file permission preserved. Next, the _-v_ option means verbose. With this option, we can see a detailed log of what the _rsync_ command has done.

Next, the tricky part _-f”+ \*/” -f”- \*”_ comes.

Each _-f_ option defines a _filter_, and a filter rule follows a filter. When _rsync_ works, it’s going to apply the filters on files it wants to copy.

**A plus “+” indicates “include”, while a minus “-” means “exclude”**. In our command, we include all directories _“+ \*/”_ but exclude all files _“- \*”_. Thus, the _rsync_ command will only copy directories under the source directory and skip all files.
