package trip.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import trip.dto.CourseDTO;
import trip.dto.FileDTO;
import trip.dto.NoticeDTO;
import trip.dto.QnaDTO;
import trip.dto.TripDTO;
import trip.enums.RoleType;
import trip.mapper.AdminMapper;
import trip.vo.PaggingVO;

@Service
public class AdminService {
	private AdminMapper mapper;

	public AdminService(AdminMapper mapper) {
		super();
		this.mapper = mapper;
	}

	public QnaDTO selectQna(int qna_no) {
		return mapper.selectQna(qna_no);
	}

	public int selectqnaCount() {
		return mapper.selectqnaCount();
	}

	public List<QnaDTO> selectAdminQnaList(int page) {
		return mapper.selectQnaAdminList(page);
	}

	public QnaDTO selectQnaResponse(int qna_no) {
		return mapper.selectQnaResponse(qna_no);
	}

	public int insertResponse(QnaDTO qnaDto) {
		return mapper.insertResponse(qnaDto);
	}

	public int selectnoticeCount() {
		return mapper.selectnoticeCount();
	}

	public List<NoticeDTO> selectNoticeList(int page) {
		return mapper.selectNoticeList(page);
	}

	public int newnno() {
		return mapper.newnno();
	}

	public int insertNotice(NoticeDTO dto) {
		return mapper.insertNotice(dto);

	}

	public void insertFileList(ArrayList<FileDTO> fList) {
		for (int i = 0; i < fList.size(); i++)
			mapper.insertFileList(fList.get(i));
	}

	public NoticeDTO selectNotice(int notice_no) {
		return mapper.selectNotice(notice_no);
	}

	public List<FileDTO> selectFileList(int notice_no) {
		return mapper.selectFileList(notice_no);
	}

	public int noticeno() {
		return mapper.noticeno();
	}

	public void deleteNotice(NoticeDTO dto) {
		mapper.deleteNotice(dto);

	}

	public int updateNotice(NoticeDTO dto) {
		return mapper.updateNotice(dto);
	}

	public List<CourseDTO> selectCourseList(String area_name) {
		return mapper.selectCourseList(area_name);
	}

	public int tripUpdateInfo(TripDTO dto) {
		return mapper.tripUpdateInfo(dto);
	}

	public int deleteTripInfo(String trip_no) {
		return mapper.deleteTripInfo(trip_no);
	}

	public int deleteResponse(int qna_no) {
		return mapper.deleteResponse(qna_no);
	}

	public List<String> selectAreaList() {
		return mapper.selectAreaList();
	}

	public String searchTripNo(String area) {
		return mapper.searchTripNo(area);
	}

	public int tripInsertInfo(TripDTO dto) {
		return mapper.tripInsertInfo(dto);
	}

	public int courseInsertInfo(ArrayList<String> placeList, String trip_no) {
		int count=0;
		for(int i=0; i<placeList.size(); i++) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("place_no", placeList.get(i));
			map.put("course_no", i+1);
			map.put("trip_no", trip_no);
			mapper.courseInsertInfo(map);
			count++;
		}
		return count;
	}

	public void courseDelete(String trip_no) {
		mapper.courseDelete(trip_no);
	}

	public void updateFileList(ArrayList<FileDTO> fList) {
		for(int i = 0;i<fList.size();i++)
			mapper.updateFileList(fList.get(i));
	}
	
}
