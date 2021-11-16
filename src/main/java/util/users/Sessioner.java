package util.users;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import beans.UsersDto;

// 세션조작 관련 처리를 담당함
public class Sessioner {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 0. 관련변수 정의
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 권한 관련 문자가 변경될 상황을 대비하여 미리 관련변수를 지정해 두는 바임.
	public static final String GRADE_ADMIN     = "관리자";
	public static final String GRADE_REGULAR   = "정회원";
	public static final String GRADE_ASSOCIATE = "준회원";



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. 로그인 / 로그아웃
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 해당 session에 대해 로그인 처리를 해준다.
	// 이때 넘어오는 dto 안에 idx, id, grade 셋 다 반드시 있어야 한다.
	public static void login(HttpSession session, UsersDto dto) throws Exception {

		// 1. 값 준비
		System.out.println("[UsersUtils 세션 셋팅기] 값을 준비합니다.");
		Integer idx   = dto.getUsersIdx  ();
		String  id    = dto.getUsersId   ();
		String  grade = dto.getUsersGrade();

		// 2. 값 검사 (idx, id, grade) 세 개 다 검사
		//    값이 정상적으로 들어오는지 믿을 수 없으므로 무조건 검사 필요.
		if(idx   == null                    ) { System.out.println("[에러] idx가 입력되지 않았습니다."  ); throw new Exception(); }
		if(id    == null ||    id.equals("")) { System.out.println("[에러] id가 입력되지 않았습니다."   ); throw new Exception(); }
		if(grade == null || grade.equals("")) { System.out.println("[에러] grade가 입력되지 않았습니다."); throw new Exception(); }
		System.out.println("[UsersUtils 세션 셋팅기] 값 준비 완료.");

		// 3. 세션값 변경
		System.out.println("[UsersUtils 세션 셋팅기] 세션에 로그인 관련 속성을 부여합니다.");
		session.setAttribute("usersIdx"  , idx);
		session.setAttribute("usersId"   , id);
		session.setAttribute("usersGrade", grade);
		System.out.println("[UsersUtils 세션 셋팅기] 로그인 처리 완료되었습니다." + getInfo(session));

	}

	// 해당 session에 대해 로그아웃 처리를 해준다.
	// 세션 값 모두 제거
	public static void logout(HttpSession session) {
		session.removeAttribute("usersIdx");
		session.removeAttribute("usersId");
		session.removeAttribute("usersGrade");
		System.out.println("[UsersUtils 세션 셋팅기] 로그아웃 처리 완료되었습니다." + getInfo(session));
	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. 정보 획득
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 현재 세션 전체 정보 문자열로 return
	public static String getInfo(HttpSession session) {
		StringBuffer sb = new StringBuffer();
		Enumeration<String> sessionNamesList = session.getAttributeNames();
		int i;
		for(i = 1; sessionNamesList.hasMoreElements(); i++) {
			sb.append("  (" + i + ") " + sessionNamesList.nextElement() + ", " + sessionNamesList.nextElement().getClass().getName() + "\n");
		}
		sb.append("[세션정보] 끝\n");
		sb.insert(0, "[세션정보] 세션의 총 개수: " + i + " \n[세션정보] 세션 상세 정보:\n");
		return sb.toString();
	}

	// 현재 각 세션 정보 회신
	// 각 문자와 숫자 모두 null이 나올 수도 있다. 따라서 메소드로 값 획득 후 null check 필히 할 것.
	public static Integer getUsersIdx  (HttpSession session) { return Integer.parseInt((String) session.getAttribute("usersIdx")); }
	public static String  getUsersId   (HttpSession session) { return (String) session.getAttribute("usersId"   ); }
	public static String  getUsersGrade(HttpSession session) { return (String) session.getAttribute("usersGrade"); }



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. 권한 검사
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 기본
	public static boolean isLoggedIn   (HttpSession session) { return getUsersIdx(session) != null; }
	public static boolean isAdmin      (HttpSession session) { return getUsersId(session).equals(GRADE_ADMIN); }

	// 권한검사: 현재 세션의 유저에게 타겟id 데이터의 조작권한이 있는지 검사.
	//         권한 있으면 true 아니면 false를 리턴함.
	// true가 나오려면, (1) 요청자가 관리자이거나 (2) 내가 내 id에 요청하는 경우여야 함.
	public static boolean isGranted(HttpSession session, String targetId) throws Exception {

		// 0. 변수준비
		String sessionId = (String) session.getAttribute("usersId");
		String

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
		boolean isAdmin = sessionGrade.equals(GRADE_ADMIN);
		if(isAdmin) {
			System.out.println(GRADE_ADMIN + " 등급입니다. 권한 확인되었습니다.");
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
