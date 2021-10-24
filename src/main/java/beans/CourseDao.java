package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.JdbcUtils;

public class CourseDao {

	//jdbc driver 아이디 패스워드
		public static final String USERNAME = "hexa", PASSWORD="hexa";

	//1. 등록(insert)
	public void insert(CourseDto courseDto)	throws Exception{

		//jdbcDriver 연결
		Connection con = JdbcUtils.connect();

		//외래키는 등록하지 않음
		String sql = "insert into course(course_idx, course_subject, course_list, course_detail, course_locations, course_tags)"
				+ "    values(courseSeq.nextval, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
//		ps.setInt(?, courseDto.getCourseId()); //시퀀스 번호?
		ps.setString(1, courseDto.getCourseSubject());
		ps.setString(2, courseDto.getCourseList());
		ps.setString(3, courseDto.getCourseDetail());
		ps.setString(4, courseDto.getCourseLocations());
		ps.setString(5, courseDto.getCourseTags());
		ps.execute();

		//jdbcDriver 닫기
		con.close();
	}

	//2. 수정(update)
	public boolean update(CourseDto courseDto) throws Exception{

		//jdbcDriver 연결
		Connection con = JdbcUtils.connect();

		//수정할수 있는 컬럼(목록, 내용, 지역, 태그)을 예상하여 기능 생성
		String sql = "update course set course_subject=?, course_list= ?, course_detail= ?, course_locations = ?, course_tags = ? where course_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, courseDto.getCourseSubject());
		ps.setString(2, courseDto.getCourseList());
		ps.setString(3, courseDto.getCourseDetail());
		ps.setString(4, courseDto.getCourseLocations());
		ps.setString(5, courseDto.getCourseTags());
		ps.setInt(6, courseDto.getCourseIdx());

		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	//3. 삭제(delete)
	public boolean delete(int courseIdx) throws Exception{
		Connection con = JdbcUtils.connect();

		String sql = "delete course where course_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);

		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

}
