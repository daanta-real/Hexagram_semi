package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseItemDao {


	//목록 메소드 (코스 등록 및 수정 서블릿에서 중복을 방지하기 위해 사용된다)
	//코스 목록
	public List<CourseItemDto> getByCourse(int courseSequnce) throws Exception {
		
		//course에 등록한 item목록을 보기위해 코스의 시퀀스값(매개변수)를 받아 course_item_idx로 내림차순 정렬
		String sql = "SELECT * FROM course_item where course_idx=? order by course_item_idx asc";
		
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseSequnce);
		ResultSet rs = ps.executeQuery();

		//반복문으로 목록 조회
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
	

	//courseIdx에 들어있는 오직 하나의 item만을 꺼내서 지역을 확인할 수 있다.
	//(코스는 따로 지역 확인이 불가능하기 때문에 하나만 꺼내도 지역을 확일할 수 있고 이를 통한 비교로 동일 지역만 선택이 가능하도록 하기 위한 메소드)
	public int getItemIdxByCourse(int courseIdx) throws Exception {
		String sql = "SELECT * FROM course_item where course_idx=? order by course_item_idx asc";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt("item_idx");

		con.close();
		return result;
		}
	
	//필터 통과시에 코스 등록전에 그 임시 코스 번호에 코스-아이템 수가 얼마인지 체크해서 확실히 등록시키기 위함.(코스 게시물에 관광지가 3~8개 사이에 있어야 등록이 가능하도록 함)
	//CourseAjaxCountItemFilter의 필터에서 사용된다.
	public int getCount(int courseIdx) throws Exception {
		String sql = "SELECT count(*) FROM course_item where course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
		}

	//코스 등록시 course_item 등록 메소드
	//CourseAjaxItemAddServlet 및 CourseAjaxItemAddForUpdateServlet에서 사용하며,
	//코스 등록시에(insert.jsp) 코스 수정시에(update.jsp)에서 cousreSequnce와 itemIdx를 ajax로 전달하여 코스_아이템 db에 항목을 추가시키기 위한 메소드
	public void insert(CourseItemDto courseItemDto) throws Exception {
		String sql = "INSERT INTO course_item values(course_item_seq.nextval,?,?)";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseItemDto.getItemIdx());
		ps.setInt(2, courseItemDto.getCourseIdx());

		ps.execute();

		con.close();
	}

	//코스 등록시 course_item 등록 메소드
	//CourseItemAjaxDeleteServlet 및 CourseItemAjaxDeleteServletForUpdateServlet에서 사용하며,
	//코스 등록시에(insert.jsp) 코스 수정시에(update.jsp)에서 cousreSequnce와 itemIdx를 ajax로 전달하여 코스_아이템 db에 항목을 삭제시키기 위한 메소드
	public boolean deleteItem(CourseItemDto courseItemDto) throws Exception {
		String sql = "delete course_item where item_idx=? and course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseItemDto.getItemIdx());
		ps.setInt(2, courseItemDto.getCourseIdx());

		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}
	
	//CourseDeleteServlet에서 코스가 삭제될때 해당 코스번호에 대한 코스-아이템 정보를 함께 삭제해준다.
	public boolean delete(int courseIdx) throws Exception {
		String sql = "delete course_item where course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseIdx);

		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}


}
