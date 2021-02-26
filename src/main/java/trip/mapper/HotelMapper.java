package trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;

@Mapper
public interface HotelMapper {

	int insert(HotelRequestDTO hotelRequestDto);
	List<HotelRequestDTO> selectById(String id);
	List<HotelRequestDTO> selectAllRequest();
	void reject(int request_no);
	int getNextNo(String area);
	int insertHotel(HotelDTO hotel);
	void permit(int request_no);
}
