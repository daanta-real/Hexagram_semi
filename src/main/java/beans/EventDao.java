package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class EventDao {

	//[1] 등록 메소드
	public void insert(EventDto eventDto) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "insert into event values(event_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, eventDto.getEventName());
		ps.setString(2, eventDto.getEventDetail());
		ps.setDate(3, (java.sql.Date) eventDto.getEventDate());
		ps.setInt(4, eventDto.getEventCountView());
		ps.setInt(5, eventDto.getEventCountReply());
		ps.execute();

		con.close();
	}

	//[2] 수정 메소드
	public boolean update(EventDto eventDto) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "update event set "
				+ "userIdx=?, "
				+ "eventName=?, "
				+ "eventDetail=?, "
				+ "eventDate=?, "
				+ "eventCountView=?, "
				+ "eventReply=?"
				+ " where eventIdx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventDto.getUsersIdx());
		ps.setString(2, eventDto.getEventName());
		ps.setString(3, eventDto.getEventDetail());
		ps.setDate(4, (java.sql.Date) eventDto.getEventDate());
		ps.setInt(5, eventDto.getEventCountView());
		ps.setInt(6, eventDto.getEventCountReply());
		ps.setInt(7, eventDto.getEventIdx());
		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}


	//[3] 수정 메소드
	public boolean updateStudent(EventDto eventDto) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "update event set eventName ,eventDetail=? where eventIdx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, eventDto.getEventName());
		ps.setString(2, eventDto.getEventDetail());
		ps.setInt(3, eventDto.getEventIdx());
		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	//[4] 삭제 메소드
	public boolean delete(int eventIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "delete event where eventIdx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventIdx);
		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	//[5] 목록조회 메소드
	public List<EventDto> select() throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from event";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<EventDto> list = new ArrayList<>();

		while(rs.next()) {
			EventDto eventDto = new EventDto();
			eventDto.setEventIdx(rs.getInt("eventIdx"));
			eventDto.setUsersIdx(rs.getInt("usersIdx"));
			eventDto.setEventName(rs.getString("eventName"));
			eventDto.setEventDetail(rs.getString("eventDetail"));
			eventDto.setEventDate(rs.getDate("eventDate"));
			eventDto.setEventCountView(rs.getInt("eventCountView"));
			eventDto.setEventCountReply(rs.getInt("eventCountReply"));

			list.add(eventDto);
		}

		con.close();

		return list;
	}

	//[6] 제목 검색 메소드
	public List<EventDto> selectByEventName(String eventName) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from event "
						+ "where eventName = ? "
						+ "order by examIdx asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, eventName);
		ResultSet rs = ps.executeQuery();

		List<EventDto> list = new ArrayList<>();

		while(rs.next()) {
			EventDto eventDto = new EventDto();
			eventDto.setEventIdx(rs.getInt("eventIdx"));
			eventDto.setUsersIdx(rs.getInt("usersIdx"));
			eventDto.setEventName(rs.getString("eventName"));
			eventDto.setEventDetail(rs.getString("eventDetail"));
			eventDto.setEventDate(rs.getDate("eventDate"));
			eventDto.setEventCountView(rs.getInt("eventCountView"));
			eventDto.setEventCountReply(rs.getInt("eventCountReply"));

			list.add(eventDto);
		}

		con.close();

		return list;
	}

	//[7] 유저 검색 메소드
	public List<EventDto> selectByUsersIdx(int usersIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from event "
						+ "where usersIdx = ? "
						+ "order by examIdx asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, usersIdx);
		ResultSet rs = ps.executeQuery();

		List<EventDto> list = new ArrayList<>();

		while(rs.next()) {
			EventDto eventDto = new EventDto();
			eventDto.setEventIdx(rs.getInt("eventIdx"));
			eventDto.setUsersIdx(rs.getInt("usersIdx"));
			eventDto.setEventName(rs.getString("eventName"));
			eventDto.setEventDetail(rs.getString("eventDetail"));
			eventDto.setEventDate(rs.getDate("eventDate"));
			eventDto.setEventCountView(rs.getInt("eventCountView"));
			eventDto.setEventCountReply(rs.getInt("eventCountReply"));

			list.add(eventDto);
		}

		con.close();

		return list;
	}

	//[8] column, keyword를 이용한 검색 메소드

	public List<EventDto> select(String column, String keyword) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from event where instr(#1, ?) > 0 order by #1 asc";

		sql = sql.replace("#1", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<EventDto> list = new ArrayList<>();

		while(rs.next()) {
			EventDto eventDto = new EventDto();
			eventDto.setEventIdx(rs.getInt("eventIdx"));
			eventDto.setUsersIdx(rs.getInt("usersIdx"));
			eventDto.setEventName(rs.getString("eventName"));
			eventDto.setEventDetail(rs.getString("eventDetail"));
			eventDto.setEventDate(rs.getDate("eventDate"));

			list.add(eventDto);
		}

		con.close();

		return list;
	}


	//[9] 단일조회 메소드
	public EventDto select(int eventIdx) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select * from event where eventIdx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventIdx);
		ResultSet rs = ps.executeQuery();

		EventDto eventDto;

		if(rs.next()) {
			eventDto = new EventDto();
			eventDto.setEventIdx(rs.getInt("eventIdx"));
			eventDto.setUsersIdx(rs.getInt("usersIdx"));
			eventDto.setEventName(rs.getString("eventName"));
			eventDto.setEventDetail(rs.getString("eventDetail"));
			eventDto.setEventDate(rs.getDate("eventDate"));
		}
		else {
			eventDto = null;
		}

		con.close();

		return eventDto;
	}

}