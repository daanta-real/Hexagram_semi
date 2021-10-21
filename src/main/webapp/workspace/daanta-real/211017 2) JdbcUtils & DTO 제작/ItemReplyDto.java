
public class itemReplyDto {

	// 1. Declarations
	private Integer itemReplyIdx;
	private Integer itemIdx;
	private Integer usersIdx;
	private Integer itemReplyTargetIdx;
	private String itemReplyDeatil;

	// 2. Constructors
	public itemReplyDto(int itemReplyIdx, int itemIdx, int usersIdx, int itemReplyTargetIdx, String itemReplyDeatil) {
		super();
		setItemReplyIdx(itemReplyIdx);
		setItemIdx(itemIdx);
		setUsersIdx(usersIdx);
		setItemReplyTargetIdx(itemReplyTargetIdx);
		setItemReplyDeatil(itemReplyDeatil);
	}

	// 3. Getters/Setters
	private final int getItemReplyIdx() {
		return itemReplyIdx;
	}
	private final void setItemReplyIdx(int itemReplyIdx) {
		this.itemReplyIdx = itemReplyIdx;
	}
	private final int getItemIdx() {
		return itemIdx;
	}
	private final void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}
	private final int getUsersIdx() {
		return usersIdx;
	}
	private final void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	private final int getItemReplyTargetIdx() {
		return itemReplyTargetIdx;
	}
	private final void setItemReplyTargetIdx(int itemReplyTargetIdx) {
		this.itemReplyTargetIdx = itemReplyTargetIdx;
	}
	private final String getItemReplyDeatil() {
		return itemReplyDeatil;
	}
	private final void setItemReplyDeatil(String itemReplyDeatil) {
		this.itemReplyDeatil = itemReplyDeatil;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "itemReplyDto [itemReplyIdx=" + itemReplyIdx + ", itemIdx=" + itemIdx + ", usersIdx=" + usersIdx
				+ ", itemReplyTargetIdx=" + itemReplyTargetIdx + ", itemReplyDeatil=" + itemReplyDeatil + "]";
	}

}