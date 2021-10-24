package beans;

public class APIDto {
	private String address;
	private String title;
	private String mapy;
	private String mapx;
	private String img;
	private String contentid;
	private String contenttypeid;
	private String homepage;
	private String overview;
	private String tel;
	private String infocenter;
	private String parking;
	private String usetime;
	
	
	public String getInfocenter() {
		return infocenter;
	}
	public void setInfocenter(String infocenter) {
		this.infocenter = infocenter;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}

	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getOverview() {
		return overview;
	}
	public void setOverview(String overview) {
		this.overview = overview;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMapy() {
		return mapy;
	}
	public void setMapy(String mapy) {
		this.mapy = mapy;
	}
	public String getMapx() {
		return mapx;
	}
	public void setMapx(String mapx) {
		this.mapx = mapx;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getContentid() {
		return contentid;
	}
	public void setContentid(String contentid) {
		this.contentid = contentid;
	}
	public String getContenttypeid() {
		return contenttypeid;
	}
	public void setContenttypeid(String contenttypeid) {
		this.contenttypeid = contenttypeid;
	}

	
	

	public String getUsetime() {
		return usetime;
	}
	public void setUsetime(String usetime) {
		this.usetime = usetime;
	}
	public APIDto(String address, String title, String mapy, String mapx, String img, String contentid,
			String contenttypeid, String homepage, String overview, String tel, String infocenter, String parking,
			String usetime) {
		this.address = address;
		this.title = title;
		this.mapy = mapy;
		this.mapx = mapx;
		this.img = img;
		this.contentid = contentid;
		this.contenttypeid = contenttypeid;
		this.homepage = homepage;
		this.overview = overview;
		this.tel = tel;
		this.infocenter = infocenter;
		this.parking = parking;
		this.usetime = usetime;
	}
	public APIDto(String address, String title, String mapy, String mapx, String img, String contentid,
			String contenttypeid, String homepage, String overview, String tel) {
		this.address = address;
		this.title = title;
		this.mapy = mapy;
		this.mapx = mapx;
		this.img = img;
		this.contentid = contentid;
		this.contenttypeid = contenttypeid;
		this.homepage = homepage;
		this.overview = overview;
		this.tel = tel;
	}
	public APIDto(String address, String title, String mapy, String mapx, String img, String contentid,
			String contenttypeid) {
		this.address = address;
		this.title = title;
		this.mapy = mapy;
		this.mapx = mapx;
		this.img = img;
		this.contentid = contentid;
		this.contenttypeid = contenttypeid;
	}
	public APIDto() {
	}
	@Override
	public String toString() {
		return "TestDto [address=" + address + ", title=" + title + ", mapy=" + mapy + ", mapx=" + mapx + ", img=" + img
				+ ", contentid=" + contentid + ", contenttypeid=" + contenttypeid + ", homepage=" + homepage
				+ ", overview=" + overview + ", tel=" + tel + ", infocenter=" + infocenter + ", parking=" + parking
				+ ", usetime=" + usetime + "]";
	}
	

	
}
