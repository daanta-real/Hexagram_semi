package test.tdd.users.usersPwMaker;

import java.security.NoSuchAlgorithmException;

import util.HexaLibrary;
import util.users.Encrypter;

public class Main {

	public static void main(String[] args) throws NoSuchAlgorithmException {

		String pw = "1234";

		// 비밀번호 관련 정보는, 비밀번호알고리즘명(algo), 솔트(salt), 해쉬값(hashOrg) 이렇게 세 개를
		// $문자로 합쳐 단일 문자열로 만든 뒤 DB의 usersPw 컬럼에 저장시킬 것이다.
		// "algo$aslt$hashOrg" 이런 식으로..
		String algo = "SHA-256";
		String saltStr = HexaLibrary.bytesArrToHexString(Encrypter.getSalt());
		String hash = Encrypter.getHash(pw, saltStr);

		System.out.println("algo: '" + algo + "'");
		System.out.println("saltStr: '" + saltStr + "' (길이 " + saltStr.length() + ")");
		System.out.println("hash: '" + hash + "' (길이 " + hash.length() + ")");
		System.out.printf("비밀번호 저장: \"%s$%s$%s", algo, saltStr, hash);

	}

}
