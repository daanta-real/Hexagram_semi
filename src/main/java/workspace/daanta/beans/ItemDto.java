package workspace.daanta.beans;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import workspace.daanta.util.DaoUtils;

public class ItemDto {

	// 1. Declarations
	private Integer itemIdx;
	private Integer usersIdx;
	private String itemType;
	private String itemName;
	private String itemDetail;
	private List<String> itemTags; // ["부산", "멋진곳", "휴양지", ...]
	private java.util.Date itemDate; // 작성일자
	private String itemPeriod; // 기간


	// 2. Constructors
	// 변수값들을 한 번에 다 받는 생성자는 itemTags와 itemPeriods의 자료형별로 오버로딩해줘야 해서 총 네 개를 만들어야 된다.
	// <기본 생성자>
	public ItemDto() {
		super();
	}
	// <서브 생성자> 태그rk 문자일 때
	public ItemDto(Integer itemIdx, Integer usersIdx, String itemType, String itemName, String itemDetail,
			String itemTagsStr, java.util.Date itemDate, String itemPeriod) {
		this(itemIdx, usersIdx, itemType, itemName, itemDetail, DaoUtils.strToList(itemTagsStr), itemDate, itemPeriod);
	}
	// <서브 생성자> 태그는 list, 기간은 문자열일 때
	public ItemDto(Integer itemIdx, Integer usersIdx, String itemType, String itemName, String itemDetail,
			List<String> itemTags, java.util.Date itemDate, String itemPeriod) {
		super();
		setItemIdx(itemIdx);
		setUsersIdx(usersIdx);
		setItemType(itemType);
		setItemName(itemName);
		setItemDetail(itemDetail);
		setItemTags(itemTags);
		setItemDate(itemDate);
		setItemPeriod(itemPeriod);
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

	// tags Getters
	// 1) String형으로 얻을 경우
	public String getItemTagsStr() {
		return String.join(",", itemTags);
	}
	// 2) List형으로 얻을 경우
	public List<String> getItemTags() {
		return itemTags;
	}

	// tags Setters
	// 1) String으로 들어왔을 경우, 뜯어서 List형으로 만든 다음 넘겨줌
	public void setItemTags(String tagsStr) {
		setItemTags(DaoUtils.strToList(tagsStr));
	}
	// 2) List로 들어왔을 경우, 정렬만 하고 바로 저장
	public void setItemTags(List<String> tagsList) {
		Collections.sort(tagsList);
		this.itemTags = tagsList;
	}

	public Date getItemDate() {
		return itemDate;
	}

	public void setItemDate(Date itemDate) {
		this.itemDate = itemDate;
	}

	public final String getItemPeriod() {
		return itemPeriod;
	}
	public final void setItemPeriod(String itemPeriod) {
		this.itemPeriod = itemPeriod;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "ItemDto [itemIdx=" + itemIdx + ", usersIdx=" + usersIdx + ", itemType=" + itemType + ", itemName="
				+ itemName + ", itemDetail=" + itemDetail + ", itemTags=" + itemTags + ", itemDate=" + itemDate
				+ ", itemPeriod=" + itemPeriod + "]";
	}

}