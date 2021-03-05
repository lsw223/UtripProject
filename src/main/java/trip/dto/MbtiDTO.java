package trip.dto;

public class MbtiDTO {
	private int mbti_no;
	private String mbti_text;
	private String mbti_type;
	private int count;
	public MbtiDTO(int mbti_no, String mbti_text, String mbti_type) {
		super();
		this.mbti_no = mbti_no;
		this.mbti_text = mbti_text;
		this.mbti_type = mbti_type;
	}
	
	public MbtiDTO(String mbti_type, int count) {
		super();
		this.mbti_type = mbti_type;
		this.count = count;
	}

	public int getMbti_no() {
		return mbti_no;
	}
	public void setMbti_no(int mbti_no) {
		this.mbti_no = mbti_no;
	}
	public String getMbti_text() {
		return mbti_text;
	}
	public void setMbti_text(String mbti_text) {
		this.mbti_text = mbti_text;
	}
	public String getMbti_type() {
		return mbti_type;
	}
	public void setMbti_type(String mbti_type) {
		this.mbti_type = mbti_type;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "MbtiDTO [mbti_no=" + mbti_no + ", mbti_text=" + mbti_text + ", mbti_type=" + mbti_type + ", count="
				+ count + "]";
	}
	
	
}
