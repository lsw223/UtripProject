package trip.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.dto.BoardDTO;
import trip.dto.CommentDTO;
import trip.mapper.BoardMapper;

@Service
public class BoardService {

	@Autowired
	BoardMapper mapper;

	public BoardService(BoardMapper mapper) {
		super();
		this.mapper = mapper;
	}

	public List<BoardDTO> selectBoardList(int page) {
		return mapper.selectBoardList(page);
	}

	public int selectCount() {
		return mapper.selectCount();
	}

	public int selectSearchCount(String kind, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("kind", kind);
		map.put("search", search);
		return mapper.selectSearchCount(map);
	}

	public BoardDTO selectBoard(int boardNo) {
		return mapper.selectBoard(boardNo);
	}

	public int newBoardNo() {
		return mapper.newBoardNo();
	}
	public int newCommentNo() {
		return mapper.newCommentNo();
	}

	public List<CommentDTO> selectBoardComment(int boardNo) {
		return mapper.selectBoardComment(boardNo);
	}

	public int insertBoard(BoardDTO dto) {
		return mapper.insertBoard(dto);
	}

	public int addBoardLike(int mode, int boardNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("mode", mode);
		map.put("boardNo", boardNo);
		mapper.addBoardLike(map);
		BoardDTO dto = mapper.selectBoard(boardNo);
		if (mode == 0)
			return dto.getBoardLike();

		return boardNo;
	}

	public int insertComment(CommentDTO dto) {
		return mapper.insertBoardComment(dto);
	}

	public List<BoardDTO> selectSearchBoard(int page, String kind, String search) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("kind", kind);
		map.put("search", search);
		map.put("pageNo", page);
		return mapper.selectSearchBoard(map);

	}

	public void addCount(int boardNo) {
		mapper.addCount(boardNo);
	}

	public int deleteBoard(int boardNo) {
		return mapper.deleteBoard(boardNo);
	}

	public int updateBoard(BoardDTO dto) {
		return mapper.updateBoard(dto);
	}

	public BoardDTO selectId(String id) {
		return mapper.selectId(id);
	}

	public int deleteComment(int commentNo) {
		return mapper.deleteComment(commentNo);
	}

	public int updateComment(CommentDTO dto) {
		return mapper.updateComment(dto);
	}

}
