package movie2019.admin.notice;

import java.sql.Date;

public class NoticeVO {
	private int NOTICE_NUMBER;
	private String NOTICE_NAME;
	private String NOTICE_SUBJECT;
	private String NOTICE_CONTENT;
	private Date NOTICE_DATE;
	public int getNOTICE_NUMBER() {
		return NOTICE_NUMBER;
	}
	public void setNOTICE_NUMBER(int nOTICE_NUMBER) {
		NOTICE_NUMBER = nOTICE_NUMBER;
	}
	public String getNOTICE_NAME() {
		return NOTICE_NAME;
	}
	public void setNOTICE_NAME(String nOTICE_NAME) {
		NOTICE_NAME = nOTICE_NAME;
	}
	public String getNOTICE_SUBJECT() {
		return NOTICE_SUBJECT;
	}
	public void setNOTICE_SUBJECT(String nOTICE_SUBJECT) {
		NOTICE_SUBJECT = nOTICE_SUBJECT;
	}
	public String getNOTICE_CONTENT() {
		return NOTICE_CONTENT;
	}
	public void setNOTICE_CONTENT(String nOTICE_CONTENT) {
		NOTICE_CONTENT = nOTICE_CONTENT;
	}
	public Date getNOTICE_DATE() {
		return NOTICE_DATE;
	}
	public void setNOTICE_DATE(Date nOTICE_DATE) {
		NOTICE_DATE = nOTICE_DATE;
	}
	
}
