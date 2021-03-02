package trip.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.HTTP;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import trip.dto.FileDTO;
import trip.dto.NoticeCommentDTO;
import trip.dto.NoticeDTO;
import trip.dto.ResponseDTO;
import trip.dto.UserDTO;
import trip.encryption.PasswordEncoder;
import trip.enums.RoleType;
import trip.oauth.KakaoLogin;
import trip.service.UserService;
import trip.vo.PaggingVO;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private KakaoLogin kakaoLogin;
	@Autowired
	private PasswordEncoder encoder;
	
	
	
	// 로그인 화면으로 이동
	@RequestMapping("/loginView.do")
	public String loginView() {
		return "user/loginView";
	}
	// 회원가입 화면으로 이동
	@RequestMapping("/registerView.do")
	public String registerView() {
		return "user/registerView";
	}
	// 카카오 계정 으로 UTrip 첫 로그인시 계정연동 페이지로 이동
	@RequestMapping("/kakaoRegisterView.do")
	public String kakaoRegisterView() {
		return "user/kakaoRegisterView";
	}
	// 카카오계정으로 로그인
	@RequestMapping("/kakaoLogin.do")
	public String loginProc(String code,HttpSession session,HttpServletResponse response) {
		JSONObject json = kakaoLogin.getKakaoToken(code);
		String token = json.getString("access_token");
		JSONObject kakaoUser = kakaoLogin.getKakaoUser(token);
		String id = "kakao_"+kakaoUser.getInt("id");
		kakaoUser.put("utripId", id);
		System.out.println(kakaoUser.toString());
		session.setAttribute("kakaoUser", kakaoUser);
		UserDTO user = userService.selectById(id);
		if(user==null) {
			System.out.println(user);
			response.setContentType("text/html;charset=utf-8");
			try {
				response.getWriter().write("<script>alert('카카오 계정으로 처음 로그인 하셨습니다');"
						+ "location.href='kakaoRegisterView.do';</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
		session.setAttribute("login", true);
		session.setAttribute("user", user);
		return "redirect:/";
	}
	// UTrip계정으로 로그인
	@RequestMapping("/login.do")
	public String login(String id, String password, HttpSession session) {
		password = encoder.encrypt(password);
		System.out.println(password);
		UserDTO user = userService.selectById(id);
		System.out.println(user);
		if(user == null) {
			return "redirect:/idIncorrect";
		}else if(password.equals(user.getPassword())){
			return "redirect:/passIncorrect";
		}
		session.setAttribute("login", true);
		session.setAttribute("user", user);
		return "/TripMain";
	}
	// 로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate(); 
		return "redirect:/";
	}
	// 일반 회원가입
	@RequestMapping("/register.do")
	public String register(UserDTO user,String domain) {
		user.setEmail(user.getEmail()+domain);
		user.setPassword(encoder.encrypt(user.getPassword()));
		user.setRole(RoleType.USER);
		int count = userService.register(user);
		if(count==1) {
			return "redirect:/registerSuccess";
		}else {
			return "redirect:/registerFail";
		}
	}
	// 카카오 계정으로 회원가입
	@RequestMapping("/kakaoRegister.do")
	public String kakaoRegister(String mbti, HttpSession session) {
		System.out.println(mbti);
		JSONObject kakaoUser = (JSONObject) session.getAttribute("kakaoUser");
		System.out.println(kakaoUser);
		UserDTO user = UserDTO.builder()
				.id(kakaoUser.getString("utripId"))
				.mbti(mbti)
				.name(kakaoUser.getJSONObject("kakao_account").getJSONObject("profile").getString("nickname"))
				.role(RoleType.USER)
				.build();
		try {
			user.setEmail(kakaoUser.getJSONObject("kakao_account").getString("email"));
		}catch (Exception e) {}
		System.out.println(user);
		int count = userService.kakaoRegister(user);
		if(count == 1) {
			session.setAttribute("login", true);
			session.setAttribute("user", user);
			return "redirect:/kakaoRegisterSuccess";
		}else {
			return "redirect:/kakaoRegisterFail";
		}
	}
	
	@RequestMapping("/infoUpdateView.do")
	public String infoUpdateView() {
		return "user/infoUpdateView";
	}
	
	@RequestMapping("/infoUpdate.do")
	public String infoUpdate(@RequestBody UserDTO user_new,HttpServletResponse resp,HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		user.setName(user_new.getName());
		user.setEmail(user_new.getEmail());
		user.setMbti(user_new.getMbti());
		int count = userService.update(user);
		ResponseDTO<String> response = new ResponseDTO<>();
		if(count==1) {
			response.setResponseCode(HttpStatus.OK.value());
			response.setResponseMessage("설정이 저장되었습니다");
			System.out.println(response);
		}else {
			response.setResponseCode(HttpStatus.BAD_REQUEST.value());
			response.setResponseMessage("변경에 실패하였습니다");
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
	@RequestMapping("/notice.do")
	public String notice(HttpServletRequest request) {
		int page = 1;
		//페이지 셋팅
		if(request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<NoticeDTO> list = userService.selectNoticeList(page);//글목록 읽어옴
		int count = userService.selectnoticeCount();
		PaggingVO vo = new PaggingVO(count, page);
		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);
		System.out.println(list.toString());
		return "notice";
	}
	@RequestMapping("/noticeView.do")
	public String noticeView(HttpServletRequest request) {
		//게시글 하나 읽음
		//1. request에서 게시글 번호 읽어옴
		int notice_no = 0;
		if(request.getParameter("notice_no") != null)
			notice_no = Integer.parseInt(request.getParameter("notice_no"));
		else
			notice_no = (int)request.getAttribute("notice_no");
		
		System.out.println("notice_no : " + notice_no);
		userService.addnoticeCount(notice_no);
		System.out.println();
		//2. DB 해당 게시글 정보 읽어옴
		NoticeDTO dto = userService.selectNotice(notice_no);
		List<NoticeCommentDTO> list = userService.selectNoticeComment(notice_no);
		//2-2. 첨부파일 로드 부분
		List<FileDTO> fList = userService.selectFileList(notice_no);
		request.setAttribute("notice", dto);
		request.setAttribute("noticecomment", list);
		request.setAttribute("file", fList);
		System.out.println("list = " + list.toString());
		System.out.println("req : " + request.getAttribute("file"));
		return "user/notice_view";
	}
	@RequestMapping("/plusLikeHate.do")
	public String plusLikeHate(HttpServletRequest request, HttpServletResponse response) {
		int notice_no = Integer.parseInt((String)request.getParameter("notice_no"));
		int mode =Integer.parseInt((String)request.getParameter("mode"));
		
		int count = 0;
		
		count = userService.addNoticeLikeHate(mode, notice_no);
		try {
			response.getWriter().write(String.valueOf(count));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	@RequestMapping("/insertnoticeComment.do")
	public String insertnoticeComment(HttpServletRequest request, HttpServletResponse response) {
		
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		String writeDate = request.getParameter("writeDate");
		
		userService.insertNoticeComment(new NoticeCommentDTO(notice_no, writer, content, writeDate));
		return null;
	}
	@RequestMapping("/noticecommentLike.do")
	public String noticecommentLike(HttpServletRequest request) {
		int comment_no = Integer.parseInt(request.getParameter("comment_no"));
		userService.updatenoticeCommentLike(comment_no);
		return noticeView(request);
	}
	@RequestMapping("/noticecommentHate.do")
	public String noticecommentHate(HttpServletRequest request) {
		int comment_no = Integer.parseInt(request.getParameter("comment_no"));
		userService.updatenoticeCommentHate(comment_no);
		return noticeView(request);
	}
	
	
	// 계정 탈퇴
	@RequestMapping("/withdraw.do")
	public String withdraw(HttpSession session) {
		UserDTO user = (UserDTO) session.getAttribute("user");
		userService.withdraw(user.getId());
		return "redirect:/logout.do";
	}
	
}
