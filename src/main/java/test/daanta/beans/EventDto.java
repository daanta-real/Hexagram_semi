package workspace.daanta.beans;

public class EventDto {

	// 1. Declarations
	private Integer eventIdx;
	private Integer usersIdx;
	private String eventSubject;
	private String eventDetail;
	private String eventPeriod;

	// 2. Constructors
	public EventDto() {
		super();
	}

	public EventDto(Integer eventIdx, Integer usersIdx, String eventSubject, String eventDetail, String eventPeriod) {
		super();
		setEventIdx(eventIdx);
		setUsersIdx(usersIdx);
		setEventSubject(eventSubject);
		setEventDetail(eventDetail);
		setEventPeriod(eventPeriod);
	}

	// 3. Getters/Setters
	public Integer getEventIdx() {
		return eventIdx;
	}

	public void setEventIdx(Integer eventIdx) {
		this.eventIdx = eventIdx;
	}

	public Integer getUsersIdx() {
		return usersIdx;
	}

	public void setUsersIdx(Integer usersIdx) {
		this.usersIdx = usersIdx;
	}

	public String getEventSubject() {
		return eventSubject;
	}

	public void setEventSubject(String eventSubject) {
		this.eventSubject = eventSubject;
	}

	public String getEventDetail() {
		return eventDetail;
	}

	public void setEventDetail(String eventDetail) {
		this.eventDetail = eventDetail;
	}

	public String getEventPeriod() {
		return eventPeriod;
	}

	public void setEventPeriod(String eventPeriod) {
		this.eventPeriod = eventPeriod;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "EventDto [eventIdx=" + eventIdx + ", usersIdx=" + usersIdx + ", eventSubject=" + eventSubject
				+ ", eventDetail=" + eventDetail + ", eventPeriod=" + eventPeriod + "]";
	}

}