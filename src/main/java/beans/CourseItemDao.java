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
		
		//course에 등록한 item목록을 보기위해 코스의 시퀀스값(매개변수)를 받아 item_idx로 정렬
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
	

	//course_item에 갯수 확인 메소드(코스등록시 3~8개로 제한되기 때문)
	public int getItemIdxByCourse(int courseIdx) throws Exception {
		String sql = "SELECT * FROM course_item where course_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt("item_idx");
		
		con.close();
		return result;
		}

	//course_item 등록 메소드
	//코스 등록시 course_item 등록 메소드
	public void insert(CourseItemDto courseItemDto) throws Exception {
		String sql = "INSERT INTO course_item values(course_item_seq.nextval,?,?)";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseItemDto.getItemIdx());
		ps.setInt(2, courseItemDto.getCourseIdx());

		ps.execute();

		con.close();
	}

	//course_item 삭제 메소드
	//코스 수정시 course_item에서 관광지 삭제를 위한 메소드
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
	
	//course 삭제 메소드 (courseDao도 있음 의동님과 회의 후 처리)
	//코스 게시물 삭제
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
