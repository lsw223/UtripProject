package trip.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.dto.CourseDTO;
import trip.dto.FileDTO;
import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;
import trip.dto.MbtiDTO;
import trip.dto.NoticeCommentDTO;
import trip.dto.NoticeDTO;
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
	public List<NoticeDTO> selectNoticeList(int page) {
		return userMapper.selectNoticeList(page);
	}

	public int selectnoticeCount() {
		return userMapper.selectnoticeCount();
	}

	public NoticeDTO selectNotice(int notice_no) {
		return userMapper.selectNotice(notice_no);
	}

	public List<FileDTO> selectFileList(int notice_no) {
		return userMapper.selectFileList(notice_no);
	}

	public int addNoticeLikeHate(int mode, int notice_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mode", mode);
		map.put("notice_no", notice_no);
		userMapper.addNoticeLikeHate(map);
		NoticeDTO dto = userMapper.selectNotice(notice_no);
		if(mode == 0)
			return dto.getNlike();
		else
			return dto.getNhate();
	}

	public int insertNoticeComment(NoticeCommentDTO dto) {
		return userMapper.insertNoticeComment(dto); 
		
	}

	public void addnoticeCount(int notice_no) {
		userMapper.addnoticeCount(notice_no);
		
	}

	public List<NoticeCommentDTO> selectNoticeComment(int notice_no) {
		return userMapper.selectNoticeComment(notice_no);
	}

	public int updatenoticeCommentLike(int comment_no) {
		return userMapper.updatenoticeCommentLike(comment_no);
		
	}

	public int updatenoticeCommentHate(int comment_no) {
		return userMapper.updatenoticeCommentHate(comment_no);
	}

	public double assessment(int score, String trip_no, String user_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("score",score);
		map.put("trip_no", trip_no);
		int count = userMapper.assessment(map);
		if(count == 0) {
			userMapper.insertTripRating(trip_no);
			userMapper.assessment(map);
		}
		double rating = userMapper.getRating(trip_no);
		rating = Math.round(rating*10.0)/10.0;
		map.put("rating",rating);
		userMapper.updateTripRating(map);
		map.put("user_id", user_id);
		userMapper.insertTripRatingUser(map);
		return rating;
	}
	
	// 해당 trip 에 별점을 이미 매긴 유저인지 체크
	public int tripRatingCheck(String user_id, String trip_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("trip_no", trip_no);
		return userMapper.tripRatingCheck(map);
	}
	public int nextnotice(int notice_no) {
		return userMapper.nextnotice(notice_no);
	}

	public List<MbtiDTO> getMbtiList() {
		return userMapper.getMbtiList();
	}

	public List<String> getMbtiType() {
		return userMapper.getMbtiType();
	}

	public int getCount() {
		return userMapper.getCount();
	}
	
}