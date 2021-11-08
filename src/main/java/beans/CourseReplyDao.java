package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseReplyDao {
	
	//댓글 등록
	public void insert(CourseReplyDto courseReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "insert into course_reply values(?, ?, ?, ?, sysdate, null, ?, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, courseReplyDto.getCourseReplyIdx());
		ps.setInt(2, courseReplyDto.getUsersIdx());
		ps.setInt(3, courseReplyDto.getCourseIdx());
		ps.setString(4, courseReplyDto.getCourseReplyDetail());
		ps.setInt(5, courseReplyDto.getCourseReplyIdx());
		ps.execute();
		
		con.close();
	}
	
	//댓글 수정
	public boolean update(CourseReplyDto courseReplyDto) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "update course_reply set course_reply_detail = ? where course_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, courseReplyDto.getCourseReplyDetail());
		ps.setInt(2, courseReplyDto.getCourseIdx());
		
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0 ;
	}
	
	//댓글 삭제
	public boolean delete(int courseReplyIdx) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "delete course_reply where course_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseReplyIdx);
		
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
	
	//댓글 목록
	public List<CourseReplyDto> list(int courseIdx) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "select * from course_reply where course_idx = ? order by course_idx dese";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();
		
		List<CourseReplyDto>list = new ArrayList<CourseReplyDto>();
		while(rs.next()) {
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			courseReplyDto.setUsersIdx(rs.getInt("users_idx"));
			courseReplyDto.setCourseIdx(rs.getInt("course_idx"));
			courseReplyDto.setCourseReplyDetail(rs.getString("course_reply_detail"));
			courseReplyDto.setCourseReplyDate(rs.getDate("course_reply_date"));
			courseReplyDto.setCourseReplySuperno(rs.getInt("course_reply_superno"));
			courseReplyDto.setCourseReplyGroupno(rs.getInt("course_reply_group"));
			courseReplyDto.setCourseReplyDepth(rs.getInt("course_reply_depth"));
			
			list.add(courseReplyDto);
		}
		
		con.close();
		
		return list;
		
	}
}
