package beans;

public class EventFileDto {
	private int eventFileNo;
	private int eventNo;
	private String eventFileUploadName;
	private String eventFileSaveName;
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
	public String getEventFileUploadName() {
		return eventFileUploadName;
	}
	public void setEventFileUploadName(String eventFileUploadName) {
		this.eventFileUploadName = eventFileUploadName;
	}
	public String getEventFileSaveName() {
		return eventFileSaveName;
	}
	public void setEventFileSaveName(String eventFileSaveName) {
		this.eventFileSaveName = eventFileSaveName;
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