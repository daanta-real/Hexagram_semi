import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class UsersUtils {

	// 입력한 아이디 비번이 맞는지 확인
	// 아디와 비번을 담은 dto vs DB측 dto 비교하는 것임.
	protected static boolean idPwMatch(UsersDto dto_input) throws ClassNotFoundException, SQLException {
		String id = dto_input.getId();
		UsersDto dto_org = new UsersDao().get(id);

		int hash_org   =   dto_org.getHash();
		int hash_input = dto_input.getHash();

		System.out.println("　　1) 입력값: " + dto_input.getId() + " / " + dto_input.getPw() + " / " + hash_input);
		System.out.println("　　2) DB값 : " +   dto_org.getId() + " / " +   dto_org.getPw() + " / " + hash_org  );
		return hash_org == hash_input;
	}

	// 데이터 조작 권한이 있는지 확인하여 t/f로 리턴해 줌.
	// true가 나오려면, 요청자가 관리자이거나, 아니면 요청대상 ID가 본인의 ID여야 함.
	protected static boolean chkIsGranted(HttpServletRequest req, UsersDao dao, String id) throws Exception {

		// 1. 세션 검사: 누가 요청했든 간에, 일단 요청자의 세션이 있어야 됨 즉 로그인된 사람이 요청해야 됨
		System.out.print("[권한확인] 1. 세션 검사..");
		HttpSession session = req.getSession();
		String workerId = (String)session.getAttribute("id");
		boolean sessionExists = workerId != null;
		if(!sessionExists) return false;
		System.out.println("세션 확인.");

		// 세션 id에 따른 권한여부를 검사함.
		// 2. 요청자가 관리자인 경우, 프리패스. 4 생략하고 바로 5로 간다.
		System.out.println("[권한확인] 2. 관리자 여부 검사");
		boolean isAdmin = dao.get(workerId).getGrade().equals("관리자");
		if(isAdmin) System.out.println("관리자입니다.");

		// 3. 요청자가 관리자가 아닌, 경우 본인에 대한 요청인지 확인
		else {
			System.out.println("관리자가 아닙니다.");
			System.out.print("[권한확인] 3. 본인 확인..");
			boolean isSelf = workerId.equals(id);
			if(!isSelf) return false;
			System.out.println("본인 확인됨.");
		}

		// 4. 모든 절차를 통과했으면 true 회신
		System.out.print("[권한확인] 4. 적절한 권한이 확인되었습니다.");
		return true;

	}

	// 세션 ID의 회원이 관리자 등급인지 여부를 리턴
	protected static boolean chkIsAdmin(HttpServletRequest req              ) throws ClassNotFoundException, SQLException {
		return chkIsAdmin(req, new UsersDao()); // DAO 안들어왔을경우 생성하는 과정임
	}
	protected static boolean chkIsAdmin(HttpServletRequest req, UsersDao dao) throws ClassNotFoundException, SQLException {
		String sessionId = (String)req.getSession().getAttribute("id");
		String userGrade = dao.get(sessionId).getGrade();
		return userGrade.equals("관리자");
	}
}
