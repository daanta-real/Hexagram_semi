package util.users;

import java.util.Enumeration;

import javax.servlet.http.HttpSession;

import beans.UsersDto;

// 세션조작 관련 처리를 담당함
public class Sessioner {

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

	// 현재 세션 정보 문자열 return
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

}
