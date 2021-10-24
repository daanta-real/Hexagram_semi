package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.JdbcUtils;
import workspace.daanta.util.DaoUtils;

public class EventDao {

	// 기능 목록
	// 1. List<EventDto> select(                 ): 모든 이벤트 목록 조회
	// 2. EventDto       get   (int      eventIdx): 이벤트 정보 조회
	// 3. boolean        insert(EventDto dto     ): 이벤트 추가
	// 4. boolean        delete(int      eventIdx): 이벤트 삭제
	// 5. boolean        update(EventDto dto     ): 이벤트 수정

	// READ: 모든 이벤트의 정보를 조회
	public List<EventDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM event";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		while (rs.next()) {
			EventDto dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventSubject(rs.getString("event_subject"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventPeriod(rs.getString("event_period"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

	// READ: 딱 한 명의 이벤트의 정보를 조회
	public EventDto get(int eventIdx) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM event WHERE event_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		EventDto dto = null;
		if (rs.next()) {
			dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventSubject(rs.getString("event_subject"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventPeriod(rs.getString("event_period"));
		}

		// 마무리
		conn.close();
		return dto;

	}

	// CREATE: 이벤트 추가
	public boolean insert(EventDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO event (event_idx, users_idx, event_subject, event_detail, event_period)"
				+ " VALUES(event_seq.NEXTVAL, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getUsersIdx());
		ps.setString(2, dto.getEventSubject());
		ps.setString(3, dto.getEventDetail());
		ps.setString(4, dto.getEventPeriod());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// DELETE: 이벤트 삭제
	public boolean delete(int eventIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM event WHERE event_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// UPDATE: 이벤트 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(EventDto dto) throws Exception {

		// SQL 정보 준비
		List<String[]> info = new ArrayList<>(Arrays.asList(
			new String[] { "UPDATE event SET "    , null    , null                             , null },
			new String[] { "users_idx = ?"        , "int"   , String.valueOf(dto.getEventIdx()), ","  },
			new String[] { "event_subject = ?"    , "String", dto.getEventSubject()            , ","  },
			new String[] { "event_detail = ?"     , "String", dto.getEventDetail()             , ","  },
			new String[] { "event_period = ?"     , "String", dto.getEventPeriod()             , ","  },
			new String[] { " WHERE event_idx = ?" , "int"   , String.valueOf(dto.getEventIdx()), null }
		));

		// SQL문 만들어 보내고 결과 받아오기
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = DaoUtils.sqlBuilder(conn, info);
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

}