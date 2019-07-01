# Cryptography-AES256

Encrypt &amp; Decrypt plaint text messages in 4gl &amp; java

![Genero program launcher (GDC)](https://github.com/FourjsGenero/ex_cryptography_AES256/blob/master/image/presentation.png)

## Prerequisites
GST 3.20.05+

## Compilation in Genero Studio

1. Load the crypto.4pw project
2. Build the project

## Usage

1. Start the program
2. In Encryption section choose a plaintext to encode and a key (32 characters)
3. Encrypt with 4gl or Java
4. Copy/paste the encrypted string and key in Decryption section
5. Decrypt with 4gl or Java

## Programmer's reference

### Spec

AES (Advanced Encryption Standard) is a specification for the encryption of electronic data established by the U.S. National Institute of Standards and Technology (NIST) in 2001.
The algorithm described by AES is a symmetric-key algorithm, meaning the same key is used for both encrypting and decrypting the data.

4gl encryption is based on W3C XML Encryption Syntax and Processing : 

https://www.w3.org/TR/xmlenc-core1/#sec-Padding

### Genero

- Encrypt

http://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_gws_XmlEncryption_EncryptString.html

```
xml.Encryption.EncryptString(
   key xml.CryptoKey,
   strToEncrypt STRING )
  RETURNS STRING
```

- Decrypt

http://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_gws_XmlEncryption_DecryptString.html

```
xml.Encryption.DecryptString(
   key xml.CryptoKey ,
   strToDecrypt STRING )
  RETURNS STRING
```

### Java

- Encryp
```java
Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");    
cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec);
byte[] encrypted = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));
```

- Decrypt
```java
Cipher cipherDecrypt = Cipher.getInstance("AES/CBC/NoPadding");
cipherDecrypt.init(Cipher.DECRYPT_MODE, secretKey, ivParameterSpec);
byte[] decrypted_pad = cipherDecrypt.doFinal(encryptedBytes); 
```

### Other
- Initialization vector (what it is, how to use in 4gl/java)
- Padding (required to implement java decryption)
