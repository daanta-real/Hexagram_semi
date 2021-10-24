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
			itemDto.setItem_idx(rs.getInt(1));
			itemDto.setUsers_idx(rs.getInt(2));
			itemDto.setItem_type(rs.getString(3));
			itemDto.setItem_name(rs.getString(4));
			itemDto.setItem_address(rs.getString(5));
			itemDto.setItem_detail(rs.getString(6));
			itemDto.setItem_tags(rs.getString(7));
			itemDto.setItem_date(rs.getDate(8));
			itemDto.setItem_periods(rs.getString(9));
			itemDto.setItem_time(rs.getString(10));
			itemDto.setItem_homepage(rs.getString(11));
			itemDto.setItem_parking(rs.getString(12));
			itemDto.setItem_count(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();
		return list;
	}

	// 단일 조회
	public ItemDto get(int item_idx) throws Exception {
		String sql = "SELECT * FROM item WHERE item_idx = ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, item_idx);
		ResultSet rs = ps.executeQuery();

		ItemDto itemDto = new ItemDto();
		if (rs.next()) {
			itemDto.setItem_idx(rs.getInt(1));
			itemDto.setUsers_idx(rs.getInt(2));
			itemDto.setItem_type(rs.getString(3));
			itemDto.setItem_name(rs.getString(4));
			itemDto.setItem_address(rs.getString(5));
			itemDto.setItem_detail(rs.getString(6));
			itemDto.setItem_tags(rs.getString(7));
			itemDto.setItem_date(rs.getDate(8));
			itemDto.setItem_periods(rs.getString(9));
			itemDto.setItem_time(rs.getString(10));
			itemDto.setItem_homepage(rs.getString(11));
			itemDto.setItem_parking(rs.getString(12));
			itemDto.setItem_count(rs.getInt(13));
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
			itemDto.setItem_idx(rs.getInt(1));
			itemDto.setUsers_idx(rs.getInt(2));
			itemDto.setItem_type(rs.getString(3));
			itemDto.setItem_name(rs.getString(4));
			itemDto.setItem_address(rs.getString(5));
			itemDto.setItem_detail(rs.getString(6));
			itemDto.setItem_tags(rs.getString(7));
			itemDto.setItem_date(rs.getDate(8));
			itemDto.setItem_periods(rs.getString(9));
			itemDto.setItem_time(rs.getString(10));
			itemDto.setItem_homepage(rs.getString(11));
			itemDto.setItem_parking(rs.getString(12));
			itemDto.setItem_count(rs.getInt(13));

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
			itemDto.setItem_idx(rs.getInt(1));
			itemDto.setUsers_idx(rs.getInt(2));
			itemDto.setItem_type(rs.getString(3));
			itemDto.setItem_name(rs.getString(4));
			itemDto.setItem_address(rs.getString(5));
			itemDto.setItem_detail(rs.getString(6));
			itemDto.setItem_tags(rs.getString(7));
			itemDto.setItem_date(rs.getDate(8));
			itemDto.setItem_periods(rs.getString(9));
			itemDto.setItem_time(rs.getString(10));
			itemDto.setItem_homepage(rs.getString(11));
			itemDto.setItem_parking(rs.getString(12));
			itemDto.setItem_count(rs.getInt(13));

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
			itemDto.setItem_idx(rs.getInt(1));
			itemDto.setUsers_idx(rs.getInt(2));
			itemDto.setItem_type(rs.getString(3));
			itemDto.setItem_name(rs.getString(4));
			itemDto.setItem_address(rs.getString(5));
			itemDto.setItem_detail(rs.getString(6));
			itemDto.setItem_tags(rs.getString(7));
			itemDto.setItem_date(rs.getDate(8));
			itemDto.setItem_periods(rs.getString(9));
			itemDto.setItem_time(rs.getString(10));
			itemDto.setItem_homepage(rs.getString(11));
			itemDto.setItem_parking(rs.getString(12));
			itemDto.setItem_count(rs.getInt(13));

			list.add(itemDto);
		}

		con.close();

		return list;
	}

	// 관광지 추가(축제인지 관광지인지는 나중에 생각)
	public boolean insert(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_address,item_detail,item_tags,item_periods,item_time,item_homepage,item_parking)"
				+ " VALUES(item_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemDto.getItem_idx());
		ps.setInt(2, itemDto.getUsers_idx());
		ps.setString(3, itemDto.getItem_type());
		ps.setString(4, itemDto.getItem_name());
		ps.setString(5, itemDto.getItem_address());
		ps.setString(6, itemDto.getItem_detail());
		ps.setString(7, itemDto.getItem_tags());
		ps.setString(8, itemDto.getItem_periods());
		ps.setString(9, itemDto.getItem_time());
		ps.setString(10, itemDto.getItem_homepage());
		ps.setString(11, itemDto.getItem_parking());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	// 관광지 삭제
	public boolean delete(int item_idx) throws Exception {
		String sql = "DELETE FROM item WHERE item_idx = ?";
		Connection con = JdbcUtils.connect();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, item_idx);

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
		ps.setString(1, itemDto.getItem_type());
		ps.setString(2, itemDto.getItem_name());
		ps.setString(3, itemDto.getItem_address());
		ps.setString(4, itemDto.getItem_detail());
		ps.setString(5, itemDto.getItem_tags());
		ps.setString(6, itemDto.getItem_periods());
		ps.setString(7, itemDto.getItem_time());
		ps.setString(8, itemDto.getItem_homepage());
		ps.setString(9, itemDto.getItem_parking());
		ps.setInt(10, itemDto.getItem_idx());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	public void updateCount(ItemDto itemDto) throws Exception {

		Connection con = JdbcUtils.connect();
		String sql = "update item set item_count=? where item_idx = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemDto.getItem_count());
		ps.setInt(2, itemDto.getItem_idx());

		ps.execute();
		con.close();
	}
}
