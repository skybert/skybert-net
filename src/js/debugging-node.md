title: Debugging Node JS
date: 2017-01-10
category: js
tags: js, node

## Debugging how node searches for modules to load (require)

Say you've got a piece of JavaScript that says:

```js
var SchemaAssembler = require("my-module/myComponent").SchemaAssembler;
```

And this fails to load, `node` giving a mediocre:

```text
{ Error: Cannot find module my-module/myComponent }
```

You can investigate this by setting the environment variable `NODE_DEBUG`:

```text
export NODE_DEBUG=module
# node ....main.js ....
[..]
MODULE 14489: Module._load REQUEST my-module/myComponent parent:
  /opt/escenic/waiter/recipe/recipe.js

MODULE 14489: looking for "my-module/myComponent" in
["/opt/escenic/waiter/recipe/node_modules",
  "/opt/escenic/waiter/node_modules",
  "/opt/escenic/node_modules",
  "/opt/node_modules",
  "/node_modules",
  "/root/.node_modules",
  "/root/.node_libraries",
  "/usr/lib/node"]
```


