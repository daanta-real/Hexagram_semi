package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.HexaLibrary;
import util.JdbcUtils;

public class CourseReplyDao {

	// 기능 목록
	// 1. List<CourseReplyDto> select(                             ): 모든 코스댓글 목록 조회
	// 2. CourseReplyDto       get   (int            courseReplyIdx): 코스댓글 정보 조회
	// 3. boolean              insert(CourseReplyDto dto           ): 코스댓글 추가
	// 4. boolean              delete(int            courseReplyIdx): 코스댓글 삭제
	// 5. boolean              update(CourseReplyDto dto           ): 코스댓글 수정

	// READ: 모든 코스댓글의 정보를 조회
	public List<CourseReplyDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM course_reply";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<CourseReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			CourseReplyDto dto = new CourseReplyDto();
			dto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			dto.setCourseIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setCourseReplyTargetIdx(rs.getInt("course_reply_target_idx"));
			dto.setCourseReplyDetail(rs.getString("course_reply_detail"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

	// READ: 딱 한 개의 코스댓글의 정보를 조회
	public CourseReplyDto get (int courseReplyIdx) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM course_reply WHERE course_reply_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, courseReplyIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		CourseReplyDto dto = null;
		if(rs.next()) {
			dto = new CourseReplyDto();
			dto.setCourseReplyIdx(rs.getInt("course_reply_idx"));
			dto.setCourseIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setCourseReplyTargetIdx(rs.getInt("course_reply_target_idx"));
			dto.setCourseReplyDetail(rs.getString("course_reply_detail"));
		}

		// 마무리
		conn.close();
		return dto;

	}

	// CREATE: 코스댓글 추가
	public boolean insert(CourseReplyDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO course_reply (course_reply_idx, item_idx, users_idx, course_reply_target_idx, course_reply_detail)"
			+ " VALUES(course_reply.NEXTVAL, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getCourseIdx());
		ps.setInt(2, dto.getUsersIdx());
		ps.setInt(3, dto.getCourseReplyTargetIdx());
		ps.setString(4, dto.getCourseReplyDetail());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// DELETE: 코스댓글 삭제
	public boolean delete(int courseReplyIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM course_reply WHERE course_reply_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, courseReplyIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// UPDATE: 코스댓글 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(CourseReplyDto dto) throws Exception {

		// SQL 정보 준비
		List<String[]> info = new ArrayList<>(Arrays.asList(
			new String[] {"UPDATE course SET "         , null    , null                                         , null},
			new String[] {"item_idx = ?"               , "int"   , String.valueOf(dto.getCourseIdx())           , "," },
			new String[] {"users_idx = ?"              , "int"   , String.valueOf(dto.getUsersIdx())            , "," },
			new String[] {"course_reply_target_idx = ?", "int"   , String.valueOf(dto.getCourseReplyTargetIdx()), "," },
			new String[] {"course_reply_detail = ?"    , "String", dto.getCourseReplyDetail()                   , "," },
			new String[] {" WHERE course_reply_idx = ?", "int"   , String.valueOf(dto.getCourseIdx())           , null}
		));

		// SQL문 만들어 보내고 결과 받아오기
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = HexaLibrary.sqlBuilder(conn, info);
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}
}
