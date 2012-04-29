to-env
==========

Run a shell command and save results to variables for easy access.

Home page: [https://github.com/von/to-env](https://github.com/von/to-env)

usage: *to-env [-p prefix] command*

Captures each line of output from command into a shell variable,
starting with *e1* for the first line and incrementing the number for
each subsequent line. The *-p* option allows you to change the
variable prefix from *e* to one of your choosing.

A simple example:

    $ source to-env.sh 
    $ to-env "ls -1"
    [1] README.md
    [2] to-env.sh
    [3] to-env.sh~
    $ echo $e1
    README.md
    $ echo $e2
    to-env.sh

Use to-env to capture long pathnames and manipulate them easily:

    $ to-env "ls -1t ~/Documents/Manuals/* | head -3"
    [1] /Users/von/Documents/Manuals/ODB2_Reader_Manual_RevA_E_Final_downloadable.pdf
    [2] /Users/von/Documents/Manuals/nexusone-userguide.pdf
    [3] /Users/von/Documents/Manuals/WiseOneBGERecipes.pdf
    $ cp $e2 /tmp
    $ ls -l /tmp/nexusone-userguide.pdf 
    -rw-r--r--  1 von  wheel   4.2M Apr 26 20:46 /tmp/nexusone-userguide.pdf

An example showing something besides 'ls' and the fact the command
doesn't have to be quoted if it doesn't contain metacharacters:

    $ to-env grep github to-env.sh
    [1] # Homepage: https://github.com/von/to-env
    $ echo $e1
    # Homepage: https://github.com/von/to-env	

Use *-p prefix* to change the prefix for the variables:

    $ to-env -p foo ls -1
    [1] #README.md#
    [2] README.md
    [3] to-env.sh
    [4] to-env.sh~
    $ echo $foo2
    README.md

The inspiration for to-env came from
[SCM Breeze](https://github.com/ndbroadbent/scm_breeze).


