package beans;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Pagination_users {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. Declarations
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 1) 필수 데이터
	private int page; // 현재 페이지
	private int count; // DB 상의 전체 데이터 수 (혹은 검색결과수)

	// 2) 선택 데이터
	private String column; // 검색할 대상 컬럼명
	private String keyword; // 검색할 키워드

	// 3) 페이징 관련 데이터
	private int pageSize = 10; // 페이지당 글 개수
	private int blockSize = 10; // 블록 당 페이지 수
	private int begin, end; // 페이지 첫 글번호, 페이지 끝 글번호
	private int startBlock, finishBlock, lastBlock; // 시작 블록, 목록 상 마지막 블록, DB상 마지막 블록
	private List<UsersDto> usersList; // 실제 출력되는 Data



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. Constructors
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 생성자를 이용하여 필수 데이터를 설정하도록 구현
	// HttpServletRequest req 에 page, column, keyword 있음
	public Pagination_users(HttpServletRequest req) {
		try {
			page = Integer.parseInt(req.getParameter("page"));
			if(page <= 0) throw new Exception();
		}
		catch(Exception e) {
			page = 1;
		}
		column = req.getParameter("column");
		keyword = req.getParameter("keyword");
	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. Getters
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 1) 일반 Getters
	public int getPage() { return page; }
	public int getCount() { return count; }
	public String getColumn() { return column; }
	public String getKeyword() { return keyword; }
	public int getPageSize() { return pageSize; }
	public int getBlockSize() { return blockSize; }
	public int getBegin() { return begin; }
	public int getEnd() { return end; }
	public int getStartBlock() { return startBlock; }
	public int getFinishBlock() { return finishBlock; }
	public int getLastBlock() { return lastBlock; }

	// 2) 특수 Getters
	// keyword 값이 null일 경우 ""로 바꿔줌
	public String getKeywordString() { return keyword == null ? "" : keyword; }
	// 진짜 마지막 블록 번호 계산
	public int getRealLastBlock() { return Math.min(finishBlock, lastBlock); }
	// 이전을 누르면 나오는 블록 번호
	public int getPreviousBlock() { return startBlock - 1; }
	// 다음을 누르면 나오는 블록 번호
	public int getNextBlock() { return finishBlock + 1; }
	public List<UsersDto> getUsersList() { return usersList; }



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. Setters
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	public void setPageSize(int pageSize) { this.pageSize = pageSize; }
	public void setBlockSize(int blockSize) { this.blockSize = blockSize; }




	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 4. Checkers
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 이전이 존재하나요?
	public boolean isPreviousAvailable() { return startBlock > 1; }
	// 다음이 존재하나요?
	public boolean isNextAvailable() { return finishBlock < lastBlock;	}
	// 회원목록 검색모드 인가요?
	public boolean isSearchMode() {
		return column  != null && !column.equals("")
		    && keyword != null && !keyword.equals("");
	}
	// 컬럼에 특정한 값이 존재하고 있는지 검사
	public boolean columnValExists(String column) {
		String thisColumnValue = this.column;
		return thisColumnValue != null && !thisColumnValue.equals("");
	}



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 5. Methods
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// UsersList 계산 메소드
	public void calculate() throws Exception{

		// 1. 전체 결과 수 계산
		UsersDao usersDao = new UsersDao();
		count = isSearchMode()
			? usersDao.count(column, keyword)
			: usersDao.count();

		// 2. 첫 rownum계산
		end   = page * pageSize;
		begin = end - (pageSize - 1);

		//block계산
		lastBlock   = (count - 1) / pageSize + 1;
		startBlock  = (page - 1) / blockSize * blockSize + 1;
		finishBlock = startBlock + (blockSize - 1);

		//UsersList계산
		usersList = isSearchMode()
			? usersDao.searchRownum(column, keyword, begin, end)
			: usersDao.listRownum(begin, end);

	}

	@Override
	public String toString() {
		return "Pagination [page=" + page + ", count=" + count + ", column=" + column + ", keyword=" + keyword + ", pageSize="
			+ pageSize + ", blockSize=" + blockSize + ", begin=" + begin + ", end=" + end + ", startBlock="
			+ startBlock + ", finishBlock=" + finishBlock + ", lastBlock=" + lastBlock + "]";
	}

}











