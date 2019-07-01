import xml

# Encryption AES256
function encrypt_4gl(plaintext string, symkey string) returns (string, boolean)
    define cryptoKey xml.CryptoKey 
    define encrypted_str string
    define isEncrypted boolean = false
    
    try
        # Creation and assign of the cryptokey
        let cryptoKey = xml.CryptoKey.Create("http://www.w3.org/2001/04/xmlenc#aes256-cbc")
        call cryptokey.setKey(symkey)

        # Encryption
        let encrypted_str = xml.Encryption.EncryptString(cryptoKey, plaintext)

        let isEncrypted = true
        display "Encrypted !" to e_status attributes(bold,blue)
        
    catch
        display "Error during encryption" to e_status attributes(bold,red)
    end try

    return encrypted_str, isEncrypted
       
end function

# Decryption AES256
function decrypt_4gl( encrypted_str string, symkey string) returns (string, boolean)
    define decrypted_str string
    define cryptoKey xml.CryptoKey
    define isDecrypted boolean = false

    try
        # Creation and assign of the cryptokey
        let cryptoKey = xml.CryptoKey.Create("http://www.w3.org/2001/04/xmlenc#aes256-cbc")
        call cryptokey.setKey(symkey)

        # Decryption
        let decrypted_str = xml.Encryption.DecryptString(cryptokey, encrypted_str)

        let isDecrypted = true
        display "Decrypted !" to d_status attributes(bold,blue)
    catch
        display "Error during decryption" to d_status attributes(bold,red)
    end try

    return decrypted_str, isDecrypted
                
end function