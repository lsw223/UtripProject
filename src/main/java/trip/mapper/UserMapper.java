package trip.mapper;

import java.util.List;
import java.util.Map;

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
	public List<TripDTO> selectTripByArea(String area);
	public int getTripLike(Map<String, Object> map);
	public int tripLike(Map<String, Object> map);
	public void insertTripLike(String tripNo);
	public int tripLikeCheck(Map<String, Object> map);
	public void insertTripLikeUser(Map<String, Object> map);
	public void withdraw(String id);
}
