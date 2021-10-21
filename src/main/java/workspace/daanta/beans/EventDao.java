package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.JdbcUtils;

public class EventDao {

	// 기능 목록
	// 1. List<EventDto> select(                 ): 모든 이벤트 목록 조회
	// 2. EventDto       get   (String   eventIdx): 이벤트 정보 조회
	// 3. boolean        insert(EventDto dto     ): 이벤트 추가
	// 4. boolean        delete(String   eventIdx): 이벤트 삭제
	// 5. boolean        update(EventDto dto     ): 이벤트 수정

	// READ: 모든 이벤트의 정보를 조회
	public List<EventDto> select() throws Exception {

		// 준비
		String sql = "SELECT * FROM event";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		List<EventDto> list = new ArrayList<>();
		while (rs.next()) {
			EventDto dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventSubject(rs.getString("event_subject"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventPeriods(rs.getString("event_periods"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;
	}

	// READ: 딱 한 명의 이벤트의 정보를 조회
	public EventDto get(String eventIdx) throws Exception {

		// 준비
		String sql = "SELECT * FROM event WHERE event_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, eventIdx);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		EventDto dto = new EventDto();
		if (rs.next()) {
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventSubject(rs.getString("event_subject"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventPeriods(rs.getString("event_periods"));
		}

		// 마무리
		conn.close();
		return dto;
	}

	// CREATE: 이벤트 추가
	public boolean insert(EventDto dto) throws Exception {

		// 준비
		String sql = "INSERT INTO event (event_idx, users_idx, event_subject, event_detail, event_periods)"
				+ " VALUES(event_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getEventIdx());
		ps.setInt(2, dto.getUsersIdx());
		ps.setString(3, dto.getEventSubject());
		ps.setString(4, dto.getEventDetail());
		ps.setString(5, dto.getEventPeriods());

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// DELETE: 이벤트 삭제
	public boolean delete(String eventIdx) throws Exception {

		// 준비
		String sql = "DELETE FROM event WHERE event_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, eventIdx);

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// UPDATE: 이벤트 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(EventDto dto) throws Exception {

		// SQL문 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE event SET");
		if (dto.getUsersIdx    () != null) sb.append((count++ == 0 ? "" : ",") + " users_idx = ?");
		if (dto.getEventSubject() != null) sb.append((count++ == 0 ? "" : ",") + " event_subject = ?");
		if (dto.getEventDetail () != null) sb.append((count++ == 0 ? "" : ",") + " event_detail = ?");
		if (dto.getEventPeriods() != null) sb.append((count++ == 0 ? "" : ",") + " event_periods = ?");
		sb.append(" WHERE event_idx = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if (dto.getUsersIdx    () != null) ps.setInt   (count++, dto.getUsersIdx    ());
		if (dto.getEventSubject() != null) ps.setString(count++, dto.getEventSubject());
		if (dto.getEventDetail () != null) ps.setString(count++, dto.getEventDetail ());
		if (dto.getEventPeriods() != null) ps.setString(count++, dto.getEventPeriods());
		ps.setInt(count, dto.getEventIdx());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

}