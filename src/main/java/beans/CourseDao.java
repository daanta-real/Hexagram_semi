package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseDao implements PaginationInterface<CourseDto> {
	
		// 전체 조회 - 페이지네이션 전
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
		
		//시퀀스값을 같이 등록하는 메소드
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
		
		//코스 게시물 삭제 메소드
		public boolean delete(int courseIdx) throws Exception {
			String sql = "delete course where course_idx=?";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);

			ps.setInt(1, courseIdx);

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}
		
		//코스 게시물 수정 메소드
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
		
		//시퀀스 번호 미리 부여받는 메소드
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
		
		//코스 게시물 총 개수 확인 메소드
		public Integer count() throws Exception {
			Connection con = JdbcUtils.connect3();
			String sql = "select count(*) from course";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		//코스 게시물 총 개수 확인 메소드(검색용)
		public Integer count(String column,String keyword) throws Exception {
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
		
		public Integer countSubCity(String column, String keyword, String subCity) throws Exception {
			Connection con = JdbcUtils.connect3();
			String sql = "select count(*) from"
					+ " (select"
					+ " course_idx,course_count_view, course_count_reply, item_address,course_item_idx,"
					+ " rank() over(partition by course_idx order by course_item_idx asc) rk"
					+ " from"
					+ " (select * from"
					+ " course_item"
					+ " inner join course using(course_idx)"
					+ " inner join item using(item_idx)"
					+ " where"
					+ " instr(#1,?) = 1"
					+ " and"
					+ " instr(#1,?)>0"
					+ ")) where rk = 1";
			sql = sql.replace("#1", column);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, subCity);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		public Integer countCity(String column, String keyword) throws Exception {
			Connection con = JdbcUtils.connect3();
			String sql = "select count(*) from"
					+ " (select"
					+ " course_idx,course_count_view, course_count_reply, item_address,course_item_idx,"
					+ " rank() over(partition by course_idx order by course_item_idx asc) rk"
					+ " from"
					+ " (select * from"
					+ " course_item"
					+ " inner join course using(course_idx)"
					+ " inner join item using(item_idx)"
					+ " where"
					+ " instr(#1, ?) = 1)) where rk = 1";
			sql = sql.replace("#1", column);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		//목록 기능 - 페이지네이션
		public List<CourseDto> list(int begin, int end) throws Exception {
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
		
		//검색 메소드 - 페이지네이션
		public List<CourseDto> search(String column, String keyword, int begin, int end) throws Exception {
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
		
		//조회수 증가 메소드
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
		
		//조회수 증가 메소드
		public boolean readUp(int courseIdx) throws Exception {
			Connection con = JdbcUtils.connect3();
			
			String sql = "update course set course_count_view = course_count_view + 1"
							+ " where course_idx = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, courseIdx);

			int result = ps.executeUpdate();

			con.close();
			return result > 0;
		}
		
		public List<CourseDto> orderByList(String order,int begin, int end) throws Exception {
			String sql = "select * from( "
					+ "select rownum rn,tmp.* from( "
					+ "(SELECT * FROM course order by #1 desc)tmp)) "
					+ "where rn between ? and ?";
			sql = sql.replace("#1", order);
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
		
		public List<CourseDto> orderByKeywordList(String order,String column, String keyword, int begin, int end) throws Exception {
			String sql = "select * from( "
					+ "select rownum rn,tmp.* from( "
					+ "(SELECT * FROM course where instr(#1,?)>0 order by #2 desc)tmp)) "
					+ "where rn between ? and ?";
			sql = sql.replace("#1", column);
			sql = sql.replace("#2", order);
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
		
		public List<CourseDto> cityList(String order,String column, String keyword, int begin, int end) throws Exception {

			Connection con = JdbcUtils.connect3();
			
			String sql = "select * from"
					+ " (select rownum rn,tmp.* from"
					+ " (select"
					+ " course_idx,course_name,course_detail,course_date,course_count_view, course_count_reply, item_address,course_item_idx,"
					+ " rank() over(partition by course_idx order by course_item_idx asc) rk"
					+ " from"
					+ " (select * from"
					+ " course_item"
					+ " inner join course using(course_idx)"
					+ " inner join item using(item_idx)"
					+ " where"
					+ " instr(#1, ?) = 1))tmp where rk = 1 order by #2 desc)"
					+ " where rn between ? and ?";
			
			sql = sql.replace("#1", column);
			sql = sql.replace("#2", order);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, begin);
			ps.setInt(3, end);
			
			ResultSet rs = ps.executeQuery();
			List<CourseDto> list = new ArrayList<>();
			while (rs.next()) {
				CourseDto courseDto = new CourseDto();
				courseDto.setCourseIdx(rs.getInt("course_idx"));
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
		
		
		public List<CourseDto> subCityList(String subCity,String order,String column, String keyword, int begin, int end) throws Exception {

			Connection con = JdbcUtils.connect3();
			String sql = "select * from"
					+ " (select rownum rn,tmp.* from"
					+ " (select"
					+ " course_idx,course_name,course_detail,course_date,course_count_view, course_count_reply, item_address,course_item_idx,"
					+ " rank() over(partition by course_idx order by course_item_idx asc) rk"
					+ " from"
					+ " (select * from"
					+ " course_item"
					+ " inner join course using(course_idx)"
					+ " inner join item using(item_idx)"
					+ " where"
					+ " instr(#1,?)=1"
					+ " and"
					+ " instr(#1,?)>0))tmp where rk = 1 order by #2 desc)"
					+ " where rn between ? and ?";
			
			sql = sql.replace("#1", column);
			sql = sql.replace("#2", order);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, subCity);
			ps.setInt(3, begin);
			ps.setInt(4, end);
			
			ResultSet rs = ps.executeQuery();
			List<CourseDto> list = new ArrayList<>();
			while (rs.next()) {
				CourseDto courseDto = new CourseDto();
				courseDto.setCourseIdx(rs.getInt("course_idx"));
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

}
