package beans;

import java.util.Date;
import java.util.StringTokenizer;

public class EventDto {

	private int eventIdx;
	private int usersIdx;
	private String eventName;
	private String eventDetail;
	private Date eventDate;
	private Integer eventCountView;
	private Integer eventCountReply;
	private String eventAddress;

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
	public Date getEventDate() {
		return eventDate;
	}
	public void setEventDate(Date eventDate) {
		this.eventDate = eventDate;
	}
	public Integer getEventCountView() {
		return eventCountView;
	}
	public void setEventCountView(Integer eventCountView) {
		this.eventCountView = eventCountView;
	}
	public Integer getEventCountReply() {
		return eventCountReply;
	}
	public void setEventCountReply(Integer eventCountReply) {
		this.eventCountReply = eventCountReply;
	}
	
//댓글 수 갱신 기능
	public boolean isCountReply() {
		return this.eventCountReply > 0;
	}
		
	public String getAdressCity() {
		StringTokenizer st = new StringTokenizer(this.eventAddress," ");
		StringBuffer sb = new StringBuffer();
		int i = 0;
		while(st.hasMoreTokens()) {
			i++;
			sb.append(st.nextToken());
			if(i==1) break;
			}
		return sb.toString();
	}
			
	public String getAdressCitySub() {
			StringTokenizer st = new StringTokenizer(this.eventAddress," ");
			StringBuffer sb = new StringBuffer();
			int i = 0;
			while(st.hasMoreTokens()) {
				i++;
				if(i==1) st.nextToken();
				if(i==2) sb.append(st.nextToken());
				if(i==2) break;
			}
			return sb.toString();
	}
		
	public EventDto() {
		super();
	}
}
