package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class ItemReplyDao {
	
	//댓글 추가 기능
	public void insert(ItemReplyDto itemReplyDto) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "INSERT INTO item_reply (item_reply_idx,item_idx,users_idx,item_reply_detail)"
				+ " VALUES(item_reply_seq.nextval,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, itemReplyDto.getItem_idx());
		ps.setInt(2, itemReplyDto.getUsers_idx());
		ps.setString(3, itemReplyDto.getItem_reply_detail());
		
		ps.execute();
		con.close();
	}
	
	//대댓글 추가 기능
	public void insertTarget(ItemReplyDto itemReplyDto) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "INSERT INTO item_reply (item_reply_idx,item_idx,users_idx,item_reply_detail,item_reply_target_idx)"
				+ " VALUES(item_reply_seq.nextval,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, itemReplyDto.getItem_idx());
		ps.setInt(2, itemReplyDto.getUsers_idx());
		ps.setString(3, itemReplyDto.getItem_reply_detail());
		ps.setInt(4, itemReplyDto.getItem_reply_target_idx());
		
		ps.execute();
		con.close();
	}
	
	//댓글 조회
	public List<ItemReplyDto> list(int item_idx) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "select IR.* from item_reply IR"
				+ " join item I on IR.item_idx = I.item_idx where IR.item_idx=? and IR.item_reply_target_idx=0";
		//조회시에 item_reply_target_idx는 없어야한다(대댓글이 아닌 댓글임)
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, item_idx);
		ResultSet rs = ps.executeQuery();
		
		List<ItemReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			ItemReplyDto itemReplyDto = new ItemReplyDto();
			itemReplyDto.setItem_reply_idx(rs.getInt(1));
			itemReplyDto.setItem_idx(rs.getInt(2));
			itemReplyDto.setUsers_idx(rs.getInt(3));
			itemReplyDto.setItem_reply_detail(rs.getString(4));
			itemReplyDto.setItem_reply_time(rs.getDate(5));
			itemReplyDto.setItem_reply_target_idx(rs.getInt(6));
			
			list.add(itemReplyDto);
		}
		
		con.close();
		return list;
	}
	
	//대 댓글 조회
	public List<ItemReplyDto> listTarget(int item_reply_idx) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "select child.item_reply_idx,child.item_idx,child.users_idx,child.item_reply_detail,child.item_reply_time from item_reply parent"
				+ " join item_reply child on parent.item_reply_idx = child.item_reply_target_idx"
				+ " where child.item_reply_target_idx=?";//자식의 타겟 번호가 부모의 댓글 idx 번호인 경우
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, item_reply_idx);
		ResultSet rs = ps.executeQuery();
		
		List<ItemReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			ItemReplyDto itemReplyDto = new ItemReplyDto();
			itemReplyDto.setItem_reply_idx(rs.getInt(1));
			itemReplyDto.setItem_idx(rs.getInt(2));
			itemReplyDto.setUsers_idx(rs.getInt(3));
			itemReplyDto.setItem_reply_detail(rs.getString(4));
			itemReplyDto.setItem_reply_time(rs.getDate(5));
			itemReplyDto.setItem_reply_target_idx(rs.getInt(6));
			
			list.add(itemReplyDto);
		}
		
		con.close();
		return list;
	}
}


