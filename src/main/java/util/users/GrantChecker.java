package util.users;

import beans.UsersDao;

public class GrantChecker {

	// 권한검사: 내가 나에 대해서 요청한 것이거나, 아니면 내가 관리자여야만 true를 반환함
	// 글 수정/삭제, 회원정보 수정/탈퇴 등에 사용
	public static boolean isGranted(String sessionId, String targetId, String sessionGrade) {

		// 1. 관리자 권한이라면 무조건 true를 회신함
		boolean isAdmin = sessionGrade != null && sessionGrade.equals(UsersUtils.GRADE_ADMIN);
		if(isAdmin) return true;

		// 2. 내가 관리자가 아니라면 여기로 온다.
		//    그럼 적어도 내가 나에 대해 요청한 것인지 확인. 맞으면 true 돌려줌.
		boolean isSelf = sessionId != null && sessionId.equals(targetId);
		if(isSelf) return true;

		// 3. 위 내용 둘다 아니라면 여기로 온다.
		//    내가 관리자도 아니고, 대상id가 내 스스로도 아니므로, false를 회신
		return false;

	}

	// 권한검사: 데이터 조작 권한이 있는지 확인하여 t/f로 리턴해 줌.
	// true가 나오려면, 요청자가 관리자이거나, 아니면 요청대상 ID가 본인의 ID여야 함.
	public static boolean isGranted(String sessionId, String targetId, UsersDao dao) throws Exception {

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

}
