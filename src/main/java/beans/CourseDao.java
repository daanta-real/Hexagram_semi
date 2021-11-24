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
		
		// 단일 조회(상세 조회를 위한 것임)
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
		
		//시퀀스값을 같이 등록하는 메소드(시퀀스 값을 생성한 뒤에 코스 등록에 넣어서 상세조회 페이지로 바로갈 수 있게 설정)
		//CourseInsertServlet에서 처리함.
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
		//CourseDeleteServlet에서 처리
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
		//CourseUpdateServlet에서 처리
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
		//CourseCreateSequnceForInsertServlet에서 코스 등록 전 생성
		//CourseCreateSequnceForUpdateServlet에서 코스 수정 전 생성(임시 수정 번호)
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
		
		//현재 시퀀스 번호를 확인한다(코스 등록 필터 처리 시에 현재의 시퀀스 값보다 높은 값을 주소값에 넣으면 막아줄 수 있다.)
		//즉 시퀀스를 미리 생성하고 나서, 절차를 진행해야함을 의미한다.
		//CourseAjaxAddFilter에서 사용
		public int getCurrSequence() throws Exception {
			String sql = "select course_seq.currval from dual";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			rs.next();
			int result = rs.getInt(1);

			con.close();
			return result;
		}
		
		//등록 및 수정시에 사용자가 완료하지 않고 생성한 코스번호에 대해서 삭제해준다.
		//CourseCreateSequnceForInsertServlet에서 코스 시퀀스 번호 발급 전 최종 코스 등록 완료된 번호를 확인한다.
		//CourseCreateSequnceForUpdateServlet에서 코스 수정 임시 번호 발급 전 최종 코스 등록 완료된 번호를 확인한다.
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
		
		//임시 발급된 번호에 대해서 등록전 코스아이템의 쓰레기 DB를 처리하는 것이라 코스아이템DAO에서 처리할 수 있지만, 문맥상
		//코스번호에 귀속된 내용이기 때문에 코스DAO에서 메소드를 만들어서 처리하기로 함.
		
		//CourseCreateSequnceForInsertServlet에서 코스 시퀀스 번호 발급 전 최종 코스 등록 완료된 번호를 확인한 후 그 번호보다 큰 값들은 삭제시키고 새로운 시퀀스 번호를 받아 진행한다.
		//CourseCreateSequnceForUpdateServlet에서 코스 수정 임시 번호 발급 전 최종 코스 등록 완료된 번호를 확인한 후 그 번호보다 큰 값들은 삭제시키고 새로운 시퀀스 번호를 받아 진행한다.
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
		//총 해당 코스번호에 있는 댓글의 총 개수를 확인하고 그 개수로 업데이트해준다.
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
		
		//코스 게시물 총 개수 확인 메소드(검색용:코스DB의 컬럼에만 있는 항목임)
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
		
		//코스 게시물 총 개수 확인 메소드(검색용)
		//코스DB에 검색에 대한 정보가 없으므로 관광지DB에서 확인하여 꺼내와야한다.
		//이를 위해서 course / item / course_item을 조인하여 item의 주소 컬럼으로 검색하게한다.
		//rank() over을 사용하여 각 코스의 첫번째로 등록된 item의 주소만 조회한다.
		//그 후 총 개수를 파악한다.
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
		
		//코스 게시물 총 개수 확인 메소드(검색용)
		//countCity와 동일하지만 시,군,구까지 함께 검색하여 두 번의 조건을 거친다.
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
		
		//조회수 증가 메소드(회원일 때 CourseReadupServlet에서 처리)
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
		
		//조회수 증가 메소드(비회원일 때 CourseReadupServlet에서 처리)
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
		
		//목록 기능 - 페이지네이션(정렬순 표시)
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
		//검색 기능 - 페이지네이션(정렬순 표시)
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
		
		//검색 기능 - 페이지네이션(정렬순 표시/아이템DB 컬럼의 주소를 사용)
		//코스DB에 검색에 대한 정보가 없으므로 관광지DB에서 확인하여 꺼내와야한다.
		//이를 위해서 course / item / course_item을 조인하여 item의 주소 컬럼으로 검색하게한다.
		//rank() over을 사용하여 각 코스의 첫번째로 등록된 item의 주소만 조회한다.
		//*주의사항 : cousreDto를 담을 때 users_idx항목을 제외 시키고 담았는데 이는 조인시에 컬럼명이 중복되어 추후 따로 course_idx만 뽑아내어 코스Dao에서 사용자를 확인후
		//UsersDao 및 UsersDto를 사용하여 유저의 정보를 알아낼 수 있다.
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
		
		//검색 기능 - 페이지네이션(정렬순 표시/아이템DB 컬럼의 주소를 사용)
		//위 cityList와 모든 설명이 동일하며, 조회시 시,군,구까지 조회하여 두 번의 조건을 거치게 된다.
		//추가적으로 아래의 sql구문이라면 코스내에 담긴 관광지의 주소들(즉 시,군,구)가 달라도 주소 검색시에는 이 모든 것들을 세부적으로 찾아줌으로써,
		//코스 내부에 담긴 관광지의 모든 시,군,구의 내용이 포함될 수 있다.
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
