package trip.dto;

public class TripDTO {
	private String area_name;
	private String trip_no;
	private String title;
	private String content;
	private String video_url;
	private double rating;
	public TripDTO(String area_name, String trip_no, String title, String content, String video_url, double rating) {
		super();
		this.area_name = area_name;
		this.trip_no = trip_no;
		this.title = title;
		this.content = content;
		this.video_url = video_url;
		this.rating = rating;
	}
	
	public TripDTO(String area_name, String trip_no, String title, String content) {
		super();
		this.area_name = area_name;
		this.trip_no = trip_no;
		this.title = title;
		this.content = content;
	}

	public String getArea_name() {
		return area_name;
	}
	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}
	public String getTrip_no() {
		return trip_no;
	}
	public void setTrip_no(String trip_no) {
		this.trip_no = trip_no;
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
	public String getVideo_url() {
		return video_url;
	}
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	@Override
	public String toString() {
		return "TripDTO [area_name=" + area_name + ", trip_no=" + trip_no + ", title=" + title + ", content=" + content
				+ ", video_url=" + video_url + ", rating=" + rating + "]";
	}
	
	
	
	
}
