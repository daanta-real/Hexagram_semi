package beans;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public class Pagination_users<DAO extends PaginationInterface<DTO>, DTO> {



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 1. Declarations
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 1) 필수 데이터
	private int page; // 현재 페이지
	private int count; // DB 상의 전체 데이터 수 (혹은 검색결과수)

	// 2) 선택 데이터
	private String column;
	private String keyword;
	private int searchSelector;//한jsp에 보여줄 화면을 선택할때 사용한다 현재 리스트 조회구문과 인서트 검색에서 사용중(구분자)

	// 2) 페이징 관련 데이터
	private int pageSize; // 페이지당 글 개수
	private int blockSize; // 블록 당 페이지 수
	private int begin, end; // 페이지 첫 글번호, 페이지 끝 글번호
	private int startBlock, finishBlock, lastBlock; // 시작 블록, 목록 상 마지막 블록, DB상 마지막 블록

	// 3) 검색 관련 변수 및 DAO, DTO들
	private DAO dao; // 검색에 이용할 DAO
	private List<DTO> resultList = new ArrayList<>(); // 검색 결과 목록을 담을 DTO List



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 2. Constructors
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// - req의 역할: page, column, keyword 매개변수 빼먹는 용도로만 사용된다. 이후 안 쓴다(버려짐)
	// - dao의 역할: 계속해서 쓴다.
	// - req/DAO는 필수지만, DTO/pageSize/blockSize는 선택사항이다.

	public Pagination_users(HttpServletRequest req, DAO dao) { this(req, dao, 10, 10); }
	public Pagination_users(HttpServletRequest req, DAO dao, int pageSize, int blockSize) {

		// 1. page 결정
		try {
			this.page = Integer.parseInt(req.getParameter("page"));
			if(this.page <= 0) throw new Exception();
		}
		catch(Exception e) {
			this.page = 1;
		}

		// 2. 기타 필드 결정
		this.column = req.getParameter("column");
		this.keyword = req.getParameter("keyword");
		this.dao = dao;
		this.pageSize = pageSize;
		this.blockSize = blockSize;
		
	    try{
	    	this.searchSelector = Integer.parseInt(req.getParameter("searchSelector"));
	    	if(this.searchSelector<0 || this.searchSelector>1) throw new Exception();//한jsp에 보여줄 화면을 선택할때 사용한다 현재 리스트 조회구문과 인서트 검색에서 사용중
	    }catch(Exception e){
	    	this.searchSelector = 0;
	    }

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
	public List<DTO> getResultList() { return resultList; }
	public int getSearchSelector() {return searchSelector;}
	
	// 2) 특수 Getters
	// keyword 값이 null일 경우 ""로 바꿔줌
	public String getKeywordString() { return keyword == null ? "" : keyword; }
	// 진짜 마지막 블록 번호 계산
	public int getRealLastBlock() { return Math.min(finishBlock, lastBlock); }
	// 이전을 누르면 나오는 블록 번호
	public int getPreviousBlock() { return startBlock - 1; }
	// 다음을 누르면 나오는 블록 번호
	public int getNextBlock() { return finishBlock + 1; }



	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 3. Setters
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	
	public void setPageSize(int pageSize) { this.pageSize = pageSize; }
	public void setBlockSize(int blockSize) { this.blockSize = blockSize; }
	public void setResultList(List<DTO> resultList) { this.resultList = resultList; }
	public void setCount(int count) {this.count = count;}


	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 4. Checkers
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// 이전이 존재하나요?
	public boolean hasPreviousBlock() { return startBlock > 1; }
	// 다음이 존재하나요?
	public boolean hasNextBlock() { return finishBlock < lastBlock;	}
	// 회원목록 검색모드 인가요?
	public boolean isSearchMode() {
		return column  != null && !column.equals("")
		    && keyword != null && !keyword.equals("");
	}
	// 컬럼에 특정한 값이 존재하고 있는지 검사
	public boolean columnValExists(String column) {
		return this.column != null && this.column.equals(column);
	}
	// 키워드에 특정한 값이 존재하고 있는지 검사
	public boolean keywordValExists(String keyword) {
		return this.keyword != null && this.keyword.equals(keyword);
	}


	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	// 5. Methods
	// ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈

	// UsersList 계산 메소드
	public void calculate() throws Exception {

		// 1. 출력할 rownum 범위 계산
		end   = page * pageSize;      // 페이지의 마지막 rownum
		begin = end - (pageSize - 1); // 페이지의 첫    rownum

		// 2. 검색 모드 해당여부에 따라 resultList, count 구하기
		if(isSearchMode()) {
			System.out.println("검색 모드: " + column + "=" + keyword + " (" + begin + "~" + end + ")");
			this.resultList = dao.search(column, keyword, begin, end);
			this.count = dao.count(column, keyword);
		}
		else {
			System.out.println("전체목록 모드");
			this.resultList = dao.list(begin, end);
			this.count = dao.count();
		}

		// 3. 하단 각 페이지 바로가기 버튼 출력범위 계산 (= block 계산)
		startBlock  = (page - 1) / blockSize * blockSize + 1; // 출력할 가장 첫 페이지 번호 (연속형 출력X blockSize단위로 끊어 출력O)
		finishBlock = startBlock + (blockSize - 1);           // 이론 상 표시 가능한 가장 마지막 페이지 번호
		lastBlock   = (count - 1) / pageSize + 1;             // 실제로 출력되는 가장 마지막 페이지 번호

	}

	@Override
	public String toString() {
		return "Pagination_users [page=" + page + ", count=" + count + ", column=" + column + ", keyword=" + keyword
				+ ", pageSize=" + pageSize + ", blockSize=" + blockSize + ", begin=" + begin + ", end=" + end
				+ ", startBlock=" + startBlock + ", finishBlock=" + finishBlock + ", lastBlock=" + lastBlock + ", dao="
				+ dao + ", 검색모드?=" + isSearchMode() + ", resultList개수=" + resultList.size() + "]";
	}

}