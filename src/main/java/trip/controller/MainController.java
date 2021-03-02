package trip.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import trip.dto.QnaDTO;
import trip.dto.ResponseDTO;
import trip.dto.TripDTO;
import trip.dto.UserDTO;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import trip.oauth.KakaoLogin;
import trip.dto.CourseDTO;
import trip.dto.HotelDTO;
import trip.dto.HotelRequestDTO;
import trip.service.AdminService;
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
	public String TripView(HttpServletRequest request, HttpSession session) {
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
	public String tripView(HttpServletRequest request) {
		String tripNo = request.getParameter("trip_no");
		TripDTO dto = userService.selectTripInfo(tripNo);
		List<CourseDTO> list = userService.selectCourseInfo(tripNo);
		
		double x=0,y=0;
		for(int i=0; i<list.size(); i++) {
			x+=list.get(i).getPlace_x();
			y+=list.get(i).getPlace_y();
		}
		x = x/list.size();
		y = y/list.size();
		JSONArray arr = new JSONArray(list);
		
		request.setAttribute("list", arr.toString());
		request.setAttribute("area", dto.getArea_name());
		
		request.setAttribute("dto", dto);
		request.setAttribute("avgX", x);
		request.setAttribute("avgY", y);

		// 로그인 된 상태일경우 해당 trip, 해당 유저mbti유형의 좋아요 갯수를 session에 포함시킨다
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) {
			UserDTO user = (UserDTO)session.getAttribute("user");
			int tripLike = 0;
			try {
				tripLike = userService.getTripLike(tripNo,user.getMbti());
			} catch (Exception e) {
				userService.insertTripLike(tripNo);
			}
			request.setAttribute("tripLike", tripLike);
		}
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
	
	@RequestMapping("/areaView.do")
	public String tripAreaView(String area,HttpServletRequest req) {
		List<TripDTO> list = userService.selectTripByArea(area);
		System.out.println(list);
		req.setAttribute("list", list);
		return "user/areaView";
	}
	
	// tripDetailView에서 따봉 클릭시 
	@RequestMapping("/tripLike.do")
	public String tripLike(String tripNo,String mbti,String userId, HttpServletResponse response) {
		ResponseDTO<String> resp = new ResponseDTO<String>();
		// 이미 해당 trip 에 따봉을 누른 유저인지 체크
		int check = userService.tripLikeCheck(tripNo,userId);
		// 이미 해당 trip 에 따봉을 누른 유저일때
		if(check > 0) {
			response.setContentType("html/text;charset=utf-8");
			resp.setResponseCode(201);
			resp.setResponseMessage("좋아요는 한번만 가능 합니다");
			JSONObject json = new JSONObject(resp);
			try {
				response.getWriter().write(json.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		// 해당 trip 에 처음 따봉을 누른 유저일때
		int count = userService.tripLike(tripNo,mbti,userId);
		if(count==1) {
			resp.setResponseCode(200);
		}else {
			resp.setResponseCode(500);
		}
		int tripLike = userService.getTripLike(tripNo,mbti);
		resp.setResponseMessage(""+tripLike);
		response.setContentType("html/text;charset=utf-8");
		JSONObject json = new JSONObject(resp);
		try {
			response.getWriter().write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
