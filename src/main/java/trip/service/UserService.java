package trip.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public List<TripDTO> selectTripByArea(String area) {
		return userMapper.selectTripByArea(area);
	}

	public int getTripLike(String tripNo, String mbti) {
		Map<String, Object> map = new HashMap<>();
		map.put("tripNo", tripNo);
		map.put("mbti", mbti);
		return userMapper.getTripLike(map);
	}

	public int tripLike(String tripNo, String mbti, String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tripNo", tripNo);
		map.put("mbti", mbti);
		map.put("userId", userId);
		userMapper.insertTripLikeUser(map);
		return userMapper.tripLike(map);
	}

	public void insertTripLike(String tripNo) {
		userMapper.insertTripLike(tripNo);
	}

	public int tripLikeCheck(String tripNo, String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tripNo", tripNo);
		map.put("userId", userId);
		return userMapper.tripLikeCheck(map);
	}

	public void withdraw(String id) {
		userMapper.withdraw(id);
	}
	
}
