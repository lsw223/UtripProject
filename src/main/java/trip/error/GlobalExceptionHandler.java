package trip.error;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// 에러 관리 컨트롤러
@ControllerAdvice
@Controller
public class GlobalExceptionHandler {
	// 에러 관리 메서드
	@ExceptionHandler(value=Exception.class)
	public String handleException(Exception e, HttpServletResponse res){
		e.printStackTrace();
		// Exception 발생시 error.jsp 리턴해줌
		return "/error";
	}
}
