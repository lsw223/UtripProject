package trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.QnaDTO;

@Mapper
public interface QnaMapper {

	List<QnaDTO> selectQnaList(String user_id);
	int insertQna(QnaDTO qnaDto);
	int deleteQna(int qna_no);

}
