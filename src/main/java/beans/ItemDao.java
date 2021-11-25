package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class ItemDao implements PaginationInterface<ItemDto> {


	// 전체 조회 (list.jsp 목록) - 페이지네이션 전
		public List<ItemDto> list() throws Exception {
			String sql = "SELECT * FROM item order by item_idx desc";
			Connection con = JdbcUtils.connect3();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			List<ItemDto> list = new ArrayList<>();
			while (rs.next()) {
				ItemDto itemDto = new ItemDto();
				itemDto.setItemIdx(rs.getInt("item_idx"));
				itemDto.setUsersIdx(rs.getInt("users_idx"));
				itemDto.setItemType(rs.getString("item_type"));
				itemDto.setItemName(rs.getString("item_name"));
				itemDto.setItemDetail(rs.getString("item_detail"));
				itemDto.setItemPeriod(rs.getString("item_period"));
				itemDto.setItemTime(rs.getString("item_time"));
				itemDto.setItemHomepage(rs.getString("item_homepage"));
				itemDto.setItemParking(rs.getString("item_parking"));
				itemDto.setItemAddress(rs.getString("item_address"));
				itemDto.setItemDate(rs.getDate("item_date"));
				itemDto.setItemCountView(rs.getInt("item_count_view"));
				itemDto.setItemCountReply(rs.getInt("item_count_reply"));


				list.add(itemDto);
			}

			con.close();
			return list;
		}

	// 전체 조회 - 페이지 네이션
	@Override
	public List<ItemDto> list(int begin, int end) throws Exception {
		String sql = "select * from ("
						+ "select rownum rn,TMP.*from("
							+ "SELECT * FROM item order by item_idx desc"
						+ ")TMP"
					+ ")where rn between ? and ?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();

		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));

			list.add(itemDto);
		}

		con.close();
		return list;
	}

	// 단일 조회
	public ItemDto get(int itemIdx) throws Exception {
		String sql = "SELECT * FROM item WHERE item_idx = ?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ResultSet rs = ps.executeQuery();

		ItemDto itemDto = new ItemDto();
		if (rs.next()) {
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));

		}

		con.close();
		return itemDto;
	}

	// 키워드 조회 - 검색용 (페이지네이션 전)
	public List<ItemDto> searchList(String column, String keyword) throws Exception {

		Connection con = JdbcUtils.connect3();
		String sql = "select * from item where instr(#1, ?) > 0 order by item_idx desc";
		sql = sql.replace("#1", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));


			list.add(itemDto);
		}

		con.close();

		return list;
	}

	@Override
	// 키워드 조회 (페이지네이션)
	public List<ItemDto> search(String column, String keyword, int begin, int end) throws Exception {

		Connection con = JdbcUtils.connect3();
		String sql = "select * from ("
						+ "select rownum rn,TMP.*from("
							+ "select * from item where instr(#1, ?) > 0 order by item_idx desc"
						+ ")TMP"
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
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));


			list.add(itemDto);
		}

		con.close();

		return list;
	}
	
	// 인기 여행지,관광지를 불러오기 위한 메소드 추가
	public List<ItemDto> searchByOrder(String order,String column, String keyword, int begin, int end) throws Exception {

		Connection con = JdbcUtils.connect3();
		String sql = "select * from ("
						+ "select rownum rn,TMP.*from("
							+ "select * from item where instr(#1, ?) > 0 order by #2 desc"
						+ ")TMP"
					+ ")where rn between ? and ?";
		sql = sql.replace("#1", column);
		sql = sql.replace("#2", order);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, begin);
		ps.setInt(3, end);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));


			list.add(itemDto);
		}

		con.close();

		return list;
	}

	@Override
	// 페이징 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능(목록)
	public Integer count() throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select count(*) from item";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();

		int count = rs.getInt(1);

		con.close();

		return count;
	}

	@Override
	// 페이징 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능(검색)
	public Integer count(String column, String keyword) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select count(*) from item where instr(#1, ?) > 0";
		sql = sql.replace("#1", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		rs.next();

		int count = rs.getInt(1);

		con.close();

		return count;
	}
	
	// 페이징 마지막 블록을 구하기 위하여 게시글 개수를 구하는 기능(검색 중 세부 도시 나왔을 경우 list_city.jsp에서 사용)
	public Integer count(String column, String keyword, String subCity) throws Exception {
		Connection con = JdbcUtils.connect3();

		String sql = "select count(*) from("
				+ "select * from item where instr(#1, ?) > 0"
				+ ")where instr(#2, ?) > 0";
		sql = sql.replace("#1", column);
		sql = sql.replace("#2", column);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setString(2, subCity);
		ResultSet rs = ps.executeQuery();

		rs.next();

		int count = rs.getInt(1);

		con.close();

		return count;
	}

	// 관광지 추가
	public boolean insert(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_detail,item_period,"
				+ "item_time,item_homepage,item_parking,item_address,item_date,item_count_view,item_count_reply)"
				+ " VALUES(item_seq.nextval,?,?,?,?,?,?,?,?,?,sysdate,0,0)";
		Connection con = JdbcUtils.connect3();
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

	// 등록후 detail페이지로 가기위해 시퀀스값 등록을 위한 등록 메소드
	public boolean insertWithSequence(ItemDto itemDto) throws Exception {
		String sql = "INSERT INTO item (item_idx,users_idx,item_type,item_name,item_detail,item_period,"
				+ "item_time,item_homepage,item_parking,item_address,item_date,item_count_view,item_count_reply)"
				+ " VALUES(?,?,?,?,?,?,?,?,?,?,sysdate,0,0)";
		Connection con = JdbcUtils.connect3();
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
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}

	// 관광지 수정
	public boolean update(ItemDto itemDto) throws Exception {
		String sql = "UPDATE item set item_type=?,item_name=?,item_detail=?,item_period=?,item_time=?,item_homepage=?,item_parking=?,item_address=?"
				+ " where item_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, itemDto.getItemType());
		ps.setString(2, itemDto.getItemName());
		ps.setString(3, itemDto.getItemDetail());
		ps.setString(4, itemDto.getItemPeriod());
		ps.setString(5, itemDto.getItemTime());
		ps.setString(6, itemDto.getItemHomepage());
		ps.setString(7, itemDto.getItemParking());
		ps.setString(8, itemDto.getItemAddress());
		ps.setInt(9, itemDto.getItemIdx());

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}
	
	//조회수 증가(게시글 작성자 이외의 상황일때 (회원전용)) ItemReadupServlet참조
	public boolean readUp(int itemIdx, int usersIdx) throws Exception {
		String sql = "UPDATE item set item_count_view=item_count_view+1" + " where item_idx=? and users_idx != ?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setInt(1, itemIdx);
		ps.setInt(2, usersIdx);

		int result = ps.executeUpdate();

		con.close();
		return result > 0;
	}
	
	//조회수 증가(비회원용) ItemReadupServlet참조
	public boolean readUp(int itemIdx) throws Exception {
		String sql = "UPDATE item set item_count_view=item_count_view+1" + " where item_idx=?";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, itemIdx);
		
		int result = ps.executeUpdate();
		
		con.close();
		return result > 0;
	}

	//시퀀스 미리 부여받는 메소드
	public int getSequence() throws Exception {
		String sql = "select item_seq.nextval from dual";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		rs.next();
		int result = rs.getInt(1);

		con.close();
		return result;
	}
	
	//목록에서 댓글수 보여주기위한 댓글 갱신 메소드
	public boolean countReply(int itemIdx) throws Exception{
		Connection con = JdbcUtils.connect3();

		String sql = "update item set item_count_reply="
					+ "(select count(*) from item_reply where item_idx = ?) "
					+ "where item_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ps.setInt(2, itemIdx);

		int result = ps.executeUpdate();

		con.close();

		return result > 0;
	}

	// 현재 사용하지 않음.
	public List<ItemDto> getCityList(String city) throws Exception {
		String sql = "select * from item where instr(item_address,?)>=1";
		Connection con = JdbcUtils.connect3();
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, city);
		ResultSet rs = ps.executeQuery();

		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));


			list.add(itemDto);
		}

		con.close();
		return list;
	}

	//정렬 조회 메소드(페이지네이션) : 비검색
	public List<ItemDto> orderByList(String order,int begin, int end) throws Exception {

		Connection con = JdbcUtils.connect3();
		String sql = "select * from ("
						+ "select rownum rn,TMP.*from("
							+ "select * from item order by #1 desc"
						+ ")TMP"
					+ ")where rn between ? and ?";
		sql = sql.replace("#1", order);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while (rs.next()) {
			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(rs.getInt("item_idx"));
			itemDto.setUsersIdx(rs.getInt("users_idx"));
			itemDto.setItemType(rs.getString("item_type"));
			itemDto.setItemName(rs.getString("item_name"));
			itemDto.setItemDetail(rs.getString("item_detail"));
			itemDto.setItemPeriod(rs.getString("item_period"));
			itemDto.setItemTime(rs.getString("item_time"));
			itemDto.setItemHomepage(rs.getString("item_homepage"));
			itemDto.setItemParking(rs.getString("item_parking"));
			itemDto.setItemAddress(rs.getString("item_address"));
			itemDto.setItemDate(rs.getDate("item_date"));
			itemDto.setItemCountView(rs.getInt("item_count_view"));
			itemDto.setItemCountReply(rs.getInt("item_count_reply"));


			list.add(itemDto);
		}

		con.close();

		return list;
	}
	
		//정렬 조회 메소드(페이지네이션) : 검색
		public List<ItemDto> orderByKeywordList(String order,String column, String keyword, int begin, int end) throws Exception {

			Connection con = JdbcUtils.connect3();
			String sql = "select * from ("
					+ "select rownum rn,TMP.*from("
						+ "select * from item where instr(#1, ?) > 0 order by #2 desc"
					+ ")TMP"
				+ ")where rn between ? and ?";
			sql = sql.replace("#1", column);
			sql = sql.replace("#2", order);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setInt(2, begin);
			ps.setInt(3, end);
			
			ResultSet rs = ps.executeQuery();
			List<ItemDto> list = new ArrayList<>();
			while (rs.next()) {
				ItemDto itemDto = new ItemDto();
				itemDto.setItemIdx(rs.getInt("item_idx"));
				itemDto.setUsersIdx(rs.getInt("users_idx"));
				itemDto.setItemType(rs.getString("item_type"));
				itemDto.setItemName(rs.getString("item_name"));
				itemDto.setItemDetail(rs.getString("item_detail"));
				itemDto.setItemPeriod(rs.getString("item_period"));
				itemDto.setItemTime(rs.getString("item_time"));
				itemDto.setItemHomepage(rs.getString("item_homepage"));
				itemDto.setItemParking(rs.getString("item_parking"));
				itemDto.setItemAddress(rs.getString("item_address"));
				itemDto.setItemDate(rs.getDate("item_date"));
				itemDto.setItemCountView(rs.getInt("item_count_view"));
				itemDto.setItemCountReply(rs.getInt("item_count_reply"));


				list.add(itemDto);
			}

			con.close();

			return list;
		}
		
		//정렬 조회 메소드(페이지네이션) : 검색
		//추가 검색 : 시,군,구
		public List<ItemDto> subCityList(String subCity,String order,String column, String keyword, int begin, int end) throws Exception {

			Connection con = JdbcUtils.connect3();
			String sql = "select * from ("
					+ "select rownum rn,TMP.* from("
						+ "select * from item where instr(#1, ?) > 0"
					+ ")TMP where instr(#1,?)>0  order by #2 desc"
				+ ")where rn between ? and ?";
			sql = sql.replace("#1", column);
			sql = sql.replace("#2", order);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, subCity);
			ps.setInt(3, begin);
			ps.setInt(4, end);
			
			ResultSet rs = ps.executeQuery();
			List<ItemDto> list = new ArrayList<>();
			while (rs.next()) {
				ItemDto itemDto = new ItemDto();
				itemDto.setItemIdx(rs.getInt("item_idx"));
				itemDto.setUsersIdx(rs.getInt("users_idx"));
				itemDto.setItemType(rs.getString("item_type"));
				itemDto.setItemName(rs.getString("item_name"));
				itemDto.setItemDetail(rs.getString("item_detail"));
				itemDto.setItemPeriod(rs.getString("item_period"));
				itemDto.setItemTime(rs.getString("item_time"));
				itemDto.setItemHomepage(rs.getString("item_homepage"));
				itemDto.setItemParking(rs.getString("item_parking"));
				itemDto.setItemAddress(rs.getString("item_address"));
				itemDto.setItemDate(rs.getDate("item_date"));
				itemDto.setItemCountView(rs.getInt("item_count_view"));
				itemDto.setItemCountReply(rs.getInt("item_count_reply"));


				list.add(itemDto);
			}

			con.close();

			return list;
		}
		
		//계절별로 축제 리스트를 뽑아오는 메소드
		public List<ItemDto> getSeasonItem(String first,String second,String third) throws Exception {

			Connection con = JdbcUtils.connect3();
			String sql = "select * from"
					+ "(select rownum rn,tmp.* from("
					+ "select * from item"
					+ " where item_type = '축제'"
					+ " and SUBSTR(item_period, 6, 2) in (?,?,?) order by to_date(SUBSTR(item_period, 1, 10),'YYYY-MM-DD') asc"//축제 시작날짜가 빠른 순서대로 정렬함.
					+ ")tmp)where rn between 1 and 7";

			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, first);
			ps.setString(2, second);
			ps.setString(3, third);
			
			ResultSet rs = ps.executeQuery();
			List<ItemDto> list = new ArrayList<>();
			while (rs.next()) {
				ItemDto itemDto = new ItemDto();
				itemDto.setItemIdx(rs.getInt("item_idx"));
				itemDto.setUsersIdx(rs.getInt("users_idx"));
				itemDto.setItemType(rs.getString("item_type"));
				itemDto.setItemName(rs.getString("item_name"));
				itemDto.setItemDetail(rs.getString("item_detail"));
				itemDto.setItemPeriod(rs.getString("item_period"));
				itemDto.setItemTime(rs.getString("item_time"));
				itemDto.setItemHomepage(rs.getString("item_homepage"));
				itemDto.setItemParking(rs.getString("item_parking"));
				itemDto.setItemAddress(rs.getString("item_address"));
				itemDto.setItemDate(rs.getDate("item_date"));
				itemDto.setItemCountView(rs.getInt("item_count_view"));
				itemDto.setItemCountReply(rs.getInt("item_count_reply"));


				list.add(itemDto);
			}

			con.close();

			return list;
		}

}