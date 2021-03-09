package trip.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import trip.dto.CourseDTO;
import trip.dto.FileDTO;
import trip.dto.NoticeDTO;
import trip.dto.QnaDTO;
import trip.dto.TripDTO;

@Mapper
public interface AdminMapper {

	List<QnaDTO> selectQnaList(String id);
	QnaDTO selectQna(int qna_no);
	int selectqnaCount();
	List<QnaDTO> selectQnaAdminList(int page);
	int insertResponse(QnaDTO qnaDto);
	int deleteResponse(int qna_no);
	List<NoticeDTO> selectNoticeList(int page);
	int newnno();
	int selectnoticeCount();
	int insertNotice(NoticeDTO dto);
	void insertFileList(FileDTO fileDTO);
	NoticeDTO selectNotice(int notice_no);
	List<FileDTO> selectFileList(int notice_no);
	int noticeno();
	QnaDTO selectQnaResponse(int qna_no);
	void deleteNotice(NoticeDTO dto);
	int updateNotice(NoticeDTO dto);
	List<CourseDTO> selectCourseList(String area_name);
	int tripUpdateInfo(TripDTO dto);
	int deleteTripInfo(String trip_no);
	List<String> selectAreaList();
	String searchTripNo(String area);
	int tripInsertInfo(TripDTO dto);
	void courseInsertInfo(HashMap<String, Object> map);
	void courseDelete(String trip_no);
	void updateFileList(FileDTO fileDTO);
	int createTripLike(String trip_no);
	int createTripRating(String trip_no);
	
}
