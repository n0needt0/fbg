#Tutorial for Git
###Preliminary Command Line Knowledge
+ **pwd** --> Print the working directory, AKA where you are.
+ **whoami** --> What your username is.
+ **cd** *DIRECTORY_NAME*--> Change the current directory you are in to the directory specified, use **..** to go up.
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

To get this repository, go to a directory, and type in **git clone https://github.com/n0needt0/fbg.git fbg**. This will clone the current project into a subdirectory called fbg. Once this is done, you should be able to edit and add files at will. When you have made a significant edit which can be summarized into a statement, stop working and run **git add** *SOMETHING* on any directories or files you have edited. Then run **git commit**. This will automatically open up Vim to create a commit message. Go into edit mode and write 50 characters or less on what you did. When you're done, save your edit and exit vim. Continuously run **git pull** so that you have the latest version of the code. Check any differences, and continue working. After you've performed a few commits, you may feel it is time to push your branch onto the remote branch. Pull and merge a final time, then run **git push -a** to put your changes on the remote branch.

To summarize:

+ **git clone** copies a project
+ **git commit** saves changes locally
+ **git push** pushes your changes upstream
+ **git pull** pulls from the upstream