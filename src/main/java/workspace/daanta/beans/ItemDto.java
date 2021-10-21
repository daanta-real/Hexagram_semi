package workspace.daanta.beans;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

// itemPeriods의 사용에 주의해야 한다. 하기 관련 메소드 설명 참조 이용 바람.
// 1. itemPeriods 자료형은 List<String> 즉 ["Date1", "Date2", "Date3", ...] 이런 형태이다.
//    안에 들어가는 날짜들은, 값이 추가되든 삭제되든 알아서 오름차순 정렬된다.
// 2. 관련 메소드
//    1) 전체값 재설정: setItemPeriods(정보).
//       이때 정보는 String을 넘겨도 되고 List<String>을 넘겨도 된다.
//       - public void setItemPeriods(String periodsStr)
//       - public void setItemPeriods(List<String> periodsList)
//    2) 값 한개 추가(날짜 추가): addItemPeriods(추가할 날짜문자열값)
//       - public void addItemPeriods(String date)
//    3) 값 한개 제거(날짜 삭제): removeItemPeriods(지울 날짜열문자값)
//       - public void removeItemPeriods(String date)

public class ItemDto {

	// 1. Declarations
	private Integer itemIdx;
	private Integer usersIdx;
	private String itemType;
	private String itemName;
	private String itemDetail;
	private String itemTags;
	private String itemDate; // Date형태로 입력되지만 마찬가지로 String으로 넣고 뺄 것
	private List<String> itemPeriods; // ["Date1", "Date2", "Date3", ...]

	// 2. Constructors
	public ItemDto() {
		super();
	}

	public ItemDto(Integer itemIdx, Integer usersIdx, String itemType, String itemName, String itemDetail,
			String itemTags, String itemDate, List<String> itemPeriods) {
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

	public List<String> getItemPeriods() {
		return itemPeriods;
	}

	// itemPeriods 저장 메소드들. String을 넣어도 되고 List<String>을 넣어도 된다.
	// String으로 들어왔을 경우, 뜯어서 List로 split한 다음 넘겨줌
	public void setItemPeriods(String periodsStr) {
		String[] splitted = periodsStr.split(",");
		List<String> list = new ArrayList<>(Arrays.asList(splitted));
		setItemPeriods(list);
	}
	// List로 들어왔을 경우, 정렬만 하고 바로 저장
	public void setItemPeriods(List<String> periodsList) {
		Collections.sort(periodsList);
		this.itemPeriods = periodsList;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "ItemDao [itemIdx=" + itemIdx + ", usersIdx=" + usersIdx + ", itemType=" + itemType + ", itemName="
				+ itemName + ", itemDetail=" + itemDetail + ", itemTags=" + itemTags + ", itemDate=" + itemDate
				+ ", itemPeriods=" + itemPeriods + "]";
	}

	// 5. Methods - Common
	// periods필드에 새로운 날짜를 추가한다.
	public void addItemPeriods(String date) {
		itemPeriods.add(date);
	}

	// periods필드에서 날짜를 삭제한다. 이때 몇 번째 값이 삭제될지 모르므로 재정렬해준다.
	public void removeItemPeriods(String date) {
		itemPeriods.remove(date);
		Collections.sort(itemPeriods);
	}

}
