package trip.dto;

import org.apache.ibatis.type.Alias;

@Alias("comment")
public class CommentDTO {
	private int commentNo;
	private int boardNo;
	private String id;
	private String content;
	private String writeDate;

	public CommentDTO(int commentNo, int boardNo, String id, String content, String writeDate) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.id = id;
		this.content = content;
		this.writeDate = writeDate;
	}

	public CommentDTO(int boardNo, String id, String content) {
		super();
		this.boardNo = boardNo;
		this.id = id;
		this.content = content;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getid() {
		return id;
	}

	public void setid(String id) {
		this.id = id;
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

	@Override
	public String toString() {
		return "CommentDTO [commentNo=" + commentNo + ", boardNo=" + boardNo + ", id=" + id + ", content="
				+ content + ", writeDate=" + writeDate + "]";
	}

}
