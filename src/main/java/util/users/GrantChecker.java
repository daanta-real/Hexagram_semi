package util.users;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class GrantChecker {

	private GrantChecker() { super(); }

	// 권한검사: 현재 세션의 유저에게 타겟id 데이터의 조작권한이 있는지 검사.
	//         권한 있으면 true 아니면 false를 리턴함.
	// true가 나오려면, (1) 요청자가 관리자이거나 (2) 내가 내 id에 요청하는 경우여야 함.
	public static boolean isGranted(String sessionId, String sessionGrade, String targetId) throws Exception {

		// 1. 세션 검사: 로그인했는지 검사
		System.out.print("[권한확인] 1. 세션 검사.. ");
		boolean sessionExists = sessionId != null && !sessionId.equals("");
		if(!sessionExists) {
			System.out.println("세션이 없습니다. 따라서 아무 권한도 줄 수 없습니다.");
			return false;
		} else {
			System.out.println("세션 존재 확인 완료.");
		}

		// 2. 요청자가 관리자인 경우, 무조건 프리패스 (바로 true 리턴)
		System.out.println("[권한확인] 2. 관리자 여부 검사.. ");
		boolean isAdmin = sessionGrade.equals(UsersUtils.GRADE_ADMIN);
		if(isAdmin) {
			System.out.println(UsersUtils.GRADE_ADMIN + " 등급입니다. 권한 확인되었습니다.");
			return true;
		} else {
			System.out.println("관리자가 아닙니다.");
		}

		// 3. 본인이면, 즉 요청자 id와 요청대상 id가 같으면 true
		System.out.print("[권한확인] 3. 본인 확인.. ");
		boolean isSelf = sessionId.equals(targetId);
		if(isSelf) {
			System.out.println("본인 확인되었습니다. 권한 확인되었습니다.");
			return true;
		} else {
			System.out.println("본인 ID에 대한 요청이 아닙니다. (세션 ID = '" + sessionId + "' ↔ 대상id = '" + targetId + "'");
		}

		// 4. 관리자가 요청한 것도 아니고 자기 자신에 대해 요청한 것도 아니라면,
		//    당연히 권한이 없으므로, false 회신
		System.out.println("[권한확인] 4. 권한이 없는 사용자임이 확인되었습니다.");
		return false;

	}


	// 오버라이드 메소드들

	// (request, 대상id) 형태
	public static boolean isGranted(HttpServletRequest req, String targetId) throws Exception {
		return isGranted(req.getSession(), targetId);
	}
	// (session, 대상id) 형태
	public static boolean isGranted(HttpSession session, String targetId) throws Exception {
		return isGranted((String)session.getAttribute("usersId"), (String)session.getAttribute("usersGrade"), targetId);
	}

}
