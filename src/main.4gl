import xml
import security
import java cryptojava

main
    # Initialize sample
    define e_plaintext string = "Hello World"
    define e_symkey string = "12345678901234567890123456789012"
    define d_plaintext, d_symkey string
    define e_encrypted_str, d_encrypted_str string
    define e_iv string = "-"
    define d_iv string = "-"
    define isEncypted, isDecrypted boolean
    define ui_form ui.Form

    call ui.Interface.loadStyles("style")
    open form w_form from "form"
    display form w_form
    let ui_form = ui.Window.getCurrent().getForm()
    
    dialog attributes(unbuffered)
        input e_plaintext from e_plaintext attributes(without defaults) end input
        input e_symkey from e_key attributes(without defaults) end input
        input e_iv from e_iv attributes(without defaults) end input 
        input e_encrypted_str from e_encryptedstring end input
        input d_plaintext from d_plaintext attributes(without defaults) end input
        input d_symkey from d_key attributes(without defaults) end input
        input d_iv from d_iv attributes(without defaults) end input 
        input d_encrypted_str from d_encryptedstring end input

        # Encryption 4gl
        on action encrypt_4gl
            if validateDataForEncryption(e_plaintext, e_symkey) then 
                call encrypt_4gl(e_plaintext, e_symkey) returning e_encrypted_str, isEncypted

                if isEncypted then
                    let e_iv = extract_iv(e_encrypted_str) 
                    # set styles
                        call ui_form.setFieldStyle("e_encryptedstring", "blue")
                        call ui_form.setFieldStyle("d_plaintext", "")
                end if
            end if

        # Decryption 4gl
        on action decrypt_4gl
             if validateDataForDecryption(d_encrypted_str, d_symkey) then
                call decrypt_4gl(d_encrypted_str, d_symkey) returning d_plaintext, isDecrypted
                if isDecrypted then
                    let d_iv = extract_iv(d_encrypted_str) 
                    # set styles
                        call ui_form.setFieldStyle("d_plaintext", "blue")
                        call ui_form.setFieldStyle("e_encryptedstring", "")
                end if
            end if

        # Encrypt Java
        on action encrypt_java
            if validateDataForEncryption(e_plaintext, e_symkey) then 
                 try
                    let e_encrypted_str = cryptojava.encrypt(e_symkey, e_plaintext)
                    let e_iv = extract_iv(e_encrypted_str)

                    display "Encrypted !" to e_status attributes(bold,blue)   
                    # set styles
                        call ui_form.setFieldStyle("e_encryptedstring", "blue")
                        call ui_form.setFieldStyle("d_plaintext", "")
                catch
                    display "Error during encryption" to e_status attributes(bold,red)
                end try
            end if

        # Decrypt Java
        on action decrypt_java
             if validateDataForDecryption(d_encrypted_str, d_symkey) then
                try 
                    let d_plaintext = cryptojava.decrypt(d_symkey, d_encrypted_str)
                    let d_iv = extract_iv(d_encrypted_str)

                    display "Decrypted !" to d_status attributes(bold,blue)
                    # set styles
                        call ui_form.setFieldStyle("d_plaintext", "blue")
                        call ui_form.setFieldStyle("e_encryptedstring", "")
                catch
                    display "Error during decryption" to d_status attributes(bold,red)
                end try
            end if

        on action close
            exit dialog
            
    end dialog   
    
end main