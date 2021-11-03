package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class EventReplyDao {
	public static final String USERNAME = "hexa", PASSWORD="hexa";
	
	//[1] 등록 메소드
	public void insert(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "insert into event values(event_seq.nextval, ?, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventReplyDto.getEventReplyTargetIdx());
		ps.setString(2, eventReplyDto.getEventReplyDetail());
		ps.setDate(3, eventReplyDto.getEventReplyDate());
		ps.setInt(4, eventReplyDto.getEventReplySuperno());
		ps.setInt(5, eventReplyDto.getEventReplyGroupno());
		ps.setInt(6, eventReplyDto.getEventReplyDepth());
		ps.execute();
		
		con.close();
	}
	
	//[2] 수정 메소드
	public boolean update(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "update event set userIdx=?, "
				+ "eventReplyDetail=?, "
				+ "eventReplyDate=?, "
				+ "eventReplySuperno=?, "
				+ "eventReplyGroupno=?, "
				+ "eventReplyDepth=? where eventReplyIdx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventReplyDto.getUsersIdx());
		ps.setString(2, eventReplyDto.getEventReplyDetail());
		ps.setDate(3, eventReplyDto.getEventReplyDate());
		ps.setInt(4, eventReplyDto.getEventReplySuperno());
		ps.setInt(5, eventReplyDto.getEventReplyGroupno());
		ps.setInt(6, eventReplyDto.getEventReplyDepth());
		ps.setInt(7, eventReplyDto.getEventReplyIdx());			
		int result = ps.executeUpdate();
		
		con.close();

		return result > 0;
	}	
	
	
	//[3] 내용 수정 메소드
	public boolean updateStudent(EventReplyDto eventReplyDto) throws Exception {
		Connection con = JdbcUtils.connect3();
		
		String sql = "update event set eventReplyDetail=? where eventReplyIdx=?";
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
		
		String sql = "delete event where eventReplyIdx = ?";
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
			eventReplyDto.setEventReplyIdx(rs.getInt("eventReplyIdx"));
			eventReplyDto.setUsersIdx(rs.getInt("usersIdx"));
			eventReplyDto.setEventReplyDetail(rs.getString("eventReplyDetail"));
			eventReplyDto.setEventReplyDate(rs.getDate("eventReplyDate"));
			eventReplyDto.setEventReplySuperno(rs.getInt("eventReplyno"));
			eventReplyDto.setEventReplyGroupno(rs.getInt("eventGroupno"));
			eventReplyDto.setEventReplyDepth(rs.getInt("eventReplyDepth"));
			
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
			eventReplyDto.setEventReplyIdx(rs.getInt("eventReplyIdx"));
			eventReplyDto.setUsersIdx(rs.getInt("usersIdx"));
			eventReplyDto.setEventReplyDetail(rs.getString("eventReplyDetail"));
			eventReplyDto.setEventReplyDate(rs.getDate("eventReplyDate"));
			eventReplyDto.setEventReplySuperno(rs.getInt("eventReplySuperno"));
			eventReplyDto.setEventReplyGroupno(rs.getInt("eventReplyGroupno"));
			eventReplyDto.setEventReplyDepth(rs.getInt("eventReplyDepth"));
					
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
		String sql = "INSERT INTO event_reply (event_reply_idx,users_idx,event_idx,event_reply_target_idx,event_reply_detail,event_reply_date,event_reply_superno,event_reply_groupno,event_reply_depth)"
				+ " VALUES(?,?,?,?,sysdate,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, eventReplyDto.getEventReplyIdx());
		ps.setInt(2, eventReplyDto.getUsersIdx());
		ps.setInt(3, eventReplyDto.getEventIdx());
		ps.setString(4, eventReplyDto.getEventReplyDetail());
		ps.setInt(5, eventReplyDto.getEventReplySuperno());
		ps.setInt(6, eventReplyDto.getEventReplyIdx());
		ps.setInt(7, eventReplyDto.getEventReplyDepth());

		ps.execute();
		con.close();
	}
}
