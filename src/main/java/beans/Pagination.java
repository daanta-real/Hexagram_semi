package beans;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Pagination {
	//필수 데이터
	private int page;		
	private int count;
	//선택 데이터
	private String column;
	private String keyword;
	
	//생성자를 이용하여 필수 데이터를 설정하도록 구현
	//HttpServletRequest req 에 page, column, keyword 있음
	public Pagination(HttpServletRequest req) {
		try {
			this.page = Integer.parseInt(req.getParameter("page"));			
			if(this.page <= 0) throw new Exception();
		}
		catch(Exception e) {
			this.page = 1;
		}
		this.column = req.getParameter("column");
		this.keyword = req.getParameter("keyword");
	}
	
	//페이지크기 10, 블록크기 10
	private int pageSize = 10;
	private int blockSize = 10;
	private int begin, end;
	private int startBlock, finishBlock, lastBlock;
	private List<UsersDto> usersList;
	
	//getter
	public int getPage() 			{	return page;			}
	public int getCount() 			{	return count;		}
	public String getColumn() 		{	return column;	}
	public String getKeyword()	{	return keyword;	}
	public int getPageSize() 		{	return pageSize;	}
	public int getBlockSize() 		{	return blockSize;	}
	public int getBegin() 			{	return begin;		}
	public int getEnd() 				{	return end;		}
	public int getStartBlock() 		{	return startBlock;}
	public int getFinishBlock() 	{	return finishBlock;}
	public int getLastBlock() 		{	return lastBlock;	}
	public List<UsersDto> getUsersList() {		return usersList;		}
	
	//UsersList 계산 메소드
	public void usersCalculater() throws Exception{	
		//회원 count 계산
		UsersDao usersDao = new UsersDao();
		if(searchUsers()) this.count = usersDao.count(column, keyword);
		else 				    this.count = usersDao.count();
		
		//rownum계산
		this.end   = this.page * this.pageSize;
		this.begin = this.end-(this.pageSize-1);
		
		//block계산
		this.lastBlock  = (this.count -1) / this.pageSize + 1;
		this.startBlock = (this.page-1) / this.blockSize * this.blockSize + 1;
		this.finishBlock = 	this.startBlock + (this.blockSize - 1);		
		
		//UsersList계산
		if(this.searchUsers()) {	this.usersList = usersDao.searchRownum(column, keyword, begin, end);}
		else						  {	this.usersList = usersDao.listRownum(begin, end);}
	}
	
	//추가 : 이전이 존재하나요?
	public boolean isPreviousAvailable() 
	{	return this.startBlock > 1;	}
	
	//추가 : 다음이 존재하나요?
	public boolean isNextAvailable()	  
	{	return this.finishBlock < lastBlock;	}
	
	//추가 : 회원목록 검색모드 인가요?
	public boolean searchUsers() {
		return this.column != null && !this.column.equals("")
		&&this.keyword != null && !this.keyword.equals("");
	}
	
	//추가 : 진짜 마지막 블록 번호 계산
	public int getRealLastBlock() 
	{	return Math.min(this.finishBlock, this.lastBlock);	}

	//추가 : 이전을 누르면 나오는 블록 번호
	public int getPreviousBlock() 
	{	return this.startBlock-1;	}
	
	//추가 : 다음을 누르면 나오는 블록 번호
	public int getNextBlock() 		
	{	return this.finishBlock+1;	}
	
	//추가 : 컬럼이 특정 값인지 검사
	public boolean columnIs(String column) 
	{	return this.column != null && !this.column.equals("");	}
	
	//추가 : null을 제거한 키워드 반환 메소드
	public String getKeywordString() {
		if(this.keyword == null) return "";
		else return this.keyword;
	}
	public void setPageSize(int pageSize) {	this.pageSize = pageSize;		}
	public void setBlockSize(int blockSize) {	this.blockSize = blockSize;		}
	
	
	@Override
	public String toString() {
		return "Pagination [page=" + page + ", count=" + count + ", column=" + column + ", keyword=" + keyword + ", pageSize="
				+ pageSize + ", blockSize=" + blockSize + ", begin=" + begin + ", end=" + end + ", startBlock="
				+ startBlock + ", finishBlock=" + finishBlock + ", lastBlock=" + lastBlock + "]";
	}

	
	
}











