package workspace.daanta.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class DaoUtils {

	// JDBC를 이용해 DB를 조작하기 위해서는 PreparedStatement 준비를 위해 두 가지 절차가 필요하다.
	// 1. SQL구문을 준비
	// 2. ?부분을 특정 값으로 바꾸기
	// 이걸 하려면 1번도 2번도 다 수동으로 코드를 작성해줘야 되는게 불편했다.
	// 본 메소드는 이것을 자동화시켜보기 위해 만들었다.
	// 정확히는 ?를 많이 쓰는 SELECT와 UPDATE를 편하게 쓰기 위해 만들었다.
	// ex1) SELECT a, b, c FROM table WHERE a=? b=?
    // ex2) UPDATE table SET a=? b=? WHERE item_idx =?
	//
	// List 내에 들어갈 String[]은 아래 구조로 되어 있다.
	// String[] str = [① sql, ② val, ③ chain];
	// sql : 넣을 SQL 구문
	// type: ?의 치환 여부 및 치환할 자료형
	// val : 이를 치환할 값
	// cont: 연속되는 값인지 즉 쉼표처리 필요한 값인지
	// 이 메소드는 for문을 돌려, 각 str 정보에 따라 첫째로 SQL 구문을 채우고, 둘째로 ?부분을 치환해준다.
	//
	// type의 옵션에 따라서 ? 치환 관련된 행동이 다르다.
	// 1) null: ?를 치환하지 않는다.
	// 2) "String": ps.setString()로 치환한다.
	// 3) "int": ps.setInt()를 실행한다.
	// 4) "date": ps.setDate()를 실행한다. 이때 Date의 형태는 무조건 "yyyy-MM-dd hh:mm:ss" 혹은 "yyyy-MM-dd" 형태여야 한다.
	//
	// cont는 ,로 구분되어 연속적으로 넣어져야 되는 값에 대한 위한 추가 옵션이다.
	// 1) null: 아무 처리도하지 않는다. ,로 구분될 필요가 없는 구문이다.
	// 2) ",": 쉼표를 알아서 붙여준된다.
	// ","옵션을 원소마다 연속적으로 넣지 않는다면, 카운터는 초기화된다.
	public static PreparedStatement sqlBuilder(Connection conn, List<String[]> info) throws Exception {

		// 1. SQL 구문 만들기
		StringBuffer sb = new StringBuffer();
		for(String[] inf: info) {
			String sql = inf[0], cont = inf[3]; // 1-0. 변수준비
			if(cont.equals(",")) sb.append(", "); // 1-1. cont 적용
			sb.append(sql); // 1-2. sql 적용
		}
		String builtSql = sb.toString();
		System.out.println("SQL 구문 준비: " + builtSql);

		// 2. ? 치환하기
		PreparedStatement ps = conn.prepareStatement(builtSql);
		String debugSql = sb.toString();
		int count = 0;
		for(String[] inf: info) {
			String type = inf[1], val = inf[2]; // 2-0. 변수준비
			if(type == null) continue;
			switch(type) {
				case "String":
					ps.setString(++count, val);
					debugSql.replaceFirst("?", "'" + val + "'");
					break;
				case "int":
					ps.setInt(++count, Integer.parseInt(val));
					debugSql.replaceFirst("?", "'" + val + "'");
					break;
				case "Date":
					ps.setDate(++count, java.sql.Date.valueOf(val));
					debugSql.replaceFirst("?", "'" + val + "'");
					break;
				default: throw new Exception();
			}
		}
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);
		System.out.println("완성된 SQL: " + debugSql);
		System.out.println("※ Date의 경우 날짜값의 입력 예시이며 실제 입력되는 값은 다를 수 있습니다.");

		// 3. 전송 준비된 PS 리턴
		return ps;
	}

}