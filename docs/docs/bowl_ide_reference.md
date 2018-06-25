# Bowl IDE Reference

## Contents of the bowl.

This bowl runs the `Ubuntu (Xenial)` distribution of Linux.

The terminal on the right uses the `bash` shell.

The text editor is `codiad`.

This documentation is being presented by `mkdocs`.

## Using the text editor.

### Editing a file.

To edit a file simply double-click on the project you want to edit in the bottom left corner, and then double click on the file you want to edit from the file-tree on the left.

To save your changes press `CTRL+s` or open the menu by clicking on the tab with three lines on the right and selecting 'Save Project'.

### Adding a project to the editor.

To add a project to the editor, make a directory for it  (`/home/user/projects` is normally a good place).
Then open the menu by clicking on the tab with three lines on the right and select 'Projects' and then 'Create New Project'.

Here give the full path to the folder you've created and a name for the project.

## Editing the documentation.

You will see a project in the editor called 'docs'.

Edit the files here to change the docs and refresh the page to see the changes (live reload coming soon!).

The documentation is presented by `mkdocs` - read the guide [here](https://www.mkdocs.org/user-guide/writing-your-docs/) to see how to do things like add pages and files.

The documentation itself is written in markdown. You can see a quick reference [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## Running Web Services.

You can run a local web service and connect to it by sticking `/port/<port number>/` at the end of the URL.

NOTE: don't forget the trailing slash!

Some port numbers will be taken including:

* 8080
* 80
* 3000
* 6000
* 8000
