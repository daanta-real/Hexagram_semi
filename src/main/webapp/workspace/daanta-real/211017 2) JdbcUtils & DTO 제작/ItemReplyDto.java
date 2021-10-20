
public class itemReplyDto {

	// 1. 선언
	private int    idx      ;
	private int    itemIdx  ;
	private int    usersIdx ;
	private int    targetIdx;
	private String deatil   ;

	// 2. 생성자
	public itemReplyDto() { super(); }
	public itemReplyDto(int idx ,        int itemIdx ,         int usersIdx ,          int targetIdx ,    String deatil) {
		super();     setIdx(idx); setItemIdx(itemIdx); setUsersIdx(usersIdx); setTargetIdx(targetIdx); setDeatil(deatil);
	}

	// 3. Getters/Setters
	public int    getIdx      () { return idx      ; }
	public int    getItemIdx  () { return itemIdx  ; }
	public int    getUsersIdx () { return usersIdx ; }
	public int    getTargetIdx() { return targetIdx; }
	public String getDeatil   () { return deatil   ; }
	public void   setIdx      (int    idx      ) { this.idx       = idx      ; }
	public void   setItemIdx  (int    itemIdx  ) { this.itemIdx   = itemIdx  ; }
	public void   setUsersIdx (int    usersIdx ) { this.usersIdx  = usersIdx ; }
	public void   setTargetIdx(int    targetIdx) { this.targetIdx = targetIdx; }
	public void   setDeatil   (String deatil   ) { this.deatil    = deatil   ; }

	// 4. 메소드 - 오버라이드
	@Override
	public String toString() {
		return "itemReplyDto [idx=" + idx + ", itemIdx=" + itemIdx + ", usersIdx=" + usersIdx + ", targetIdx=" + targetIdx + ", deatil=" + deatil + "]";
	}

}