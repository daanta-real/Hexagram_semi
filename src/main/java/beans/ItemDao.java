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
		String sql = "SELECT * FROM item";
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
			itemDto.setItemAddress(rs.getString(5));
			itemDto.setItemDetail(rs.getString(6));
			itemDto.setItemTags(rs.getString(7));
			itemDto.setItemDate(rs.getDate(8));
			itemDto.setItemPeriods(rs.getString(9));
			itemDto.setItemTime(rs.getString(10));
			itemDto.setItemHomepage(rs.getString(11));
			itemDto.setItemParking(rs.getString(12));
			itemDto.setItemCount(rs.getInt(13));

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
			itemDto.setItemAddress(rs.getString(5));
			itemDto.setItemDetail(rs.getString(6));
			itemDto.setItemTags(rs.getString(7));
			itemDto.setItemDate(rs.getDate(8));
			itemDto.setItemPeriods(rs.getString(9));
			itemDto.setItemTime(rs.getString(10));
			itemDto.setItemHomepage(rs.getString(11));
			itemDto.setItemParking(rs.getString(12));
			itemDto.setItemCount(rs.getInt(13));
		}

		con.close();
		return itemDto;
	}

	//키워드 조회
	public List<ItemDto> searchList(String column, String keyword) throws Exception {

		Connection con = JdbcUtils.connect();
		String sql = "select * from item where instr(#1,?)>0";
		sql = sql.replace("#1", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemAddress(rs.getString(5));
			itemDto.setItemDetail(rs.getString(6));
			itemDto.setItemTags(rs.getString(7));
			itemDto.setItemDate(rs.getDate(8));
			itemDto.setItemPeriods(rs.getString(9));
			itemDto.setItemTime(rs.getString(10));
			itemDto.setItemHomepage(rs.getString(11));
			itemDto.setItemParking(rs.getString(12));
			itemDto.setItemCount(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();

		return list;
	}

	//전체 페이징 조회
	public List<ItemDto> searchPaging(int pages) throws Exception {

		Connection con = JdbcUtils.connect();

		String sql = "select item_idx,users_idx,item_type,item_name,item_address,item_detail,item_tags,item_date,item_periods,item_time,item_homepage,item_parking,item_count from("
				+ "select rownum rn,tmp.* from("
				+ "(select * from item order by item_idx)"
				+ "tmp)) where rn between #2 and #3";

		int start = 1 + (pages - 1) * 10;
		String startPages = String.valueOf(start);
		int end = (pages) * 10;
		String endPages = String.valueOf(end);

		sql = sql.replace("#2", startPages);
		sql = sql.replace("#3", endPages);

		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();

		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemAddress(rs.getString(5));
			itemDto.setItemDetail(rs.getString(6));
			itemDto.setItemTags(rs.getString(7));
			itemDto.setItemDate(rs.getDate(8));
			itemDto.setItemPeriods(rs.getString(9));
			itemDto.setItemTime(rs.getString(10));
			itemDto.setItemHomepage(rs.getString(11));
			itemDto.setItemParking(rs.getString(12));
			itemDto.setItemCount(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();

		return list;
	}

	//키워드 페이징 조회
	public List<ItemDto> searchKeywordPaging(String column, String keyword, int pages) throws Exception {

		Connection con = JdbcUtils.connect();

		String sql = "select item_idx,users_idx,item_type,item_name,item_address,item_detail,item_tags,item_date,item_periods,item_time,item_homepage,item_parking,item_count from("
				+ "select rownum rn,tmp.* from("
				+ "select * from item where instr(#1,?)>0 order by item_idx) tmp)"
				+ "where rn between #2 and #3";

		int start = 1 + (pages - 1) * 10;
		String startPages = String.valueOf(start);
		int end = (pages) * 10;
		String endPages = String.valueOf(end);

		sql = sql.replace("#2", startPages);
		sql = sql.replace("#3", endPages);
		sql = sql.replace("#1", column);

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();

		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt(1));
			itemDto.setUsersIdx(rs.getInt(2));
			itemDto.setItemType(rs.getString(3));
			itemDto.setItemName(rs.getString(4));
			itemDto.setItemAddress(rs.getString(5));
			itemDto.setItemDetail(rs.getString(6));
			itemDto.setItemTags(rs.getString(7));
			itemDto.setItemDate(rs.getDate(8));
			itemDto.setItemPeriods(rs.getString(9));
			itemDto.setItemTime(rs.getString(10));
			itemDto.setItemHomepage(rs.getString(11));
			itemDto.setItemParking(rs.getString(12));
			itemDto.setItemCount(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();

		return list;
	}

	// 관광지 추가(축제인지 관광지인지는 나중에 생각)
	public boolean insert(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_address,item_detail,"
				+ "item_tags,item_periods,item_time,item_homepage,item_parking)"
				+ " VALUES(item_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemDto.getUsersIdx());
		ps.setString(2, itemDto.getItemType());
		ps.setString(3, itemDto.getItemName());
		ps.setString(4, itemDto.getItemAddress());
		ps.setString(5, itemDto.getItemDetail());
		ps.setString(6, itemDto.getItemTags());
		ps.setString(7, itemDto.getItemPeriods());
		ps.setString(8, itemDto.getItemTime());
		ps.setString(9, itemDto.getItemHomepage());
		ps.setString(10, itemDto.getItemParking());

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
		String sql = "UPDATE INTO item set item_type=?,item_name=?,item_address=?,item_detail=?,item_tags=?,item_periods=?,item_time=?,item_homepage=?,item_parking=?)"
				+ " where item_idx=?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, itemDto.getItemType());
		ps.setString(2, itemDto.getItemName());
		ps.setString(3, itemDto.getItemAddress());
		ps.setString(4, itemDto.getItemDetail());
		ps.setString(5, itemDto.getItemTags());
		ps.setString(6, itemDto.getItemPeriods());
		ps.setString(7, itemDto.getItemTime());
		ps.setString(8, itemDto.getItemHomepage());
		ps.setString(9, itemDto.getItemParking());
		ps.setInt(10, itemDto.getItemIdx());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	public void updateCount(ItemDto itemDto) throws Exception {

		Connection con = JdbcUtils.connect();
		String sql = "update item set item_count=? where item_idx = ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemDto.getItemCount());
		ps.setInt(2, itemDto.getItemIdx());

		ps.execute();
		con.close();
	}
}
