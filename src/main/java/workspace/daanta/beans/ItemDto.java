package workspace.daanta.beans;

public class ItemDto {

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
	public ItemDto() {
		super();
	}

	public ItemDto(Integer itemIdx, Integer usersIdx, String itemType, String itemName, String itemDetail,
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

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemDetail() {
		return itemDetail;
	}

	public void setItemDetail(String itemDetail) {
		this.itemDetail = itemDetail;
	}

	public String getItemTags() {
		return itemTags;
	}

	public void setItemTags(String itemTags) {
		this.itemTags = itemTags;
	}

	public String getItemDate() {
		return itemDate;
	}

	public void setItemDate(String itemDate) {
		this.itemDate = itemDate;
	}

	public String getItemPeriods() {
		return itemPeriods;
	}

	public void setItemPeriods(String itemPeriods) {
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
