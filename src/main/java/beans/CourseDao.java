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

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}
		
		public boolean delete(int courseIdx) throws Exception {
			String sql = "delete course where course_idx=?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, courseIdx);

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}
		
		public boolean update(CourseDto courseDto) throws Exception {
			String sql = "update course set course_name=?,course_detail=? where course_idx=?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setString(1, courseDto.getCourseName());
			ps.setString(2, courseDto.getCourseDetail());
			ps.setInt(3, courseDto.getCourseIdx());

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
		
		//등록 및 수정시에 사용자가 완료하지 않고 생성한 코스번호에 대해서 삭제해준다.
		public int getMaxIdx() throws Exception {
			String sql = "select max(course_idx) from course";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		//코스아이템 DAO에서 처리할 수 있으나 여기에서도 충분히 처리가능하여 여기에서 처리하기로 함.
		public boolean getMaxIdxDelete(int maxCourseIdx) throws Exception {
			String sql = "delete course_item where course_idx > ?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, maxCourseIdx);
			
			int result = ps.executeUpdate();

			con.close();
			return result>0;
		}
		
		//게시글 댓글 개수 갱신 기능
		public boolean countCourseReply(int courseIdx) throws Exception{
			Connection con = JdbcUtils.connect3();
			String sql = "update course set course_count_reply = (select count(*) from course_reply where course_idx = ?) where course_idx = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, courseIdx);
			ps.setInt(2, courseIdx);
			
			int result = ps.executeUpdate();
			
			con.close();
			
			return result > 0;
			
		}
		
		public int count() throws Exception {
			Connection con = JdbcUtils.connect3();
			String sql = "select count(*) from course";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		public int count(String column,String keyword) throws Exception {
			Connection con = JdbcUtils.connect3();
			String sql = "select count(*) from course where instr(#1,?)>0";
			sql = sql.replace("#1", column);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		public List<CourseDto> listByRownum(int begin, int end) throws Exception {
			String sql = "select * from( "
					+ "select rownum rn,tmp.* from( "
					+ "(SELECT * FROM course order by course_idx desc)tmp)) "
					+ "where rn between ? and ?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, begin);
			ps.setInt(2, end);
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
		
		public List<CourseDto> searchByRownum(String column, String keyword, int begin, int end) throws Exception {
			String sql = "select * from( "
					+ "select rownum rn,tmp.* from( "
					+ "(SELECT * FROM course where instr(#1,?)>0 order by course_idx desc)tmp)) "
					+ "where rn between ? and ?";
			sql = sql.replace("#1", column);
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, begin);
			ps.setInt(3, end);
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
		public boolean readUp(int courseIdx, int usersIdx) throws Exception {
			Connection con = JdbcUtils.connect3();
			
			String sql = "update course set course_count_view = course_count_view + 1"
							+ " where course_idx = ? and users_idx != ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, courseIdx);
			ps.setInt(2, usersIdx);

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}

}
