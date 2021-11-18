package beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JdbcUtils;

public class ItemFileDao {

	//첨부파일 등록 메소드
	public void insert(ItemFileDto itemFileDto) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "insert into item_file values(item_file_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemFileDto.getItemIdx());
		ps.setString(2, itemFileDto.getItemFileUploadname());
		ps.setString(3, itemFileDto.getItemFileSaveName());
		ps.setLong(4, itemFileDto.getItemFileSize());
		ps.setString(5, itemFileDto.getItemFileType());
		
		ps.execute();
		
		con.close();
		
	}
	
	//첨부파일 삭제 메소드
	public void delete(int itemFileIdx) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "delete item_file where item_file_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemFileIdx);
		
		ps.execute();
		
		con.close();
	}

	//첨부파일 단일조회 메소드
	public ItemFileDto get(int itemFileIdx) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "select * from item_file where item_file_idx = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemFileIdx);
		ResultSet rs = ps.executeQuery();
		
		ItemFileDto itemFileDto;
		if(rs.next()) {
			itemFileDto = new ItemFileDto();
			
			itemFileDto.setItemFileIdx(rs.getInt("item_file_idx"));
			itemFileDto.setItemIdx(rs.getInt("item_idx"));
			itemFileDto.setItemFileUploadname(rs.getString("item_file_uploadname"));
			itemFileDto.setItemFileSaveName(rs.getString("item_file_savename"));
			itemFileDto.setItemFileSize(rs.getLong("item_file_size"));
			itemFileDto.setItemFileType(rs.getString("item_file_type"));
		}
		else {
			itemFileDto = null;
		}
		con.close();
		
		return itemFileDto;
	}

	
	//게시글에 해당하는 파일 목록 조회 (여러개 있을때 detail페이지에서 조회)
	public List<ItemFileDto> find1(int itemIdx) throws Exception{
		Connection con = JdbcUtils.connect3();
		
		String sql = "select * from item_file where item_idx = ? order by item_file_idx asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, itemIdx);
		ResultSet rs = ps.executeQuery();
		
		List<ItemFileDto> list = new ArrayList<ItemFileDto>();
		while(rs.next()) {
			ItemFileDto itemFileDto = new ItemFileDto();
			
			itemFileDto.setItemFileIdx(rs.getInt("item_file_idx"));
			itemFileDto.setItemIdx(rs.getInt("item_idx"));
			itemFileDto.setItemFileUploadname(rs.getString("item_file_uploadname"));
			itemFileDto.setItemFileSaveName(rs.getString("item_file_savename"));
			itemFileDto.setItemFileSize(rs.getLong("item_file_size"));
			itemFileDto.setItemFileType(rs.getString("item_file_type"));
			
			list.add(itemFileDto);
		}
		con.close();
		
		return list;
	}
	
	//게시글에 해당하는 파일 목록 조회 (한개만 조회 list페이지에서 조회)
		public ItemFileDto find2(int itemIdx) throws Exception{
			Connection con = JdbcUtils.connect3();
			
			String sql = "select * from item_file where item_idx = ? order by item_file_idx asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, itemIdx);
			ResultSet rs = ps.executeQuery();
			
			ItemFileDto itemFileDto;
			if(rs.next()) {
				itemFileDto = new ItemFileDto();
				
				itemFileDto.setItemFileIdx(rs.getInt("item_file_idx"));
				itemFileDto.setItemIdx(rs.getInt("item_idx"));
				itemFileDto.setItemFileUploadname(rs.getString("item_file_uploadname"));
				itemFileDto.setItemFileSaveName(rs.getString("item_file_savename"));
				itemFileDto.setItemFileSize(rs.getLong("item_file_size"));
				itemFileDto.setItemFileType(rs.getString("item_file_type"));
				
			}
			else {
				itemFileDto = null;
			}
			con.close();
			
			return itemFileDto;
		}
}
