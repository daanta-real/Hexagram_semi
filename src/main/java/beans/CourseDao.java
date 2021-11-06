package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseDao {
	// 전체 조회
		public List<CourseDto> list() throws Exception {
			String sql = "SELECT * FROM course";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			List<CourseDto> list = new ArrayList<>();
			while (rs.next()) {
				CourseDto courseDto = new CourseDto();
				courseDto.setCourseIdx(rs.getInt("course_idx"));
				courseDto.setUsersIdx(rs.getInt("users_idx"));
				courseDto.setCourseName(rs.getString("course_name"));
				courseDto.setCourseDetail(rs.getString("course_detail"));
				courseDto.setCourseDate(rs.getDate("course_date"));
				courseDto.setCourseCountView(rs.getInt("course_count_view"));
				courseDto.setCourseCountReply(rs.getInt("course_count_reply"));

				list.add(courseDto);
			}

			con.close();
			return list;
		}
		
		// 단일 조회
		public CourseDto get(int courseIdx) throws Exception {
			String sql = "SELECT * FROM course WHERE course_idx = ?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, courseIdx);
			ResultSet rs = ps.executeQuery();


			CourseDto courseDto = new CourseDto();
			if (rs.next()) {
				courseDto.setCourseIdx(rs.getInt("course_idx"));
				courseDto.setUsersIdx(rs.getInt("users_idx"));
				courseDto.setCourseName(rs.getString("course_name"));
				courseDto.setCourseDetail(rs.getString("course_detail"));
				courseDto.setCourseDate(rs.getDate("course_date"));
				courseDto.setCourseCountView(rs.getInt("course_count_view"));
				courseDto.setCourseCountReply(rs.getInt("course_count_reply"));

			}

			con.close();
			return courseDto;
		}
		
		public boolean insertWithSequence(CourseDto courseDto) throws Exception {
			String sql = "INSERT INTO course VALUES(?,?,?,?,sysdate,0,0)";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, courseDto.getCourseIdx());
			ps.setInt(2, courseDto.getUsersIdx());
			ps.setString(3, courseDto.getCourseName());
			ps.setString(4, courseDto.getCourseDetail());
			ps.setInt(5, courseDto.getCourseCountView());
			ps.setInt(6, courseDto.getCourseCountReply());

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}
		
		public int getSequence() throws Exception {
			String sql = "select course_seq.nextval from dual";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}

}
