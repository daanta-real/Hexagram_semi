package test.tdd.users.usersPwMaker;

import java.security.NoSuchAlgorithmException;

import util.HexaLibrary;
import util.users.Encrypter;

public class Main {

	public static String getHash(String pw) throws NoSuchAlgorithmException {
		// 비밀번호 관련 정보는, 비밀번호알고리즘명(algo), 솔트(salt), 해쉬값(hashOrg) 이렇게 세 개를
		// $문자로 합쳐 단일 문자열로 만든 뒤 DB의 usersPw 컬럼에 저장시킬 것이다.
		// "algo$aslt$hashOrg" 이런 식으로..
		String algo = "SHA-256";
		String saltStr = HexaLibrary.bytesArrToHexString(Encrypter.getSalt());
		String hash = Encrypter.getHash(pw, saltStr);

		System.out.println("algo: '" + algo + "'");
		System.out.println("saltStr: '" + saltStr + "' (길이 " + saltStr.length() + ")");
		System.out.println("hash: '" + hash + "' (길이 " + hash.length() + ")");

		String result = String.format("%s$%s$%s", algo, saltStr, hash);
		return result;
	}

	public static void main(String[] args) throws NoSuchAlgorithmException {

		String pw = "1234";
		String hash = getHash(pw);
		System.out.printf("비밀번호 저장: \"%s\" (길이 %d)", hash, hash.length());

		// 더미데이터용 해쉬를 생성해 봅니다
		String[] pwArr = {"admin1@", "Admin1@", "admin_admin3", "_admin1", "admin##1", "admin3@", "testtest1!", "testtest2!", "rhasdfafsn3#", "135131353as@", "$%@#$%$@a12", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "cccc12@", "monkey2@", "MoNkey@2", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf", "asdfasdf", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@", "asdfasdf12@"};
		String[][] pwResultArr = new String[pwArr.length][2];
		for(int i = 0; i < pwArr.length; i++) {
			pwResultArr[i] = new String[] { pwArr[i], getHash(pwArr[i]) };
			System.out.println("__\t" + pwResultArr[i][0] + "\t" + pwResultArr[i][1]);
		}

	}

}
