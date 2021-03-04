package trip.dto;

public class QnaDTO {
	private int qna_no;
	private String user_id;
	private String title;
	private String content;
	private String write_date;
	private String response_content;
	private String response_date;
	
	public QnaDTO() {
		
	}
	
	public QnaDTO(String user_id, String title, String content) {
		super();
		this.user_id = user_id;
		this.title = title;
		this.content = content;
	}

	public QnaDTO(int qna_no, String user_id, String title, String content, String write_date, String response_content,
			String response_date) {
		super();
		this.qna_no = qna_no;
		this.user_id = user_id;
		this.title = title;
		this.content = content;
		this.write_date = write_date;
		this.response_content = response_content;
		this.response_date = response_date;
	}
	
	public QnaDTO(int qna_no, String user_id, String title, String content) {
		super();
		this.qna_no = qna_no;
		this.user_id = user_id;
		this.title = title;
		this.content = content;
	}
	
	public QnaDTO(String title, String content) {
		super();
		this.title = title;
		this.content = content;
	}
	

	public QnaDTO(int qna_no, String response_content) {
		super();
		this.qna_no = qna_no;
		this.response_content = response_content;
	}

	public int getqna_no() {
		return qna_no;
	}

	public void setqna_no(int qna_no) {
		this.qna_no = qna_no;
	}

	public String getuser_id() {
		return user_id;
	}

	public void setuser_id(String user_id) {
		this.user_id = user_id;
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

	public String getwrite_date() {
		return write_date;
	}

	public void setwrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getresponse_content() {
		return response_content;
	}

	public void setresponse_content(String response_content) {
		this.response_content = response_content;
	}

	public String getresponse_date() {
		return response_date;
	}

	public void setresponse_date(String response_date) {
		this.response_date = response_date;
	}
	@Override
	public String toString() {
		return "QnaDTO [qna_no=" + qna_no + ", user_id=" + user_id + ", title=" + title + ", content=" + content
				+ "]";
	}

	
	
}
