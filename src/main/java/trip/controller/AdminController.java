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
import trip.service.UserService;
import trip.vo.PaggingVO;

@Controller
public class AdminController {
	private AdminService adminService;
	
	@Autowired	
	KakaoLogin kakaoLogin;
	
	public AdminController(AdminService adminService) {
		this.adminService = adminService;
	}
	@RequestMapping("adminQna.do")
	public String qnaAdmin(HttpServletRequest request) {
		String userId = (String) request.getSession().getAttribute("userId");
		RoleType role = (RoleType) request.getSession().getAttribute("role");
		int page = 1;
		if(request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<QnaDTO> list = adminService.selectAdminQnaList(page);
		int count = adminService.selectqnaCount();
		PaggingVO vo = new PaggingVO(count, page);
		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);
		System.out.println(list.toString());
		return "admin/admin_qna";
	}
	
	@RequestMapping("/adminQnADtailView.do")
	public String adminQnaView(HttpServletRequest request) {
		int qna_no = 0;
		if(request.getParameter("qna_no") != null)
			qna_no = Integer.parseInt(request.getParameter("qna_no"));
		else
			qna_no = (int) request.getAttribute("qno_no");
		QnaDTO dto = adminService.selectQna(qna_no);
		QnaDTO response = adminService.selectQnaResponse(qna_no);
		request.setAttribute("dto", dto);
		request.setAttribute("response", response);
		return "admin/admin_qna_detail_view"; 
		}
	
	
	@RequestMapping("/adminnotice.do")
	public String adminnotice(HttpServletRequest request) {
		int page = 1;
		//페이지 셋팅
		if(request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<NoticeDTO> list = adminService.selectNoticeList(page);//글목록 읽어옴
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
	public String updateNotice() {
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
					fList.add(new FileDTO(nno, writer, originalFileName));
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
	public RedirectView noticeUodateAction(MultipartHttpServletRequest request) {
		//글번호 먼저 발급
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		String title = request.getParameter("title");
		String nwriter = request.getParameter("nwriter");
		String content = request.getParameter("content");
		String write_date = request.getParameter("write_date");
		adminService.updateNotice(new NoticeDTO(notice_no, title, nwriter, content, write_date));
		
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
				fList.add(new FileDTO(nno, writer, originalFileName));
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
		return new RedirectView("adminnoticeView.do?notice_no="+notice_no);
	}
	@RequestMapping("/fileDownload.do")
	public String fileDownload(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("file");
		String writer = request.getParameter("writer");
		String path = "c:\\fileupload\\"+writer+"\\"+fileName;

		File file = new File(path);
		try {
			FileInputStream fis = new FileInputStream(file);
			String encodingName = URLEncoder.encode(path,"utf-8");
			fileName = URLEncoder.encode(fileName,"utf-8");
			response.setHeader("Content-Disposition", "attachment;filename="+fileName);
			response.setHeader("Content-Transfer-Encode", "binary");
			response.setContentLength((int)file.length());
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024*1024];
			while(true) {
				int count = fis.read(buffer);
				if(count == -1) break;
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
		String path = "c:\\fileupload\\"+writer+"\\"+fileName;

		File file = new File(path);
		try {
			FileInputStream fis = new FileInputStream(file);
			String encodingName = URLEncoder.encode(path,"utf-8");
			fileName = URLEncoder.encode(fileName,"utf-8");
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			byte[] buffer = new byte[1024*1024];
			while(true) {
				int count = fis.read(buffer);
				if(count == -1) break;
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
		//2. DB 해당 게시글 정보 읽어옴
		NoticeDTO dto = adminService.selectNotice(notice_no);
		//2-2. 첨부파일 로드 부분
		List<FileDTO> fList = adminService.selectFileList(notice_no);
		System.out.println(fList.toString());
		request.setAttribute("notice", dto);
		request.setAttribute("file", fList);
		
		return "admin/admin_notice_view";
	}
}

