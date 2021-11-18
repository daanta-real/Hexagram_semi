package util.users;

import beans.UsersDao;
import beans.UsersDto;

// 해시를 이용한 메소드들만 모아놓았다.
public class HashChecker {

	// 입력한 아이디 비번이 맞는지 확인
	public static boolean idPwMatch(String id, String inputtedPw, UsersDao dao) throws Exception {

		System.out.println("[해쉬 비교기] 0. 해쉬 비교를 시작합니다. ID=" + id + " / PW=" + inputtedPw);

		// 1. 원본 DB 정보
		// 비밀번호 관련 정보는 DB의 usersPw 컬럼에 아래와 같은 구조의 문자열로 저장되어 있다.
		// "비밀번호알고리즘명$솔트값$해쉬값"
		// 이 문자열을 $로 split한 후, 순서대로 algo, salt, hashOrg에 저장할 것이다.
		System.out.println("[해쉬 비교기] 1. 해쉬 정보 입수 시작.. ");
		UsersDto dto = dao.get(id);
		System.out.println("[해쉬 비교기] 획득한 DTO 정보: " + dto);
		String[] pwInfoes = dto.getUsersPw().split("\\$");
		String algo = pwInfoes[0], salt = pwInfoes[1], hashOrg = pwInfoes[2];

		// 2. 값 비교
		System.out.println("[해쉬 비교기] 2. 해쉬 정보 비교 시작");
		System.out.println("　　1) 대상 ID: " + id);
		System.out.println("　　2) 암호화 정보: 알고리즘(" + algo + ") / 솔트(" + salt + "),");
		System.out.println("　　　  컬럼에 저장시킨 원본 해쉬값: " + hashOrg);
		// 입력한 패스워드를 토대로 해시 구하기
		String hashInput = Encrypter.getHash(inputtedPw, salt);
		System.out.println("　　4) 입력된 비번으로 만든 해쉬값: " + hashInput);

		// 4. 결과 도출 및 회신
		boolean isEqual = hashOrg.equals(hashInput);
		System.out.println("[해쉬 비교기] 3. 해쉬값끼리 비교 결과: " + isEqual);
		return isEqual;

	}


	// 오버로딩: .idPwMatch() 메소드 호출받았을 때, DAO를 못 넘겨받았을 경우, 새 DAO를 만들어서 호출함
	public static boolean idPwMatch(String id, String inputtedPw) throws Exception {
		return idPwMatch(id, inputtedPw, new UsersDao()); }

}
