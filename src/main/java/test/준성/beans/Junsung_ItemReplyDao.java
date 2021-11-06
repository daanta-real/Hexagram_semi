package test.준성.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.JdbcUtils;
import util.SQLBuilder;

public class Junsung_ItemReplyDao {

	// 기능 목록
	// 1. List<ItemReplyDto> select(                         ): 모든 관광지댓글 목록 조회
	// 2. ItemReplyDto       get   (int          itemReplyIdx): 관광지댓글 정보 조회
	// 3. boolean            insert(ItemReplyDto dto         ): 관광지댓글 추가
	// 4. boolean            delete(int          itemReplyIdx): 관광지댓글 삭제
	// 5. boolean            update(ItemReplyDto dto         ): 관광지댓글 수정

	// READ: 모든 관광지댓글의 정보를 조회
	public List<Junsung_ItemReplyDto> select() throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM item_reply";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		List<Junsung_ItemReplyDto> list = new ArrayList<>();
		while(rs.next()) {
			Junsung_ItemReplyDto dto = new Junsung_ItemReplyDto();
			dto.setItemReplyIdx(rs.getInt("item_reply_idx"));
			dto.setItemIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setItemReplyTargetIdx(rs.getInt("item_reply_target_idx"));
			dto.setItemReplyDetail(rs.getString("item_reply_detail"));
			list.add(dto);
		}

		// 마무리
		conn.close();
		return list;

	}

	// READ: 딱 한 개의 관광지댓글의 정보를 조회
	public Junsung_ItemReplyDto get (int itemReplyIdx) throws Exception {

		// SQL 준비
		String sql = "SELECT * FROM item_reply WHERE item_reply_idx = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemReplyIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		ResultSet rs = ps.executeQuery();
		Junsung_ItemReplyDto dto = null;
		if(rs.next()) {
			dto = new Junsung_ItemReplyDto();
			dto.setItemReplyIdx(rs.getInt("item_reply_idx"));
			dto.setItemIdx(rs.getInt("item_idx"));
			dto.setUsersIdx(rs.getInt("users_idx"));
			dto.setItemReplyTargetIdx(rs.getInt("item_reply_target_idx"));
			dto.setItemReplyDetail(rs.getString("item_reply_detail"));
		}

		// 마무리
		conn.close();
		return dto;

	}

	// CREATE: 관광지댓글 추가
	public boolean insert(Junsung_ItemReplyDto dto) throws Exception {

		// SQL 준비
		String sql = "INSERT INTO item_reply (item_reply_idx, item_idx, users_idx, item_reply_target_idx, item_reply_detail)"
			+ " VALUES(item_reply.NEXTVAL, ?, ?, ?, ?)";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getItemIdx());
		ps.setInt(2, dto.getUsersIdx());
		ps.setInt(3, dto.getItemReplyTargetIdx());
		ps.setString(4, dto.getItemReplyDetail());

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// DELETE: 관광지댓글 삭제
	public boolean delete(int itemReplyIdx) throws Exception {

		// SQL 준비
		String sql = "DELETE FROM item_reply WHERE item_reply_idx = ?";
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, itemReplyIdx);

		// 완성된 SQL문 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}

	// UPDATE: 관광지댓글 수정
	// DTO에는 ID 외에 수정할 컬럼에 해당하는 값이 반드시 한 개는 있어야 한다. 아예 없으면 에러 난다.
	public boolean update(Junsung_ItemReplyDto dto) throws Exception {

		// SQL 정보 준비
		List<String[]> info = new ArrayList<>(Arrays.asList(
			new String[] {"UPDATE course SET "       , null    , null                                       , null},
			new String[] {"item_idx = ?"             , "int"   , String.valueOf(dto.getItemIdx())           , "," },
			new String[] {"users_idx = ?"            , "int"   , String.valueOf(dto.getUsersIdx())          , "," },
			new String[] {"item_reply_target_idx = ?", "int"   , String.valueOf(dto.getItemReplyTargetIdx()), "," },
			new String[] {"item_reply_detail = ?"    , "String", dto.getItemReplyDetail()                   , "," },
			new String[] {" WHERE item_reply_idx = ?", "int"   , String.valueOf(dto.getItemIdx())           , null}
		));
		Connection conn = JdbcUtils.connect3();
		PreparedStatement ps = SQLBuilder.getInstance(conn, info);

		// SQL문 만들어 보내고 결과 받아오기
		int result = ps.executeUpdate();
		boolean isSucceed = result == 1;

		// 마무리
		conn.close();
		return isSucceed;

	}
}
