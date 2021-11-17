package util.users;

import beans.UsersDao;
import beans.UsersDto;

// 해시를 이용한 메소드들만 모아놓았다.
public class HashChecker {

	// 입력한 아이디 비번이 맞는지 확인
	public static boolean idPwMatch(String inputtedId, String inputtedPw, UsersDao dao) throws Exception {

		System.out.println("[해쉬 비교기] 0. 해쉬 비교를 시작합니다.");

		// 1. 원본 DB 정보
		// 비밀번호 관련 정보는 DB의 usersPw 컬럼에 아래와 같은 구조의 문자열로 저장되어 있다.
		// "비밀번호알고리즘명$솔트값$해쉬값"
		// 이 문자열을 $로 split한 후, 순서대로 algo, salt, hashOrg에 저장할 것이다.
		UsersDto dto = dao.get(inputtedId);
		String[] pwInfoes = dto.getUsersPw().split("$");
		String algo = pwInfoes[0], salt = pwInfoes[1], hashOrg = pwInfoes[2];

		// 2.
		Integer hashInput = Encrypter.getHash(null, salt);

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
