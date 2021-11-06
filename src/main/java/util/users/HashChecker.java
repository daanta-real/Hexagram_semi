package util.users;

import beans.UsersDao;
import beans.UsersDto;
import util.HexaLibrary;

// 해시를 이용한 메소드들만 모아놓았다.
public class HashChecker {

	// 현재 dto 두 개의 id와 pw만 비교하고 있으나, DB 암호화 이후 알고리즘 변경 예정임

	// dto에서 id와 pw 두 개를 빼내어 로그인 검증용 해쉬를 만들어 줌
	// 이때 오늘날짜문자열도 합쳐준다.
	// 재부용이다. (공개되어 있지 않다.)
	private static Integer getIdPwHash(UsersDto dto) {

		// ID문자열 + PW문자열 + 오늘날짜문자열 세 개를 합친 '합체문자열'을 준비
		String id = dto.getUsersId();
		String pw = dto.getUsersPw();
		String todayStr = HexaLibrary.getTodayStr();
		String input  = id + pw + todayStr;

		// '합체문자열'의 해시코드를 리턴함
		Integer output = input.hashCode();
		return output;

	}

	// 입력한 아이디 비번이 맞는지 확인
	// 아디와 비번을 담은 dto vs DB측 dto 비교하는 것임.
	public static boolean idPwMatch(UsersDto dtoInput              ) throws Exception { return idPwMatch(dtoInput, new UsersDao()); }
	public static boolean idPwMatch(UsersDto dtoInput, UsersDao dao) throws Exception {

		// 1. 변수 준비
		String inputtedId = dtoInput.getUsersId();
		String inputtedPw = dtoInput.getUsersPw();
		UsersDto dtoOrg   = new UsersDao().get(inputtedId);

		// 2. 해쉬 계산
		Integer hashInput = getIdPwHash(dtoInput);
		Integer hashOrg   = getIdPwHash(dtoOrg);
		// String DB_HASHED_PW = dtoOrg.getPw(); <<< DB암호화 이후 적용 예정

		// 3. 결과 도출
		System.out.println("　　1) 입력값: " + inputtedId          + " / " + inputtedPw          + " ▶ 해쉬: " + hashInput);
		System.out.println("　　2) DB값 : " + dtoOrg.getUsersId() + " / " + dtoOrg.getUsersPw() + " ▶ 해쉬: " + hashOrg  );
		return hashOrg.equals(hashInput); // Integer vs Integer이므로 equals 써도 된다..

	}

}
