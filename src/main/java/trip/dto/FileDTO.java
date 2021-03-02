package trip.dto;

import java.io.File;

//파일 정보를 저장
public class FileDTO {
	private int nno;
	private int notice_no;
	private String fileName;
	private String writer;
	private String type;

	public FileDTO(File file,String writer) {
		super();
		this.fileName = file.getName();
		this.writer = writer;
		nno = 0;
		//error.png 
		switch(fileName.substring(fileName.lastIndexOf(".")+1)) {
		case "png":
		case "bmp":
		case "jpg":
		case "gif":
			type="image";
			break;
		case "mp4":
			type="video";
			break;
		default:
			type="normal";
		}
	}
	
	public FileDTO(int nno, int notice_no, String writer, String fileName) {
		super();
		this.nno = nno;
		this.notice_no = notice_no;
		this.writer = writer;
		this.fileName = fileName;
		switch(fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase()) {
		case "png":
		case "bmp":
		case "jpg":
		case "gif":
			type="image";
			break;
		case "mp4":
			type="video";
			break;
		default:
			type="normal";
		}
	}
	public FileDTO(int nno, String writer, String fileName) {
		super();
		this.nno = nno;
		this.writer = writer;
		this.fileName = fileName;
		switch(fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase()) {
		case "png":
		case "bmp":
		case "jpg":
		case "gif":
			type="image";
			break;
		case "mp4":
			type="video";
			break;
		default:
			type="normal";
		}
	}
	
	public FileDTO(int nno, String writer, String fileName, int notice_no) {
		super();
		this.nno = nno;
		this.writer = writer;
		this.fileName = fileName;
		this.notice_no = notice_no;
		switch(fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase()) {
		case "png":
		case "bmp":
		case "jpg":
		case "gif":
			type="image";
			break;
		case "mp4":
			type="video";
			break;
		default:
			type="normal";
		}
	}
	
	public FileDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}

	public int getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "FileDTO [nno=" + nno + ", notice_no=" + notice_no + ", fileName=" + fileName + ", writer=" + writer
				+ ", type=" + type + "]";
	}

	
	
	
	
}