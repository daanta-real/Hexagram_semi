package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtils;

public class CourseLikeDao {
	//좋아요 추가
	public void insert(int usersIdx,int courseIdx) throws Exception {
		String sql = "INSERT INTO course_like values(?,?)";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, usersIdx);
		ps.setInt(2, courseIdx);

		ps.execute();

		con.close();
	}
	//좋아요 취소
	public boolean delete(int usersIdx,int courseIdx) throws Exception {
		String sql = "delete course_like where users_idx=? and course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, usersIdx);
		ps.setInt(2, courseIdx);

		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}
	
	//좋아요 갯수 확인
	public int countLike(int courseIdx) throws Exception {
		String sql = "select count(*) course_like where course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}
	
	//현재 접속한 회원이 해당 게시물의 좋아요 조회를 했는지 확인
	public CourseLikeDto get(int usersIdx,int courseIdx) throws Exception {
		String sql = "select * course_like where users_idx=? and course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();
		
		CourseLikeDto courseLikeDto = new CourseLikeDto();
		if(rs.next()) {
			courseLikeDto.setUsersIdx(rs.getInt("users_idx"));
			courseLikeDto.setCourseIdx(rs.getInt("course_idx"));
		}

		con.close();
		return courseLikeDto;
	}
	
}
