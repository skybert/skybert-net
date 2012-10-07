var MyObject = function() {
  var mInternalValue;

  /**
   * Publiclly available method
   */
  this.toString = function() {
    document.writeln("Hello from the public toString method");
  }

  /**
   * Only accessible inside MyObject
   * @param pValue a value to set an internal value.
   */
  var setInternalValue = function(pValue) {
    mInternalValue = pValue;
    document.writeln("Hello from the private setInternalValue method");
  }

  return this;
};    
