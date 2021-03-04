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

import trip.dto.BoardDTO;
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
	public String qnaView(HttpSession session, HttpServletRequest request) {
		if (session.getAttribute("user") == null) {
			return "user/qna_view";
		} else {
			UserDTO userdto = (UserDTO) session.getAttribute("user");
			String id = userdto.getId();
			List<QnaDTO> list = qnaService.selectQnaList(userdto.getId());
			request.setAttribute("list", list);
			return "user/qna_view";

		}

	}

	@RequestMapping("/sendQnA.do")
	public String sendQnA(HttpServletResponse response, HttpServletRequest request, HttpSession session) {
		String title = request.getParameter("title");
		String user_id = request.getParameter("user_id");
		String content = request.getParameter("content");
		System.out.println(title);
		System.out.println(user_id);
		System.out.println(content);
		QnaDTO qnaDto = new QnaDTO(user_id, title, content);
		int count = qnaService.insertQna(qnaDto);

		if (count == 1) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(count);
				response.getWriter().println("<script>alert('정상적으로 등록 되었습니다'); location.href='qnaView.do';</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		return null;
	}

	@RequestMapping("/deleteQna.do")
	public String deleteQna(HttpServletRequest request, HttpServletResponse response) {
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		int count = qnaService.deleteQna(qna_no);
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(count + "");
			response.getWriter().println("<script>alert('문의글이 삭제 되었습니다'); location.href='qnaView.do';</script>");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

}