title: Tales from OSCON Amsterdam 2015
date: 2015-10-28

Jotting down these memories as I'm waiting for my flight back home
after three days of coolness at OSCON Amsterdam 2015.

## People
Perhaps the best thing about going to OSCON was the people I got to
talk to. It's great to speak to people that write the software that
you've used for ages.

Among others, I talked to people from the
[Mozilla](http://mozilla.org), [LibreOffice](http://libreoffice.org),
Drupal, [Github](http://github.com), O'Reilly (of course), Gitlab,

Compared to a conference like [JavaZone](http://javazone), the free
and open source profile at OSCON is much stronger. People are a lot
more aware of what goes on in the FOSS scene and the geek factor are a
couple of notches higher. It's great to be a place where it's natural
to ask if and what open source project people were involved in.

Glancing at people's laptops showed a great number of people running
Linux natively, something which always gives me a warm fuzzy feeling 😃

## Sonic Pi

The keynotes were generally really good, but one was in a class of its
own: [Sam Aaron's](https://twitter.com/samaaron)
[live coding with Sonic Pi](http://conferences.oreilly.com/oscon/open-source-eu-2015/public/schedule/detail/46068)

## AB testing

> Robbed of context, the result of an experiment is a fart in the wind

Great talk on AB testing by
[@stuartfrisby](https://twitter.com/stuartfrisby)

https://twitter.com/torsteinkrause/status/659268365068972032

<img src="/graphics/2015/oscon/fart.jpg" alt="context is king"/>

## The physical web

This was a session that presented an interesting concept: that mobile
devices can
[interact with systems around you without knowing anything about those machines](https://github.com/google/physical-web):
Just like REST, the machines tell the devices what they can do and
what the devices need to do to operate the machines.

The example that was used was a mobile phone which paid a parking
machine. This worked because the machine broadcasted the URL which the
device needed to access in order to pay the ticket. Thanks to clever
design, the user experience was that the mobile phone had a native
"parking machine app".

A good quote came up during the talk:

> It is a mistake to look too far ahead. Only one link of the chain of
> destiny can be handled at a time.

—Winston Churchill

This was to reflect that there are many problems and criticisms that
come immediately when this
[physical web](https://github.com/google/physical-web) is being
presented. Some slack should be given with the belief that not all
terrible things will come true and good forces will work out hard
problems in time.

## Go bootcamp

I learned a lot about the Go language in this 3.5 hour boot camp,
going from being a complete noob to creating multi processing channel
consumers and producers. The tutor was
[John Graham-Cumming](https://twitter.com/jgrahamc) who did a fine job
of leading us to a higher state of geekness.

Among the things I learned is that Go UNIXy tooling, allowing
building, auto completion (!), linting, documentation lookup and code
formatting offcially supported, from the command line from day one.

The Emacs support also pretty decent, with on the fly syntax checking
through flycheck. To compliment [go-mode](), I wrote a
[write hook that runs `gofmt` whenever you save the file](https://github.com/skybert/my-little-friends/blob/master/emacs/.emacs.d/tkj-go.el).

<img src="/graphics/2015/oscon/2015-10-28_092613_831852204.png" alt="go boot camp"/>

## Kubernetes & Google Cloud SDK bootcamp.

- https://cloud.google.com/sdk/
- https://github.com/kubernetes/kubernetes
- https://github.com/kelseyhightower/intro-to-kubernetes-workshop/
