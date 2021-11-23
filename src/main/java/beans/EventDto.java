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

	// 1. Declarations - Optional
	// Handling List: id, nick, grade
	private UsersDto usersDto = null;
	public void initDto(String usersId, String usersNick, String usersGrade) throws Exception {
		usersDto = new UsersDto();
		usersDto.setUsersId(usersId);
		usersDto.setUsersNick(usersNick);
		usersDto.setUsersGrade(usersGrade);
	}

	// 2. Constructors
	public EventDto() { super(); }

	// 3. Getters
	public Integer getEventIdx() { return eventIdx; }
	public Integer getUsersIdx() { return usersIdx; }
	public String  getEventName() { return eventName; }
	public String  getEventDetail() { return eventDetail; }
	public java.util.Date getEventDate() { return eventDate; }
	public Integer getEventCountView() { return eventCountView; }
	public Integer getEventCountReply() { return eventCountReply; }

	// 3. Getters - Optional
	public String getUsersId()    { return usersDto != null ? usersDto.getUsersId()    : null; }
	public String getUsersNick()  { return usersDto != null ? usersDto.getUsersNick()  : null; }
	public String getUsersGrade() { return usersDto != null ? usersDto.getUsersGrade() : null; }

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
		return "EventDto [eventIdx=" + eventIdx + ", usersIdx=" + usersIdx + ", eventName=" + eventName
				+ ", eventDetail=" + eventDetail + ", eventDate=" + eventDate + ", eventCountView=" + eventCountView
				+ ", eventCountReply=" + eventCountReply + ", usersDto=" + usersDto + "]";
	}

}
