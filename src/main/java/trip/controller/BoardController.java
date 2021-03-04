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
import org.springframework.web.bind.annotation.RequestMethod;
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
		return "user/board";
	}

	@RequestMapping("adminBoard.do")
	public String adminBoard(HttpServletRequest request) {

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
		return "admin/admin_board";
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

		return "user/board_view";
	}

	@RequestMapping("/adminBoardView.do")
	public String AdminBoardView(HttpServletRequest request) {
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

		return "admin/admin_board_view";
	}

	@RequestMapping("/boardWriteView.do")
	public String boardWriteView() {
		return "user/board_write_view";
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

	@RequestMapping("/adminBoardWriteView.do")
	public String adminBoardWriteView() {
		return "admin/admin_board_write_view";
	}

	@RequestMapping("/adminBoardWriteAction.do")
	public RedirectView adminBoardWriteAction(HttpServletRequest request) { // 글번호 먼저 발급 int boardNo =
		int boardNo = boardService.newBoardNo();

		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		boardService.insertBoard(new BoardDTO(boardNo, id, title, content));
		request.setAttribute("boardno", boardNo);

		return new RedirectView("adminBoardView.do?boardno=" + boardNo);
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
		int commentNo = boardService.newCommentNo();
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String content = request.getParameter("content");

		boardService.insertComment(new CommentDTO(commentNo, boardNo, id, content));

		return null;
	}

	@RequestMapping("boardSerach.do")
	public String BoardSerach(HttpServletRequest request) {

		String kind = request.getParameter("kind");
		String search = request.getParameter("search");

		int page = 1; // 페이지 셋팅
		if (request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		int count = boardService.selectSearchCount(kind, search);

		List<BoardDTO> list = boardService.selectSearchBoard(page, kind, search);
		PaggingVO vo = new PaggingVO(count, page);

		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);

		request.setAttribute("kind", kind);
		request.setAttribute("search", search);

		System.out.println(list.toString());

		return "user/board";
	}

	@RequestMapping("adminBoardSerach.do")
	public String AdminBoardSerach(HttpServletRequest request) {

		String kind = request.getParameter("kind");
		String search = request.getParameter("search");

		int page = 1; // 페이지 셋팅
		if (request.getParameter("pageNo") != null)
			page = Integer.parseInt(request.getParameter("pageNo"));
		int count = boardService.selectSearchCount(kind, search);

		List<BoardDTO> list = boardService.selectSearchBoard(page, kind, search);
		PaggingVO vo = new PaggingVO(count, page);

		request.setAttribute("list", list);
		request.setAttribute("pagging", vo);

		request.setAttribute("kind", kind);
		request.setAttribute("search", search);

		System.out.println(list.toString());

		return "admin/admin_board";
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

	@RequestMapping("/adminDeleteBoard.do")
	public String adminDeleteBoard(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		int count = boardService.deleteBoard(boardNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(count + "");
			response.getWriter().println("<script>alert('게시글을 삭제가 완료되었습니다.'); location.href='adminBoard.do';</script>");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping("/updateBoardView.do")
	public String updateBoardView(HttpServletRequest request) {

		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		BoardDTO dto = boardService.selectBoard(boardNo);
		request.setAttribute("board", dto);

		return "user/board_update_view";
	}

	@RequestMapping("/updateBoard.do")
	public String updateBoard(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		BoardDTO dto = new BoardDTO(boardNo, id, title, content);
		int count = boardService.updateBoard(dto);
		try {
			if (count == 1) {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('게시글 수정 완료했습니다.');"
						+ "location.href='http://localhost:9999/boardView.do?boardno=" + boardNo + "';</script>");
			} else
				response.getWriter().write("false");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/adminUpdateBoardView.do")
	public String adminUpdateBoardView(HttpServletRequest request) {

		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		BoardDTO dto = boardService.selectBoard(boardNo);
		request.setAttribute("board", dto);

		return "admin/admin_board_update_view";
	}

	@RequestMapping("/adminUpdateBoard.do")
	public String adminUpdateBoard(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		BoardDTO dto = new BoardDTO(boardNo, id, title, content);
		int count = boardService.updateBoard(dto);
		try {
			if (count == 1) {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('게시글 수정 완료했습니다.');"
						+ "location.href='http://localhost:9999/adminBoardView.do?boardno=" + boardNo + "';</script>");
			} else
				response.getWriter().write("false");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping("/updateComment.do")
	public String updateComment(HttpServletRequest request, HttpServletResponse response) {
		int commentNo = Integer.parseInt(request.getParameter("commentno"));
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String content = request.getParameter("content");

		CommentDTO dto = new CommentDTO(commentNo, boardNo, id, content);
		boardService.updateComment(dto);

		int count = boardService.updateComment(dto);

		try {
			if (count == 1) {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('댓글 수정 완료했습니다.');"
						+ "location.href='http://localhost:9999/boardView.do?boardno=" + boardNo + "';</script>");
				System.out.println(dto.toString());
			} else
				response.getWriter().write("false");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping("/adminUpdateComment.do")
	public String adminUpdateComment(HttpServletRequest request, HttpServletResponse response) {
		int commentNo = Integer.parseInt(request.getParameter("commentno"));
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		String id = request.getParameter("id");
		String content = request.getParameter("content");

		CommentDTO dto = new CommentDTO(commentNo, boardNo, id, content);
		boardService.updateComment(dto);

		int count = boardService.updateComment(dto);

		try {
			if (count == 1) {
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().println("<script>alert('댓글 수정 완료했습니다.');"
						+ "location.href='http://localhost:9999/adminBoardView.do?boardno=" + boardNo + "';</script>");
				System.out.println(dto.toString());
			} else
				response.getWriter().write("false");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping("/deleteComment.do")
	public String deleteComment(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		int commentNo = Integer.parseInt(request.getParameter("commentno"));
		int count = boardService.deleteComment(commentNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(count + "");
			response.getWriter().println("<script>alert('댓글 삭제가 완료되었습니다.');"
					+ "location.href='http://localhost:9999/boardView.do?boardno=" + boardNo + "';</script>");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	@RequestMapping("/adminDeleteComment.do")
	public String adminDeleteComment(HttpServletRequest request, HttpServletResponse response) {
		int boardNo = Integer.parseInt(request.getParameter("boardno"));
		int commentNo = Integer.parseInt(request.getParameter("commentno"));
		int count = boardService.deleteComment(commentNo);
		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(count + "");
			response.getWriter().println("<script>alert('댓글 삭제가 완료되었습니다.');"
					+ "location.href='http://localhost:9999/adminBoardView.do?boardno=" + boardNo + "';</script>");

		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
}
