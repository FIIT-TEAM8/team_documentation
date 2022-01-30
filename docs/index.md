# Home

You can edit this documentation directly in Github without needing to clone the repository to your machine. Github also offers a markdown preview, which is very convenient for this purpouse. Simply start by creating a file or a folder inside the **docs** directory of the repository and after commiting these changes, updated documentation will automatically be redeployed containing your changes. 

This documentation uses [mkdocs](https://www.mkdocs.org/) project with the [mkdocs-material](https://squidfunk.github.io/mkdocs-material/) plugin. You can edit **mkdocs.yml** to change the appearance and behaviour of this site. For details, refer to the mkdocs-material website.

## Documentation structure
Each module should be contained inside the **modules** folder. It can be represented by a single markdown file or a folder containing multiple related documents. This structure will be automatically reflected in the page navigation.


## Editing documentation localy
If you preffer to edit this documentation localy, clone this repository and install the needed python dependencies:

```
pip install -r requirements.txt
```

After that, go to the root of this repository and run this command:

```
mkdocs serve
```

This will run a simple webserver that will automatically update the served content as soon as you edit any files. After you are done, simply comit and push your changes. The deployed documentation will update automatically.
