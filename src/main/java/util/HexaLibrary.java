package util;

public class HexaLibrary {

	// byte[]를 16진수 문자열로 변경해 준다.
	public static String bytesArrToHexString(byte[] bytes) {

		// 1. 변수준비
		StringBuffer sb = new StringBuffer();

		// 2. 변환
		for(byte a : bytes) sb.append(String.format("%02x", a));

		// 3. 결과 회신
		return sb.toString();

	}

	// 16진수 문자열을 byte[]로 변경해 준다. byte[]는 당연히 짝수 길이여야 함.
	public static byte[] hexStringToByteArr(String str) {

		// 1. 변수 준비
	    byte[] bytes = new byte[str.length() / 2];
	    String[] strBytes = new String[str.length() / 2];

	    // 2. 변환
	    for (int i = 0, k = 0; i < str.length(); i += 2, k++) {
	        strBytes[k] = str.substring(i, i + 2);
	        bytes[k] = (byte)Integer.parseInt(strBytes[k], 16);
	    }

	    // 3. 결과 회신
	    return bytes;

	}

}
