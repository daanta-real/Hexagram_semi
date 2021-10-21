public class EventDto {

	// 1. Declarations
	public int eventIdx;
	public int usersIdx;
	public String eventSubject;
	public String eventDetail;
	public String eventPeriods;

	// 2. Constructors
	public EventDto(int eventIdx, int usersIdx, String eventSubject, String eventDetail, String eventPeriods) {
		super();
		setEventIdx(eventIdx);
		setUsersIdx(usersIdx);
		setEventSubject(eventSubject);
		setEventDetail(eventDetail);
		setEventPeriods(eventPeriods);
	}

	// 3. Getters/Setters
	private final int getEventIdx() {
		return eventIdx;
	}

	private final void setEventIdx(int eventIdx) {
		this.eventIdx = eventIdx;
	}

	private final int getUsersIdx() {
		return usersIdx;
	}

	private final void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}

	private final String getEventSubject() {
		return eventSubject;
	}

	private final void setEventSubject(String eventSubject) {
		this.eventSubject = eventSubject;
	}

	private final String getEventDetail() {
		return eventDetail;
	}

	private final void setEventDetail(String eventDetail) {
		this.eventDetail = eventDetail;
	}

	private final String getEventPeriods() {
		return eventPeriods;
	}

	private final void setEventPeriods(String eventPeriods) {
		this.eventPeriods = eventPeriods;
	}

	// 4. Methods - Overrided
	@Override
	public String toString() {
		return "EventDto [eventIdx=" + eventIdx + ", usersIdx=" + usersIdx + ", eventSubject=" + eventSubject
				+ ", eventDetail=" + eventDetail + ", eventPeriods=" + eventPeriods + "]";
	}

}