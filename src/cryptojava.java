import java.security.Key;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Arrays;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

/*
* Encrypt and decrypt with AES-256
*/
public class cryptojava {
 
	private static final byte[] iv = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

	public static String encrypt(String password, String strToEncrypt) throws Exception {
		// Generating IV.
		int ivSize = 16;
        byte[] iv = new byte[ivSize];

		SecureRandom random = new SecureRandom();
		random.nextBytes(iv);
	
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);

		byte[] keyBytes = password.getBytes("UTF-8");
		Key secretKey = new SecretKeySpec(keyBytes, "AES");

	 	// Encrypt
	 	Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");    
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivParameterSpec);
		byte[] encrypted = cipher.doFinal(strToEncrypt.getBytes("UTF-8"));

	 	// Combine IV and encrypted part
		byte[] encryptedIVAndText = new byte[ivSize + encrypted.length];
		System.arraycopy(iv, 0, encryptedIVAndText, 0, ivSize);
		System.arraycopy(encrypted, 0, encryptedIVAndText, ivSize, encrypted.length);

		String base64Encoded = new String(Base64.encodeBase64(encryptedIVAndText));
	
		return base64Encoded;
	}

   
	public static String decrypt(String password, String strToDecrypt) throws Exception {
	 	int ivSize = 16;
	 	byte[] iv = new byte[ivSize];
		byte[] decrypt = Base64.decodeBase64(strToDecrypt.getBytes());

	 	// Extract IV from the 16 first bytes
		System.arraycopy(decrypt, 0, iv, 0, iv.length);
		IvParameterSpec ivParameterSpec = new IvParameterSpec(iv);

		// Extract String to decrypt (without IV)
        int encryptedSize = decrypt.length - ivSize;
        byte[] encryptedBytes = new byte[encryptedSize];
		System.arraycopy(decrypt, ivSize, encryptedBytes, 0,encryptedSize);
    
		// Decrypt with padding (need to perform XML Sec padding by our own)
        byte[] keyBytes = password.getBytes("UTF-8");
	 	Key secretKey = new SecretKeySpec(keyBytes, "AES");
	 	Cipher cipherDecrypt = Cipher.getInstance("AES/CBC/NoPadding");
		cipherDecrypt.init(Cipher.DECRYPT_MODE, secretKey, ivParameterSpec);

        // Need to handle XML sec padding as described here https://www.w3.org/TR/xmlenc-core1/#sec-Padding */ 
		byte[] decrypted_pad = cipherDecrypt.doFinal(encryptedBytes); 
	    byte[] decrypted = null;
		/* Remove XML Sec padding */
		int pad = decrypted_pad[decrypted_pad.length-1];
		if (pad>0) { /* remove last pad values from array */
			int s = decrypted_pad.length - pad;
			decrypted = new byte[s];
			System.arraycopy(decrypted_pad, 0, decrypted, 0, s);
		}
	 	String stringDecoded = new String(decrypted);
		
	 	return stringDecoded;
	}
}
