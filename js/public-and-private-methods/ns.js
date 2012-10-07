/**
 * The method will push the namespace parts onto the window object, so
 * that calling namespace("net.skybert"); will make it possible for
 * you to start creating objects on net.skybert, while keeping
 * existing object you may have pushed on your name space.
 * 
 * Credits go to
 * http://elegantcode.com/2011/01/26/basic-javascript-part-8-namespaces/
 * for creating an elegantly simple name space function. This method is
 * just a little simpler version of that method (no return and no
 * storage variable). Also it doesn't use the Perl-ish || construct.
 * 
 * @pNamespace a string presenting your namespace, delimited by dots,
 * e.g.: net.skybert.io
 */
function namespace(pNamespace) {
  var namespaceParts = pNamespace.split(".");
  var parent = window;

  for (var i = 0; i < namespaceParts.length; i++) {
    if (parent[namespaceParts[i]] == undefined) {
        parent[namespaceParts[i]] = {};
    }
    parent = parent[namespaceParts[i]];
  }
}