package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class UsersDao implements PaginationInterface<UsersDto> {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. READ: 모든 회원의 정보를 조회
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public List<UsersDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM users ORDER BY users_idx ASC";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		while (rs.next()) {
			UsersDto dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. READ: 딱 한 명의 회원의 정보를 조회
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1) idx 기준
	public UsersDto get(int usersIdx) throws Exception{

		// SQL 준비
		Connection conn = JdbcUtils.connect3();

		String sql = "SELECT * FROM users WHERE users_idx = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, usersIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		UsersDto dto = null;
		if(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
		}

		// 마무리
		conn.close();
		return dto;
	}

	// 2) id 기준
	public UsersDto get(String usersId) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, usersId);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		UsersDto dto = null;
		if(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
		}

		// 마무리
		conn.close();
		return dto;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. CREATE: 회원 추가
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1) 새 시퀀스 얻기
	public Integer getNextSequence() throws Exception {

		// SQL 준비
		String sql = "SELECT users_seq.NEXTVAL FROM DUAL";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL 구문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		Integer result = null;
		if(rs.next()) result = rs.getInt(0);

		// 마무리
		conn.close();
		return result;

	}

	// 2) 회원 추가 부분
	// 여기서 설정 못하는 기본값: 등급(DB값; 아마 준회원), 가입일(SYSDATE), 포인트(0)
	public boolean insert(UsersDto dto) throws Exception {

		// ※ 시퀀스 없을 때는 알아서 새로 따서 DTO에 넣어 준다.
		// 단, 이러면 당연히 외부에서 시퀀스 번호를 못 얻게 된다.
		if(dto.getUsersIdx() == null) dto.setUsersIdx(getNextSequence());

		// SQL 준비
		String sql = "INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone)"
			+ " VALUES(?, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt   (1, dto.getUsersIdx());
		ps.setString(2, dto.getUsersId());
		ps.setString(3, dto.getUsersPw());
		ps.setString(4, dto.getUsersNick());
		ps.setString(5, dto.getUsersEmail());
		ps.setString(6, dto.getUsersPhone());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 4. DELETE: 회원 삭제
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public boolean delete(String usersId) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, usersId);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 5. UPDATE: 회원 수정
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1) 비밀번호를 제외한 정보수정
	// DTO에는 ID만 기존 값을 식별자 용도로 넣되, 나머지는 모두 새롭게 수정될 값을 넣는다.
	// 참고로 수정될 값은 최소 한 종류 이상은 넣어야 된다. 아예 없으면 에러 난다.
	public boolean update(UsersDto dto) throws Exception {

		// SQL 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE users SET");
		if (dto.getUsersPw   () != null) sb.append((count++ == 0 ? "" : ",") + " users_pw = ?"   );
		if (dto.getUsersNick () != null) sb.append((count++ == 0 ? "" : ",") + " users_nick = ?" );
		if (dto.getUsersEmail() != null) sb.append((count++ == 0 ? "" : ",") + " users_email = ?");
		if (dto.getUsersPhone() != null) sb.append((count++ == 0 ? "" : ",") + " users_phone = ?");
		if (dto.getUsersGrade() != null) sb.append((count++ == 0 ? "" : ",") + " users_grade = ?");
		sb.append(" WHERE users_id = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if (dto.getUsersPw   () != null) ps.setString(count++, dto.getUsersPw   ());
		if (dto.getUsersNick () != null) ps.setString(count++, dto.getUsersNick ());
		if (dto.getUsersEmail() != null) ps.setString(count++, dto.getUsersEmail());
		if (dto.getUsersPhone() != null) ps.setString(count++, dto.getUsersPhone());
		if (dto.getUsersGrade() != null) ps.setString(count++, dto.getUsersGrade());
		ps.setString(count, dto.getUsersId());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// 2) 비밀번호 수정
	// 비밀번호 검증 같은 건 여기서 안 한다. 그건 HashChecker가 맡아야 할 부분이다.
	public boolean updatePw(String id, String pwUpdate) throws Exception {

		// SQL 준비
		String sql = "UPDATE users SET users_pw = ? WHERE users_id = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, pwUpdate); // 변경할 비번
		ps.setString(2, id);       // 아이디

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 6. SEARCH: 회원 검색
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	//검색(항목, 검색어)기능- 관리자: 회원목록
	public List<UsersDto> search(String column, String keyword) throws Exception{

		//SQL준비
		String sql = "SELECT * FROM users WHERE INSTR(#1, ?) > 0 ORDER BY users_idx ASC";
		sql = sql.replace("#1", column);
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, keyword);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		UsersDto dto = null;
		while(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 7. PAGING: 회원 검색목록 페이징
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 1. 목록 - 페이징에서 마지막 블록을 구하기 위하여 회원목록글 개수를 구하는 기능
	@Override
	public Integer count() throws Exception {

		// SQL 준비
		String sql = "SELECT COUNT(*) FROM users";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		// 마무리
		conn.close();
		return count;

	}

	// 2. 검색 - 페이징에서 마지막 블록을 구하기 위하여 회원목록글 개수를 구하는 기능
	@Override
	public Integer count(String column, String keyword) throws Exception {

		// SQL 준비
		String sql = "SELECT COUNT(*) FROM users WHERE INSTR(#1, ?) > 0 ";
		sql = sql.replace("#1", column);
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, keyword);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		// 마무리
		conn.close();
		return count;

	}

	// 3. 회원 검색목록 페이징
	@Override
	public List<UsersDto> search(String column, String keyword, int begin, int end) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM ( "
						+ " SELECT ROWNUM RN, TMP.* FROM( "
							+ " SELECT * FROM users WHERE INSTR(#1, ?) > 0 ORDER BY users_idx ASC"
						  + " )TMP"
						+ " )WHERE RN BETWEEN ? AND ?";
		sql = sql.replace("#1", column);
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		UsersDto dto = null;
		while(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

	// 4. 회원목록 페이징
	@Override
	public List<UsersDto> list(int begin, int end) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM ( "
						+ " SELECT ROWNUM RN, TMP.* FROM( "
					+ " SELECT * FROM users ORDER BY users_idx ASC"
				  + ")TMP "
				+ ")WHERE RN BETWEEN ? AND ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		UsersDto dto = null;
		while(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

}