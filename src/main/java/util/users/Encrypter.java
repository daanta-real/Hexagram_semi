package util.users;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import util.HexaLibrary;

public class Encrypter {

	// 0. 변수준비
	private static int SALT_SIZE_BYTES = 32;               // 솔트 길이(바이트)
	private static int KEY_STRETCHING_ITERATIONS = 500000; // 키 스트레칭 횟수(회)

	// 1. 솔트 생성
	public static byte[] getSalt() {
		SecureRandom random = new SecureRandom();
		byte[] saltArr = new byte[SALT_SIZE_BYTES];
		random.nextBytes(saltArr);
		return saltArr;
	}

	// 2. 실제 해쉬 생성
	public static String getHash(String pw, String saltStr) throws NoSuchAlgorithmException { // salt가 Hex String으로 들어오는 경우
		byte[] salt = HexaLibrary.hexStringToByteArr(saltStr);
		return getHash(pw, salt);
	}
	public static String getHash(String pw, byte[] salt) throws NoSuchAlgorithmException {

		// 변수준비
		byte[] strBytes = pw.getBytes();
		// Digest 생성기 인스턴스를 부르고, salt 값을 대입해 준다.
		MessageDigest md = MessageDigest.getInstance("SHA-256");

		// Key Stretching을 반복 실시한다. 이때 매 해시 생성 시마다 Salt를 붙여서 생성한다.
		// for문을 다 돌고 나면 byte[] strBytes가 나오는데 이게 최종이다.
		System.out.println("[해시] 생성 시작..");
		long start = System.currentTimeMillis();
		for(int i = 0; i < KEY_STRETCHING_ITERATIONS; i++) {
			md.update(strBytes);
			md.update(salt);
			strBytes = md.digest();
		}
		long end = System.currentTimeMillis();
		System.out.println("[해시] 생성 완료. 실행 소요시간 1: " + (end - start)/1000.0 + "초");

		// 완성된 해쉬 문자열을 반환.
		String result = HexaLibrary.bytesArrToHexString(strBytes);
		System.out.println("[해시] 완성된 해시값: " + result);
		return result;

	}

}