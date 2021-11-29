package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.JdbcUtils;

public class EventDao implements PaginationInterface<EventDto> {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 0. 요청된 컬럼 적합여부 검사용
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	private static String[] COLUMN_LIST = {
		"event_idx", "users_idx", "users_id", "users_nick", "event_name", "event_detail", "event_date", "event_count_view", "event_count_reply"
	};
	// 입력받은 컬럼이 null이거나 혹은 컬럼 목록에 해당되는 문자열 값이어야 함.
	public boolean columnVerify(String column) throws Exception {
		if(column != null && !Arrays.stream(COLUMN_LIST).anyMatch(column::equals)) {
			System.out.println("[오류] " + column + " → 이 값은 기본 컬럼 리스트에 없는 값입니다. 오류를 발생시키겠습니다.");
			throw new Exception();
		}
		return true;
	}

	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. READ: 모든 이벤트 글을 조회
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public List<EventDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM event ORDER BY event_idx DESC";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		while (rs.next()) {
			EventDto dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventName(rs.getString("event_name"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventDate(rs.getDate("event_date"));
			dto.setEventCountView(rs.getInt("event_count_view"));
			dto.setEventCountReply(rs.getInt("event_count_reply"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. READ: 딱 한 글 정보를 조회
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public EventDto get(Integer eventIdx) throws Exception{

		// SQL 준비
		Connection conn = JdbcUtils.connect3();

		String sql
		= "SELECT * FROM ("
			+ "SELECT e.event_idx, e.users_idx, e.event_name, e.event_detail, e.event_date, e.event_count_view, e.event_count_reply"
				  + ", u.users_id, u.users_nick, u.users_grade" // users 테이블에서 일부 정보를 갖고 온다.
				  + ", NVL(f.event_file_idx, -1) \"file_idx\", f.event_file_upload_name, f.event_file_save_name, f.event_file_size, f.event_file_type" // event_file 테이블에서 일부 정보를 갖고 온다. 무조건 합치며 없으면 NULL임
			+ " FROM event e"
			+ " LEFT JOIN users u      ON e.users_idx = u.users_idx"
			+ " LEFT JOIN event_file f ON f.event_idx = e.event_idx"
		+ ") WHERE event_idx = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		EventDto dto = null;
		if(rs.next()) {
			dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventName(rs.getString("event_name"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventDate(rs.getDate("event_date"));
			dto.setEventCountView(rs.getInt("event_count_view"));
			dto.setEventCountReply(rs.getInt("event_count_reply"));
			// Users 추가 설정
			dto.initUsersDto(rs.getString("users_id"), rs.getString("users_nick"), rs.getString("users_grade"));
			// Files 추가 설정. -1이 아닐 경우 fileDto가 있으므로 각 하위값을 넣어주지만 -1일 경우 fileDto는 null로 취급
			int fileIdx = rs.getInt("file_idx");
			System.out.println("file_idx = " + fileIdx);
			if(fileIdx != -1) {
				Integer idx = rs.getInt("file_idx");
				String uploadName = rs.getString("event_file_upload_name");
				String saveName = rs.getString("event_file_save_name");
				Long fileSize = rs.getLong("event_file_size");
				String fileType = rs.getString("event_file_type");
				dto.initFileDto(idx, uploadName, saveName, fileSize, fileType);
			}
		}

		// 마무리
		conn.close();
		return dto;
	}

	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. CREATE: 이벤트 글 추가
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1) 새 시퀀스(DB의 event_idx 컬럼에 들어갈 값) 얻기
	public Integer getNextSequence() throws Exception {

		// SQL 준비
		String sql = "SELECT event_seq.NEXTVAL FROM DUAL";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL 구문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		Integer result = null;
		if(rs.next()) result = rs.getInt(1);

		// 마무리
		conn.close();
		return result;

	}

	// 2) 글 추가 부분
	// 여기서 설정 못 하는 기본값: 작성일(DEF. SYSDATE), 뷰카운트(DEF. 0), 댓글수(DEF. 0)
	public boolean insert(EventDto dto) throws Exception {

		// ※ 시퀀스 없을 때는 알아서 새로 따서 DTO에 넣어 준다.
		// 단, 이러면 당연히 외부에서 시퀀스 번호를 못 얻게 된다.
		if(dto.getEventIdx() == null) dto.setEventIdx(getNextSequence());

		// SQL 준비
		String sql = "INSERT INTO event(event_idx, users_idx, event_name, event_detail)"
			+ " VALUES(?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt   (1, dto.getEventIdx());
		ps.setInt   (2, dto.getUsersIdx());
		ps.setString(3, dto.getEventName());
		ps.setString(4, dto.getEventDetail());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 4. DELETE: 글 삭제
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	public boolean delete(Integer eventIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM event WHERE event_idx = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 5. UPDATE: 글 수정
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1) 정보 수정 가능
	// DTO에는 ID만 기존 값을 식별자 용도로 넣되, 나머지는 모두 새롭게 수정될 값을 넣는다.
	// 참고로 수정될 값은 최소 한 종류 이상은 넣어야 된다. 아예 없으면 에러 난다.
	public boolean update(EventDto dto) throws Exception {

		// SQL 준비
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE event SET");
		if (dto.getEventIdx()        != null) sb.append((count++ == 0 ? "" : ",") + " event_idx = ?");
		if (dto.getUsersIdx()        != null) sb.append((count++ == 0 ? "" : ",") + " users_idx = ?");
		if (dto.getEventName()       != null) sb.append((count++ == 0 ? "" : ",") + " event_name = ?");
		if (dto.getEventDetail()     != null) sb.append((count++ == 0 ? "" : ",") + " event_detail = ?");
		if (dto.getEventDate()       != null) sb.append((count++ == 0 ? "" : ",") + " event_date = ?");
		if (dto.getEventCountView()  != null) sb.append((count++ == 0 ? "" : ",") + " event_count_view = ?");
		if (dto.getEventCountReply() != null) sb.append((count++ == 0 ? "" : ",") + " event_count_reply = ?");
		sb.append(" WHERE event_idx = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if (dto.getEventIdx()        != null) ps.setInt   (count++, dto.getEventIdx()       );
		if (dto.getUsersIdx()        != null) ps.setInt   (count++, dto.getUsersIdx()       );
		if (dto.getEventName()       != null) ps.setString(count++, dto.getEventName()      );
		if (dto.getEventDetail()     != null) ps.setString(count++, dto.getEventDetail()    );
		if (dto.getEventDate()       != null) ps.setDate  (count++, (java.sql.Date) dto.getEventDate());
		if (dto.getEventCountView()  != null) ps.setInt   (count++, dto.getEventCountView() );
		if (dto.getEventCountReply() != null) ps.setInt   (count++, dto.getEventCountReply());
		ps.setInt(count, dto.getEventIdx());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// 2) 조회수 증가
	//조회수 증가(비회원용)
	public boolean readUp(Integer eventIdx) throws Exception {
		// SQL 준비
		String sql = "UPDATE event SET event_count_view = event_count_view + 1"
			+ " WHERE event_idx = ?";

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();

		// 마무리
		conn.close();
		return result>0;
	}
	
	//조회수 증가(게시글 작성자 이외의 상황일때 (회원전용))
	public boolean readUp(Integer eventIdx, Integer usersIdx) throws Exception {

		// SQL 준비
		String sql = "UPDATE event SET event_count_view = event_count_view + 1"
			+ " WHERE event_idx = ? and users_idx != ?";

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);
		ps.setInt(2, usersIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();

		// 마무리
		conn.close();
		return result>0;

	}

	// 특정 event_idx의 댓글 수를 재계산하여 DB 반영
	public boolean countReply(Integer eventIdx) throws Exception {

		// SQL 준비
		String sql = "UPDATE event"
			+ " SET event_count_reply = ("
				+ "SELECT COUNT(*) FROM event_reply"
				+ " WHERE event_idx = ?"
			+ ") WHERE event_idx = ?";
		System.out.println("　　SQL문 준비됨: " + sql);

		// SQL ?부분 완성
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, eventIdx);
		ps.setInt(2, eventIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 6. SEARCH: 글 검색
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 목록 - 단일컬럼 검색(항목, 검색어)기능
	public List<EventDto> search(String column, String keyword) throws Exception {

		// column값 검사: null이 아니면서, 본 DB의 컬럼이 아닌 문자열이 들어오면 오류 생성해서 팅가냄
		columnVerify(column);

		// SQL준비
		String sql = "SELECT * FROM event b"
			+ " LEFT JOIN users u ON b.users_idx = u.users_idx"
			+ " WHERE INSTR(#1, ?) > 0"
			+ " ORDER BY b.users_idx DESC";
		sql = sql.replace("#1", column);
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, keyword);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		EventDto dto = null;
		while(rs.next()) {
			dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventName(rs.getString("event_name"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventDate(rs.getDate("event_date"));
			dto.setEventCountView(rs.getInt("event_count_view"));
			dto.setEventCountReply(rs.getInt("event_count_reply"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 7. PAGING: 글 검색목록 페이징
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 1-1. 개수 - DB 전체 (페이징에서 마지막 블록을 구하기 위하여 목록 개수를 구함)
	@Override
	public Integer count() throws Exception { return count(null, null); }
	// 1-2. 개수 - 단일컬럼 검색 (페이징에서 마지막 블록을 구하기 위하여 목록 개수를 구함)
	@Override
	public Integer count(String column, String keyword) throws Exception {

		// column값 검사: null이 아니면서, 본 DB의 컬럼이 아닌 문자열이 들어오면 오류 생성해서 팅가냄
		columnVerify(column);

		// SQL 준비
		String sql
			= "SELECT COUNT(*) FROM ("
				+ "SELECT b.event_idx, b.users_idx, b.event_name, b.event_detail, b.event_date, b.event_count_view, b.event_count_reply,"
					  + " u.users_id, u.users_nick, u.users_grade" // users 테이블에서 일부 정보를 갖고 온다.
				+ " FROM event b"
				+ " LEFT JOIN users u ON b.users_idx = u.users_idx"
				+ (column != null ? (" WHERE INSTR(" + column + ", ?) > 0") : "")
			+ ") ORDER BY event_idx DESC";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		if(column != null) ps.setString(1, keyword);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		// 마무리
		conn.close();
		return count;

	}

	// 2-1. 목록 - DB 전체 (글 한 페이지를 통으로 갖고 옴)
	@Override
	public List<EventDto> list(int begin, int end) throws Exception { return search(null, null, begin, end); }
	// 2-2. 목록 - 단일컬럼 검색 (글 한 페이지를 통으로 갖고 옴)
	@Override
	public List<EventDto> search(String column, String keyword, int begin, int end) throws Exception {

		// column값 검사: null이 아니면서, 본 DB의 컬럼이 아닌 문자열이 들어오면 오류 생성해서 팅가냄
		columnVerify(column);

		// SQL 준비
		String sql
			= "SELECT * FROM ("
				+ " SELECT ROWNUM RN, TMP.*"
				+ " FROM ("
					+ "SELECT e.event_idx, e.event_name, e.event_detail"
						+ ", e.event_date, e.event_count_view, e.event_count_reply"
						+ ", u.users_idx, u.users_id, u.users_nick, u.users_grade" // users 테이블에서 일부 정보를 갖고 온다.
					+ " FROM event e"
					+ " LEFT JOIN users u ON e.users_idx = u.users_idx"
					+ (column != null ? (" WHERE INSTR(" + column + ", ?) > 0") : "")
					+ " ORDER BY e.event_idx DESC"
				+ ")TMP"
			+ ") WHERE RN BETWEEN ? AND ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		int count = 0;
		if(column != null) ps.setString(++count, keyword);
		ps.setInt(++count, begin);
		ps.setInt(++count, end);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<EventDto> list = new ArrayList<>();
		EventDto dto = null;
		while(rs.next()) {
			dto = new EventDto();
			dto.setEventIdx(rs.getInt("event_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setEventName(rs.getString("event_name"));
			dto.setEventDetail(rs.getString("event_detail"));
			dto.setEventDate(rs.getDate("event_date"));
			dto.setEventCountView(rs.getInt("event_count_view"));
			dto.setEventCountReply(rs.getInt("event_count_reply"));
			// 아래는 유저 관련 설정이다.
			dto.initUsersDto(rs.getString("users_id"), rs.getString("users_nick"), rs.getString("users_grade"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

}