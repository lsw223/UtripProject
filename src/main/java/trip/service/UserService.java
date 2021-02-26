package trip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.dto.CourseDTO;
import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;
import trip.dto.QnaDTO;
import trip.dto.TripDTO;
import trip.dto.UserDTO;
import trip.mapper.UserMapper;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;
	
	public int register(UserDTO user) {
		System.out.println(user); 
		return userMapper.register(user);
	}

	public UserDTO selectById(String id) {
		return userMapper.selectById(id);
	}
	
	public int kakaoRegister(UserDTO user) {
		return userMapper.kakaoRegister(user);
	}

	public int update(UserDTO user) {
		return userMapper.update(user);
	}
	
	public List<QnaDTO> selectQnaList(String id) {
		return userMapper.selectQnaList(id);
	}
	
	public List<TripDTO> selectPopulTripList() {
		return userMapper.selectPopulTripList();
	}

	public TripDTO selectTripInfo(String tripNo) {
		return userMapper.selectTripInfo(tripNo);
	}

	public List<CourseDTO> selectCourseInfo(String tripNo) {
		return userMapper.selectCourseInfo(tripNo);
	}

	public TripDTO selectMbtiTripInfo(String mbti) {
		return userMapper.selectMbtiTripInfo(mbti);
	}

	public List<TripDTO> selectAreaList() {
		return userMapper.selectAreaList();
	}

	public List<HotelDTO> selectHotelInfo(String area_name) {
		return userMapper.selectHotelInfo(area_name);
	}
	
}
