package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Jdbc.Util.JdbcUtils;

public class UsersDao {
	
	//jdbc driver 아이디 패스워드 성진님이 만들어 두신걸로 사용했어요
	public static final String USERNAME = "hexa", PASSWORD="hexa";
	
	//회원가입시 아이디 중복검사
	public boolean checkId(String users_id) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "select users_id from users where users_id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, users_id);
		ResultSet rs = ps.executeQuery();
		boolean isCheckId; 
		if(rs.next()) isCheckId = true;		//아이디 조회결과가 있다면 중복
		else isCheckId = false;					//아이디 조회결과가 없다면 사용가능
		
		con.close();
		return isCheckId;	//아이디 조회결과 반환	
	}
	
	//회원등록-등급 제약조건 추가 기본값 일반회원으로 설정
	//users_idx는 시퀀스자동생성
	public void joinUsers(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		String sql = "insert into users(users_id, users_pw, users_nick, users_email, users_phone) "
						+ "values( ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsers_id());
		ps.setString(2, usersDto.getUsers_pw());
		ps.setString(3, usersDto.getUsers_nick());
		ps.setString(4, usersDto.getUsers_email());
		ps.setString(5, usersDto.getUsers_phone());
		ps.execute();		
		con.close();
	}
	
	//로그인
	public boolean login(String users_id, String users_pw) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "select * from users where users_id=?, users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, users_id);
		ps.setString(2, users_pw);
		ResultSet rs = ps.executeQuery();
		boolean isLogin;
		if(rs.next()) isLogin = true;	//입력한 아이디, 비밀번호와 일치하는 정보가 있다면
		else isLogin = false;				//입력한 아이디, 비밀번호와 일치하는 정보가 없다면
		con.close();
		return isLogin;
	}
	
	//회원정보수정:닉네임, 이메일, 폰번 - 비밀번호 확인
	//로그인 상태에서 변경시 비밀번호만 입력
	//로그인 상태가 아니라면 로그인 페이지로 이동시켜야 함
	public boolean updateUsers(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "update users set users_nick=?, users_email=?, users_phone=? where users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsers_nick());
		ps.setString(2, usersDto.getUsers_email());
		ps.setString(3, usersDto.getUsers_phone());
		ps.setString(4, usersDto.getUsers_pw());
		int result = ps.executeUpdate();	
		con.close();
		return result>0;
	}
	
	
	//비밀번호 변경 - 현재 비밀번호 확인
	//로그인 상태에서 변경시 비밀번호만 입력
	//로그인 상태가 아니라면 로그인 페이지로 이동시켜야 함 
	public boolean updatePw(UsersDto usersDto, String pwUpdate) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "update users set users_pw=? where users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, pwUpdate);					//변경할 비번
		ps.setString(2, usersDto.getUsers_pw());	//현재 비번
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}
	
	
	//회원탈퇴 - 아이디 비밀번호 확인
	public boolean usersDelete(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "delete users where users_id=? and users_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsers_id());
		ps.setString(2, usersDto.getUsers_pw());
		int result = ps.executeUpdate();
		con.close();
		return result>0;
	}
	
	
	//등급수정 - 관리자가 회원등급 수정. 회원번호입력
	public  boolean updateGrade(UsersDto usersDto) throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "update users set users_grade=? where users_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, usersDto.getUsers_grade());
		ps.setInt(2, usersDto.getUsers_idx());
		int result = ps.executeUpdate();	
		con.close();
		return result>0;
	}
	
	
	//회원전체목록조회 - 관리자만 회원조회가능
	public List<UsersDto> usersList() throws Exception{
		Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
		
		String sql = "select * from users";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<UsersDto> list = new ArrayList<>();
		while(rs.next()) {
			UsersDto usersDto = new UsersDto();
			usersDto.setUsers_id(rs.getString("users_id"));
			usersDto.setUsers_nick(rs.getString("users_nick"));
			usersDto.setUsers_email(rs.getString("users_email"));
			usersDto.setUsers_phone(rs.getString("users_phone"));
			usersDto.setUsers_grade(rs.getString("users_grade"));
			list.add(usersDto);
		}
		con.close();
		return list;
	}
	
	
}
