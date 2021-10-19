package www.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDao {
	
	public static final String USERNAME = "kh", PASSWORD = "kh";
	
		//[1] 등록 메소드
		public void insert(EventDto eventDto) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "insert into event values(event_seq.nextval, ?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, eventDto.getEventSubject());
			ps.setString(2, eventDto.getEventDetail());
			ps.setString(3, eventDto.getEventAbles());
			ps.execute();
			
			con.close();
		}
		
		//[2] 수정 메소드
		public boolean update(EventDto eventDto) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "update event set userIdx=?, eventSubject=?, eventDetail=?, eventAbles=? where eventIdx=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, eventDto.getUserIdx());
			ps.setString(2, eventDto.getEventSubject());
			ps.setString(3, eventDto.getEventDetail());
			ps.setString(4, eventDto.getEventAbles());
			ps.setInt(5, eventDto.getEventIdx());
			int result = ps.executeUpdate();
			
			con.close();

			return result > 0;
		}	
		
		
		//[3] 제목, 내용만 수정하는 메소드
		public boolean updateStudent(EventDto eventDto) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "update event set eventSubject ,eventDetail=? where eventIdx=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, eventDto.getEventSubject());
			ps.setString(2, eventDto.getEventDetail());
			ps.setInt(3, eventDto.getEventIdx());
			int result = ps.executeUpdate();
			
			con.close();
			
			return result > 0;
		}
		
		//[4] 데이터를 삭제하는 메소드		
		public boolean delete(int eventIdx) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "delete event where eventIdx = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, eventIdx);
			int result = ps.executeUpdate();
			
			con.close();
			
			return result > 0;
		}
		
		//[5] 목록조회 메소드
		public List<EventDto> select() throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "select * from event";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
						
			List<EventDto> list = new ArrayList<>();
			
			while(rs.next()) {
				EventDto eventDto = new EventDto();
				eventDto.setEventIdx(rs.getInt("eventIdx"));
				eventDto.setUserIdx(rs.getInt("userIdx"));
				eventDto.setEventSubject(rs.getString("eventSubject"));
				eventDto.setEventDetail(rs.getString("eventDetail"));
				eventDto.setEventAbles(rs.getString("eventAbles"));
				
				list.add(eventDto);
			}
			
			con.close();
			
			return list;
		}
		
		//[6] 제목 검색 메소드
		public List<EventDto> selectByEventSubject(String eventSubject) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "select * from event "
							+ "where eventSubject = ? "
							+ "order by examIdx asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, eventSubject);
			ResultSet rs = ps.executeQuery();
			
			List<EventDto> list = new ArrayList<>();
			
			while(rs.next()) {
				EventDto eventDto = new EventDto();
				eventDto.setEventIdx(rs.getInt("eventIdx"));
				eventDto.setUserIdx(rs.getInt("userIdx"));
				eventDto.setEventSubject(rs.getString("eventSubject"));
				eventDto.setEventDetail(rs.getString("eventDetail"));
				eventDto.setEventAbles(rs.getString("eventAbles"));
				
				list.add(eventDto);
			}
			
			con.close();
			
			return list;
		}
		
		//[7] column, keyword를 이용한 검색 메소드

		public List<EventDto> select(String column, String keyword) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "select * from event where instr(#1, ?) > 0 order by #1 asc";

			sql = sql.replace("#1", column);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();
			
			List<EventDto> list = new ArrayList<>();
			
			while(rs.next()) {
				EventDto eventDto = new EventDto();
				eventDto.setEventIdx(rs.getInt("eventIdx"));
				eventDto.setUserIdx(rs.getInt("userIdx"));
				eventDto.setEventSubject(rs.getString("eventSubject"));
				eventDto.setEventDetail(rs.getString("eventDetail"));
				eventDto.setEventAbles(rs.getString("eventAbles"));
				
				list.add(eventDto);
			}
			
			con.close();
			
			return list;
		}
		
		
		//[8] 단일조회 메소드
		public EventDto select(int eventIdx) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "select * from event where eventIdx = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, eventIdx);
			ResultSet rs = ps.executeQuery();
			
			EventDto eventDto;
			
			if(rs.next()) {
				eventDto = new EventDto();				
				eventDto.setEventIdx(rs.getInt("eventIdx"));
				eventDto.setUserIdx(rs.getInt("userIdx"));
				eventDto.setEventSubject(rs.getString("eventSubject"));
				eventDto.setEventDetail(rs.getString("eventDetail"));
				eventDto.setEventAbles(rs.getString("eventAbles"));
			}
			else {
				eventDto = null;
			}
			
			con.close();
			
			return eventDto;
		}
	}


