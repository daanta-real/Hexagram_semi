package workspace.daanta.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.JdbcUtils;

public class ItemDao {

	// 기능 목록
	// 1. List<ItemDto> select(               ): 모든 관광지 목록 조회
	// 2. ItemDto       get   (String  itemIdx): 관광지 정보 조회
	// 3. boolean       insert(ItemDto dto    ): 관광지 추가
	// 4. boolean       delete(String  itemIdx): 관광지 삭제
	// 5. boolean       update(ItemDto dto    ): 관광지 수정

	// READ: 모든 관광지의 정보를 조회
	public List<ItemDto> select() throws Exception {
		String sql = "SELECT * FROM item";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
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
			dto.setItemPeriods(rs.getString("item_periods"));
			list.add(dto);
		}

		conn.close();
		return list;
	}

	// READ: 딱 한 개의 관광지의 정보를 조회
	public ItemDto get(int itemIdx) throws Exception {
		String sql = "SELECT * FROM item WHERE item_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ResultSet rs = ps.executeQuery();

		ItemDto dto = new ItemDto();
		if(rs.next()) {
			dto.setItemIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setItemType(rs.getString("item_type"));
			dto.setItemName(rs.getString("item_name"));
			dto.setItemDetail(rs.getString("item_detail"));
			dto.setItemTags(rs.getString("item_tags"));
			dto.setItemDate(rs.getDate("item_date"));
			dto.setItemPeriods(rs.getString("item_periods"));
		}

		conn.close();
		return dto;
	}

	// CREATE: 관광지 추가
	public boolean insert(ItemDto dto) throws Exception {
		String sql = "INSERT INTO item (item_idx, users_idx, item_type, item_name, item_detail, item_tags, item_date, item_periods)"
				+ " VALUES(item_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt   (1, dto.getItemIdx());
		ps.setInt   (2, dto.getUsersIdx());
		ps.setString(3, dto.getItemType());
		ps.setString(4, dto.getItemName());
		ps.setString(5, dto.getItemDetail());
		ps.setString(6, dto.getItemTagsStr());
		ps.setDate  (7, (java.sql.Date)dto.getItemDate());
		ps.setString(8, dto.getItemPeriodsStr());

		// 완성된 SQL문 보내고 결과 받아오기
		int rs = ps.executeUpdate();
		boolean isSucceed = rs == 1;

		// 마무리
		conn.close();
		return isSucceed;
	}

	// DELETE: 관광지 삭제
	public boolean delete(int itemIdx) throws Exception {
		String sql = "DELETE FROM item WHERE item_idx = ?";
		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int rs = ps.executeUpdate();
		boolean isSucceed = rs == 1;

		// 마무리
		conn.close();
		return isSucceed;
	}

	// UPDATE: 관광지 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(ItemDto dto) throws Exception {
		// SQL 제작
		int count = 0;
		StringBuilder sb = new StringBuilder("UPDATE item SET");
		if(dto.getItemIdx       () != null) sb.append((count++ == 0 ? "" : ",") + " item_idx = ?");
		if(dto.getUsersIdx      () != null) sb.append((count++ == 0 ? "" : ",") + " users_idx = ?");
		if(dto.getItemType      () != null) sb.append((count++ == 0 ? "" : ",") + " item_type = ?");
		if(dto.getItemName      () != null) sb.append((count++ == 0 ? "" : ",") + " item_name = ?");
		if(dto.getItemDetail    () != null) sb.append((count++ == 0 ? "" : ",") + " item_detail = ?");
		if(dto.getItemTagsStr   () != null) sb.append((count++ == 0 ? "" : ",") + " item_tags = ?");
		if(dto.getItemDate      () != null) sb.append((count++ == 0 ? "" : ",") + " item_date = ?");
		if(dto.getItemPeriodsStr() != null) sb.append((count++ == 0 ? "" : ",") + " item_periods = ?");

		sb.append(" WHERE item_idx = ?");
		String sql = sb.toString();
		System.out.println("　　SQL문 준비됨: " + sql);

		Connection conn = JdbcUtils.connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		count = 1;
		if(dto.getItemIdx       () != null) ps.setInt   (count++, dto.getItemIdx());
		if(dto.getUsersIdx      () != null) ps.setInt   (count++, dto.getUsersIdx());
		if(dto.getItemType      () != null) ps.setString(count++, dto.getItemType());
		if(dto.getItemName      () != null) ps.setString(count++, dto.getItemName());
		if(dto.getItemDetail    () != null) ps.setString(count++, dto.getItemDetail());
		if(dto.getItemTagsStr   () != null) ps.setString(count++, dto.getItemTagsStr());
		if(dto.getItemDate      () != null) ps.setDate  (count++, (java.sql.Date) dto.getItemDate());
		if(dto.getItemPeriodsStr() != null) ps.setString(count++, dto.getItemPeriodsStr());
		ps.setInt(count, dto.getItemIdx());
		System.out.println("　　?항목 치환한 개수(id 포함): " + count);

		// 완성된 SQL문 보내고 결과 받아오기
		int rs = ps.executeUpdate();
		boolean isSucceed = rs == 1;

		// 마무리
		conn.close();
		return isSucceed;
	}

}
