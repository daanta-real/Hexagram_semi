package beans;

import java.sql.Date;

public class ItemDto {
	private int item_idx;
	private int users_idx;
	private String item_type;
	private String item_name;
	private String item_address;
	private String item_detail;
	private String item_tags;
	private Date item_date;
	private String item_periods;
	private String item_time;
	private String item_homepage;
	private String item_parking;
	private int item_count;
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getUsers_idx() {
		return users_idx;
	}
	public void setUsers_idx(int users_idx) {
		this.users_idx = users_idx;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_address() {
		return item_address;
	}
	public void setItem_address(String item_address) {
		this.item_address = item_address;
	}
	public String getItem_detail() {
		return item_detail;
	}
	public void setItem_detail(String item_detail) {
		this.item_detail = item_detail;
	}
	public String getItem_tags() {
		return item_tags;
	}
	public void setItem_tags(String item_tags) {
		this.item_tags = item_tags;
	}
	public Date getItem_date() {
		return item_date;
	}
	public void setItem_date(Date item_date) {
		this.item_date = item_date;
	}
	public String getItem_periods() {
		return item_periods;
	}
	public void setItem_periods(String item_periods) {
		this.item_periods = item_periods;
	}
	public String getItem_time() {
		return item_time;
	}
	public void setItem_time(String item_time) {
		this.item_time = item_time;
	}
	public String getItem_homepage() {
		return item_homepage;
	}
	public void setItem_homepage(String item_homepage) {
		this.item_homepage = item_homepage;
	}
	public String getItem_parking() {
		return item_parking;
	}
	public void setItem_parking(String item_parking) {
		this.item_parking = item_parking;
	}
	public int getItem_count() {
		return item_count;
	}
	public void setItem_count(int item_count) {
		this.item_count = item_count;
	}
	public ItemDto(int item_idx, int users_idx, String item_type, String item_name, String item_address,
			String item_detail, String item_tags, Date item_date, String item_periods, String item_time,
			String item_homepage, String item_parking, int item_count) {
		super();
		this.item_idx = item_idx;
		this.users_idx = users_idx;
		this.item_type = item_type;
		this.item_name = item_name;
		this.item_address = item_address;
		this.item_detail = item_detail;
		this.item_tags = item_tags;
		this.item_date = item_date;
		this.item_periods = item_periods;
		this.item_time = item_time;
		this.item_homepage = item_homepage;
		this.item_parking = item_parking;
		this.item_count = item_count;
	}
	public ItemDto() {
		super();
	}
	
}
