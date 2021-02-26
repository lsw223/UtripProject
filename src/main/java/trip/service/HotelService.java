package trip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;
import trip.mapper.HotelMapper;

@Service
public class HotelService {
	
	@Autowired
	private HotelMapper mapper;

	public int insert(HotelRequestDTO hotelRequestDto) {
		return mapper.insert(hotelRequestDto);
	}

	public List<HotelRequestDTO> selectById(String id) {
		return mapper.selectById(id);
	}

	public List<HotelRequestDTO> selectAllRequest() {
		return mapper.selectAllRequest();
	}
	
	//hotel_request 반려(거절)
	public void reject(int request_no) {
		mapper.reject(request_no);
	}
	
	//hotel_request 승인시 호텔 정보 insert
	public int insertHotel(HotelDTO hotel, String area) {
		int no = 0;
		try {
			no = mapper.getNextNo(area);
		}catch (Exception e) {}
		no++;
		String _no = Integer.toString(no);
		if(_no.length()==1)
			_no = "0"+_no;
		hotel.setHotel_no(area+_no);
		return mapper.insertHotel(hotel);
	}
	//hotel_request 승인
	public void permit(int request_no) {
		mapper.permit(request_no);
	}
	
}
