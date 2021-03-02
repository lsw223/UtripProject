package trip.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.websocket.server.WsRemoteEndpointImplServer;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import trip.dto.HotelRequestDTO;
import trip.dto.QnaDTO;
import trip.dto.ResponseDTO;
import trip.dto.UserDTO;
import trip.service.QnaService;

@Controller
public class QnaController {
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("qnaFaqView.do")
	public String qnaFaqView() {
		return "user/qna_faq_view";
	}
	
	@RequestMapping("qnaView.do")
	public String qnaView() {
		return "user/qna_view";
	}
	@RequestMapping("/qna.do")
	public String qna(QnaDTO qnaDto,HttpServletResponse resp,HttpSession session) {
		ResponseDTO<String> response = new ResponseDTO<>();
		UserDTO user = (UserDTO)session.getAttribute("user");
		if(user!=null) {
			qnaDto.setuser_id(user.getId());
		}
		System.out.println(qnaDto);
		int count = qnaService.insertQna(qnaDto);
		if(count == 1) {
			response.setResponseCode(210);
			response.setResponseMessage("등록 성공");
		}else {
			response.setResponseCode(211);
			response.setResponseMessage("등록 실패");
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
	@RequestMapping("/showQnaList.do")
	public String showQnaList(String user_id,HttpServletResponse resp) {
		System.out.println(user_id);
		ResponseDTO<String> respDto = new ResponseDTO<>();
		List<QnaDTO> list = qnaService.selectQnaList(user_id);
		System.out.println(list);
		resp.setContentType("html/text;charset=utf-8");
		if(list.size()==0) {
			respDto.setResponseCode(211);
			respDto.setResponseMessage("등록한 문의내역이 없습니다");
			JSONObject json = new JSONObject(respDto);
			try {
				resp.getWriter().write(json.toString());
				System.out.println(json.toString());
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		respDto.setResponseCode(210);
		JSONObject json = new JSONObject(respDto);
		json.put("result", list);
		try {
			resp.getWriter().write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}