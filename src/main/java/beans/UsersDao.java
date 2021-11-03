package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class UsersDao {

	// 1. READ: 모든 회원의 정보를 조회
	public List<UsersDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM users";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		while (rs.next()) {
			UsersDto dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
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

	// 2. READ: 딱 한 명의 회원의 정보를 조회
	// 1) idx 기준
	public UsersDto get(int usersIdx) throws Exception{

		// SQL 준비
		Connection con = JdbcUtils.connect3();

		String sql = "SELECT * FROM users WHERE users_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, usersIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		UsersDto dto = null;
		if(rs.next()) {
			dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
			dto.setUsersJoin(rs.getDate("users_join"));
			dto.setUsersPoint(rs.getInt("users_point"));
		}

		// 마무리
		con.close();
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

	// 3. CREATE: 회원 추가
	// 기본값 - 등급: 준회원, 가입일: sysdate, 포인트: 0
	public boolean insert(UsersDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone)"
			+ " VALUES(users_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getUsersId());
		ps.setString(2, dto.getUsersPw());
		ps.setString(3, dto.getUsersNick());
		ps.setString(4, dto.getUsersEmail());
		ps.setString(5, dto.getUsersPhone());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// 4. DELETE: 회원 삭제
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

	// 5. UPDATE: 회원 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
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

	// 비밀번호 변경 - 현재 비밀번호 확인
	// 로그인 상태에서 변경시 비밀번호만 입력
	// 로그인 상태가 아니라면 로그인 페이지로 이동시켜야 함
	public boolean updatePw(UsersDto dto, String pwUpdate) throws Exception {

		// SQL 준비
		String sql = "UPDATE users SET users_pw = ? WHERE users_id = ? AND users_pw = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, pwUpdate);		   // 변경할 비번
		ps.setString(2, dto.getUsersId());
		ps.setString(3, dto.getUsersPw()); // 현재 비번

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

}