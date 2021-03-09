package trip.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import trip.dto.QnaDTO;
import trip.dto.TripDTO;
import trip.enums.RoleType;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import trip.dto.QnaDTO;
import trip.oauth.KakaoLogin;
import trip.dto.CourseDTO;
import trip.dto.FileDTO;
import trip.dto.NoticeDTO;
import trip.dto.QnaDTO;
import trip.oauth.KakaoLogin;
import trip.service.AdminService;
import trip.service.QnaService;
import trip.service.UserService;
import trip.vo.PaggingVO;

@Controller
public class AdminController {
	private AdminService adminService;
	private UserService userService;
	@Autowired
	KakaoLogin kakaoLogin;

	public AdminController(AdminService adminService, UserService userService) {
		this.adminService = adminService;
		this.userService = userService;
	}
	//관리자용 QnA 리스트

	@RequestMapping("adminQna.do")
	public String qnaAdmin(HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute("userId");
		RoleType role = (RoleType) request.getSession().getAttribute("role");
		int page = 1;
		if (request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<QnaDTO> list = adminService.selectAdminQnaList(page);
		int count = adminService.selectqnaCount();
		PaggingVO vo = new PaggingVO(count, page);
		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);
		System.out.println(list.toString());
		return "admin/admin_qna";
	}
	
	
	//관리자 QnA 리스트 화면에서 제목 눌렀을 시 이동
	@RequestMapping("/adminQnAView.do")
    public String adminQnaView(HttpServletRequest request) {
        int qna_no = Integer.parseInt(request.getParameter("qna_no"));
        System.out.println(qna_no);
        QnaDTO dto = adminService.selectQna(qna_no);
        QnaDTO response = adminService.selectQnaResponse(qna_no);
        request.setAttribute("dto", dto);
        System.out.println(dto);
        request.setAttribute("response", response);
        return "admin/admin_qna_view"; 
        }


	@RequestMapping("/adminQnADtailView.do")
	public String adminQnADtailView(HttpServletRequest request) {
		int qna_no = 0;
		if (request.getParameter("qna_no") != null)
			qna_no = Integer.parseInt(request.getParameter("qna_no"));
		else
			qna_no = (int) request.getAttribute("qno_no");
		QnaDTO dto = adminService.selectQna(qna_no);
		QnaDTO response = adminService.selectQnaResponse(qna_no);
		request.setAttribute("dto", dto);
		System.out.println(dto);
		request.setAttribute("response", response);
		return "admin/admin_qna_view"; 
		}
	
	//Qna 답변 작성
	@RequestMapping("/insertResponse.do")
	public RedirectView insertResponse(HttpServletRequest request, HttpServletResponse response) {
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String response_content = request.getParameter("response_content");
		System.out.println(qna_no);
		System.out.println(response_content);
		QnaDTO qnaDto = new QnaDTO(qna_no, response_content);
		int count = adminService.insertResponse(qnaDto);
		return new RedirectView("adminQnAView.do?qna_no="+qna_no);
	}
	@RequestMapping("/deleteResponse.do")
	public RedirectView deleteResponse(HttpServletRequest request, HttpServletResponse response) {
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		int count = adminService.deleteResponse(qna_no);
		return new RedirectView("adminQnAView.do?qna_no="+qna_no);
	}
	

	@RequestMapping("/adminnotice.do")
	public String adminnotice(HttpServletRequest request) {
		int page = 1;
		// 페이지 셋팅
		if (request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<NoticeDTO> list = adminService.selectNoticeList(page);// 글목록 읽어옴
		int count = adminService.selectnoticeCount();
		PaggingVO vo = new PaggingVO(count, page);
		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);
		System.out.println(list.toString());
		return "admin_notice";
	}

	@RequestMapping("/adminnoticeWriteView.do")
	public String noviceWriteView() {
		return "admin/admin_notice_write_view";
	}

	@RequestMapping("/updateNoticeview.do")
	public String updateNotice(HttpServletRequest request) {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		List<FileDTO> fList = adminService.selectFileList(notice_no);
		NoticeDTO detail = adminService.selectNotice(notice_no);
		request.setAttribute("file", fList);
		request.setAttribute("detail", detail);
		
		return "admin/admin_notice_update_view";
	}

	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(HttpServletRequest request) {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String write_date = request.getParameter("write_date");
		String nwriter = request.getParameter("nwriter");
		NoticeDTO dto = new NoticeDTO(notice_no, title, nwriter, content, write_date);
		adminService.deleteNotice(dto);
		adminService.deleteNotice(dto);
		return "admin_notice";
	}

