package util;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsersUtils {

	// 로그인 검사: 로그인 아디/비번 일치 여부 체크 결과를 true/false로 반환
	public boolean isValid(String usersId, String usersPw) throws Exception {

		// SQL 준비
		String sql = "select * from users where users_id=? and users_pw=?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		ps.setString(2, usersPw);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		boolean valid = rs.next() ? true : false;

		// 마무리
		con.close();
		return valid;

	}

	// 중복검사: 회원 가입 시 미사용 아이디가 맞는지 확인한 결과를 리턴
	// 테이블에 해당 usersId로 검색했을 때 결과가 아예 안 나와야 된다.
	// 사용할 수 있는 usersId일 경우에만 true를 반환한다.
	public boolean isUnusedId(String usersId) throws Exception{

		// SQL 준비
		String sql = "select count(*) from users where users_id = ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		rs.next();
		boolean isUnique = rs.getInt(1) == 0;

		// 마무리
		con.close();
		return isUnique;

	}

	/*
	// 5. Methods - Common
	// 아이디와 비번 문자열을 이용해, 로그인 검증용 해쉬를 만들어 줌
	public static int getHash(UsersDto dto) {
		// 오늘 날짜를 문자열로 얻기 (YYYY-MM-DD 형식)
		Calendar c = Calendar.getInstance();
		Date cTime = c.getTime();
		SimpleDateFormat ymdSDF = new SimpleDateFormat("YYYY-MM-DD");
		String ymdString = ymdSDF.format(cTime);
		// ID문자열 + PW문자열 + 오늘날짜문자열 조합을 hashCode로 만들어 리턴
		String result = dto.getUsersId() + dto.getUsersPw() + ymdString;
		return result.hashCode();
	}

	// 입력한 아이디 비번이 맞는지 확인
	// 아디와 비번을 담은 dto vs DB측 dto 비교하는 것임.
	public static boolean idPwMatch(UsersDto dto_input) throws Exception {
		String id = dto_input.getUsersId();
		UsersDto dto_org = new UsersDao().get(id);

		int hash_org   = getHash(dto_org);
		int hash_input = getHash(dto_input);

		System.out.println("　　1) 입력값: " + dto_input.getUsersId() + " / " + dto_input.getUsersPw() + " / " + hash_input);
		System.out.println("　　2) DB값 : " +   dto_org.getUsersId() + " / " +   dto_org.getUsersPw() + " / " + hash_org  );
		return hash_org == hash_input;
	}

	// 데이터 조작 권한이 있는지 확인하여 t/f로 리턴해 줌.
	// true가 나오려면, 요청자가 관리자이거나, 아니면 요청대상 ID가 본인의 ID여야 함.
	public static boolean isGranted(String sessionId, UsersDao dao, String usersId) throws Exception {

		// 1. 세션 검사: 누가 요청했든 간에, 일단 요청자의 세션이 있어야 됨 즉 로그인된 사람이 요청해야 됨
		System.out.print("[권한확인] 1. 세션 검사..");
		boolean sessionExists = sessionId != null;
		if(!sessionExists) return false;
		System.out.println("세션 확인.");

		// 세션 id에 따른 권한여부를 검사함.
		// 2. 요청자가 관리자인 경우, 프리패스. 4 생략하고 바로 5로 간다.
		System.out.println("[권한확인] 2. 관리자 여부 검사");
		boolean isAdmin = dao.get(sessionId).getUsersGrade().equals("관리자");
		if(isAdmin) System.out.println("관리자입니다.");

		// 3. 요청자가 관리자가 아닌, 경우 본인에 대한 요청인지 확인
		else {
			System.out.println("관리자가 아닙니다.");
			System.out.print("[권한확인] 3. 본인 확인..");
			boolean isSelf = sessionId.equals(usersId);
			if(!isSelf) return false;
			System.out.println("본인 확인됨.");
		}

		// 4. 모든 절차를 통과했으면 true 회신
		System.out.print("[권한확인] 4. 적절한 권한이 확인되었습니다.");
		return true;

	}

	// 세션 ID의 회원이 관리자 등급인지 여부를 리턴
	protected static boolean isAdmin(HttpServletRequest req) throws Exception {
		return isAdmin(req, new UsersDao()); // DAO 안들어왔을경우 생성하는 과정임
	}
	public static boolean isAdmin(HttpServletRequest req, UsersDao dao) throws Exception {
		String sessionId = (String)req.getSession().getAttribute("id");
		String userGrade = dao.get(sessionId).getUsersGrade();
		return userGrade.equals("관리자");
	}
	*/

}
