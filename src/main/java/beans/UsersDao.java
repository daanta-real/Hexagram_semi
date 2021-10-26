package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class UsersDao {

<<<<<<< HEAD
	// 기능 목록
	// 1. List<UsersDto> select   (                 ): 모든 회원 목록 조회
	// 2. UsersDto       get      (String   usersIdx): 회원 정보 조회
	//    UsersDto       get      (String   usersId ): 회원 정보 조회
	// 3. boolean        insert   (UsersDto dto     ): 회원 추가
	// 4. boolean        delete   (String   usersId ): 회원 삭제
	// 5. boolean        update   (UsersDto dto     ): 회원 수정
	// 6. boolean        updatePw (UsersDto dto, String pwUpdate): 회원 비번 수정
=======
	//회원가입시 아이디 중복검사...맘처럼 구현이 안되서 일단 이 친구는 쓰지 않겠습니다..
	public boolean checkId(String usersId) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "select users_id from users where users_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		ResultSet rs = ps.executeQuery();
		boolean isCheckId;
		if(rs.next()) isCheckId = true;		//아이디 조회결과가 있다면 중복
		else isCheckId = false;					//아이디 조회결과가 없다면 사용가능
  
		con.close();
		return isCheckId;	//아이디 조회결과 반환
	}

	//회원가입-등급 제약조건 추가 기본값 일반회원으로 설정
	//users_idx는 시퀀스자동생성
	public void joinUsers(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect();
		String sql = "insert into users(users_idx, users_id, users_pw, users_nick, users_email"/*, users_phone*/ + ") "
						+ "values(users_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsersId());
		ps.setString(2, usersDto.getUsersPw());
		ps.setString(3, usersDto.getUsersNick());
		ps.setString(4, usersDto.getUsersEmail());
//		ps.setString(5, usersDto.getUsersPhone());
		ps.execute();
		con.close();
	}

	//로그인 : 반환형-UsersDto, 매개변수 : usersId, usersPw
	public UsersDto login(String usersId, String usersPw) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "select * from users where users_id=? and users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		ps.setString(2, usersPw);
		ResultSet rs = ps.executeQuery();
		UsersDto usersDto;
		if(rs.next()) {
			//데이터가 있다면 rs를 DTO에 복사저장
			usersDto = new UsersDto();
			usersDto.setUsersIdx(rs.getInt("users_idx"));
			usersDto.setUsersId(rs.getString("users_id"));
			usersDto.setUsersPw(rs.getString("users_pw"));
			usersDto.setUsersNick(rs.getString("users_nick"));
			usersDto.setUsersEmail(rs.getString("users_email"));
//			usersDto.setUsersPhone(rs.getString("users_phone"));
		}
		else {  usersDto = null;  }

		con.close();
		return usersDto;
	}

	//회원정보수정:닉네임, 이메일, 폰번 - 비밀번호 확인
	//로그인 상태에서 변경시 비밀번호만 입력
	//로그인 상태가 아니라면 로그인 페이지로 이동시켜야 함
	public boolean updateUsers(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "update users set users_nick=?, users_email=?" + /*, users_phone=?*/ " where users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsersNick());
		ps.setString(2, usersDto.getUsersEmail());
//		ps.setString(3, usersDto.getUsersPhone());
		ps.setString(4, usersDto.getUsersPw());
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}
>>>>>>> branch 'main' of https://github.com/daanta-real/Hexagram_semi


	// 1. READ: 모든 회원의 정보를 조회
	public List<UsersDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM users";
		Connection conn = JdbcUtils.connect();
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
		Connection con = JdbcUtils.connect();

		String sql = "select * from users where users_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, usersIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		UsersDto dto = null;
		if(rs.next()) {
			dto = new UsersDto();
			dto.setUsersId(rs.getString("users_id"));
			dto.setUsersNick(rs.getString("users_nick"));
			dto.setUsersEmail(rs.getString("users_email"));
			dto.setUsersPhone(rs.getString("users_phone"));
			dto.setUsersGrade(rs.getString("users_grade"));
		}

		// 마무리
		con.close();
		return dto;
	}

	// 2) id 기준
	public UsersDto get(String usersId) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM users WHERE users_id = ?";
		Connection conn = JdbcUtils.connect();
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
		}

		// 마무리
		conn.close();
		return dto;

	}

	// 3. CREATE: 회원 추가
	// 기본 준회원
	public boolean insert(UsersDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email)"
			+ " VALUES(users_seq.NEXTVAL, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getUsersId());
		ps.setString(2, dto.getUsersPw());
		ps.setString(3, dto.getUsersNick());
		ps.setString(4, dto.getUsersEmail());

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
		Connection conn = JdbcUtils.connect();
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
		Connection conn = JdbcUtils.connect();
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
		Connection conn = JdbcUtils.connect();
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