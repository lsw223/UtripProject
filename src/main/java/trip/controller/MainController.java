package trip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import trip.dto.QnaDTO;
import trip.dto.TripDTO;
import trip.dto.UserDTO;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;

import trip.oauth.KakaoLogin;
import trip.dto.CourseDTO;
import trip.dto.HotelDTO;
import trip.service.UserService;

@Controller
public class MainController {
	private UserService userService;
	
	@Autowired	
	KakaoLogin kakaoLogin;
	
	public MainController(UserService userService) {
		this.userService = userService;
	}
		
	@RequestMapping("/")
	public String main() {
		System.out.println("성일test");
		System.out.println("강진솔 테스트2");
		System.out.println("임승환 테스트");
		System.out.println("전창웅 테스트");
		System.out.println("lsw-test");
		System.out.println("성일test2");
		return "TripMain";
	}
	
	@RequestMapping("tripMain.do")
	public String tripMain() {
		return "TripMain";
	}

	@RequestMapping("qna.do")
	public String qna(HttpServletRequest request, HttpSession session) {
		UserDTO userdto= (UserDTO) session.getAttribute("user"); 
		String id=userdto.getId();
		System.out.println(id);
		//유저 아이디를 기반으로 문의한 내용
		List<QnaDTO> list = userService.selectQnaList(id);
		System.out.println(list.toString());
		request.setAttribute("list", list);
		
		return "user/qna";
	}
	
	@RequestMapping("/tripView.do")
	public String tripView(HttpServletRequest request, HttpSession session) {
		UserDTO userdto= (UserDTO) session.getAttribute("user");
		
		//String mbti="ENTJ";
		List<TripDTO> list = userService.selectPopulTripList();
		TripDTO dto = userService.selectMbtiTripInfo(userdto.getMbti());
		List<TripDTO> areaList = userService.selectAreaList();
		request.setAttribute("list", list);
		request.setAttribute("dto", dto);
		request.setAttribute("areaList", areaList);
		return "user/tripView";
	}
	
	@RequestMapping("/tripDetailView.do")
	public String tripDetailView(HttpServletRequest request) {
		String tripNo = request.getParameter("trip_no");
		
		//여행 정보 내용
		TripDTO dto = userService.selectTripInfo(tripNo);
		//여행코스 리스트
		List<CourseDTO> list = userService.selectCourseInfo(tripNo);
		
		double x=0,y=0;
		for(int i=0; i<list.size(); i++) {
			x+=list.get(i).getPlace_x();
			y+=list.get(i).getPlace_y();
		}
		x = x/list.size();
		y = y/list.size();
		JSONArray arr = new JSONArray(list);
		request.setAttribute("tripList", list);
		request.setAttribute("list", arr.toString());
		request.setAttribute("area", dto.getArea_name());
		request.setAttribute("trip_no", tripNo);
		request.setAttribute("dto", dto);
		request.setAttribute("avgX", x);
		request.setAttribute("avgY", y);

		return "user/tripDetailView";
	}
	
	@RequestMapping("/hotelView.do")
	public String hotelView(HttpServletRequest request, String area) {
		List<HotelDTO> list = userService.selectHotelInfo(area);
		JSONArray arr = new JSONArray(list);
		double x=0,y=0;
		for(int i=0; i<list.size(); i++) {
			x+=list.get(i).getHotel_x();
			y+=list.get(i).getHotel_y();
		}
		x = x/list.size();
		y = y/list.size();
		
		request.setAttribute("list", arr.toString());
		request.setAttribute("avgX", x);
		request.setAttribute("avgY", y);
		
		return "user/hotelDetailView";
	}
	
}
