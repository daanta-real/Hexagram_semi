package beans;

public class EventDto {

	// 1. Declarations
	private Integer eventIdx;
	private Integer usersIdx;
	private String eventName;
	private String eventDetail;
	private java.util.Date eventDate;
	private Integer eventCountView;
	private Integer eventCountReply;

	// 2. Constructors
	public EventDto() { super(); }

	// 3. Getters
	public Integer getEventIdx() { return eventIdx; }
	public Integer getUsersIdx() { return usersIdx; }
	public String getEventName() { return eventName; }
	public String getEventDetail() { return eventDetail; }
	public java.util.Date getEventDate() { return eventDate; }
	public Integer getEventCountView() { return eventCountView; }
	public Integer getEventCountReply() { return eventCountReply; }

	// 4. Setters
	public void setEventIdx(Integer eventIdx) { this.eventIdx = eventIdx; }
	public void setUsersIdx(Integer usersIdx) { this.usersIdx = usersIdx; }
	public void setEventName(String eventName) { this.eventName = eventName; }
	public void setEventDetail(String eventDetail) { this.eventDetail = eventDetail; }
	public void setEventDate(java.util.Date eventDate) { this.eventDate = eventDate; }
	public void setEventCountView(Integer eventCountView) { this.eventCountView = eventCountView; }
	public void setEventCountReply(Integer eventCountReply) { this.eventCountReply = eventCountReply; }

	// 5. Status Information Methods
	public boolean isCountReply() {
		return this.eventCountReply > 0;
	}
	@Override
	public String toString() {
		return "EventDto [eventCountReply=" + eventCountReply + ", eventCountView="
				+ eventCountView + ", eventDate=" + eventDate + ", eventDetail=" + eventDetail + ", eventIdx="
				+ eventIdx + ", eventName=" + eventName + ", usersIdx=" + usersIdx + "]";
	}

}
