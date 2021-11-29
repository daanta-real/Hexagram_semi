package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class EventReplyDao {
	public static final String USERNAME = "hexa", PASSWORD="hexa";
	
	//[1] 등록 메소드
	public void insert(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "insert into event_reply values(?, ?, ?, ?, sysdate, null, ?, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventReplyDto.getEventReplyIdx());
		ps.setInt(2, eventReplyDto.getUsersIdx());
		ps.setInt(3, eventReplyDto.getEventIdx());
		ps.setString(4, eventReplyDto.getEventReplyDetail());
		ps.setInt(5, eventReplyDto.getEventReplyIdx());
		ps.execute();
		
		con.close();

	}
	
	
	//[3] 내용 수정 메소드
	public boolean update(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "update event_reply set event_reply_detail = ? where event_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, eventReplyDto.getEventReplyDetail());
		ps.setInt(2, eventReplyDto.getEventReplyIdx());
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
	
	//[4] 댓글 삭제 메소드		
	public boolean delete(int eventReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "delete event_reply where event_reply_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventReplyIdx);
		int result = ps.executeUpdate();
		
		con.close();
		
		return result > 0;
	}
	
	//[5] 댓글 조회 메소드
	public List<EventReplyDto> select() throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "select * from event";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
					
		List<EventReplyDto> list = new ArrayList<>();
		
		while(rs.next()) {
			EventReplyDto eventReplyDto = new EventReplyDto();

			eventReplyDto.setEventReplyIdx(rs.getInt("event_reply_idx"));
			eventReplyDto.setUsersIdx(rs.getInt("users_idx"));
			eventReplyDto.setEventIdx(rs.getInt("event_idx"));
			eventReplyDto.setEventReplyDetail(rs.getString("event_reply_detail"));
			eventReplyDto.setEventReplyDate(rs.getDate("event_reply_date"));
			eventReplyDto.setEventReplySuperno(rs.getInt("event_reply_superno"));
			eventReplyDto.setEventReplyGroupno(rs.getInt("event_reply_groupno"));
			eventReplyDto.setEventReplyDepth(rs.getInt("event_reply_depth"));
			
			
			list.add(eventReplyDto);
		}

		
		con.close();
		
		return list;
	}
			
	//[6] 유저 검색 메소드
	public List<EventReplyDto> selectByUsersIdx(int usersIdx) throws Exception {
		Connection con = JdbcUtils.connect3();
				
		String sql = "select * from event "
						+ "where usersIdx = ? "
						+ "order by examReplyIdx asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, usersIdx);
		ResultSet rs = ps.executeQuery();
				
		List<EventReplyDto> list = new ArrayList<>();
				
		while(rs.next()) {
			EventReplyDto eventReplyDto = new EventReplyDto();

			eventReplyDto.setEventReplyIdx(rs.getInt("event_reply_idx"));
			eventReplyDto.setUsersIdx(rs.getInt("users_idx"));
			eventReplyDto.setEventIdx(rs.getInt("event_idx"));
			eventReplyDto.setEventReplyDetail(rs.getString("event_reply_detail"));
			eventReplyDto.setEventReplyDate(rs.getDate("event_reply_date"));
			eventReplyDto.setEventReplySuperno(rs.getInt("event_reply_superno"));
			eventReplyDto.setEventReplyGroupno(rs.getInt("event_reply_groupno"));
			eventReplyDto.setEventReplyDepth(rs.getInt("event_reply_depth"));
			
					
			list.add(eventReplyDto);
		}
				
		con.close();
				
		return list;
	}
	//[7] 시퀀스 번호 생성.
	public int getSequenceNo() throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "select event_reply_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
	}

	//[8] 대댓글 추가 기능
	public void insertTarget(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "INSERT INTO event_reply"
				+ " VALUES(?,?,?,?,sysdate,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, eventReplyDto.getEventReplyIdx());
		ps.setInt(2, eventReplyDto.getUsersIdx());
		ps.setInt(3, eventReplyDto.getEventIdx());
		ps.setString(4, eventReplyDto.getEventReplyDetail());
		ps.setInt(5, eventReplyDto.getEventReplySuperno());
		ps.setInt(6, eventReplyDto.getEventReplyGroupno());
		ps.setInt(7, eventReplyDto.getEventReplyDepth());

		ps.execute();
		con.close();
	}

	public EventReplyDto get(int eventReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect3();
		String sql = "select * from event_reply where event_reply_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventReplyIdx);
		ResultSet rs = ps.executeQuery();
		
		EventReplyDto eventReplyDto = new EventReplyDto();
		if(rs.next()) {
		eventReplyDto.setEventReplyIdx(rs.getInt("event_reply_idx"));
		eventReplyDto.setUsersIdx(rs.getInt("users_idx"));
		eventReplyDto.setEventIdx(rs.getInt("event_idx"));
		eventReplyDto.setEventReplyDetail(rs.getString("event_reply_detail"));
		eventReplyDto.setEventReplyDate(rs.getDate("event_reply_date"));
		eventReplyDto.setEventReplySuperno(rs.getInt("event_reply_superno"));
		eventReplyDto.setEventReplyGroupno(rs.getInt("event_reply_groupno"));
		eventReplyDto.setEventReplyDepth(rs.getInt("event_reply_depth"));
		}
		con.close();
		return eventReplyDto;
		
	}
	
	// 계층형 댓글 목록
		public List<EventReplyDto> listByTreeSort(int eventIdx) throws Exception {
			Connection con = JdbcUtils.connect3();

			String sql = "select * from event_reply where event_idx = ? connect by prior event_reply_idx = event_reply_superno "
					+ "start with event_reply_superno is null "
					+ "order siblings by event_reply_groupno desc, event_idx asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, eventIdx);
			ResultSet rs = ps.executeQuery();

			List<EventReplyDto> list = new ArrayList<EventReplyDto>();
			while (rs.next()) {
				EventReplyDto eventReplyDto = new EventReplyDto();

				eventReplyDto.setEventReplyIdx(rs.getInt("event_reply_idx"));
				eventReplyDto.setUsersIdx(rs.getInt("users_idx"));
				eventReplyDto.setEventIdx(rs.getInt("event_idx"));
				eventReplyDto.setEventReplyDetail(rs.getString("event_reply_detail"));
				eventReplyDto.setEventReplyDate(rs.getDate("event_reply_date"));
				eventReplyDto.setEventReplySuperno(rs.getInt("event_reply_superno"));
				eventReplyDto.setEventReplyGroupno(rs.getInt("event_reply_groupno"));
				eventReplyDto.setEventReplyDepth(rs.getInt("event_reply_depth"));
				
				
				list.add(eventReplyDto);
			}

			con.close();

			return list;

		}
	
}
