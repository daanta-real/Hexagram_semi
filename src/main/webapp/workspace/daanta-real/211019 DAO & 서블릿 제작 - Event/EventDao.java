import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EventDao {

	// 기능 목록
	// 1. List<EventDto> select   (                  ): 모든 이벤트 목록 조회
	// 2. EventDto       get      (String   id       ): 이벤트 정보 조회
	// 3. boolean        insert   (EventDto dto      ): 이벤트 추가
	// 4. boolean        delete   (String   id       ): 이벤트 삭제
	// 5. boolean        update   (EventDto dto      ): 이벤트 수정

	// READ: 모든 이벤트의 정보를 조회
	public List<EventDto> select() throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "SELECT * FROM event";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		List<EventDto> list = new ArrayList<>();
		while(rs.next()) {
			EventDto dto = new EventDto();
			dto.setIdx  (rs.getInt   ("event_idx"  ));
			dto.setId   (rs.getString("event_id"   ));
			dto.setNick (rs.getString("event_nick" ));
			dto.setEmail(rs.getString("event_email"));
			dto.setGrade(rs.getString("event_grade"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;
	}

	// READ: 딱 한 명의 이벤트의 정보를 조회
	public EventDto get(String id) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "SELECT * FROM event WHERE event_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();

		// 받아오기
		EventDto dto = new EventDto();
		if(rs.next()) {
			dto.setIdx  (rs.getInt   ("event_idx"  ));
			dto.setId   (rs.getString("event_id"   ));
			dto.setPw   (rs.getString("event_pw"   ));
			dto.setNick (rs.getString("event_nick" ));
			dto.setEmail(rs.getString("event_email"));
			dto.setGrade(rs.getString("event_grade"));
		}

		// 마무리
		conn.close();
		return dto;
	}

	// CREATE: 이벤트 추가
	public boolean insert(EventDto dto) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "INSERT INTO event (event_idx, event_id, event_pw, event_nick, event_email, event_grade)"
			+ " VALUES(event_seq.NEXTVAL, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getId());
		ps.setString(2, dto.getPw());
		ps.setString(3, dto.getNick());
		ps.setString(4, dto.getEmail());
		ps.setString(5, dto.getGrade());

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// DELETE: 이벤트 삭제
	public boolean delete(String id) throws ClassNotFoundException, SQLException {

		// 준비
		String sql = "DELETE FROM event WHERE event_id = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, id);

		// 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

	// UPDATE: 이벤트 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(EventDto dto) throws ClassNotFoundException, SQLException {

		// SQL문 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE event SET");
		if(dto.getPw()    != null) sb.append( (count++ == 0 ? "" : ",") + " event_pw = ?"   );
		if(dto.getNick()  != null) sb.append( (count++ == 0 ? "" : ",") + " event_nick = ?" );
		if(dto.getEmail() != null) sb.append( (count++ == 0 ? "" : ",") + " event_email = ?");
		if(dto.getGrade() != null) sb.append( (count++ == 0 ? "" : ",") + " event_grade = ?");
		sb.append(" WHERE event_id = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if(dto.getPw()    != null) ps.setString(count++, dto.getPw()   );
		if(dto.getNick()  != null) ps.setString(count++, dto.getNick() );
		if(dto.getEmail() != null) ps.setString(count++, dto.getEmail());
		if(dto.getGrade() != null) ps.setString(count++, dto.getGrade());
		ps.setString(count, dto.getId());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int isSucceed = ps.executeUpdate();

		// 마무리
		conn.close();
		return isSucceed == 1;
	}

}