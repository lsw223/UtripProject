package trip.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.FileDTO;
import trip.dto.NoticeDTO;
import trip.dto.QnaDTO;

@Mapper
public interface AdminMapper {

	List<QnaDTO> selectQnaList(String id);
	QnaDTO selectQna(int qna_no);
	int selectqnaCount();
	int selectnoticeCount();
	List<QnaDTO> selectQnaAdminList(int page);
	List<NoticeDTO> selectNoticeList(int page);
	int newnno();
	int insertNotice(NoticeDTO dto);
	void insertFileList(FileDTO fileDTO);
	NoticeDTO selectNotice(int notice_no);
	List<FileDTO> selectFileList(int notice_no);
	int noticeno();
	QnaDTO selectQnaResponse(int qna_no);
	void deleteNotice(NoticeDTO dto);
	int updateNotice(NoticeDTO dto);
	


	
}