	@RequestMapping("/noticeWriteAction.do")
	public RedirectView noticeWriteAction(MultipartHttpServletRequest request) {
		//글번호 먼저 발급
				int notice_no = adminService.noticeno();
				
				String title = request.getParameter("title");
				String nwriter = request.getParameter("nwriter");
				String content = request.getParameter("content");
				String write_date = request.getParameter("write_date");
				adminService.insertNotice(new NoticeDTO(notice_no, title, nwriter, content, write_date));
				request.setAttribute("notice_no", notice_no);
				
				List<MultipartFile> fileList = request.getFiles("file"); 
				System.out.println(fileList.size());
				String path = "c:\\fileupload\\"+nwriter+"\\";
				ArrayList<FileDTO> fList =new  ArrayList<FileDTO>();
				
				int nno = adminService.newnno();
				String writer = request.getParameter("nwriter");
				if(writer == null) {
					writer = "test";
				}
				
				for(MultipartFile mf : fileList) {
					String originalFileName = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					if(fileSize == 0) continue;
					System.out.println("originalFileName : " + originalFileName);
					System.out.println("fileSize : "+ fileSize);
					System.err.println(mf.getContentType());
					
					try {
					//파일 업로드
					String safeFile = path + originalFileName;
					fList.add(new FileDTO(nno, notice_no, writer, originalFileName));
					File parentPath = new File(path);
					if(!parentPath.exists()) parentPath.mkdirs();//경로 생성
						mf.transferTo(new File(safeFile));	
					
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
					
				}
				adminService.insertFileList(fList);
				return new RedirectView("adminnotice.do?notice_no="+notice_no);
	}
	@RequestMapping("/noticeUpdateAction.do")
	public RedirectView noticeUpdateAction(MultipartHttpServletRequest request,
			NoticeDTO dto, FileDTO fileDTO ) {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		String writer = request.getParameter("nwriter");
		String nwriter = request.getParameter("writer");
		adminService.updateNotice(dto);
		
		List<MultipartFile> fileList = request.getFiles("file"); 
		System.out.println(fileList.size());
		if(writer == null) {
			writer = "test";
		}
		String path = "c:\\fileupload\\"+writer+"\\";
		ArrayList<FileDTO> fList =new  ArrayList<FileDTO>();
		
		int nno = Integer.parseInt(request.getParameter("nno"));
		
		System.out.println("nno : " + nno);
		
		for(MultipartFile mf : fileList) {
			String originalFileName = mf.getOriginalFilename();
			long fileSize = mf.getSize();
			if(fileSize == 0) continue;
			System.out.println("originalFileName : " + originalFileName);
			System.out.println("fileSize : "+ fileSize);
			System.err.println(mf.getContentType());
			
			try {
			//파일 업로드
				String safeFile = path + originalFileName;
				fList.add(new FileDTO(nno, notice_no, writer, originalFileName));
				File parentPath = new File(path);
			if(!parentPath.exists()) parentPath.mkdirs();//경로 생성
				mf.transferTo(new File(safeFile));	
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		adminService.updateFileList(fList);
		return new RedirectView("adminnoticeView.do?notice_no="+notice_no);
	}

	@RequestMapping("/fileDownload.do")
	public String fileDownload(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("file");
		String writer = request.getParameter("writer");
		String path = "c:\\fileupload\\" + writer + "\\" + fileName;

		File file = new File(path);
		try {
			FileInputStream fis = new FileInputStream(file);
			String encodingName = URLEncoder.encode(path, "utf-8");
			fileName = URLEncoder.encode(fileName, "utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
			response.setHeader("Content-Transfer-Encode", "binary");
			response.setContentLength((int) file.length());
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (true) {
				int count = fis.read(buffer);
				if (count == -1)
					break;
				bos.write(buffer, 0, count);
				bos.flush();
			}
			fis.close();
			bos.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/imageLoad.do")
	public String imageLoad(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("file");
		String writer = request.getParameter("writer");
		String path = "c:\\fileupload\\" + writer + "\\" + fileName;

		File file = new File(path);
		try {
			FileInputStream fis = new FileInputStream(file);
			String encodingName = URLEncoder.encode(path, "utf-8");
			fileName = URLEncoder.encode(fileName, "utf-8");
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024 * 1024];
			while (true) {
				int count = fis.read(buffer);
				if (count == -1)
					break;
				bos.write(buffer, 0, count);
				bos.flush();
			}
			fis.close();
			bos.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/adminnoticeView.do")
	public String adminnoticeView(HttpServletRequest request) {
		//게시글 하나 읽음
				//1. request에서 게시글 번호 읽어옴
				int notice_no = 0;
				if(request.getParameter("notice_no") != null)
					notice_no = Integer.parseInt(request.getParameter("notice_no"));
				else
					notice_no = (int)request.getAttribute("notice_no");
				
				System.out.println("notice_no : " + notice_no);
				
				//2. DB 해당 게시글 정보 읽어옴
				NoticeDTO dto = adminService.selectNotice(notice_no);
				//2-2. 첨부파일 로드 부분
				List<FileDTO> fList = adminService.selectFileList(notice_no);
				request.setAttribute("notice", dto);
				request.setAttribute("file", fList);
				
				System.out.println("req : " + request.getAttribute("file"));
				
				
				return "admin/admin_notice_view";
			}
	// 조성일 추가내용
	@RequestMapping("tripUpdateView.do")
	public String tripUpdateView(HttpServletRequest request, HttpServletResponse response, String tripNo) {
		TripDTO dto = userService.selectTripInfo(tripNo);
		List<CourseDTO> list = userService.selectCourseInfo(tripNo);
		List<CourseDTO> courseList = adminService.selectCourseList(dto.getArea_name());
		// 수정할 trip,course 정보
		request.setAttribute("dto", dto);
		request.setAttribute("list", list);
		// 선택할 지역 코스 리스트
		request.setAttribute("courseList", courseList);
		return "admin/admin_trip_update_view";
	}

	@RequestMapping("tripUpdateAction.do")
	public RedirectView tripUpdateAction(MultipartHttpServletRequest request, HttpServletResponse response) {
		// 이미지 업로드
		String trip_no = request.getParameter("trip_no");
		// String filename=trip_no;
		String fileName = trip_no + ".jpg";
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int x = 1;
		ArrayList<String> placeList = new ArrayList<String>();
		String path = request.getSession().getServletContext().getRealPath("/img/trip/");

		//
		List<MultipartFile> fileList = request.getFiles("file");
		System.out.println(path);
		for (MultipartFile mf : fileList) {
			System.out.println("A");
			long fileSize = mf.getSize();
			if (fileSize == 0)
				continue;
			System.out.println("fileSize : " + fileSize);
			System.err.println(mf.getContentType());

			try {
				// 파일 업로드
				String safeFile = path + fileName;
				File parentPath = new File(path);
				if (!parentPath.exists())
					parentPath.mkdirs();// 경로 생성
				mf.transferTo(new File(safeFile));

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		//

		while (request.getParameter("place" + x) != null) {
			placeList.add(request.getParameter("place" + x));
			x++;
		}

		TripDTO dto = new TripDTO(trip_no, title, content);
		int count = adminService.tripUpdateInfo(dto);
		System.out.println(count);
		adminService.courseDelete(trip_no);
		adminService.courseInsertInfo(placeList, trip_no);
		return new RedirectView("tripDetailView.do?trip_no=" + trip_no);
	}

	@RequestMapping("tripDeleteAction.do")
	public RedirectView tripDeleteAction(HttpServletRequest request, String trip_no) {
		System.out.println(trip_no);
		int count = adminService.deleteTripInfo(trip_no);
		System.out.println(count);
		return new RedirectView("tripView.do");
	}

	@RequestMapping("tripInsertView.do")
	public String tripInsertView(HttpServletRequest request) {

		List<String> areaList = adminService.selectAreaList();
		request.setAttribute("areaList", areaList);
		return "admin/admin_trip_insert_view";
	}

	@RequestMapping("courseSearch.do")
	public String courseSearch(HttpServletResponse response, HttpServletRequest request) {
		String area = request.getParameter("area");
		System.out.println(area);
		List<CourseDTO> list = adminService.selectCourseList(area);
		response.setContentType("text/html;charset=utf-8");
		JSONArray array = new JSONArray(list);
		JSONObject obj = new JSONObject();
		obj.put("result", array);
		if (list.size() > 0) {
			obj.put("responseCode", 200);
			obj.put("responseMessage", "정상적으로 조회되었습니다.");
		} else {
			obj.put("responseCode", 500);
			obj.put("responseMessage", "조회된 데이터가 없습니다.");
		}
		try {
			response.getWriter().write(obj.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("tripInsertInfoAction.do")
	public RedirectView tripInsertInfoAction(MultipartHttpServletRequest request, HttpServletResponse response) {
		// 이미지 업로드
		String trip_no = adminService.searchTripNo(request.getParameter("area"));
		System.out.println(trip_no);
		String fileName = trip_no + ".jpg";
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int x = 1;
		ArrayList<String> placeList = new ArrayList<String>();
		String path = request.getSession().getServletContext().getRealPath("/img/trip/");

		//
		List<MultipartFile> fileList = request.getFiles("file");
		System.out.println(path);
		for (MultipartFile mf : fileList) {
			System.out.println("A");
			long fileSize = mf.getSize();
			if (fileSize == 0)
				continue;
			System.out.println("fileSize : " + fileSize);
			System.err.println(mf.getContentType());

			try {
				// 파일 업로드
				String safeFile = path + fileName;
				File parentPath = new File(path);
				if (!parentPath.exists())
					parentPath.mkdirs();// 경로 생성
				mf.transferTo(new File(safeFile));

			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

		//

		while (request.getParameter("place" + x) != null) {
			placeList.add(request.getParameter("place" + x));
			x++;
		}

		TripDTO dto = new TripDTO(trip_no, title, content);
		int count = adminService.tripInsertInfo(dto);
		System.out.println(count);

		int count1 = adminService.courseInsertInfo(placeList, trip_no);
		return new RedirectView("tripDetailView.do?trip_no=" + trip_no);
	}

	
	
}
