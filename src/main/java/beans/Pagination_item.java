package beans;

import javax.servlet.http.HttpServletRequest;

//Item 리스트 페이지 네이션 모듈화

public class Pagination_item {

	// 입력
	// - 페이지번호: page
	// - 검색분류: column
	// - 검색어: keyword
	// - 데이터 개수: count
	private int page;
	private int count;
	private String column;
	private String keyword;

	//생성자
	public Pagination_item(HttpServletRequest req) {
		try {
			page = Integer.parseInt(req.getParameter("p"));

			//예외가 발생하면 catch로 이동
			if(page <= 0) throw new Exception();
		}
		catch(Exception e) {
			//예외가 발생하면 페이지를 1로 보낸다.
			page = 1;
		}
		column = req.getParameter("column");
		keyword = req.getParameter("keyword");
	}



	//페이지 크기
	private int pageSize = 10;
	//블록크기
	private int blockSize = 10;
	//데이터의 시작, 끝
	private int begin, end;
	//시작 블록, 끝 블록, 라스트 블록
	private int startBlock, finishBlock, lastBlock;

	//페이징에 필요한 계산 메소드
	public void calculateList() throws Exception {
		//count 계산
		ItemDao itemDao = new ItemDao();
		if(isSearch()) {
			count = itemDao.countLastSearch(column, keyword);
		}
		else {
			count = itemDao.countLastList();
		}

		//rownum 으로 데이터 갯수 계산
		end = page * pageSize;
		begin = end - (pageSize - 1);

		//block 계산
		startBlock = (page - 1) / blockSize * blockSize + 1;
		finishBlock = startBlock + (blockSize - 1);
		lastBlock = (count - 1) / blockSize + 1;
	}

	//블럭 사이즈와 페이지 사이즈는 변경할수 있게 setter메소드 추가
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}


	public int getPage() {
		return page;
	}

	public int getCount() {
		return count;
	}

	public String getColumn() {
		return column;
	}

	public String getKeyword() {
		return keyword;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public int getBegin() {
		return begin;
	}

	public int getEnd() {
		return end;
	}

	public int getStartBlock() {
		return startBlock;
	}

	public int getFinishBlock() {
		return finishBlock;
	}

	public int getLastBlock() {
		return lastBlock;
	}

	//이전이 존재 하는가? (페이지 네비게이터에서 사용)
	public boolean isBackPage() {
		return startBlock > 1;
	}

	//다음이 존재 하는가? (페이지 네비게이터에서 사용)
	public boolean isNextPage() {
		return finishBlock < lastBlock;
	}

	//검색인지 아닌지
	public boolean isSearch() {
		return column != null && !column.isEmpty() && keyword != null && !keyword.isEmpty();
	}

	//마지막 블록 번호 계산
	public int getEndBlock() {
		return Math.min(finishBlock, lastBlock);
	}

	// 이전을 누르면 나오는 블록 번호
	public int getBackPage() {
		return startBlock - 1;
	}

	// 다음을 누르면 나오는 블록 번호
	public int getNextPage() {
		return finishBlock + 1;
	}

	// 컬럼이 특정 값인지 검사
	public boolean columnIs(String column) {
		return column != null && column.equals(column);
	}

	//null을 제거한 keyword 반환 메소드 (검색후 검색어 유지)
	public String getKeywordString() {
		if(keyword == null)
			return "";
		else
			return keyword;
	}

	//Item list 검색 및 목록 처리
	@Override
	public String toString() {
		return "ItemPagination [page=" + page + ", count=" + count + ", column=" + column + ", keyword=" + keyword
				+ ", pageSize=" + pageSize + ", blockSize=" + blockSize + ", begin=" + begin + ", end=" + end
				+ ", startBlock=" + startBlock + ", finishBlock=" + finishBlock + ", lastBlock=" + lastBlock + "]";
	}


}
