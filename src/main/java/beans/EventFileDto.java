package beans;

public class EventFileDto {
	private int eventFileNo;
	private int eventNo;
	private String eventFileUploadname;
	private String eventFileSavename;
	private String eventFileType;
	private long eventFileSize;
	public EventFileDto() {
		super();
	}
	public int getEventFileNo() {
		return eventFileNo;
	}
	public void setEventFileNo(int eventFileNo) {
		this.eventFileNo = eventFileNo;
	}
	public int getEventNo() {
		return eventNo;
	}
	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}
	public String getEventFileUploadname() {
		return eventFileUploadname;
	}
	public void setEventFileUploadname(String eventFileUploadname) {
		this.eventFileUploadname = eventFileUploadname;
	}
	public String getEventFileSavename() {
		return eventFileSavename;
	}
	public void setEventFileSavename(String eventFileSavename) {
		this.eventFileSavename = eventFileSavename;
	}
	public String getEventFileType() {
		return eventFileType;
	}
	public void setEventFileType(String eventFileType) {
		this.eventFileType = eventFileType;
	}
	public long getEventFileSize() {
		return eventFileSize;
	}
	public void setEventFileSize(long eventFileSize) {
		this.eventFileSize = eventFileSize;
	}
}