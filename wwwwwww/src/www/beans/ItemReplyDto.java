package www.beans;

public class ItemReplyDto {
	
	private int itemReplyIdx;
	private int itemIdx;
	private int userIdx;
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
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
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
		return "ReplyitemDto [itemReplyIdx=" + itemReplyIdx + ", itemIdx=" + itemIdx + ", userIdx=" + userIdx
				+ ", itemReplyTargetIdx=" + itemReplyTargetIdx + ", itemReplyDetail=" + itemReplyDetail + "]";
	}
	
	
	
}
