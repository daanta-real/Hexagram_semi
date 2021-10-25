package beans;

import java.sql.Date;

public class ItemReplyDto {
	private int itemReplyIdx;
	private int itemIdx;
	private int usersIdx;
	private String itemReplyDetail;
	private Date itemReplyTime;
	private int itemReplyTargetIdx;

	public int getItemReplyIdx() {
		return itemReplyIdx;
	}
	public void setItemReplyIdx(int itemReplyIdx) {
		this.itemReplyIdx = itemReplyIdx;
	}
	public int getItemIdx() {
		return itemIdx;
	}
	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}
	public int getUsersIdx() {
		return usersIdx;
	}
	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	public String getItemReplyDetail() {
		return itemReplyDetail;
	}
	public void setItemReplyDetail(String itemReplyDetail) {
		this.itemReplyDetail = itemReplyDetail;
	}
	public Date getItemReplyTime() {
		return itemReplyTime;
	}
	public void setItemReplyTime(Date itemReplyTime) {
		this.itemReplyTime = itemReplyTime;
	}
	public int getItemReplyTargetIdx() {
		return itemReplyTargetIdx;
	}
	public void setItemReplyTargetIdx(int itemReplyRargetIdx) {
		this.itemReplyTargetIdx = itemReplyRargetIdx;
	}
	public ItemReplyDto(int itemReplyIdx, int itemIdx, int usersIdx, String itemReplyDetail, Date itemReplyTime,
			int itemReplyRargetIdx) {
		super();
		this.itemReplyIdx = itemReplyIdx;
		this.itemIdx = itemIdx;
		this.usersIdx = usersIdx;
		this.itemReplyDetail = itemReplyDetail;
		this.itemReplyTime = itemReplyTime;
		this.itemReplyTargetIdx = itemReplyRargetIdx;
	}
	public ItemReplyDto() {
		super();
	}


}
