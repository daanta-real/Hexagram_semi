package www.beans;

public class ItemReplyDto {
	
	private int itemReplyIdx;
	private int itemIdx;
	private int usersIdx;
	private int itemReplyTargetIdx;
	private String itemReplyDetail;
	
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
	public int getItemReplyTargetIdx() {
		return itemReplyTargetIdx;
	}
	public void setItemReplyTargetIdx(int itemReplyTargetIdx) {
		this.itemReplyTargetIdx = itemReplyTargetIdx;
	}
	public String getItemReplyDetail() {
		return itemReplyDetail;
	}
	public void setItemReplyDetail(String itemReplyDetail) {
		this.itemReplyDetail = itemReplyDetail;
	}
	
	@Override
	public String toString() {
		return "ItemReplyDto [itemReplyIdx=" + itemReplyIdx + ", itemIdx=" + itemIdx + ", usersIdx=" + usersIdx
				+ ", itemReplyTargetIdx=" + itemReplyTargetIdx + ", itemReplyDetail=" + itemReplyDetail + "]";
	}
	
	
	
	
}
