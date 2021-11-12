package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventFileDao {

	//���� ���� ���� ���
	public void insert(EventFileDto eventFileDto) throws Exception {
		Connection con = JdbcUtils.connect2();
		
		String sql = "insert into event_file values(event_file_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventFileDto.getEventNo());
		ps.setString(2, eventFileDto.getEventFileUploadname());
		ps.setString(3, eventFileDto.getEventFileSavename());
		ps.setLong(4, eventFileDto.getEventFileSize());
		ps.setString(5, eventFileDto.getEventFileType());
		ps.execute();
		
		con.close();
	}

	//������ȸ
	public EventFileDto get(int eventFileNo) throws Exception{
		Connection con = JdbcUtils.connect2();
		
		String sql = "select * from event_file where event_file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventFileNo);
		ResultSet rs = ps.executeQuery();
		
		EventFileDto eventFileDto;
		if(rs.next()) {
			eventFileDto = new EventFileDto();
			
			//copy
			eventFileDto.setEventFileNo(rs.getInt("event_file_no"));
			eventFileDto.setEventNo(rs.getInt("event_no"));
			eventFileDto.setEventFileSavename(rs.getString("event_file_savename"));
			eventFileDto.setEventFileUploadname(rs.getString("event_file_uploadname"));
			eventFileDto.setEventFileType(rs.getString("event_file_type"));
			eventFileDto.setEventFileSize(rs.getLong("event_file_size"));
		}
		else {
			eventFileDto = null;
		}
		
		con.close();
		
		return eventFileDto;
	}
	
	//�Խñۿ� �ش��ϴ� ���ϸ�� ��ȸ
	public List<EventFileDto> find(int eventNo) throws Exception {
		Connection con = JdbcUtils.connect2();
		
		String sql = "select * from event_file where event_no = ? order by event_file_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, eventNo);
		ResultSet rs = ps.executeQuery();
		
		List<EventFileDto> list = new ArrayList<>();
		while(rs.next()) {
			EventFileDto eventFileDto = new EventFileDto();
			
			//copy
			eventFileDto.setEventFileNo(rs.getInt("event_file_no"));
			eventFileDto.setEventNo(rs.getInt("event_no"));
			eventFileDto.setEventFileSavename(rs.getString("event_file_savename"));
			eventFileDto.setEventFileUploadname(rs.getString("event_file_uploadname"));
			eventFileDto.setEventFileType(rs.getString("event_file_type"));
			eventFileDto.setEventFileSize(rs.getLong("event_file_size"));
			
			list.add(eventFileDto);
		}
		
		con.close();
		
		return list;
	}

}
