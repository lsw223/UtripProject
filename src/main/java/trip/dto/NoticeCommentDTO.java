package trip.dto;

import org.apache.ibatis.type.Alias;

@Alias("noticecomment")
public class NoticeCommentDTO {
	private int comment_no;
	private int notice_no;
	private String writer;
	private String content;
	private String write_date;
	private int clike;
	private int chate;
	public NoticeCommentDTO(int comment_no, int notice_no, String writer, String content, String write_date, int clike,
			int chate) {
		super();
		this.comment_no = comment_no;
		this.notice_no = notice_no;
		this.writer = writer;
		this.content = content;
		this.write_date = write_date;
		this.clike = clike;
		this.chate = chate;
	}
	
	public NoticeCommentDTO(int notice_no, String writer, String content, String write_date) {
		super();
		this.notice_no = notice_no;
		this.writer = writer;
		this.content = content;
		this.write_date = write_date;
	}

	public NoticeCommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getComment_no() {
		return comment_no;
	}
	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwrite_date() {
		return write_date;
	}
	public void setwrite_date(String write_date) {
		this.write_date = write_date;
	}
	public int getClike() {
		return clike;
	}
	public void setClike(int clike) {
		this.clike = clike;
	}
	public int getChate() {
		return chate;
	}
	public void setChate(int chate) {
		this.chate = chate;
	}
	@Override
	public String toString() {
		return "NoticeCommentDTO [comment_no=" + comment_no + ", notice_no=" + notice_no + ", writer=" + writer
				+ ", content=" + content + ", write_date=" + write_date + ", clike=" + clike + ", chate=" + chate + "]";
	}
	
}