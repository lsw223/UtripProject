package trip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import trip.dto.BoardDTO;
import trip.dto.CommentDTO;
import trip.service.BoardService;
import trip.vo.PaggingVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardService;

	@RequestMapping("board.do")
	public String board(HttpServletRequest request) {

		int page = 1;
		// 페이지 셋팅
		if (request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		List<BoardDTO> list = boardService.selectBoardList(page);// 글목록 읽어옴
		int count = boardService.selectCount();
		PaggingVO vo = new PaggingVO(count, page);
		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);
		
		
		System.out.println(list.toString());
		return "board";
	}

	@RequestMapping("/boardView.do")
	public String boardView(HttpServletRequest request) {
		// 게시글 하나 읽음
		// 1. request에서 게시글 번호 읽어옴
		int boardNo = 0;
		if (request.getParameter("boardno") != null)
			boardNo = Integer.parseInt(request.getParameter("boardno"));
		else
			boardNo = (int) request.getAttribute("boardno");
		// 1-1. 해당 게시글 조회수 증가
		boardService.addCount(boardNo);
		// 2. DB 해당 게시글 정보 읽어옴
		BoardDTO dto = boardService.selectBoard(boardNo);
		// 2-1. 댓글 로드 부분
		List<CommentDTO> list = boardService.selectBoardComment(boardNo);
		// 3. request에 BoardDTO, CommentList 저장
		request.setAttribute("board", dto);
		request.setAttribute("comment", list);

		return "board_view";
	}

	@RequestMapping("/boardWriteView.do")
	public String boardWriteView() {
		return "board_write_view";
	}

	@RequestMapping("/boardWriteAction.do")
	public RedirectView boardWriteAction(HttpServletRequest request) { // 글번호 먼저 발급 int boardNo =
		int boardNo = boardService.newBoardNo();

		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		boardService.insertBoard(new BoardDTO(boardNo, id, title, content));
		request.setAttribute("boardno", boardNo);

		return new RedirectView("boardView.do?boardno=" + boardNo);
	}

	@RequestMapping("/plusLike.do")
	public String plusLike(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt((String) request.getParameter("boardno"));
		int mode = Integer.parseInt((String) request.getParameter("mode"));

		int count = 0;

		count = boardService.addBoardLike(mode, boardNo);
		try {
			response.getWriter().write(String.valueOf(count));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/insertComment.do")
	public String insertComment(HttpServletRequest request, HttpServletResponse response) {

		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String content = request.getParameter("content");

		boardService.insertComment(new CommentDTO(boardNo, id, content));

		return null;
	}

	@RequestMapping("/boardSerach.do")
	public String BoardSerach(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String kind = request.getParameter("kind");
		String search = request.getParameter("search");
		List<BoardDTO> list = boardService.selectSearchBoard(kind, search);
		
		/*
		 * int page = 1; // 페이지 셋팅 if (request.getParameter("pageNo") != null) page =
		 * Integer.parseInt(request.getParameter("pageNo")); int count =
		 * boardService.selectCount(); PaggingVO vo = new PaggingVO(count, page);
		 * request.setAttribute("list", list); request.setAttribute("pagging", vo);
		 */

		response.setContentType("text/html;charset=utf-8");
		JSONArray array = new JSONArray(list);
		JSONObject obj = new JSONObject();
		obj.put("result", array);
		if (list.size() > 0) {
			obj.put("responseCode", 200);
			obj.put("responseMessage", "Search Succes");
		} else {
			obj.put("responseCode", 500);
			obj.put("responseMessage", "Search Fail");
		}

		try {
			response.getWriter().write(obj.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		int count = boardService.deleteBoard(boardNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(count + "");
			response.getWriter().println("<script>alert('게시글을 삭제가 완료되었습니다.'); location.href='board.do';</script>");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	@RequestMapping("/updateBoardView.do")
	public String updateBoardView(HttpServletRequest request) {
		int boardNo = 0;
		if (request.getParameter("boardno") != null)
			boardNo = Integer.parseInt(request.getParameter("boardno"));
		else
			boardNo = (int) request.getAttribute("boardno");

		BoardDTO dto = boardService.selectBoard(boardNo);
		request.setAttribute("board", dto);

		return "board_update_view";
	}
	
	@RequestMapping("/updateBoard.do")
	public String updateBoard(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));		
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		BoardDTO dto = new BoardDTO(boardNo, null, title, content);
		int count = boardService.updateBoard(dto);
		try {
			if (count == 1)
				response.getWriter().write("true");
			else
				response.getWriter().write("false");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
