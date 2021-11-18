package test.tdd.users.usersEmailRegexTest_valid;

import java.util.regex.Pattern;

public class Main {

	public static String[] arr = {
			"adm@a.com", "vtitomm21@osmye.com", "niwajeh557@incoware.com", "nicktrig@gmail.com", "noodles@msn.com", "gward@att.net", "wkrebs@outlook.com", "jeteve@att.net", "elmer@yahoo.com", "ajlitt@comcast.net", "mhoffman@me.com", "majordick@live.com", "phyruxus@me.com", "tbmaddux@yahoo.com", "hling@live.com", "jfreedma@msn.com", "juliano@hotmail.com", "rcwil@comcast.net", "kmiller@comcast.net", "rfoley@att.net", "wenzlaff@hotmail.com", "errxn@msn.com", "esbeck@yahoo.ca", "paley@comcast.net", "chance@yahoo.ca", "spadkins@icloud.com", "eminence@live.com", "kingjoshi@aol.com", "research@msn.com", "munson@yahoo.com", "cremonini@gmail.com", "gboss@msn.com", "chrisk@optonline.net", "laird@outlook.com", "zavadsky@hotmail.com", "research@live.com", "crimsane@aol.com", "emcleod@msn.com", "bmcmahon@optonline.net", "seano@att.net", "kdawson@msn.com", "giafly@hotmail.com", "kramulous@mac.com", "cgreuter@optonline.net", "loscar@verizon.net", "gavinls@verizon.net", "nachbaur@icloud.com", "metzzo@outlook.com", "moonlapse@mac.com", "kosact@me.com", "kingjoshi@icloud.com"
	};

	public static String regex = "^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\\.([a-zA-Z])+$";

	public static void main(String[] args) {
		System.out.println("정규표현식 검사");
		for(String s: arr) System.out.println(s + " ▷ " + Pattern.matches(regex, s));
	}

}
