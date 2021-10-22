package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class UsersDao {

	// 기능 목록
	// 1. List<UsersDto> select (            ): 모든 회원 목록 조회
	// 2. UsersDto       get    (String   id ): 회원 정보 조회
	// 3. boolean        insert (UsersDto dto): 회원 추가
	// 4. boolean        delete (String   id ): 회원 삭제
	// 5. boolean        update (UsersDto dto): 회원 수정

	// 1. READ: 모든 회원의 정보를 조회
	public List<UsersDto> select() throws Exception {

		// 준비
		String sql = "SELECT * FROM users";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		List<UsersDto> list = new ArrayList<>();
		while (rs.next()) {
			UsersDto dto = new UsersDto();
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersGrade(rs.getString("users_grade"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;
	}

	// 2. READ: 딱 한 명의 회원의 정보를 조회
	public UsersDto get(String id) throws Exception {

		// 준비
		String sql = "SELECT * FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		UsersDto dto = new UsersDto();
		if (rs.next()) {
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersPw(rs.getString("users_pw"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersGrade(rs.getString("users_grade"));
		}

		// 마무리
		conn.close();
		return dto;
	}

	// 3. CREATE: 회원 추가
	public boolean insert(UsersDto dto) throws Exception {

		// 준비
		String sql = "INSERT INTO users (users_idx, users_id, users_pw, users_nick, users_email, users_grade)"
				+ " VALUES(users_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getUsersId());
		ps.setString(2, dto.getUsersPw());
		ps.setString(3, dto.getUsersNick());
		ps.setString(4, dto.getUsersEmail());
		ps.setString(5, dto.getUsersGrade());

		// 완성된 SQL문 보내고 결과 받아오기
		int rs = ps.executeUpdate();
		boolean isSucceed = rs == 1;

		// 마무리
		conn.close();
		return isSucceed;
	}

	// 4. DELETE: 회원 삭제
	public boolean delete(String id) throws Exception {

		// 준비
		String sql = "DELETE FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		// 완성된 SQL문 보내고 결과 받아오기
		int rs = ps.executeUpdate();
		boolean isSucceed = rs == 1;

		// 마무리
		conn.close();
		return isSucceed;
	}

	// 5. UPDATE: 회원 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(UsersDto dto) throws Exception {

		// SQL문 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE users SET");
		if (dto.getUsersPw   () != null) sb.append((count++ == 0 ? "" : ",") + " users_pw = ?");
		if (dto.getUsersNick () != null) sb.append((count++ == 0 ? "" : ",") + " users_nick = ?");
		if (dto.getUsersEmail() != null) sb.append((count++ == 0 ? "" : ",") + " users_email = ?");
		if (dto.getUsersGrade() != null) sb.append((count++ == 0 ? "" : ",") + " users_grade = ?");
		sb.append(" WHERE users_id = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if (dto.getUsersPw   () != null) ps.setString(count++, dto.getUsersPw   ());
		if (dto.getUsersNick () != null) ps.setString(count++, dto.getUsersNick ());
		if (dto.getUsersEmail() != null) ps.setString(count++, dto.getUsersEmail());
		if (dto.getUsersGrade() != null) ps.setString(count++, dto.getUsersGrade());
		ps.setString(count, dto.getUsersId());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

}