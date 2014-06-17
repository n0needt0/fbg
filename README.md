#Tutorial for Git
###Preliminary Command Line Knowldge
+ **pwd** --> Print the working directory, AKA where you are.
+ **whoami** --> What your username is.
+ **ls** --> List what is in the directory <ul><li>**-l** --> Lists with more metadata.</li><li>**-a** --> Shows hidden files.</li></ul>
+ **mkdir** *DIRECTORY_NAME* --> Creates an empty directory with that name.
+ **touch** *FILE_NAME* --> Creates an empty file with that name.
+ **sudo apt-get install** *PACKAGE_NAME* --> Downloads a package.

Using **sudo apt-get install**, download *vim* and *git*. Vim is a shortcut-heavy editor which can be difficult to use. There are two modes in Vim: *insert mode* and *command mode*. By default, Vim opens in command mode. Commands are usually preceded with a colon. To enter insert mode, press **i**. To go back to command mode, press either **escape** or **ctrl c**.

In command mode, to save press **: w**. This is supposed to signify "writing to the file." To quit Vim, press **: q**. You must save before hand, or else it will fail. If you want to quit without saving changes, press **: q !**. This is a force quit.

###What is Git?
Git is a version control system. It allows multiple people to work on different pieces of a project, while still keeping a very good record of every change made. Every project is a *repository*. This repository must have a central host, such as *GitHub*. Different people own *branches* of the project - that is - their own versions. When you are done editing your own branch, you have to *commit* a change, and *add* any changes to the commit. This will require you to write a commit message in Vim. Once this is done, you can *push* your commit to a remote branch.

Sometimes, however, someone will have updated the main branch before you committed. Thus, you will have competing versions of changes. To resolve these, you must *pull* changes before you can *push* new ones. Once you do that, Git will try to *merge* the two versions. It will mark any differences in your files. You must then manually change each merge so that the new version is correct. Only then can you push.

###What Should I Do?

To get this repository, go to a directory, and type in **git clone https://github.com/n0needt0/fbg.git fbg**. This will clone the current project into a subdirectory called fbg.