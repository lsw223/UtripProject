package trip.dto;

public class CourseDTO {
	
	private int course_no;//코스 순서
	private int place_no;//관광장소 식별자
	private String place_name;
	private double place_x; 
	private double place_y;
	public CourseDTO(int course_no, int place_no, String place_name, double place_x, double place_y) {
		super();
		this.course_no = course_no;
		this.place_no = place_no;
		this.place_name = place_name;
		this.place_x = place_x;
		this.place_y = place_y;
	}
	public int getCourse_no() {
		return course_no;
	}
	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}
	public int getPlace_no() {
		return place_no;
	}
	public void setPlace_no(int place_no) {
		this.place_no = place_no;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public double getPlace_x() {
		return place_x;
	}
	public void setPlace_x(double place_x) {
		this.place_x = place_x;
	}
	public double getPlace_y() {
		return place_y;
	}
	public void setPlace_y(double place_y) {
		this.place_y = place_y;
	}
	@Override
	public String toString() {
		return "courseDTO [course_no=" + course_no + ", place_no=" + place_no + ", place_name=" + place_name
				+ ", place_x=" + place_x + ", place_y=" + place_y + "]";
	} 
	
	
}
