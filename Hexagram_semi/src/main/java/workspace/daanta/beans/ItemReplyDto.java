package workspace.daanta.beans;

public class ItemReplyDto {

	// 1. Declarations
	private Integer itemReplyIdx;
	private Integer itemIdx;
	private Integer usersIdx;
	private Integer itemReplyTargetIdx;
	private String itemReplyDeatil;

	// 2. Constructors
	public ItemReplyDto() {
		super();
	}

	public ItemReplyDto(int itemReplyIdx, int itemIdx, int usersIdx, int itemReplyTargetIdx, String itemReplyDeatil) {
		super();
		setItemReplyIdx(itemReplyIdx);
		setItemIdx(itemIdx);
		setUsersIdx(usersIdx);
		setItemReplyTargetIdx(itemReplyTargetIdx);
		setItemReplyDeatil(itemReplyDeatil);
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

	public String getItemReplyDeatil() {
		return itemReplyDeatil;
	}

	public void setItemReplyDeatil(String itemReplyDeatil) {
		this.itemReplyDeatil = itemReplyDeatil;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "itemReplyDto [itemReplyIdx=" + itemReplyIdx + ", itemIdx=" + itemIdx + ", usersIdx=" + usersIdx
				+ ", itemReplyTargetIdx=" + itemReplyTargetIdx + ", itemReplyDeatil=" + itemReplyDeatil + "]";
	}

}