package workspace.daanta.util;

public class Library {

	// 빈값검사기. 빈값이 아닐 경우에만 true를 회신, 빈값이면 false를 회신
	public static boolean isExists(String str) {
		return str != null && str.trim().length() > 0;
	}

}
