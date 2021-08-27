title: javax.crypto.BadPaddingException
date: 2020-11-10
category: java
tags: java, security


```text
javax.crypto.BadPaddingException: Given final block not properly padded. Such issues can arise if a bad key is used during decryption.
  at java.base/com.sun.crypto.provider.CipherCore.unpad(CipherCore.java:975)
  at java.base/com.sun.crypto.provider.CipherCore.fillOutputBuffer(CipherCore.java:1056)
  at java.base/com.sun.crypto.provider.CipherCore.doFinal(CipherCore.java:853)
  at java.base/com.sun.crypto.provider.AESCipher.engineDoFinal(AESCipher.java:446)
  at java.base/javax.crypto.Cipher.doFinal(Cipher.java:2202)            
```

Could arise if you've Base64 encoded the string when encrypting it,
but have forgotten to do so when decrypting it.
