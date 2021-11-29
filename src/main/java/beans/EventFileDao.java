package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JdbcUtils;

public class EventFileDao {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. CREATE: 파일 추가
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public boolean insert(EventFileDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO event_file(event_file_idx, event_idx, event_file_upload_name,"
			+ " event_file_save_name, event_file_type, event_file_size)"
			+ " VALUES(event_file_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getEventIdx());
		ps.setString(2, dto.getEventFileUploadName());
		ps.setString(3, dto.getEventFileSaveName());
		ps.setString(4, dto.getEventFileType());
		ps.setLong(5, dto.getEventFileSize());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. DELETE: 파일 삭제
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public boolean delete(Integer eventFileIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM event_file WHERE event_file_idx = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventFileIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. READ: 딱 한 파일의 정보를 조회 (여러 파일 아님)
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public EventFileDto get(Integer eventIdx) throws Exception {

		// SQL 준비
		Connection conn = JdbcUtils.connect3();

		String sql = "SELECT * FROM event_file WHERE event_idx = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		EventFileDto dto = null;
		if(rs.next()) {
			dto = new EventFileDto();
			dto.setEventFileIdx(rs.getInt("event_file_idx"));
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setEventFileUploadName(rs.getString("event_file_upload_name"));
			dto.setEventFileSaveName(rs.getString("event_file_save_name"));
			dto.setEventFileSize(rs.getLong("event_file_size"));
			dto.setEventFileType(rs.getString("event_file_type"));
		}

		// 마무리
		conn.close();
		return dto;

	}

}
