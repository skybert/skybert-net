title: Creating All Import Folders
date:    2012-10-07
category: escenic

Given that you've got your Nursery configuration somewhere
under```/etc/escenic/engine```, you can do the following to create all
the import folders your import jobs are referencing:


    $ egrep -r "(import|archive|error)Directory" /etc/escenic/engine | \
    grep -v svn | \
    grep -v \:\# | \
    cut -d'=' -f2 | \
    sort | \
    uniq | \
    xargs mkdir -p


