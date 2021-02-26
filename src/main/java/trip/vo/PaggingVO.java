package trip.vo;
/*
 * 현재 사용자가 조회하고 있는 페이지 정보
 * 현재 페이지 번호,
 * 전체 글 개수,
 * 한페이지당 출력할 글목록 개수
 * 게시판 하단에 나타낼 페이지 번호 개수
 */
public class PaggingVO {
	//전체 게시글 개수
	private int count;
	//한페이지당 출력할 게시글(글목록) 개수
	private final int pageOfContentCount = 7;
	//게시판 하단에 나타낼 페이지 번호 개수
	private final int pageGroupOfCount = 4;
	//현재 페이지 번호
	private int currentPage;
	
	public PaggingVO(int count, int currentPage) {
		super();
		this.count = count;
		this.currentPage = currentPage;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	
	//총 페이지 개수를 return
	//전체 게시글 / 한페이지에 보여줄 글번호 --> 나머지가 0일때
	//전체 게시글 / 한페이지에 보여줄 글번호+ 1  --> 나머지가 0이 아닐때
	public int getTotalPage() {
		int totalPage = count / pageOfContentCount;
		if(count % pageOfContentCount != 0) {
			totalPage++;
		}
		return totalPage;
	}
	/**
	 * 총 페이지 그룹 수 : 4<br>
	 * 페이지 번호 1 2 3 4 5 6 7 8 9 10 11 12 13<br>
	 * 1그룹 : 1 2 3 4<br>
	 * 2그룹 : 5 6 7 8<br>
	 * 3그룹 : 9 10 11 12<br>
	 * 4그룹 : 13<br>
	 * @return 총 페이지 그룹 개수
	 */
	public int getTotalPageGroup() {
		int result = getTotalPage() / pageGroupOfCount; 
		if(getTotalPage()%pageGroupOfCount != 0)
			result++;
		return result;
	}
	/**
	 * 현재 페이지의 그룹 번호
	 * 페이지 번호 1 2 3 4 5 6 7 8 9 10 11 12 13<br>
	 * 1그룹 : 1 2 3 4<br>
	 * 2그룹 : 5 6 7 8<br>
	 * 3그룹 : 9 10 11 12<br>
	 * 4그룹 : 13<br>
	 */
	public int getNowPageGroupNo() {
		int result = currentPage / pageGroupOfCount;
		if(currentPage % pageGroupOfCount != 0)
			result++;		
		return result;
	}
	/**
	 *현재 페이지 그룹의 시작 페이지 번호
	 * 페이지 번호 1 2 3 4 5 6 7 8 9 10 11 12 13<br>
	 * 1그룹 : <b>1</b> 2 3 4<br>
	 * 2그룹 : <b>5</b> 6 7 8<br>
	 * 3그룹 : <b>9</b> 10 11 12<br>
	 * 4그룹 : <b>13</b><br>
	 */
	public int getStartPageOfPageGroup() {
		return pageGroupOfCount * (getNowPageGroupNo()-1)+1;		
	}
	/**
	 *현재 페이지 그룹의 마지막 페이지 번호
	 * 페이지 번호 1 2 3 4 5 6 7 8 9 10 11 12 13<br>
	 * 1그룹 : 1 2 3 <b>4</b><br>
	 * 2그룹 : 5 6 7 <b>8</b><br>
	 * 3그룹 : 9 10 11 <b>12</b><br>
	 * 4그룹 : <b>13</b><br>
	 */
	public int getEndPageOfPageGroup() {
		int result = pageGroupOfCount * getNowPageGroupNo();
		if(getTotalPage() < result) 
			result = getTotalPage();//전체 페이지 개수는 마지막 페이지 번호봐도됨
		return result;		
	}
	/**
	 * 이전 페이지 그룹이 있는지 체크
	 * << 의 (이전 페이지 그룹으로 이동하기 위한)출력 여부를 위한 메서드
	 */
	public boolean isPreviousPageGroup() {
		return getNowPageGroupNo() > 1;
	}
	
	/** 
	 * 다음 페이지 그룹이 있는지 체크
	 * >> 의 출력 여부를 위한 메서드
	 */
	public boolean isNextPageGroup() {
		return getNowPageGroupNo() < getTotalPageGroup();
	}

	@Override
	public String toString() {
		return "PaggingVO [count=" + count + ", pageOfContentCount=" + pageOfContentCount + ", pageGroupOfCount="
				+ pageGroupOfCount + ", currentPage=" + currentPage + ", getCurrentPage()=" + getCurrentPage()
				+ ", getTotalPage()=" + getTotalPage() + ", getTotalPageGroup()=" + getTotalPageGroup()
				+ ", getNowPageGroupNo()=" + getNowPageGroupNo() + ", getStartPageOfPageGroup()="
				+ getStartPageOfPageGroup() + ", getEndPageOfPageGroup()=" + getEndPageOfPageGroup()
				+ ", isPreviousPageGroup()=" + isPreviousPageGroup() + ", isNextPageGroup()=" + isNextPageGroup() + "]";
	}
	
	
	
}
