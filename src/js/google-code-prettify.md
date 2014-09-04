title: Using Google's Code prettifyer
date:    2012-10-07
category: js

Using Google's Code prettifyer adds nice language specific
syntax highlightning to your code examples.


Add the JS to your HEAD and the init method to the onload
handler:


<script>
[..]
<script type="text/javascript"
src="/js/prettify.js">
</script>
</head>
<body onload="prettyPrint()">


Now, for all the```pre``` elements were you list your
code snippets, added the```prettyprint``` CSS class
and reload your browser.

    <pre class="prettyprint">[..]</pre>


Your code is now displayed in all its
colourful glory!

