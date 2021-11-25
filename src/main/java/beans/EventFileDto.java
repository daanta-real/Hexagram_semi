package beans;

public class EventFileDto {

	// 1. Declarations
	private Integer eventFileIdx       ;
	private Integer eventIdx           ;
	private String  eventFileUploadName; // 업로드한 사람한테 보이는 가짜 이름
	private String  eventFileSaveName  ; // 서버에 저장되는 실제 이름
	private String  eventFileType      ;
	private long    eventFileSize      ;

	// 2. Constructors
	public EventFileDto() { super(); }

	// 3. Getters
	public Integer getEventFileIdx       () { return eventFileIdx       ; }
	public Integer getEventIdx           () { return eventIdx           ; }
	public String  getEventFileUploadName() { return eventFileUploadName; }
	public String  getEventFileSaveName  () { return eventFileSaveName  ; }
	public String  getEventFileType      () { return eventFileType      ; }
	public long    getEventFileSize      () { return eventFileSize      ; }

	// 4. Setters
	public void setEventFileIdx       (Integer eventFileIdx       ) { this.eventFileIdx        = eventFileIdx       ; }
	public void setEventIdx           (Integer eventIdx           ) { this.eventIdx            = eventIdx           ; }
	public void setEventFileUploadName(String  eventFileUploadName) { this.eventFileUploadName = eventFileUploadName; }
	public void setEventFileSaveName  (String  eventFileSaveName  ) { this.eventFileSaveName   = eventFileSaveName  ; }
	public void setEventFileType      (String  eventFileType      ) { this.eventFileType       = eventFileType      ; }
	public void setEventFileSize      (long    eventFileSize      ) { this.eventFileSize       = eventFileSize      ; }

	// 5. Methods
	@Override
	public String toString() {
		return "EventFileDto [eventFileIdx=" + eventFileIdx + ", eventIdx=" + eventIdx + ", eventFileUploadName="
			+ eventFileUploadName + ", eventFileSaveName=" + eventFileSaveName + ", eventFileType=" + eventFileType
			+ ", eventFileSize=" + eventFileSize + "]";
	}

}