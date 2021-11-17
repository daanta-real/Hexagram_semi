package util;

public class HexaLibrary {

	// byte[]를 16진수 문자열로 변경해 준다.
	public static String bytesArr_to_hexString(byte[] bytes) {
		StringBuffer sb = new StringBuffer();
		for(byte a : bytes) sb.append(String.format("%02x", a));
		return sb.toString();
	}

}
