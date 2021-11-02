package beans;

public class EventDto {
	
	private int eventIdx;
	private int usersIdx;
	private String eventName;
	private String eventDetail;
	private String eventDate;
	private String eventCountView;
	private String eventCountReply;
	
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
	public String getEventDate() {
		return eventDate;
	}
	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}
	public String getEventCountView() {
		return eventCountView;
	}
	public void setEventCountView(String eventCountView) {
		this.eventCountView = eventCountView;
	}
	public String getEventCountReply() {
		return eventCountReply;
	}
	public void setEventCountReply(String eventCountReply) {
		this.eventCountReply = eventCountReply;
	}
	
	
	@Override
	public String toString() {
		return "EventDto [eventIdx=" + eventIdx + ", usersIdx=" + usersIdx + ", eventName=" + eventName
				+ ", eventDetail=" + eventDetail + ", eventDate=" + eventDate + ", eventCountView=" + eventCountView + ", eventCountReply=" + eventCountReply + "]";
	}

}
