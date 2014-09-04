title: escenic
date:    2012-10-07
category: escenic

Updating the publication resources for my Escenic publication
is so easy <a
href="https://github.com/skybert/ece-scripts/blob/master/usr/bin/ece">with
the new ece script</a>.


Here, I have all my publication resource in a folder on my
local computer:

    $ ls my-dir-with-publication-resources
content-type  feature  image-version  layout  layout-group  security


I can now update all of them for my publication "mypub" with
one line of BASH:

    $ cd my-dir-with-publication-resources
    $ for el in *; do ece -i dev1 -p mypub -r $el update; done
[ece#engine-dev1] Updating the content-type resource for the mypub publication
[ece#engine-dev1] Updating the feature resource for the mypub publication
[ece#engine-dev1] Updating the image-version resource for the mypub publication
[ece#engine-dev1] Updating the layout resource for the mypub publication
[ece#engine-dev1] Updating the layout-group resource for the mypub publication
[ece#engine-dev1] Updating the security resource for the mypub publication


That's it, all my publication resources are now up to date.

