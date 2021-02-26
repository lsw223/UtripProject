package trip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import trip.mapper.QnaMapper;

@Service
public class QnaService {
	@Autowired
	private QnaMapper mapper;
}
