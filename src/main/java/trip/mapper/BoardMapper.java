package trip.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.BoardDTO;
import trip.dto.CommentDTO;

@Mapper
public interface BoardMapper {
	
	List<BoardDTO> selectBoardList(int page);
	int selectCount();
	BoardDTO selectBoard(int boardNo);
	List<CommentDTO> selectBoardComment(int boardNo);
	int newBoardNo();
	int newCommentNo();
	int insertBoard(BoardDTO dto);
	void addBoardLike(HashMap<String, Object> map);
	int insertBoardComment(CommentDTO dto);
	void addCount(int boardNo);
	int deleteBoard(int boardNo);
	int updateBoard(BoardDTO dto);
	BoardDTO selectId(String id);
	List<BoardDTO> selectSearchBoard(HashMap<String, Object> map);
	int selectSearchCount(HashMap<String, Object> map);
	int deleteComment(int commentNo);
	int updateComment(CommentDTO dto);
}
