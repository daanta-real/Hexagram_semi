package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class CourseReplyDao {

	// 댓글 등록
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

	// 댓글 수정
	public boolean update(CourseReplyDto courseReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "update course_reply set course_reply_detail = ? where course_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, courseReplyDto.getCourseReplyDetail());
		ps.setInt(2, courseReplyDto.getCourseReplyIdx());

		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	// 댓글 삭제
	public boolean delete(int courseReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "delete course_reply where course_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseReplyIdx);

		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	// 댓글 목록
	public List<CourseReplyDto> list(int courseIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from course_reply where course_idx = ? order by course_idx desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);
		ResultSet rs = ps.executeQuery();

		List<CourseReplyDto> list = new ArrayList<CourseReplyDto>();
		while (rs.next()) {
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			courseReplyDto.setUsersIdx(rs.getInt("users_idx"));
			courseReplyDto.setCourseIdx(rs.getInt("course_idx"));
			courseReplyDto.setCourseReplyDetail(rs.getString("course_reply_detail"));
			courseReplyDto.setCourseReplyDate(rs.getDate("course_reply_date"));
			courseReplyDto.setCourseReplySuperno(rs.getInt("course_reply_superno"));
			courseReplyDto.setCourseReplyGroupno(rs.getInt("course_reply_groupno"));
			courseReplyDto.setCourseReplyDepth(rs.getInt("course_reply_depth"));

			list.add(courseReplyDto);
		}

		con.close();

		return list;

	}

	// 계층형 댓글 목록
	public List<CourseReplyDto> listByTreeSort(int courseIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from course_reply where course_idx = ? connect by prior course_reply_idx = course_reply_superno "
				+ "start with course_reply_superno is null "
				+ "order siblings by course_reply_groupno desc, course_idx asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseIdx);;
		ResultSet rs = ps.executeQuery();

		List<CourseReplyDto> list = new ArrayList<CourseReplyDto>();
		while (rs.next()) {
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			courseReplyDto.setUsersIdx(rs.getInt("users_idx"));
			courseReplyDto.setCourseIdx(rs.getInt("course_idx"));
			courseReplyDto.setCourseReplyDetail(rs.getString("course_reply_detail"));
			courseReplyDto.setCourseReplyDate(rs.getDate("course_reply_date"));
			courseReplyDto.setCourseReplySuperno(rs.getInt("course_reply_superno"));
			courseReplyDto.setCourseReplyGroupno(rs.getInt("course_reply_groupno"));
			courseReplyDto.setCourseReplyDepth(rs.getInt("course_reply_depth"));

			list.add(courseReplyDto);
		}

		con.close();

		return list;

	}

	// 시퀀스 번호 생성.
	// 계층형이기 때문에 생성해주어야 한다. 즉CourseReplyGroupno에다가 최초 생성할 시에, 시퀀스 번호가 계층형 그룹 번호가 되어야하므로,
	//그 정보가 필요하다.
	public int getSequenceNo() throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "select course_reply_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
	}

	// 대댓글 등록 기능
	public void insertTarget(CourseReplyDto courseReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "insert into course_reply values(?, ?, ?, ?, sysdate, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, courseReplyDto.getCourseReplyIdx());
		ps.setInt(2, courseReplyDto.getUsersIdx());
		ps.setInt(3, courseReplyDto.getCourseIdx());
		ps.setString(4, courseReplyDto.getCourseReplyDetail());
		ps.setInt(5, courseReplyDto.getCourseReplySuperno());
		ps.setInt(6, courseReplyDto.getCourseReplyGroupno());
		ps.setInt(7, courseReplyDto.getCourseReplyDepth());

		ps.execute();
		
		con.close();
	}
	
	//대댓글 등록시 필요한 단일조회
	public CourseReplyDto get(int courseReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "select * from course_reply where course_reply_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, courseReplyIdx);
		ResultSet rs = ps.executeQuery();
		
		CourseReplyDto courseReplyDto = new CourseReplyDto();
		
		if(rs.next()) {
			courseReplyDto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			courseReplyDto.setUsersIdx(rs.getInt("users_idx"));
			courseReplyDto.setCourseIdx(rs.getInt("course_idx"));
			courseReplyDto.setCourseReplyDetail(rs.getString("course_reply_detail"));
			courseReplyDto.setCourseReplyDate(rs.getDate("course_reply_date"));
			courseReplyDto.setCourseReplySuperno(rs.getInt("course_reply_superno"));
			courseReplyDto.setCourseReplyGroupno(rs.getInt("course_reply_groupno"));
			courseReplyDto.setCourseReplyDepth(rs.getInt("course_reply_depth"));

		}
	
		con.close();
		return courseReplyDto;
	}
	
}
