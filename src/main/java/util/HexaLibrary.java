package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class HexaLibrary {

	// ,로 분리된 문자열 → List<>
	public static List<String> strToList(String str) {
		String[] splitted = str.split(",");
		List<String> list = new ArrayList<>(Arrays.asList(splitted));
		Collections.sort(list);
		return list;
	}

	// List<> → ,로 분리된 문자열
	public static String listToStr(List<String> list) {
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < list.size(); i++) {
			if(i > 0) sb.append(",");
			sb.append(list.get(i));
		}
		return sb.toString();
	}

	// Date 인스턴스를 문자열로 변환한다.
	// 1) java.util.Date를 입력받은 경우
	public static String dateToStr(java.util.Date date) throws ParseException {
		return dateToStr((java.sql.Date) date);
	}
	// 2) java.sql.Date를 입력받은 경우
	public static String dateToStr(java.sql.Date date) throws ParseException {
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date);
	}

	// 오늘 날짜 문자열을 YYYY-MM-DD 형식으로 리턴한다.
	public static String getTodayStr() {
		Calendar c = Calendar.getInstance();                       // 캘린더 인스턴스 획득
		Date d = c.getTime();                                      // Date로 변환
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD"); // 오늘 날짜 포맷생성기 준비
		String todayString = sdf.format(d);                        // 준비된 포맷 생성기에 Date 인스턴스 집어넣음
		return todayString;
	}

	// 문자열 → SHA-256 HASH
	public static String testSHA256(String pwd) throws RuntimeException, NoSuchAlgorithmException {

		MessageDigest digest = MessageDigest.getInstance("SHA-256");
		byte[] hash = digest.digest(pwd.getBytes("UTF-8"));
		StringBuffer hexString = new StringBuffer();

		for (int i = 0; i < hash.length; i++) {
			String hex = Integer.toHexString(0xff & hash[i]);
			if(hex.length() == 1) hexString.append('0');
			hexString.append(hex);
		}

		//출력
		return hexString.toString();

	}
}
