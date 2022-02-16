# Password management

## Quick start
Download keepass ZIP file located in the root of our Google Drive. Unzip the contents wherever you like and launch the **KeePass.exe** executable.

To open our password vault, click on **File -> Open -> Open URL**. In the URL field, enter the following value:

```
scp://team08-21.studenti.fiit.stuba.sk/home/fiitkar/.keepass/kps.kdbx
```

In the username and password field, please enter the SSH credentials for user **fiitkar**. After that you can select whether you want to be prompted for this login next time.

After clicking OK you should be prompted for the vault master password. Enter the master password and you should be able to view our password vault. 
You will have to enter this master password every time you open this password vault, however, as mentioned earlier, you don't have to enter ssh credentials for fiitkar if you choose the option to save it for next time.

If you add a new record, simply save the password vault with **ctrl+s**. This change will automatically synchronize to our team server.

## How it works
We use open source password manager [KeePass](https://keepass.info/) for password management. The password databse is stored on our team server and is accessed using [SFTP sync plugin](https://github.com/shellster/keepass-sftp-sync) for KeePass. This plugin allows accessing our Database with the SCP protocol (among others). 

The zip file uploaded to our Google Drive is simply a portable keepass distribution with the plugin already installed.
