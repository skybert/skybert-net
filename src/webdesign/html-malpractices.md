date:    2012-10-07
category: webdesign
title: HTML Malpractices
## Multiple Line Breaks

The 
``` br
``` tag is for enforcing a line break, where you don't
trust the browser to do what you want. However, you <em>never
need more than one</em>. If you put more than one line break,
you should rather use a block level element that will produce
the space you want. 


Hence, this is just plain non sense:

    
&lt;p&gt;
My text
&lt;br/&gt;
&lt;br/&gt;
after some space
&lt;/p&gt;



Instead, just start a new paragraph:

    
&lt;p&gt;
My text
&lt;/p&gt;
&lt;p&gt;
after some space
&lt;/p&gt;



