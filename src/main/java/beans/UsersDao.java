package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class UsersDao {

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


	//비밀번호 변경 - 현재 비밀번호 확인
	//로그인 상태에서 변경시 비밀번호만 입력
	//로그인 상태가 아니라면 로그인 페이지로 이동시켜야 함
	public boolean updatePw(UsersDto usersDto, String pwUpdate) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "update users set users_pw=? where users_id and users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, pwUpdate);					//변경할 비번
		ps.setString(2, usersDto.getUsersPw());	//현재 비번
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}


	//회원탈퇴 - 아이디 비밀번호 확인
	public boolean usersDelete(String usersId, String usersPw) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "delete users where users_id=? and users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		ps.setString(2, usersPw);
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}
	
	//회원탈퇴 - 관리자가 회원 탈퇴 처리할떄
	public boolean adminDelete(String usersId) throws Exception{
		Connection con = JdbcUtils.connect();
		
		String sql = "delete users where users_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}


	//등급수정 - 관리자가 회원등급 수정. 회원번호입력
	public  boolean updateGrade(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "update users set users_grade=? where users_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsersGrade());
		ps.setInt(2, usersDto.getUsersIdx());
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}


	//회원전체목록조회 - 관리자만 회원조회가능
	public List<UsersDto> usersList() throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "select * from users";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		while(rs.next()) {
			UsersDto usersDto = new UsersDto();
			usersDto.setUsersId(rs.getString("users_id"));
			usersDto.setUsersNick(rs.getString("users_nick"));
			usersDto.setUsersEmail(rs.getString("users_email"));
//			usersDto.setUsersPhone(rs.getString("users_phone"));
			usersDto.setUsersGrade(rs.getString("users_grade"));
			list.add(usersDto);
		}
		con.close();
		return list;
	}

	//회원단일 조회 - id
	public UsersDto get(String usersId) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "select * from users where users_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersId);
		ResultSet rs = ps.executeQuery();
		UsersDto usersDto;
		if(rs.next()) {
			usersDto = new UsersDto();
			usersDto.setUsersId(rs.getString("users_id"));
			usersDto.setUsersNick(rs.getString("users_nick"));
			usersDto.setUsersEmail(rs.getString("users_email"));
//			usersDto.setUsersPhone(rs.getString("users_phone"));
			usersDto.setUsersGrade(rs.getString("users_grade"));
		}else usersDto = null;
		
		con.close();
		return usersDto;
	}

	//회원단일 조회 - idx
	public UsersDto get(int usersIdx) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "select * from users where users_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, usersIdx);
		ResultSet rs = ps.executeQuery();
		UsersDto usersDto;
		if(rs.next()) {
			usersDto = new UsersDto();
			usersDto.setUsersId(rs.getString("users_id"));
			usersDto.setUsersNick(rs.getString("users_nick"));
			usersDto.setUsersEmail(rs.getString("users_email"));
//			usersDto.setUsersPhone(rs.getString("users_phone"));
			usersDto.setUsersGrade(rs.getString("users_grade"));
		}else usersDto = null;
		con.close();
		return usersDto;
	}

}
