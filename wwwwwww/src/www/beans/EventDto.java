package www.beans;

public class EventDto {
	
	private int eventIdx;
	private int userIdx;
	private String eventSubject;
	private String eventDetail;
	private String eventAbles;
	
	public int getEventIdx() {
		return eventIdx;
	}
	public void setEventIdx(int eventIdx) {
		this.eventIdx = eventIdx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
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
	public String getEventAbles() {
		return eventAbles;
	}
	public void setEventAbles(String eventAbles) {
		this.eventAbles = eventAbles;
	}
	
	@Override
	public String toString() {
		return "EventDto [eventIdx=" + eventIdx + ", userIdx=" + userIdx + ", eventSubject=" + eventSubject
				+ ", eventDetail=" + eventDetail + ", eventAbles=" + eventAbles + "]";
	}
	
	
	
	
	
}
