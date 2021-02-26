package trip.dto;

import lombok.Data;

@Data
public class ResponseDTO<T> {
	private int responseCode;
	private T responseMessage;
}
