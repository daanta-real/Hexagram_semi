package workspace.daanta.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class DaoUtils {

	// 아직 미완성임

	//String sqlStart,
	//String sqlEnd,
	//Connection conn,
	//Map<String, String> 값, 구문(?포함)
	public PreparedStatement sqlMaker(String st, String ed, Connection conn, List<Map<String, String>> info) throws SQLException {

		// 1. SQL 구문 만들기
		int count = 0;
		StringBuffer sb = new StringBuffer(st);
		for(Map<String, String> map: info) {
			String val = map.get("val");
			String sql = map.get("sql");
			if(val != null) {
				if(count++ > 0) sb.append(",");
				sb.append(" " + sql);
			}
		}
		sb.append(ed);
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// 2. PS 셋팅
		PreparedStatement ps = conn.prepareStatement(sql);
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 3. 전송 준비된 PS 리턴
		return ps;
	}

}