package test.tdd.users.usersEmailRegexTest_null;

import java.util.regex.Pattern;

public class Main {

	public static void main(String[] args) {
		String regex = "^(null)|([a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\\.([a-zA-Z])+)$";
		System.out.println(Pattern.matches(regex, null));
		// ↑ null을 regex matcher에 넣어봤더니 에러가 났다. 일단 null값은 자바 정규식으로는 검사 불가능함.
	}

}
