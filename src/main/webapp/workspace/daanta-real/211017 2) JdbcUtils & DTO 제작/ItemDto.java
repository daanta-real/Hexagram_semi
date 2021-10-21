
public class itemDto {

	// 1. Declarations
	private Integer itemIdx;
	private Integer usersIdx;
	private String itemType;
	private String itemName;
	private String itemDetail;
	private String itemTags;
	private String itemDate; // String으로만 저장함. DATE 자료형 관련된 핸들링은 DAO에서 할 것
	private String itemPeriods;

	// 2. Constructors
	public itemDto(Integer itemIdx, Integer usersIdx, String itemType, String itemName, String itemDetail,
			String itemTags, String itemDate, String itemPeriods) {
		super();
		setItemIdx(itemIdx);
		setUsersIdx(usersIdx);
		setItemType(itemType);
		setItemName(itemName);
		setItemDetail(itemDetail);
		setItemTags(itemTags);
		setItemDate(itemDate);
		setItemPeriods(itemPeriods);
	}

	// 3. Getters/Setters
	private final Integer getItemIdx() {
		return itemIdx;
	}
	private final void setItemIdx(Integer itemIdx) {
		this.itemIdx = itemIdx;
	}
	private final Integer getUsersIdx() {
		return usersIdx;
	}
	private final void setUsersIdx(Integer usersIdx) {
		this.usersIdx = usersIdx;
	}
	private final String getItemType() {
		return itemType;
	}
	private final void setItemType(String itemType) {
		this.itemType = itemType;
	}
	private final String getItemName() {
		return itemName;
	}
	private final void setItemName(String itemName) {
		this.itemName = itemName;
	}
	private final String getItemDetail() {
		return itemDetail;
	}
	private final void setItemDetail(String itemDetail) {
		this.itemDetail = itemDetail;
	}
	private final String getItemTags() {
		return itemTags;
	}
	private final void setItemTags(String itemTags) {
		this.itemTags = itemTags;
	}
	private final String getItemDate() {
		return itemDate;
	}
	private final void setItemDate(String itemDate) {
		this.itemDate = itemDate;
	}
	private final String getItemPeriods() {
		return itemPeriods;
	}
	private final void setItemPeriods(String itemPeriods) {
		this.itemPeriods = itemPeriods;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "itemDto [itemIdx=" + itemIdx + ", usersIdx=" + usersIdx + ", itemType=" + itemType + ", itemName="
				+ itemName + ", itemDetail=" + itemDetail + ", itemTags=" + itemTags + ", itemDate=" + itemDate
				+ ", itemPeriods=" + itemPeriods + "]";
	}

}
