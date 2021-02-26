package trip.dto;

public class NoticeDTO {
	private int num;
	private int notice_no;
	private String title;
	private String nwriter;
	private String content;
	private String write_date;

	public NoticeDTO(int notice_no, String title, String nwriter, String content, String write_date) {
		super();
		this.notice_no = notice_no;
		this.title = title;
		this.nwriter = nwriter;
		this.content = content;
		this.write_date = write_date;
	}
	
	public NoticeDTO(int notice_no, String title, String nwriter, String write_date) {
		super();
		this.notice_no = notice_no;
		this.title = title;
		this.nwriter = nwriter;
		this.write_date = write_date;
	}
	

	public NoticeDTO(int notice_no, String title, String content) {
		super();
		this.notice_no = notice_no;
		this.title = title;
		this.content = content;
	}

	public NoticeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNwriter() {
		return nwriter;
	}
	public void setNwriter(String nwriter) {
		this.nwriter = nwriter;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	@Override
	public String toString() {
		return "NoticeDTO [notice_no=" + notice_no + ", title=" + title + ", nwriter=" + nwriter + ", content="
				+ content + ", wreite_date=" + write_date + "]";
	}
	
	
}