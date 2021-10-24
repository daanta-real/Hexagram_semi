package beans;

import java.sql.Date;

public class ItemReplyDto {
	private int item_reply_idx;
	private int item_idx;
	private int users_idx;
	private String item_reply_detail;
	private Date item_reply_time;
	private int item_reply_target_idx;
	
	public int getItem_reply_idx() {
		return item_reply_idx;
	}
	public void setItem_reply_idx(int item_reply_idx) {
		this.item_reply_idx = item_reply_idx;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getUsers_idx() {
		return users_idx;
	}
	public void setUsers_idx(int users_idx) {
		this.users_idx = users_idx;
	}
	public String getItem_reply_detail() {
		return item_reply_detail;
	}
	public void setItem_reply_detail(String item_reply_detail) {
		this.item_reply_detail = item_reply_detail;
	}
	public Date getItem_reply_time() {
		return item_reply_time;
	}
	public void setItem_reply_time(Date item_reply_time) {
		this.item_reply_time = item_reply_time;
	}
	public int getItem_reply_target_idx() {
		return item_reply_target_idx;
	}
	public void setItem_reply_target_idx(int item_reply_target_idx) {
		this.item_reply_target_idx = item_reply_target_idx;
	}
	public ItemReplyDto(int item_reply_idx, int item_idx, int users_idx, String item_reply_detail, Date item_reply_time,
			int item_reply_target_idx) {
		super();
		this.item_reply_idx = item_reply_idx;
		this.item_idx = item_idx;
		this.users_idx = users_idx;
		this.item_reply_detail = item_reply_detail;
		this.item_reply_time = item_reply_time;
		this.item_reply_target_idx = item_reply_target_idx;
	}
	public ItemReplyDto() {
		super();
	}
	

}
