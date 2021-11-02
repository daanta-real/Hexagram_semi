package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class ItemDao {

	// 전체 조회
	public List<ItemDto> list() throws Exception {
		String sql = "SELECT * FROM item order by item_idx desc";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemDetail(rs.getString(5));
			itemDto.setItemPeriod(rs.getString(6));
			itemDto.setItemTime(rs.getString(7));
			itemDto.setItemHomepage(rs.getString(8));
			itemDto.setItemParking(rs.getString(9));
			itemDto.setItemAddress(rs.getString(10));
			itemDto.setItemDate(rs.getDate(11));
			itemDto.setItemCountView(rs.getInt(12));
			itemDto.setItemCountReply(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();
		return list;
	}

	// 단일 조회
	public ItemDto get(int itemIdx) throws Exception {
		String sql = "SELECT * FROM item WHERE item_idx = ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ResultSet rs = ps.executeQuery();

		ItemDto itemDto = new ItemDto();
		if (rs.next()) {
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemDetail(rs.getString(5));
			itemDto.setItemPeriod(rs.getString(6));
			itemDto.setItemTime(rs.getString(7));
			itemDto.setItemHomepage(rs.getString(8));
			itemDto.setItemParking(rs.getString(9));
			itemDto.setItemAddress(rs.getString(10));
			itemDto.setItemDate(rs.getDate(11));
			itemDto.setItemCountView(rs.getInt(12));
			itemDto.setItemCountReply(rs.getInt(13));
		}

		con.close();
		return itemDto;
	}

	// 키워드 조회 및 페이징 조회
	public List<ItemDto> searchList(String column, String keyword, int begin, int end) throws Exception {

		Connection con = JdbcUtils.connect();
		String sql = "select * from (" + "select rownum rn,TMP.*from("
				+ "select * from item where instr(#1, ?) > 0 order by item_idx desc" + ")TMP"
				+ ")where rn between ? and ?";
		sql = sql.replace("#1", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemDetail(rs.getString(5));
			itemDto.setItemPeriod(rs.getString(6));
			itemDto.setItemTime(rs.getString(7));
			itemDto.setItemHomepage(rs.getString(8));
			itemDto.setItemParking(rs.getString(9));
			itemDto.setItemAddress(rs.getString(10));
			itemDto.setItemDate(rs.getDate(11));
			itemDto.setItemCountView(rs.getInt(12));
			itemDto.setItemCountReply(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();

		return list;
	}

	// 페이징 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능(목록 / 검색)
	public int count() throws Exception {
		Connection con = JdbcUtils.connect();

		String sql = "select count(*) from item";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();

		int count = rs.getInt(1);

		con.close();

		return count;
	}

	// 관광지 추가(축제인지 관광지인지는 나중에 생각)
	public boolean insert(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_detail,item_period,"
				+ "item_time,item_homepage,item_parking,item_address,item_date,item_count_view,item_count_reply)"
				+ " VALUES(item_idx_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate,0,0)";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemDto.getUsersIdx());
		ps.setString(2, itemDto.getItemType());
		ps.setString(3, itemDto.getItemName());
		ps.setString(4, itemDto.getItemDetail());
		ps.setString(5, itemDto.getItemPeriod());
		ps.setString(6, itemDto.getItemTime());
		ps.setString(7, itemDto.getItemHomepage());
		ps.setString(8, itemDto.getItemParking());
		ps.setString(9, itemDto.getItemAddress());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	public boolean insertWithSequence(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_detail,item_period,"
				+ "item_time,item_homepage,item_parking,item_address,item_date,item_count_view,item_count_reply)"
				+ " VALUES(?,?,?,?,?,?,?,?,?,?,sysdate,0,0)";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemDto.getItemIdx());
		ps.setInt(2, itemDto.getUsersIdx());
		ps.setString(3, itemDto.getItemType());
		ps.setString(4, itemDto.getItemName());
		ps.setString(5, itemDto.getItemDetail());
		ps.setString(6, itemDto.getItemPeriod());
		ps.setString(7, itemDto.getItemTime());
		ps.setString(8, itemDto.getItemHomepage());
		ps.setString(9, itemDto.getItemParking());
		ps.setString(10, itemDto.getItemAddress());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	// 관광지 삭제
	public boolean delete(int itemIdx) throws Exception {
		String sql = "DELETE FROM item WHERE item_idx = ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	// 관광지 수정
	public boolean update(ItemDto itemDto) throws Exception {
		String sql = "UPDATE item set users_idx=?,item_type=?,item_name=?,item_detail=?,item_period=?,item_time=?,item_homepage=?,item_parking=?,item_address=?"
				+ " where item_idx=?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemDto.getUsersIdx());
		ps.setString(2, itemDto.getItemType());
		ps.setString(3, itemDto.getItemName());
		ps.setString(4, itemDto.getItemDetail());
		ps.setString(5, itemDto.getItemPeriod());
		ps.setString(6, itemDto.getItemTime());
		ps.setString(7, itemDto.getItemHomepage());
		ps.setString(8, itemDto.getItemParking());
		ps.setString(9, itemDto.getItemAddress());
		ps.setInt(10, itemDto.getItemIdx());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	public boolean readUp(int itemIdx, int usersIdx) throws Exception {
		String sql = "UPDATE item set item_count_view=item_count_view+1" + " where item_idx=? and users_idx != ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemIdx);
		ps.setInt(2, usersIdx);

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	public int getSequence() throws Exception {
		String sql = "select item_seq.nextval from dual";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
	}

}
