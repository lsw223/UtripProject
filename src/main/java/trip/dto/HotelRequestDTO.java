package trip.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Alias("hotelRequest")
public class HotelRequestDTO {
	private int request_no;
	private String user_id;
	private String hotel_name;
	private String address; 
	private String area;
	private String status;
	private String request_date;
	private String hotel_url;
}
