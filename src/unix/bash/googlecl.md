date:    2012-10-07
category: bash
title: Google CLI

<a href="http://code.google.com/p/googlecl">GoogleCL</a> is
great as it gives you command line access to a number of
Google's services. The best thing is that it's supported by
Google themselves and I therefore believe it'll be the best
CLI tool to use with the Google services once the project
matures.

<h2>
Calendar events are always added to the following day 
</h2>

I had the problem that

    $ google calendar add "Dinner at Tiffany's"


always would add the event on the next day, not today's
date. I just had a hunch it was related to timezone (although
that normally doesn't imply date + 24 hours, more +/- a few
hours). Anyway, putting 

    export TZ='Europe/Oslo'


in my```$HOME/.bashrc``` remedied it. Now all my
events are added to the correct day and time.

