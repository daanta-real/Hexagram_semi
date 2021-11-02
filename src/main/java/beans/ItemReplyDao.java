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
		String sql = "INSERT INTO item_reply (item_reply_idx,users_idx,item_idx,item_reply_detail,item_reply_date,item_reply_superno,item_reply_groupno,item_reply_depth)"
				+ " VALUES(?,?,?,?,sysdate,null,?,0)";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, itemReplyDto.getItemReplyIdx());
		ps.setInt(2, itemReplyDto.getUsersIdx());
		ps.setInt(3, itemReplyDto.getItemIdx());
		ps.setString(4, itemReplyDto.getItemReplyDetail());
		ps.setInt(5, itemReplyDto.getItemReplyIdx());

		ps.execute();
		con.close();
	}
	
	//시퀀스 번호 생성.
	public int getSequenceNo() throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "select item_reply_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
	}

	//대댓글 추가 기능
	public void insertTarget(ItemReplyDto itemReplyDto) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "INSERT INTO item_reply (item_reply_idx,users_idx,item_idx,item_reply_detail,item_reply_date,item_reply_superno,item_reply_groupno,item_reply_depth)"
				+ " VALUES(?,?,?,?,sysdate,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemReplyDto.getItemReplyIdx());
		ps.setInt(2, itemReplyDto.getUsersIdx());
		ps.setInt(3, itemReplyDto.getItemIdx());
		ps.setString(4, itemReplyDto.getItemReplyDetail());
		ps.setInt(5, itemReplyDto.getItemReplySuperno());
		ps.setInt(6, itemReplyDto.getItemReplyIdx());
		ps.setInt(7, itemReplyDto.getItemReplyDepth());
		
		ps.execute();
		con.close();
	}

	//댓글 조회
	public List<ItemReplyDto> list(int itemIdx) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "select * from item_reply where item_idx=? "
				+ "connect by prior item_reply_no = item_reply_superno "
				+ "start with item_reply_superno is null "
				+ "order by siblings by item_reply_groupno desc, item_reply_no asc";
		//조회시에 item_reply_target_idx는 없어야한다(대댓글이 아닌 댓글임)
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ResultSet rs = ps.executeQuery();

		List<ItemReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			ItemReplyDto itemReplyDto = new ItemReplyDto();
			
			itemReplyDto.setItemReplyIdx(rs.getInt(1));
			itemReplyDto.setUsersIdx(rs.getInt(2));
			itemReplyDto.setItemIdx(rs.getInt(3));
			itemReplyDto.setItemReplyDetail(rs.getString(4));
			itemReplyDto.setItemReplyDate(rs.getDate(5));
			itemReplyDto.setItemReplySuperno(rs.getInt(6));
			itemReplyDto.setItemReplyGroupno(rs.getInt(7));
			itemReplyDto.setItemReplyDepth(rs.getInt(8));
			
			list.add(itemReplyDto);
		}

		con.close();
		return list;
	}

	
	public boolean update(int itemReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "update item_reply set item_reply_detail where item_reply_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemReplyIdx);
		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}

	public boolean delete(int itemReplyIdx) throws Exception {
		Connection con = JdbcUtils.connect();
		String sql = "delete item_reply where item_reply_idx=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemReplyIdx);
		int result = ps.executeUpdate();

		con.close();
		return result>0;
	}
	
	
	
	
}


