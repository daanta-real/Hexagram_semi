package beans;

import java.sql.Date;
import java.text.Format;
import java.text.SimpleDateFormat;

public class ItemReplyDto {
	private int itemReplyIdx;
	private int usersIdx;
	private int itemIdx;
	private String itemReplyDetail;
	private Date itemReplyDate;
	private int itemReplySuperno;
	private int itemReplyGroupno;
	private int itemReplyDepth;

	
	
	public int getItemReplyIdx() {
		return itemReplyIdx;
	}



	public void setItemReplyIdx(int itemReplyIdx) {
		this.itemReplyIdx = itemReplyIdx;
	}



	public int getUsersIdx() {
		return usersIdx;
	}



	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}



	public int getItemIdx() {
		return itemIdx;
	}



	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}



	public String getItemReplyDetail() {
		return itemReplyDetail;
	}



	public void setItemReplyDetail(String itemReplyDetail) {
		this.itemReplyDetail = itemReplyDetail;
	}



	public Date getItemReplyDate() {
		return itemReplyDate;
	}



	public void setItemReplyDate(Date itemReplyDate) {
		this.itemReplyDate = itemReplyDate;
	}



	public int getItemReplySuperno() {
		return itemReplySuperno;
	}



	public void setItemReplySuperno(int itemReplySuperno) {
		this.itemReplySuperno = itemReplySuperno;
	}



	public int getItemReplyGroupno() {
		return itemReplyGroupno;
	}



	public void setItemReplyGroupno(int itemReplyGroupno) {
		this.itemReplyGroupno = itemReplyGroupno;
	}



	public int getItemReplyDepth() {
		return itemReplyDepth;
	}



	public void setItemReplyDepth(int itemReplyDepth) {
		this.itemReplyDepth = itemReplyDepth;
	}

	public String getItemReplyTotalDate() {
		Format f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return f.format(this.itemReplyDate);
	}

	public ItemReplyDto() {
		super();
	}


}
