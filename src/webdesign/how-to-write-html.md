date:    2012-10-07
category: webdesign
title: How to code HTML
## Introduction
<p class="reg">
"Everyone" believes they know how to write HTML code. People
consider it as THE basic skill in the computer world, and
they are right, HTML is definitely one of the basic,
fundamentals of computer science and is not hard at
all once you get the grips with it. 


Even so, there's extremely rare to come across a site
that is properly written. Most people don't actually know
how to do HTML properly, the right way. It is only
the grace of web browsers, and especially the blind
stupidity of kindness from Microsoft Internet Explorer, that
make people's pages work at all on the world wide web.


Worse is, that when looking through a dusin of HTML coding
books, there's not one that teaches it properly. It's just
"quick and dirty" and low level Mickey Mouse code that
is taught, no one seems to take HTML seriously.


This is not done any better by the vast majority of
WYSIWYG programs that produces crappy code, such
as Frontpage, Dreamweaver and HotMetal. A lot of people
say that these produce "not bade code at all", especially
Dreamweaver gets a lot of praise in this respect. But,
I would argue that it's only people that don't know
how to do it the proper way that use these programs. Once
you're comfertable with the robes of HTML and CSS, it's
faster, a lot more acurate and better craftmanship alltogether
to code the pages yourself.


I will
on this page teach you how to do HTML properly, how it
was meant to be and how it should be. If you write
proper HTML code, you will have greater control and your
page stand a better chance of being displayed identically
on all browsers. So, if you want to take "the path
less travelled by", read on dear traveller.

## The Road Less Travelled By

# 
<a href="#what">What HTML is</a>,
so you know what you're talking about
# 
<a href="#how">How HTML elements work together</a>, so you know
what you're doing.

# 
<a href="#howto">How to write your code</a>,
so it looks like you know what you're doing

# 
<a href="#validate">How to validate your code</a>,
so you can prove you know what you're doing.


<h2><a name="what">What HTML is</a></h2>

HTML is short for HyperText Markup Language and is
a language for describing how documents should be
presented. It is not a programming language as some people
mistakenly call it, but a language you use to
tell how you want your data to be displayed, either
on screen, paper, voice or blind displays.

<div class="image">
<img src="../../../graphics/computers/w3c.png"
alt="W3C" />

It was first presented by Tim Berners Lee and is now
maintained by the
<a href="http://www.w3c.org">World Wide Web Consortium</a>.
This is an independent, non profit organ that sets the standards
on the web, much like a goverment in a country.


There are different versions of HTML, the ones you
should know about is HTML 3.2, HTML 4.0, HTML 4.01
and XHTML 1.0.


The specifications are written as a DTD, a Document
Type Definition, which is a document written in
SGML, another language, describing what is allowed
and what is not allowed in the different HTML versions.
The DTD is the ultimate reference when coding (X)HTML.


Version 3.2 is old style, which should
be avoided as newer offer better ways of doing things.
3.2 is very forgiving and "nice". It combines
presentation and structure, meaning it has elements
and arguments for telling how you want things to "look",
including &lt;font&gt; and &lt;center&gt;. 

<div class="image">
<img src="../../../graphics/computers/html_validated.png"
alt="html validated" />

It was then decided that HTML should only be used
to describe the <em>structure</em> of the document and
that all formatting/visual information should be
given elsewhere, for example with the use of a
<a href="viewpage.py.cgi?computers+webdesign+css">
Cascading Style Sheet
</a>. HTML 4.0 was released with this given in its
definition and all elements like &lt;font&gt; and &lt;center&gt;
were deprecated and not allowed to be used anymore. Version 4.01
quickly followed, and was more or less a rewrite of
the 4.0 with the inclusion of the "name" attribute, needed
for the highly popular "image swap" JavaScript and
various CGI interfaces.

<div class="image">
<img src="../../../graphics/computers/xhtml_validated.png"
alt="xhtml validated" />

As the XML was introduced as a generic language of
defining data, XHTML was introduced to give an HTML version
of XML. Basically it is HTML 4.01 but stricter. Following
the XML recommendation, all elements must be lower case,
"name" is not allowed as an attribute and empty
elements must be closed. I will use XHTML in my
examples in this tutorial.


To show the world (&nbsp;and the validator&nbsp;) that
you know which HTML specification you are coding after,
you must insert a DOCTYPE header in your HTML file.
This is a line of code that says which DTD your writing
after, and where it can be found. I use this
header for my XHTML files, remember to that this
must be on the first line, otherwise it will just
confuse the validator or browser. 

    
&lt;!DOCTYPE html PUBLIC
"-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
&gt;



You can find the approperiate DOCTYPE headers for the other
versions of HTML at the
<a href="http://www.w3c.org">World Wide Web Consortium</a>
website.


Now you know more about HTML than most web designers and web
programmers. Seriously.

<h2><a name="howto">How HTML elements work together</a></h2>

HTML consists of a number of elements which each have
their properties and uses. 

### The html, body and head

The "biggest" element is the <em>html</em>
element. It can hold two, and only two, other 
elements, namely <em>head</em> and <em>body</em>. 
An HTML document needs a body, but not a head. If you
do have a head, you need a <em>title</em> inside
the head.

    
&lt;html&gt;
&lt;head&gt;
&lt;title&gt;If you have a head you must have a title&lt;/head&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;/body&gt;
&lt;/html&gt;



Apart from these three, special elements (&nbsp;which to a great
extent are block level elements&nbsp;),
there are two kinds of elements, inline elements and
block level elements.

