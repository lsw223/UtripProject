package trip.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import trip.dto.HotelRequestDTO;
import trip.dto.ResponseDTO;
import trip.dto.UserDTO;
import trip.service.HotelService;

@Controller
public class HotelController {
	
	@Autowired
	private HotelService service;
	
	@RequestMapping("/hotelRequestView.do")
	public String hotelRequestView() {
		return "user/hotel_request_view";
	}
	
	@RequestMapping("/hotelRequest.do")
	public String hotelRequest(HotelRequestDTO hotelRequestDto,HttpServletResponse resp,HttpSession session) {
		ResponseDTO<String> response = new ResponseDTO<>();
		UserDTO user = (UserDTO)session.getAttribute("user");
		if(user!=null) {
			hotelRequestDto.setUser_id(user.getId());
		}
		System.out.println(hotelRequestDto);
		int count = service.insert(hotelRequestDto);
		if(count == 1) {
			response.setResponseCode(200);
			response.setResponseMessage("신청 성공");
		}else {
			response.setResponseCode(201);
			response.setResponseMessage("신청 실패");
		}
		JSONObject json = new JSONObject(response);
		try {
			resp.setContentType("html/text;charset=utf-8");
			resp.getWriter().write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping("/showRequestList.do")
	public String showRequestList(String id,HttpServletResponse resp) {
		System.out.println(id);
		ResponseDTO<String> respDto = new ResponseDTO<>();
		List<HotelRequestDTO> list = service.selectById(id);
		System.out.println(list);
		resp.setContentType("html/text;charset=utf-8");
		if(list.size()==0) {
			respDto.setResponseCode(201);
			respDto.setResponseMessage("신청하신 내역이 없습니다");
			JSONObject json = new JSONObject(respDto);
			try {
				resp.getWriter().write(json.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		respDto.setResponseCode(200);
		JSONObject json = new JSONObject(respDto);
		json.put("result", list);
		try {
			resp.getWriter().write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping("/hotelRequestAdminView.do")
	public String hotelRequestAdminView(HttpSession session) {
		List<HotelRequestDTO> list = service.selectAllRequest();
		session.setAttribute("list", list);
		return "admin/admin_hotel_request_view";
	}
	
	@RequestMapping("/reject.do")
	public String reject(int request_no) {
		service.reject(request_no);
		return "redirect:/hotelRequestAdminView.do";
	}
	
}
