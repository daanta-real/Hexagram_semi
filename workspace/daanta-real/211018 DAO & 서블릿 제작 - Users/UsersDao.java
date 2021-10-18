import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsersDao {

	// 기능 목록
	// 1. List<UsersDto> select   (                  ): 모든 회원 목록 조회
	// 2. UsersDto       get      (String   id       ): 회원 정보 조회
	// 3. boolean        insert   (UsersDto dto      ): 회원 추가
	// 4. boolean        delete   (String   id       ): 회원 삭제
	// 5. boolean        update   (UsersDto dto      ): 회원 수정
	// 6. boolean        idPwMatch(UsersDto dto_input): 아디&비번 일치여부 리턴

	// READ: 모든 회원의 정보를 조회
	public List<UsersDto> select() throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "SELECT * FROM users";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		List<UsersDto> list = new ArrayList<>();
		while(rs.next()) {
			UsersDto dto = new UsersDto();
			dto.setIdx  (rs.getInt   ("users_idx"  ));
			dto.setId   (rs.getString("users_id"   ));
			dto.setNick (rs.getString("users_nick" ));
			dto.setEmail(rs.getString("users_email"));
			dto.setGrade(rs.getString("users_grade"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;
	}

	// READ: 딱 한 명의 회원의 정보를 조회
	public UsersDto get(String id) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "SELECT * FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		UsersDto dto = new UsersDto();
		if(rs.next()) {
			dto.setIdx  (rs.getInt   ("users_idx"  ));
			dto.setId   (rs.getString("users_id"   ));
			dto.setPw   (rs.getString("users_pw"   ));
			dto.setNick (rs.getString("users_nick" ));
			dto.setEmail(rs.getString("users_email"));
			dto.setGrade(rs.getString("users_grade"));
		}

		// 마무리
		conn.close();
		return dto;
	}

	// CREATE: 회원 추가
	public boolean insert(UsersDto dto) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "INSERT INTO users (users_idx, users_id, users_pw, users_nick, users_email, users_grade)"
			+ " VALUES(users_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getId());
		ps.setString(2, dto.getPw());
		ps.setString(3, dto.getNick());
		ps.setString(4, dto.getEmail());
		ps.setString(5, dto.getGrade());

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// DELETE: 회원 삭제
	public boolean delete(String id) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "DELETE FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// UPDATE: 회원 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(UsersDto dto) throws ClassNotFoundException, SQLException {

		// SQL문 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE users SET");
		if(dto.getPw()    != null) sb.append( (count++ == 0 ? "" : ",") + " users_pw = ?"   );
		if(dto.getNick()  != null) sb.append( (count++ == 0 ? "" : ",") + " users_nick = ?" );
		if(dto.getEmail() != null) sb.append( (count++ == 0 ? "" : ",") + " users_email = ?");
		if(dto.getGrade() != null) sb.append( (count++ == 0 ? "" : ",") + " users_grade = ?");
		sb.append(" WHERE users_id = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if(dto.getPw()    != null) ps.setString(count++, dto.getPw()   );
		if(dto.getNick()  != null) ps.setString(count++, dto.getNick() );
		if(dto.getEmail() != null) ps.setString(count++, dto.getEmail());
		if(dto.getGrade() != null) ps.setString(count++, dto.getGrade());
		ps.setString(count, dto.getId());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// 입력한 아이디 비번이 맞는지 확인
	// 아디와 비번을 담은 dto vs DB측 dto 비교하는 것임.
	public boolean idPwMatch(UsersDto dto_input) throws ClassNotFoundException, SQLException {
		String id = dto_input.getId();
		UsersDto dto_org = new UsersDao().get(id);

		int hash_org   =   dto_org.getHash();
		int hash_input = dto_input.getHash();

		System.out.println("　　1) 입력값: " + dto_input.getId() + " / " + dto_input.getPw() + " / " + hash_input);
		System.out.println("　　2) DB값 : " +   dto_org.getId() + " / " +   dto_org.getPw() + " / " + hash_org  );
		return hash_org == hash_input;
	}

}