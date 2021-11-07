package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseItemDao {
	
	public List<CourseItemDto> getByCourse(int courseSequnce) throws Exception {
		String sql = "SELECT * FROM course_item where course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseSequnce);
		ResultSet rs = ps.executeQuery();

		List<CourseItemDto> list = new ArrayList<>();
		while (rs.next()) {
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseItemIdx(rs.getInt("course_item_idx"));
			courseItemDto.setItemIdx(rs.getInt("item_idx"));
			courseItemDto.setCourseIdx(rs.getInt("course_idx"));

			list.add(courseItemDto);
		}

		con.close();
		return list;
	}
	
	public void insert(CourseItemDto courseItemDto) throws Exception {
		String sql = "INSERT INTO course_item values(course_item_seq.nextval,?,?)";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseItemDto.getItemIdx());
		ps.setInt(2, courseItemDto.getCourseIdx());
	
		ps.execute();

		con.close();
	}
	
	public boolean delete(CourseItemDto courseItemDto) throws Exception {
		String sql = "delete course_item where item_idx=? and course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseItemDto.getItemIdx());
		ps.setInt(2, courseItemDto.getCourseIdx());
	
		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}
	
}
