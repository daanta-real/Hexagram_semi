package test.준성.beans;

public class ItemReplyDto {

	// 1. Declarations
	private Integer itemReplyIdx;
	private Integer itemIdx;
	private Integer usersIdx;
	private Integer itemReplyTargetIdx;
	private String itemReplyDetail;

	// 2. Constructors
	public ItemReplyDto() {
		super();
	}

	public ItemReplyDto(int itemReplyIdx, int itemIdx, int usersIdx, int itemReplyTargetIdx, String itemReplyDetail) {
		super();
		setItemReplyIdx(itemReplyIdx);
		setItemIdx(itemIdx);
		setUsersIdx(usersIdx);
		setItemReplyTargetIdx(itemReplyTargetIdx);
		setItemReplyDetail(itemReplyDetail);
	}

	// 3. Getters/Setters
	public Integer getItemReplyIdx() {
		return itemReplyIdx;
	}

	public void setItemReplyIdx(Integer itemReplyIdx) {
		this.itemReplyIdx = itemReplyIdx;
	}

	public Integer getItemIdx() {
		return itemIdx;
	}

	public void setItemIdx(Integer itemIdx) {
		this.itemIdx = itemIdx;
	}

	public Integer getUsersIdx() {
		return usersIdx;
	}

	public void setUsersIdx(Integer usersIdx) {
		this.usersIdx = usersIdx;
	}

	public Integer getItemReplyTargetIdx() {
		return itemReplyTargetIdx;
	}

	public void setItemReplyTargetIdx(Integer itemReplyTargetIdx) {
		this.itemReplyTargetIdx = itemReplyTargetIdx;
	}

	public String getItemReplyDetail() {
		return itemReplyDetail;
	}

	public void setItemReplyDetail(String itemReplyDetail) {
		this.itemReplyDetail = itemReplyDetail;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "itemReplyDto [itemReplyIdx=" + itemReplyIdx + ", itemIdx=" + itemIdx + ", usersIdx=" + usersIdx
				+ ", itemReplyTargetIdx=" + itemReplyTargetIdx + ", itemReplyDetail=" + itemReplyDetail + "]";
	}

}