package util.users;

import beans.UsersDao;
import beans.UsersDto;
import util.HexaLibrary;

// 해시를 이용한 메소드들만 모아놓았다.
public class HashChecker {

	// 아이디와 비번 문자열을 이용해, 로그인 검증용 해쉬를 만들어 줌
	public static Integer getIdPwHash(UsersDto dto) {

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
	public static boolean idPwMatch(UsersDto dto_input) throws Exception {
		String id = dto_input.getUsersId();
		UsersDto dto_org = new UsersDao().get(id);

		int hash_org   = getIdPwHash(dto_org);
		int hash_input = getIdPwHash(dto_input);

		System.out.println("　　1) 입력값: " + dto_input.getUsersId() + " / " + dto_input.getUsersPw() + " / " + hash_input);
		System.out.println("　　2) DB값 : " +   dto_org.getUsersId() + " / " +   dto_org.getUsersPw() + " / " + hash_org  );
		return hash_org == hash_input;
	}

}
