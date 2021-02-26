package trip.encryption;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.context.annotation.Configuration;
@Configuration
public class PasswordEncoder {
	
	public String encrypt(String password) {
		String encPass = "";
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(password.getBytes());
			byte[] byteData = sh.digest();
			StringBuffer sb = new StringBuffer();
			for(int i=0 ; i<byteData.length ; i++) {
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			encPass = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	
		return encPass;
}
}
