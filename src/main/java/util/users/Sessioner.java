package util.users;

import javax.servlet.http.HttpSession;

import beans.UsersDto;

// 세션조작 관련 처리를 담당함
public class Sessioner {

	// 해당 session에 대해 로그인 처리를 해준다.
	// 이때 dto 안에 idx, id, grade 반드시 다 있어야 한다.
	public static void login(HttpSession session, UsersDto dto) throws Exception {

		// 값 준비
		System.out.println("[UsersUtils 세션 셋팅기] 값을 준비합니다.");
		Integer idx   = dto.getUsersIdx  ();
		String  id    = dto.getUsersId   ();
		String  grade = dto.getUsersGrade();
		if(idx   == null                    ) { System.out.println("[에러] idx가 입력되지 않았습니다."  ); throw new Exception(); }
		if(id    == null ||    id.equals("")) { System.out.println("[에러] id가 입력되지 않았습니다."   ); throw new Exception(); }
		if(grade == null || grade.equals("")) { System.out.println("[에러] grade가 입력되지 않았습니다."); throw new Exception(); }
		System.out.println("[UsersUtils 세션 셋팅기] 값 준비 완료.");

		// 세션값 변경
		System.out.println("[UsersUtils 세션 셋팅기] 세션에 로그인 관련 속성을 부여합니다.");
		session.setAttribute("usersIdx"  , idx);
		session.setAttribute("usersId"   , id);
		session.setAttribute("usersGrade", grade);
		System.out.println("[UsersUtils 세션 셋팅기] 세션의 로그인 관련 처리가 완료되었습니다. ("
			+   "idx = '" + session.getAttribute("idx"  )
			+    "id = '" + session.getAttribute("id"   )
			+ "grade = '" + session.getAttribute("grade")
		);

	}

	// 해당 session에 대해 로그아웃 처리를 해준다.
	// 세션 값 모두 제거
	public static void logout(HttpSession session) {
		session.removeAttribute("usersIdx");
		session.removeAttribute("usersId");
		session.removeAttribute("usersGrade");
		System.out.println("[UsersUtils 세션 셋팅기] 세션의 로그아웃 관련 처리가 완료되었습니다. ("
			+   "idx = '" + session.getAttribute("idx"  )
			+    "id = '" + session.getAttribute("id"   )
			+ "grade = '" + session.getAttribute("grade")
		);

	}

}
