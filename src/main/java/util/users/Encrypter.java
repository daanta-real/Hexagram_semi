package util.users;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import util.HexaLibrary;

// 암호화(해싱)된 문자열 생성 그 자체를 위한 라이브러리이다.
// (해싱된 문자열을 활용하는 내용은 본 라이브러리가 아니고 HashChecker 라이브러리임)
public class Encrypter {

	// 0. 변수준비
	private static final String ALGO = "SHA-256";                   // 사용 알고리즘명
	private static final int    SALT_SIZE_BYTES = 32;               // 솔트 길이(바이트)
	private static final int    KEY_STRETCHING_ITERATIONS = 500000; // 키 스트레칭 횟수(회)

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

	// usersPw 컬럼에 들어갈 양식문자열 암호 + 솔트를 해쉬값으로 저장
	// salt는 꺼내서 대조할 때나 쓰지 문자열을 만드는 지금은 회신할 필요 없다.
	public static String getUsersPwColumnTxt(String pw) throws NoSuchAlgorithmException {

		// 각 재료문자열들 준비
		String algo = ALGO;
		String salt = HexaLibrary.bytesArrToHexString(getSalt());
		String hash = getHash(pw, salt);

		// 결과물자열 만들어 회신
		String result = String.format("%s$%s$%s", algo, salt, hash);
		return result;

	}

}