### Block level elements

Block level elements have the thing in common that
they can contain other elements. They can hold
both inline elements and other block level elements.


The commonly used block level elements are <em>p</em>,
<em>div</em>, <em>form</em>, <em>pre</em>, <em>tr</em>
and <em>table</em> (&nbsp;<em>font</em> and <em>center</em>
are both block level elments,
but are deprecated in HTML version 4.0 and should therefore
not be used&nbsp;).

    
&lt;p&gt;
The paragraph, <em>p</em>, is a block level element.
&lt;/p&gt;


### Inline elements

These elements cannot hold other elements. They also
<em>must</em> reside within a block level element.
For example, an anchor/web link cannot exist
on its own, but need a block
level element "to take care of it". For example
a paragraph.

    
&lt;p&gt;
&lt;a href=""&gt;My web link is an inline element&lt;/a&gt;
and resides within a block level element, namely a
paragraph.
&lt;/p&gt;



The commonly used inline elements are <em>img</em>, 
<em>a</em>, <em>input</em>, <em>span</em>,
<em>em</em>, <em>strong</em>, <em>link</em>, <em>br</em>,
<em>meta</em>, <em>title</em>, <em>script</em>, 
<em>th</em>, <em>td</em>, <em>script</em>, <em>code</em>
and <em>h1-h6</em> (&nbsp;<em>b</em>,
<em>i</em>, <em>u</em> are all inline elements,
but deprecated in HTML version 4.0 and should therefore
not be used&nbsp;).


You shouldn't really use the linebreak element, <em>br</em>,
as it controls the appearance of the document. Again,
everything (&nbsp;as far as possible&nbsp;) about the
looks of your page should be given in a stylesheet.

### Attributes

Attributes are the things written inside the
tags of the start element after the element name
itself. The attribute consist of two parts, the
attribute name and the attribute value. The
attribute value should be given with double
quotes around it.

    
&lt;div attribute_name="attribute_value" /&gt;



The reason why you should not
use single quotes is that JavaScript instructions
may be given in an attribute, and these may use
single quotes for strings without messing up
your markup and confusing the browser.


    
&lt;input id="my_button_id"
type="button"
onclick="javascriptFunction( 'You clicked a button' );"
/&gt;


<h2><a name="howto">Writing Your Code</a></h2>

How you write your code is entirely up to you,
but I have some strong recommendations on how to do
it for reasons which I will make clear below.

### Indentation size

I think 3 space indentiation is right, whereas others
think 2 is enough and other again pick 8 spaces
for each indentation. The important thing is that
you are consistent.

### Inline and block level elements

Inline elements should be indented inside block level elements.
Inline elements are affected by the block level element(s)
which they reside within. For example will a link
inherit the colours and font from the block it is within.
By indenting the inline elements inside block level
elements, you keep a clear overview on how elements
affect eachother. Block level elements can also influence
other block level elements that reside within, so
everything should be indented.

    
&lt;div&gt;
&lt;a href=""&gt;An anchor/link is an inline element&lt;/a&gt;
&lt;div&gt;
This div is inside the other div, and is therefore
indented like this.
&lt;/div&gt;
&lt;/div&gt;



Indenting like this, with open element and corresponding close
element over one another also makes it a lot easier to
see if you've closed all your elements.


By being consequent with your indentation, it is
at all times easy to see which elements that
contain which. For example, the <em>head</em> and <em>body</em>
elements should be indented under the <em>html</em> element,
as this is the mother these.

### Attributes

To keep a clear and concise style, it is important
to have everything on one line, including the indentaiton.
This can be difficult if you have attributes that
will make the total space the element takes
exceed the line width in your editor. Therefore, I
indent the atttributes under one another with the
closing tag under the opening one. Once you start
with this, you will gain a <em>far</em> greater
control over complex elements, and it will also
be benefitial for clearity when coding XML.

    
&lt;img src="graphics/my_picture.png"
alt="My picture text"
id="my_picture_id"
/&gt;



As you can see, I keep the element name clear,
and indent all attributes according to the first attribute
name.

<h2><a name="validate">Validating Your Code</a></h2>
<div class="image">
<img src="../../../graphics/computers/xhtml_validated.png"
alt="xhtml validated" />

To ensure that you have done everything correctly, there's
two things you should do. Firstly, go to the
<a href="http://validator.w3.org">
World Wide Web Consortium validator
</a> and let it run through your page. It will list
any error it finds, if any alongside with explenations
for why this is an error. Don't give up until there's
no errors left, and it says "validated!".


You can then put a validation icon on your page
to tell the world that you:


# 
care about good HTML craftmanships

# 
that you have taken heed to ensure that your pages stand
a better chance of being viewed correctly on all
standards compliant web browsers, also taken into account
Braille (&nbsp;browser for visually impaired&nbsp;) and

# 
that you have successfully written after a W3C standard
and done so without any errors.



The other thing you should do, is to read through the
whole HTML recommendation at <a
href="http://www.w3c.org/MarkUp">World Wide Web
Consortium</a> to ensure that you have understood
everything. Just because your site validates doesn't mean
that you have done everything correctly, it's just likely
:-)


But seriosuly, I strongly believe that you are able
to start walking "the road less travelled by" coding
HTML the proper just after reading this article. Read the
above document at W3C only if you feel you want more
in-depth and thorough discussion on the subject.
Also, refer to W3C to find the full HTML specifications
and DTD.            


Happy coding!

