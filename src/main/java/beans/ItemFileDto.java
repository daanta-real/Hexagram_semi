package beans;

public class ItemFileDto {
	 
	private int itemFileIdx;
	private int itemIdx;
	private String itemFileUploadname;
	private String itemFileSaveName;
	private long itemFileSize;
	private String itemFileType;
	
	public ItemFileDto() {
		super();
	}

	public int getItemFileIdx() {
		return itemFileIdx;
	}

	public void setItemFileIdx(int itemFileIdx) {
		this.itemFileIdx = itemFileIdx;
	}

	public int getItemIdx() {
		return itemIdx;
	}

	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}

	public String getItemFileUploadname() {
		return itemFileUploadname;
	}

	public void setItemFileUploadname(String itemFileUploadname) {
		this.itemFileUploadname = itemFileUploadname;
	}

	public String getItemFileSaveName() {
		return itemFileSaveName;
	}

	public void setItemFileSaveName(String itemFileSaveName) {
		this.itemFileSaveName = itemFileSaveName;
	}

	public long getItemFileSize() {
		return itemFileSize;
	}

	public void setItemFileSize(long itemFileSize) {
		this.itemFileSize = itemFileSize;
	}

	public String getItemFileType() {
		return itemFileType;
	}

	public void setItemFileType(String itemFileType) {
		this.itemFileType = itemFileType;
	}

	
	
}
