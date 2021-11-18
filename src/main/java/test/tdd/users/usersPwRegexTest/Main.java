package test.tdd.users.usersPwRegexTest;

import java.util.regex.Pattern;

import beans.DTORegex;

public class Main {

	@SuppressWarnings("unused")
	public static void main(String[] args) {
		String regex  = DTORegex.USERSPW;
		String regex_ = "^.*$";
		String regex1 = "^(?=.[a-zA-Z])(?=.[0-9])(?=.[-_~\\!@#\\$%\\^&=\\+\\|/\\(\\)\\{\\}\\[\\],.;’”?])[a-zA-Z0-9-_~!@#[$]%\\^&=\\+\\|/\\(\\)\\{\\}\\[\\],.;’”?]{4,20}$";
		String regex2 = "^(?=[a-zA-Z].*)(?=[0-9].*)(?=[-_~\\!@#\\$%\\^&=\\+\\|/\\(\\)\\{\\}\\[\\],.;’”?].*)[a-zA-Z0-_~!@#\\$%\\^&=\\+\\|/\\(\\)\\{\\}\\[\\],.;’”?]{4,20}$";
		String regex3 = "^(?=[a-zA-Z].*)(?=[0-9].*)(?=[-_~!@#\\$%\\^&=\\+\\|/\\(\\)\\{\\}\\[\\],.;’”?].*$";
		String str = "parapara3##FG";
		System.out.println("[정규식 대상]\n　　▷ㄴ" + str + "\n");
		System.out.println("[정규식 검사] " + regex_ + "\n　　▷" + Pattern.matches(regex_, str) + "\n");
		System.out.println("[정규식 검사] " + regex + "\n　　▷" + Pattern.matches(regex, str) + "\n");
		System.out.println("[정규식 검사] " + regex1 + "\n　　▷" + Pattern.matches(regex1, str) + "\n");
		System.out.println("[정규식 검사] " + regex2 + "\n　　▷" + Pattern.matches(regex2, str) + "\n");
	}

}
