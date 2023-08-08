# mount network drive

To access a mapped network drive within Windows Subsystem for Linux 2 (WSL2), you can follow these steps:

1.  **Create a Directory**: Open your WSL2 terminal and navigate to the desired location where you want to mount the network drive. You can use the `cd` command to change directories. Then, create a directory where you'll mount the network drive. For example:

    ```bash
    mkdir /mnt/networkdrive
    ```
2.  **Mount the Network Drive**: Once the directory is created, you can use the `mount` command to mount the network drive. In WSL2, you can access Windows drives using the `/mnt` directory followed by the drive letter. Replace `X` with the appropriate drive letter and update the network drive path accordingly:

    ```bash
    sudo mount -t drvfs X: /mnt/networkdrive
    ```

    Replace `X:` with the drive letter of the mapped network drive in Windows.
3.  **Access the Network Drive**: After mounting the network drive, you can navigate to the mounted directory within WSL2 and access its contents just like you would with any other directory:

    ```bash
    cd /mnt/networkdrive
    ls
    ```

Remember to replace `X:` and adjust paths according to your actual network drive setup.

Please note that network drive access might have some limitations based on your network configuration and security settings. Additionally, WSL2 requires administrative privileges (`sudo`) to mount the network drive, so you might need appropriate permissions.

Also, it's important to understand that any changes you make to files on the network drive within WSL2 will affect the files in the network drive on the Windows side, and vice versa, as it's the same data source being accessed from both environments.
