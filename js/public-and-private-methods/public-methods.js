var MyGreatObject = {
  mInternalValue : 0,

  setInternalValue : function(pValue) {
    mInternalValue = pValue;
    document.writeln("Hello from the private setInternalValue method");
  },

  toString : function() {
    document.writeln("Hello from the public toString method");
  }
};    
