package mind;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Hash {

    /**
     * adopted from de.mindbroker.core.Hash
     */
    public static String getHash( String secret) throws NoSuchAlgorithmException {
	MessageDigest md = MessageDigest.getInstance( "SHA" );
	md.update( secret.getBytes() );
	byte digestedBytes[] = md.digest();
	return convert( digestedBytes );
    }
  
    /**
     * from org.apache.catalina.util.HexUtils
     */
    public static String convert(byte bytes[]) {
	StringBuffer sb = new StringBuffer(bytes.length * 2);
	for (int i = 0; i < bytes.length; i++) {
	    sb.append(convertDigit((int) (bytes[i] >> 4)));
	    sb.append(convertDigit((int) (bytes[i] & 0x0f)));
	}
	return (sb.toString());
    }

    /**
     * from org.apache.catalina.util.HexUtils
     */
    private static char convertDigit(int value) {
	value &= 0x0f;
	if (value >= 10) {
	    return ((char) (value - 10 + 'a'));
	}
	return ((char) (value + '0'));
    }

    /**
     * simple test
     */
    public static void main(String[] args) throws Exception {
	System.out.println(getHash("pYtSPMCyT5#rx"));
    }  
}