# Cryptography-AES256

Encrypt &amp; Decrypt plaint text messages in 4gl &amp; java

![Genero program launcher (GDC)](url)

// README UNDER CONSTRUCTION //

## Prerequisites
GST 3.20.05+

## Compilation in Genero Studio

1. Load the appmenu.4pw project
2. Build the project

## Usage

1. Start the program
2. In Encryption section choose a plaintext to encode and a key (32 characters)
3. Encrypt with 4gl or Java
4. Copy/paste the encrypted string and key in Decryption section
5. Decrypt with 4gl or Java

## Programmer's reference

### Spec

AES256 spec : //url

### Genero

Encrypt
http://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_gws_XmlEncryption_EncryptString.html

```C#
xml.Encryption.EncryptString(
   key xml.CryptoKey,
   strToEncrypt STRING )
  RETURNS STRING
```

Decrypt
http://4js.com/online_documentation/fjs-fgl-manual-html/#fgl-topics/c_gws_XmlEncryption_DecryptString.html

```C#
xml.Encryption.DecryptString(
   key xml.CryptoKey ,
   strToDecrypt STRING )
  RETURNS STRING
```

### Java

Encryp
```java
Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");    
cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec);
byte[] encrypted = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));
```

Decrytp
```java
Cipher cipherDecrypt = Cipher.getInstance("AES/CBC/NoPadding");
cipherDecrypt.init(Cipher.DECRYPT_MODE, secretKey, ivParameterSpec);
byte[] decrypted_pad = cipherDecrypt.doFinal(encryptedBytes); 
```

// padding?
