package trip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.dto.QnaDTO;
import trip.mapper.QnaMapper;

@Service
public class QnaService {
	@Autowired
	QnaMapper mapper;
	
	public QnaService(QnaMapper mapper) {
		super();
		this.mapper = mapper;
	}
	
	public List<QnaDTO> selectQnaList(String user_id) {
		return mapper.selectQnaList(user_id); 
	}

	public int insertQna(QnaDTO qnaDto) {
		return mapper.insertQna(qnaDto);
	}

}
