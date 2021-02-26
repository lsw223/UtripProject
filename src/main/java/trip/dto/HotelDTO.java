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
@Alias("hotel")
public class HotelDTO {
	private String hotel_no;
	private String hotel_name;
	private double hotel_x;
	private double hotel_y;
	private String hotel_url;
}
