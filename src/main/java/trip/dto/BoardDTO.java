package trip.dto;

import org.apache.ibatis.type.Alias;

@Alias("board")
public class BoardDTO {
	private int boardNo;
	private String id;
	private String title;
	private String content;
	private String writeDate;
	private int boardLike;
	private int boardCount;
	private int commentCount;
	private int prevNum; //이전글의 글번호를 담을 필드
	private int nextNum; //다음글의 글번호를 담을 필드
		

	public BoardDTO(int boardNo, String id, String title, String content, String writeDate, int boardLike,
			int boardCount, int commentCount, int prevNum, int nextNum) {
		super();
		this.boardNo = boardNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.boardLike = boardLike;
		this.boardCount = boardCount;
		this.commentCount = commentCount;
		this.prevNum = prevNum;
		this.nextNum = nextNum;
	}



	public BoardDTO(int boardNo, String id, String title, String content, String writeDate, int boardLike,
			int boardCount, int commentCount) {
		super();
		this.boardNo = boardNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.boardLike = boardLike;
		this.boardCount = boardCount;
		this.commentCount = commentCount;
	}
	
	

	public BoardDTO(int boardNo, String id, String title, String content, String writeDate, int boardLike,
			int boardCount) {
		super();
		this.boardNo = boardNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.boardLike = boardLike;
		this.boardCount = boardCount;
	}



	public BoardDTO(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public BoardDTO(int boardNo, String id, String title, String content) {
		super();
		this.boardNo = boardNo;
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public int getBoardLike() {
		return boardLike;
	}

	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getBoardCount() {
		return boardCount;
	}

	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}

	public int getPrevNum() {
		return prevNum;
	}

	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}

	public int getNextNum() {
		return nextNum;
	}

	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}

	@Override
	public String toString() {
		return "BoardDTO [boardNo=" + boardNo + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", writeDate=" + writeDate + ", boardLike=" + boardLike + ", boardCount=" + boardCount
				+ ", commentCount=" + commentCount + "]";
	}
	

	
}
