namespace("net.skybert");
net.skybert.io = {
  toString : function() {
    document.writeln("hello from net.skybert.io");
  }
};

/* Illustrating that a second call to the namespace inject method
 * doesn't do away with previosuly pushed namespaces */
namespace("net.skybert");

net.skybert.audio = {
  toString : function() {
    document.writeln("hello from net.skybert.audio");
  }    
}

net.skybert.io.toString();
net.skybert.audio.toString();
