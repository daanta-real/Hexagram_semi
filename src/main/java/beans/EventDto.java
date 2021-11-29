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
	// Handling List: Users - id, nick, grade
	private UsersDto usersDto = null;
	public void initUsersDto(String usersId, String usersNick, String usersGrade) throws Exception {
		usersDto = new UsersDto();
		usersDto.setUsersId(usersId);
		usersDto.setUsersNick(usersNick);
		usersDto.setUsersGrade(usersGrade);
	}
	// Handling List: EventFile - fileIdx, uploadName, saveName, fileSize, fileType
	private EventFileDto eventFileDto = null;
	public void initFileDto(Integer fileIdx, String uploadName, String saveName, long fileSize, String fileType) {
		eventFileDto = new EventFileDto();
		eventFileDto.setEventFileIdx(fileIdx);
		eventFileDto.setEventFileUploadName(uploadName);
		eventFileDto.setEventFileSaveName(saveName);
		eventFileDto.setEventFileSize(fileSize);
		eventFileDto.setEventFileType(fileType);
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
	public Integer getFileIdx()        { return eventFileDto != null ? eventFileDto.getEventFileIdx() : null; }
	public String  getFileUploadName() { return eventFileDto != null ? eventFileDto.getEventFileUploadName() : null; }
	public String  getFileSaveName()   { return eventFileDto != null ? eventFileDto.getEventFileSaveName() : null; }
	public Long    getFileSize()       { return eventFileDto != null ? eventFileDto.getEventFileSize() : null; }
	public String  getFileType()       { return eventFileDto != null ? eventFileDto.getEventFileType() : null; }

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
				+ ", eventCountReply=" + eventCountReply + "\n, usersDto=" + usersDto + "\n, eventFileDto=" + eventFileDto + "]";
	}

}
