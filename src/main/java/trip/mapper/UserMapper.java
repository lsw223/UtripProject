package trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.CourseDTO;
import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;
import trip.dto.QnaDTO;
import trip.dto.TripDTO;
import trip.dto.UserDTO;

@Mapper
public interface UserMapper {
	public int register(UserDTO user);
	public UserDTO selectById(String id);
	public int kakaoRegister(UserDTO user);
	public int update(UserDTO user);
	List<QnaDTO> selectQnaList(String id);
	List<TripDTO> selectPopulTripList();
	TripDTO selectTripInfo(String tripNo);
	List<CourseDTO> selectCourseInfo(String tripNo);
	TripDTO selectMbtiTripInfo(String mbti);
	public List<TripDTO> selectAreaList();
	public List<HotelDTO> selectHotelInfo(String area_name);
}
