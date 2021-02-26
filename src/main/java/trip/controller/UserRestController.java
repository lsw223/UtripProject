package trip.controller;



import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import trip.dto.ResponseDTO;
import trip.dto.UserDTO;
import trip.service.UserService;

@RestController
public class UserRestController {
	
	@Autowired
	UserService userService;  
	
	// 회원가입 성공시
	@RequestMapping("/registerSuccess")
	public String registerSuccess() {
		String str = "<script>"
				+"alert('회원가입 성공');"
				+"location.href='/loginView.do';"
				+"</script>";
		
		return str;
	}
	@RequestMapping("/registerFail")
	public String registerFail() {
		String str = "<script>"
				+"alert('회원가입 실패, 입력하신 정보를 다시 확인해 주세요');"
				+"history.back();"
				+"</script>";
		return str;
	}
	@RequestMapping("/kakaoRegisterSuccess")
	public String kakaoRegisterSuccess() {
		String str = "<script>"
				+"alert('카카오 계정 연동하기 성공');"
				+"location.href='/';"
				+"</script>";
		
		return str;
	}
	@RequestMapping("/kakaoRegisterFail")
	public String kakaoRegisterFail() {
		String str = "<script>"
				+"alert('연동하기 실패');"
				+"location.href='loginView.do';"
				+"</script>";
		return str;
	}
	// 아이디가 틀렸을때
	@RequestMapping("/idIncorrect")
	public String idIncorrect() {
		String str = "<script>"
				+"alert('아이디를 확인해주세요');"
				+"history.back();" 
				+"</script>";
		return str;
	}
	// 비밀번호가 틀렸을때
	@RequestMapping("/passIncorrect")
	public String passIncorrect() {
		String str = "<script>"
				+"alert('비밀번호를 확인해주세요');"
				+"history.back();"
				+"</script>";
		return str;
	}
	
	@RequestMapping("idCheck.do")
	public String idCheck(String id) {
		ResponseDTO<String> resp = new ResponseDTO<String>();
		UserDTO user = userService.selectById(id);
		if(user==null) {
			resp.setResponseCode(2);
			resp.setResponseMessage("사용 가능한 아이디 입니다");
		}else {
			resp.setResponseCode(1);
			resp.setResponseMessage("해당 아이디는 사용중인 아이디 입니다");
		}
		JSONObject jo = new JSONObject(resp);
		return jo.toString();
	}
	
}
