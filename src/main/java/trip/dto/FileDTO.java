package trip.dto;

import java.io.File;

//파일 정보를 저장
public class FileDTO {
	private int nno;
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

	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	@Override
	public String toString() {
		return "FileDTO [nno=" + nno + ", fileName=" + fileName + ", writer=" + writer + ", type=" + type + "]";
	}
	
	
	
}
