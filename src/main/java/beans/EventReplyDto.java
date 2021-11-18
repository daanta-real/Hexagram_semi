package beans;

import java.sql.Date;
import java.text.Format;
import java.text.SimpleDateFormat;

public class EventReplyDto {
	private int eventReplyIdx;
	private int usersIdx;
	private int eventIdx;
	private int eventReplyTargetIdx;
	private String eventReplyDetail;
	private Date eventReplyDate;
	private Integer eventReplySuperno;
	private Integer eventReplyGroupno;
	private Integer eventReplyDepth;
	
	public int getEventReplyIdx() {
		return eventReplyIdx;
	}
	public void setEventReplyIdx(int eventReplyIdx) {
		this.eventReplyIdx = eventReplyIdx;
	}
	public int getUsersIdx() {
		return usersIdx;
	}
	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	public int getEventIdx() {
		return eventIdx;
	}
	public void setEventIdx(int eventIdx) {
		this.eventIdx = eventIdx;
	}
	public int getEventReplyTargetIdx() {
		return eventReplyTargetIdx;
	}
	public void setEventReplyTargetIdx(int eventReplyTargetIdx) {
		this.eventReplyTargetIdx = eventReplyTargetIdx;
	}
	public String getEventReplyDetail() {
		return eventReplyDetail;
	}
	public void setEventReplyDetail(String eventReplyDetail) {
		this.eventReplyDetail = eventReplyDetail;
	}
	public Date getEventReplyDate() {
		return eventReplyDate;
	}
	public void setEventReplyDate(Date eventReplyDate) {
		this.eventReplyDate = eventReplyDate;
	}
	public int getEventReplySuperno() {
		return eventReplySuperno;
	}
	public void setEventReplySuperno(int eventReplySuperno) {
		this.eventReplySuperno = eventReplySuperno;
	}
	public int getEventReplyGroupno() {
		return eventReplyGroupno;
	}
	public void setEventReplyGroupno(int eventReplyGroupno) {
		this.eventReplyGroupno = eventReplyGroupno;
	}
	public int getEventReplyDepth() {
		return eventReplyDepth;
	}
	public void setEventReplyDepth(int eventReplyDepth) {
		this.eventReplyDepth = eventReplyDepth;
	}
	
	public String getItemReplyTotalDate() {
		Format f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return f.format(this.eventReplyDate);
	}

	public EventReplyDto() {
		super();
	}


}
