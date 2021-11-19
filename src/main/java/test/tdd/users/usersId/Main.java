package test.tdd.users.usersId;

import java.util.regex.Pattern;

import beans.DTORegex;

public class Main {

	@SuppressWarnings("unused")
	public static void main(String[] args) {
		String regex  = DTORegex.USERSID;
		String str = "parapara3@";
		System.out.println("[정규식 대상]\n　　▷ㄴ" + str + "\n");
		System.out.println("[정규식 검사] " + regex + "\n　　▷" + Pattern.matches(regex, str) + "\n");
	}

}
