# copy nested folder

**RootFolderI:**

```bash
RootFolderI/FolderA/Subfolder1
RootFolderI/FolderA/Subfolder2
RootFolderI/FolderA/Subfolder3
. . .
RootFolderI/FolderB/Subfolder1
RootFolderI/FolderB/Subfolder2
RootFolderI/FolderB/Subfolder3
...
```

(And many other `FolderC`, `FolderD`, ...)

***

I want to copy all `Subfolder1` (and respective `FolderA/B/etc`) to `RootFolderII`:

**RootFolderII:**

```bash
RootFolderII/FolderA/Subfolder1
RootFolderII/FolderB/Subfolder1
```

You can execute this from RootDirectoryI (it is essential that you run it from RootDirectoryI):

```bash
cp --parents -r */Subfolder1 ../RootDirectoryII
```

This works by copying (`-r` lets you copy entire directories) each `Subfolder1` that exists in second level nesting to RootDirectoryII.

The `--parents` option copies the path used to get to the copied file, so in this example, it makes each Subfolder1 reside not right under RootDirecoryII but nested under a Folder\*, like it was in the first place\
