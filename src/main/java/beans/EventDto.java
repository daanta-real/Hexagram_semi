package beans;

import java.util.Date;

public class EventDto {

	private int eventIdx;
	private int usersIdx;
	private String eventName;
	private String eventDetail;
	private Date eventDate;
	private Integer eventCountView;
	private Integer eventCountReply;

	public int getEventIdx() {
		return eventIdx;
	}
	public void setEventIdx(int eventIdx) {
		this.eventIdx = eventIdx;
	}
	public int getUsersIdx() {
		return usersIdx;
	}
	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getEventDetail() {
		return eventDetail;
	}
	public void setEventDetail(String eventDetail) {
		this.eventDetail = eventDetail;
	}
	public Date getEventDate() {
		return eventDate;
	}
	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}
	public Integer getEventCountView() {
		return eventCountView;
	}
	public void setEventCountView(Integer eventCountView) {
		this.eventCountView = eventCountView;
	}
	public Integer getEventCountReply() {
		return eventCountReply;
	}
	public void setEventCountReply(Integer eventCountReply) {
		this.eventCountReply = eventCountReply;
	}


	@Override
	public String toString() {
		return "EventDto [eventIdx=" + eventIdx + ", usersIdx=" + usersIdx + ", eventName=" + eventName
				+ ", eventDetail=" + eventDetail + ", eventDate=" + eventDate + ", eventCountView=" + eventCountView
				+ ", eventCountReply=" + eventCountReply + "]";
	}

}
