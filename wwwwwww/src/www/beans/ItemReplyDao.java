package www.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ItemReplyDao {
	
	public static final String USERNAME = "kh", PASSWORD = "kh";
	
		//[1] 등록 메소드
		public void insert(ItemReplyDto replyitemDto) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "insert into itemreply values(event_seq.nextval, ?, ?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, replyitemDto.getItemReplyTargetIdx());
			ps.setString(2, replyitemDto.getItemReplyDetail());
			ps.execute();
			
			con.close();
		}
		
		//[2] 수정 메소드 -- 헷갈려서 관광지번호 처리 못했습니다
		public boolean update(ItemReplyDto replyitemDto) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "update itemreply set usersIdx=?, itemReplyTargetIdx=?, itemReplyDetail=?, where itemReplyIdx=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, replyitemDto.getUsersIdx());
			ps.setInt(2, replyitemDto.getItemReplyTargetIdx());
			ps.setString(3, replyitemDto.getItemReplyDetail());
			ps.setInt(4, replyitemDto.getItemReplyIdx());
			
			int result = ps.executeUpdate();
			
			con.close();

			return result > 0;
		}	
		
		//[3] 데이터를 삭제하는 메소드		
		public boolean delete(int itemReplyIdx) throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "delete itemreply where itemReplyIdx = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, itemReplyIdx);
			int result = ps.executeUpdate();
			
			con.close();
			
			return result > 0;
		}
		
		//[4] 목록조회 메소드
		public List<ItemReplyDto> select() throws Exception {
			Connection con = JdbcUtils.connect(USERNAME, PASSWORD);
			
			String sql = "select * from itemreply";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
						
			List<ItemReplyDto> list = new ArrayList<>();
			
			while(rs.next()) {
				ItemReplyDto itemReplyDto = new ItemReplyDto();
				itemReplyDto.setItemReplyIdx(rs.getInt("itemReplyIdx"));
				itemReplyDto.setItemIdx(rs.getInt("itemIdx"));
				itemReplyDto.setUsersIdx(rs.getInt("usersIdx"));
				itemReplyDto.setItemReplyTargetIdx(rs.getInt("itemReplyTargetIdx"));
				itemReplyDto.setItemReplyDetail(rs.getString("itemReplyDeatil"));
				
				list.add(itemReplyDto);
			}
			
			con.close();
			
			return list;
		}
		
}