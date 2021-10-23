package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.JdbcUtils;
import workspace.daanta.util.DaoUtils;

public class CoursesDao {

	// 기능 목록
	// 1. List<CourseDto> select(                   ): 모든 코스 목록 조회
	// 2. CourseDto       get   (String    courseIdx): 코스 정보 조회
	// 3. boolean         insert(CourseDto dto      ): 코스 추가
	// 4. boolean         delete(String    courseIdx): 코스 삭제
	// 5. boolean         update(CourseDto  dto     ): 코스 수정

	// READ: 모든 코스의 정보를 조회
	public List<CourseDto> select() throws Exception {
		String sql = "SELECT * FROM course";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<CourseDto> list = null;
		while(rs.next()) {
			CourseDto dto = new CourseDto();
			dto.setCourseIdx      (rs.getInt   ("course_idx"      ));
			dto.setUsersIdx       (rs.getInt   ("users_idx"      ));
			dto.setCourseSubject  (rs.getString("course_subject"  ));
			dto.setCourseList     (rs.getString("course_list"     ));
			dto.setCourseLocations(rs.getString("course_locations"));
			dto.setCourseDetail   (rs.getString("course_detail"   ));
			dto.setCourseTags     (rs.getString("course_tags"     ));
		}
		conn.close();
		return list;
	}

	// READ: 딱 한 명의 코스의 정보를 조회
	public CourseDto get(int courseIdx) throws Exception {
		String sql = "SELECT * FROM course WHERE course_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();
		CourseDto dto = null;
		if(rs.next()) {
			dto.setCourseIdx      (rs.getInt   ("course_idx"      ));
			dto.setUsersIdx       (rs.getInt   ("users_idx"      ));
			dto.setCourseSubject  (rs.getString("course_subject"  ));
			dto.setCourseList     (rs.getString("course_list"     ));
			dto.setCourseLocations(rs.getString("course_locations"));
			dto.setCourseDetail   (rs.getString("course_detail"   ));
			dto.setCourseTags     (rs.getString("course_tags"     ));
		}
		conn.close();
		return dto;
	}

	// CREATE: 코스 추가
	public boolean insert(CourseDto dto) throws Exception {
		String sql = "INSERT INTO course (course_idx, users_idx, course_subject, course_list, course_locations, course_detail, course_tags)"
				+ " VALUES(course_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt   (1, dto.getUsersIdx());
		ps.setString(2, dto.getCourseSubject());
		ps.setString(3, dto.getCourseList());
		ps.setString(4, dto.getCourseLocations());
		ps.setString(5, dto.getCourseDetail());
		ps.setString(6, dto.getCourseTags());

		int result = ps.executeUpdate();
		conn.close();
		return result == 1;
	}

	// DELETE: 코스 삭제
	public boolean delete(int courseIdx) throws Exception {
		String sql = "DELETE FROM course WHERE course_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		int result = ps.executeUpdate();
		conn.close();
		return result == 1;
	}

	// UPDATE: 코스 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(CourseDto dto) throws Exception {
		List<String[]> info = new ArrayList<>(Arrays.asList(
			new String[] {"UPDATE course SET "   , null    , null                              , null},
			new String[] {"users_idx = ?"        , "int"   , String.valueOf(dto.getUsersIdx()) , "," },
			new String[] {"course_subject = ?"   , "String", dto.getCourseSubject()            , "," },
			new String[] {"course_list = ?"      , "String", dto.getCourseList()               , "," },
			new String[] {"course_locations = ?" , "String", dto.getCourseLocations()          , "," },
			new String[] {"course_detail = ?"    , "String", dto.getCourseDetail()             , "," },
			new String[] {"course_tags = ?"      , "String", dto.getCourseTags()               , "," },
			new String[] {" WHERE course_idx = ?", "int"   , String.valueOf(dto.getCourseIdx()), null}
		));
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = DaoUtils.sqlBuilder(conn, info);
		int result = ps.executeUpdate();
		conn.close();
		return result == 1;
	}
}
