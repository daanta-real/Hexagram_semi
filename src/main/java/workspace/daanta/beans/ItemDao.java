package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.JdbcUtils;
import workspace.daanta.util.DaoUtils;

public class ItemDao {

	// 기능 목록
	// 1. List<ItemDto> select(               ): 모든 관광지 목록 조회
	// 2. ItemDto       get   (int     itemIdx): 관광지 정보 조회
	// 3. boolean       insert(ItemDto dto    ): 관광지 추가
	// 4. boolean       delete(int     itemIdx): 관광지 삭제
	// 5. boolean       update(ItemDto dto    ): 관광지 수정

	// READ: 모든 관광지의 정보를 조회
	public List<ItemDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM item";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<ItemDto> list = new ArrayList<>();
		while(rs.next()) {
			ItemDto dto = new ItemDto();
			dto.setItemIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setItemType(rs.getString("item_type"));
			dto.setItemName(rs.getString("item_name"));
			dto.setItemDetail(rs.getString("item_detail"));
			dto.setItemTags(rs.getString("item_tags"));
			dto.setItemDate(rs.getDate("item_date"));
			dto.setItemPeriod(rs.getString("item_period"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

	// READ: 딱 한 개의 관광지의 정보를 조회
	public ItemDto get(int itemIdx) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM item WHERE item_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		ItemDto dto = null;
		if(rs.next()) {
			dto = new ItemDto();
			dto.setItemIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setItemType(rs.getString("item_type"));
			dto.setItemName(rs.getString("item_name"));
			dto.setItemDetail(rs.getString("item_detail"));
			dto.setItemTags(rs.getString("item_tags"));
			dto.setItemDate(rs.getDate("item_date"));
			dto.setItemPeriod(rs.getString("item_period"));
		}

		// 마무리
		conn.close();
		return dto;

	}

	// CREATE: 관광지 추가
	public boolean insert(ItemDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO item (item_idx, users_idx, item_type, item_name, item_detail, item_tags, item_date, item_period)"
				+ " VALUES(item_seq.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt   (1, dto.getUsersIdx());
		ps.setString(2, dto.getItemType());
		ps.setString(3, dto.getItemName());
		ps.setString(4, dto.getItemDetail());
		ps.setString(5, dto.getItemTagsStr());
		ps.setString(6, dto.getItemPeriod());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// DELETE: 관광지 삭제
	public boolean delete(int itemIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM item WHERE item_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// UPDATE: 관광지 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(ItemDto dto) throws Exception {

		// SQL 정보 준비
		List<String[]> list = new ArrayList<>(Arrays.asList(
			new String[] {"UPDATE item SET ", null, null, null },
			new String[] {"item_idx = ?", "int", String.valueOf(dto.getItemIdx()), ","},
			new String[] {"users_idx = ?", "int", String.valueOf(dto.getUsersIdx()), ","},
			new String[] {"item_type = ?", "String", dto.getItemType(), ","},
			new String[] {"item_detail = ?", "String", dto.getItemDetail(), ","},
			new String[] {"item_tags = ?", "String", DaoUtils.listToStr(dto.getItemTags()), ","},
			new String[] {"item_date = DATE('yyyy-MM-dd hh:mm:ss', ?)", "Date", DaoUtils.dateToStr(dto.getItemDate()), ","},
			new String[] {"item_period = ?", "String", dto.getItemPeriod(), ","},
			new String[] {" WHERE item_idx = ?", "int", String.valueOf(dto.getItemIdx()), ","}
		));

		// SQL문 만들어 보내고 결과 받아오기
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = DaoUtils.sqlBuilder(conn, list);
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

}
