package trip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public void reject(int request_no) {
		mapper.reject(request_no);
	}
	
}
