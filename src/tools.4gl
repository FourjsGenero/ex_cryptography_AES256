import security

# Check input data before encryption
function validateDataForEncryption(plaintext string, symkey string) returns boolean

    define isValid boolean = false

    case
        when plaintext.getLength() == 0
            display "Plaintext is required" to e_status attributes(bold,red)
        when symkey.getLength() == 0
            display "Key is required" to e_status attributes(bold,red)
        when symkey.getLength() != 32
            display "Key need to be 32 characters" to e_status attributes(bold,red)
        otherwise # all data are valid
            let isValid = true
    end case
    
    return isValid
    
end function

# Check input data before description
function validateDataForDecryption(encrypted_str string, symkey string) returns boolean

    define isValid boolean = false

    case
        when encrypted_str.getLength() == 0
            display "Encrypted string is required" to d_status attributes(bold,red)
         --when encrypted_str NOT* VALID
         --   display "Encrypted string is not valid" to status attributes(bold,red)
        when symkey.getLength() == 0
            display "Key is required" to d_status attributes(bold,red)
        when symkey.getLength() != 32
            display "Key need to be 32 characters" to d_status attributes(bold,red)
            
        otherwise # all data are valid
            let isValid = true
    end case

    return isValid
    
end function

# Extract Initialization Vector from the encrypted chain
function extract_iv(encrypted_str string) returns string
    define iv string
    
        # IV is the first 16 bytes of the encrypted string
        let encrypted_str = security.HexBinary.FromBase64(encrypted_str)                # Convert to HEX
        let iv = encrypted_str.subString(1,32)                                          # Extract 16 first bytes (=32 characters)
        let iv = security.Base64.FromHexBinary(iv)                                      # Convert back to base64

        return iv
end function