package beans;

import java.sql.Date;
import java.text.Format;
import java.text.SimpleDateFormat;

public class EventReplyDto {
	private int eventReplyIdx;
	private int usersIdx;
	private int eventIdx;
	private String eventReplyDetail;
	private Date eventReplyDate;
	private Integer eventReplySuperno;
	private Integer eventReplyGroupno;
	private Integer eventReplyDepth;
	
	
	
	public int getEventReplyIdx() {
		return eventReplyIdx;
	}

	public void setEventReplyIdx(int eventReplyIdx) {
		this.eventReplyIdx = eventReplyIdx;
	}

	public int getUsersIdx() {
		return usersIdx;
	}

	public void setUsersIdx(int usersIdx) {
		this.usersIdx = usersIdx;
	}

	public int getEventIdx() {
		return eventIdx;
	}

	public void setEventIdx(int eventIdx) {
		this.eventIdx = eventIdx;
	}

	public String getEventReplyDetail() {
		return eventReplyDetail;
	}

	public void setEventReplyDetail(String eventReplyDetail) {
		this.eventReplyDetail = eventReplyDetail;
	}

	public Date getEventReplyDate() {
		return eventReplyDate;
	}

	public void setEventReplyDate(Date eventReplyDate) {
		this.eventReplyDate = eventReplyDate;
	}

	public Integer getEventReplySuperno() {
		return eventReplySuperno;
	}

	public void setEventReplySuperno(Integer eventReplySuperno) {
		this.eventReplySuperno = eventReplySuperno;
	}

	public Integer getEventReplyGroupno() {
		return eventReplyGroupno;
	}

	public void setEventReplyGroupno(Integer eventReplyGroupno) {
		this.eventReplyGroupno = eventReplyGroupno;
	}

	public Integer getEventReplyDepth() {
		return eventReplyDepth;
	}

	public void setEventReplyDepth(Integer eventReplyDepth) {
		this.eventReplyDepth = eventReplyDepth;
	}

	public String getItemReplyTotalDate() {
		Format f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		return f.format(this.eventReplyDate);
	}
	
	//추가 : 답변 글인지 확인하는 메소드
	public boolean hasDepth() {
		return this.eventReplyDepth > 0;
	}

	public EventReplyDto() {
		super();
	}


}
