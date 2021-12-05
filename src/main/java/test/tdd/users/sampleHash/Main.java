package test.tdd.users.sampleHash;

import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

import util.users.Encrypter;

public class Main {

	public static void main(String[] args) throws NoSuchAlgorithmException {

		// 1. 비밀번호 입력 받음
		Scanner sc = new Scanner(System.in);
		System.out.println("[해시를 생성할 비밀번호를 입력하세요]");
		String pw = sc.nextLine();
		sc.close();

		// 2. 비밀번호 결과문자열 생성 및 결과 출력
		String hash = Encrypter.getUsersPwColumnTxt(pw);
		System.out.println("\n[결과 문자열]\n" + hash);

	}

}
