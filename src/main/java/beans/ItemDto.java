package beans;

import java.sql.Date;
import java.util.StringTokenizer;

public class ItemDto {
	private int itemIdx;
	private int usersIdx;
	private String itemType;
	private String itemName;
	private String itemDetail;
	private String itemPeriod;
	private String itemTime;
	private String itemHomepage;
	private String itemParking;
	private String itemAddress;
	private Date itemDate;
	private int itemCountView;
	private int itemCountReply;
	
	
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
	public String getItemDetail() {
		return itemDetail;
	}
	public void setItemDetail(String itemDetail) {
		this.itemDetail = itemDetail;
	}
	public String getItemPeriod() {
		if(itemPeriod == null) 
			return "";
		else		
			return itemPeriod;
	}
	public void setItemPeriod(String itemPeriod) {
		this.itemPeriod = itemPeriod;
	}
	public String getItemTime() {
		if(itemTime == null)
			return "";
		else
			return itemTime;
	}
	public void setItemTime(String itemTime) {
		this.itemTime = itemTime;
	}
	public String getItemHomepage() {
		if(itemHomepage == null)
			return "";
		else
			return itemHomepage;
	}
	public void setItemHomepage(String itemHomepage) {
		this.itemHomepage = itemHomepage;
	}
	public String getItemParking() {
		if(itemParking == null)
			return "";
		else
			return itemParking;
	}
	public void setItemParking(String itemParking) {
		this.itemParking = itemParking;
	}
	public String getItemAddress() {
		return itemAddress;
	}
	public void setItemAddress(String itemAddress) {
		this.itemAddress = itemAddress;
	}
	public Date getItemDate() {
		return itemDate;
	}
	public void setItemDate(Date itemDate) {
		this.itemDate = itemDate;
	}
	public int getItemCountView() {
		return itemCountView;
	}
	public void setItemCountView(int itemCountView) {
		this.itemCountView = itemCountView;
	}
	public int getItemCountReply() {
		return itemCountReply;
	}
	public void setItemCountReply(int itemCountReply) {
		this.itemCountReply = itemCountReply;
	}
	
	//댓글 수 갱신 기능
	public boolean isCountReply() {
		return this.itemCountReply > 0;
	}
	
	public String getAdressCity() {
		StringTokenizer st = new StringTokenizer(this.itemAddress," ");
		StringBuffer sb = new StringBuffer();
		int i = 0;
		while(st.hasMoreTokens()) {
			i++;
			sb.append(st.nextToken());
			if(i==1) break;
		}
		return sb.toString();
		}
		
		public String getAdressCitySub() {
			StringTokenizer st = new StringTokenizer(this.itemAddress," ");
			StringBuffer sb = new StringBuffer();
			int i = 0;
			while(st.hasMoreTokens()) {
				i++;
				if(i==1) st.nextToken();
				if(i==2) sb.append(st.nextToken());
				if(i==2) break;
			}
			return sb.toString();
	}
	
	public ItemDto() {
		super();
	}

}
