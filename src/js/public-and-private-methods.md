title: Having only public methods inside a JS object
date:    2012-10-07
category: js


If you want all your object methods to be public (or don't mind them
being public), you can simply define:


The advantage here, is that you don't need any ```new function``` or
```return this inside your object```. Also, you don't need any
```MyGreatObject.``` or ```this.``` prefix to your public methods.


For most cases, I find this approach the neatest; I don't mind
that all of my methods are accessible to callees.

## Having both private and public methods inside a JS object

This is my preferred way of mixing private and public methods
in a JavaScript object. The advantage is obviously that you don't expose more methods to the outside world than you strictly need to.

