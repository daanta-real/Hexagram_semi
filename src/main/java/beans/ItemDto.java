package beans;

import java.sql.Date;

public class ItemDto {
	private int itemIdx;
	private int usersIdx;
	private String itemType;
	private String itemName;
	private String itemAddress;
	private String itemDetail;
	private String itemTags;
	private Date itemDate;
	private String itemPeriods;
	private String itemTime;
	private String itemHomepage;
	private String itemParking;
	private int itemCount;
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
	public String getItemAddress() {
		return itemAddress;
	}
	public void setItemAddress(String itemAddress) {
		this.itemAddress = itemAddress;
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
	public Date getItemDate() {
		return itemDate;
	}
	public void setItemDate(Date itemDate) {
		this.itemDate = itemDate;
	}
	public String getItemPeriods() {
		return itemPeriods;
	}
	public void setItemPeriods(String itemPeriods) {
		this.itemPeriods = itemPeriods;
	}
	public String getItemTime() {
		return itemTime;
	}
	public void setItemTime(String itemTime) {
		this.itemTime = itemTime;
	}
	public String getItemHomepage() {
		return itemHomepage;
	}
	public void setItemHomepage(String itemHomepage) {
		this.itemHomepage = itemHomepage;
	}
	public String getItemParking() {
		return itemParking;
	}
	public void setItemParking(String itemParking) {
		this.itemParking = itemParking;
	}
	public int getItemCount() {
		return itemCount;
	}
	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}
	public ItemDto(int itemIdx, int usersIdx, String itemType, String itemName, String itemAddress,
			String itemDetail, String itemTags, Date itemDate, String itemPeriods, String itemTime,
			String itemHomepage, String itemParking, int itemCount) {
		super();
		this.itemIdx = itemIdx;
		this.usersIdx = usersIdx;
		this.itemType = itemType;
		this.itemName = itemName;
		this.itemAddress = itemAddress;
		this.itemDetail = itemDetail;
		this.itemTags = itemTags;
		this.itemDate = itemDate;
		this.itemPeriods = itemPeriods;
		this.itemTime = itemTime;
		this.itemHomepage = itemHomepage;
		this.itemParking = itemParking;
		this.itemCount = itemCount;
	}
	public ItemDto() {
		super();
	}

}
