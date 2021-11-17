package util.users;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.text.ParseException;
import java.util.Objects;

import beans.UsersDao;
import beans.UsersDto;
import system.Settings;
import util.HexaLibrary;

// 해시를 이용한 메소드들만 모아놓았다.
public class HashChecker {

	// ID문자열 & PW문자열 & 날짜문자열 & 해시키워드 네 개를 해쉬값으로 변환해줌.
	public static Integer getIdPwHash(String id, String pw, String joinedDate) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		byte[] hash = md.digest()
		return Objects.hash(id, pw, joinedDate, Settings.HASH_KEYWORD);
	}
	// (↑ 만약 날짜가 Date로 들어온다면 String으로 변환해서 구해줌.)
	public static Integer getIdPwHash(String id, String pw, Date joinedDate) throws ParseException {
		String formattedDateStr = HexaLibrary.dateToStr(joinedDate);
		return Objects.hash(id, pw, formattedDateStr, Settings.HASH_KEYWORD);
	}

	// 입력한 아이디 비번이 맞는지 확인
	// 입력측 해쉬 내용 = hashInput = 메소드 실행 시 생성됨  ; 구성요소: [ID, 지금 입력받은 PW, DB상 가입일자, 해시키워드]
	// 원본측 해쉬 내용 = hashOrg   = DB에 미리 생성되어 있음; 구성요소: [ID, 가입때 입력한 PW, DB상 가입일자, 해시키워드]
	public static boolean idPwMatch(String inputtedId, String inputtedPw, UsersDao dao) throws Exception {

		System.out.println("[해쉬 비교기] 0. 해쉬 비교를 시작합니다.");

		// 1. 원본 DB DTO 겟
		UsersDto dtoOrg = dao.get(inputtedId);
		String hashOrg = dtoOrg.getUsersPw();
		Date joinnedDate = dtoOrg.getUsersJoin();
		System.out.println(
			"[해쉬 비교기] 1. DB 정보\n"
			+ "　　▷ 원본 DTO: " + dtoOrg + "\n"
			+ "　　▷ 원본 해쉬값: " + hashOrg
		);

		// 2.
		Integer hashInput = getIdPwHash(inputtedId, inputtedPw, joinnedDate);

		// String DB_HASHED_PW = dtoOrg.getPw(); <<< DB암호화 이후 적용 예정

		// 3. 결과 도출
		System.out.println("　　1) 입력값: " + inputtedId          + " / " + inputtedPw          + " ▶ 해쉬: " + hashInput);
		System.out.println("　　2) DB값 : " + dtoOrg.getUsersId() + " / " + dtoOrg.getUsersPw() + " ▶ 해쉬: " + hashOrg  );
		return hashOrg.equals(hashInput); // Integer vs Integer이므로 equals 써도 된다..

	}


	// 오버로딩: .idPwMatch() 메소드 호출받았을 때, DAO를 못 넘겨받았을 경우, 새 DAO를 만들어서 호출함
	public static boolean idPwMatch(String usersId, String usersPw) throws Exception {
		return idPwMatch(usersId, usersPw, new UsersDao()); }

}
