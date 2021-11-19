package test.tdd.users.usersPhoneRegexTest;

import java.util.regex.Pattern;

import beans.DTORegex;

public class Main {

	public static void main(String[] args) {
		String regex  = DTORegex.USERSPHONE;
		String str = "69846651651";
		System.out.println("[정규식 대상]\n　　▷" + str + "\n");
		System.out.println("[정규식 검사] " + regex + "\n　　▷" + Pattern.matches(regex, str) + "\n");
	}

}
