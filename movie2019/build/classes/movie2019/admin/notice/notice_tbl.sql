create table notice_tbl(
   NOTICE_NUM 	NUMBER,		
   NOTICE_NAME 	VARCHAR2(30),
   NOTICE_SUBJECT 	VARCHAR2(30),
   NOTICE_CONTENT VARCHAR2(300),
   NOTICE_DATE DATE,
   PRIMARY KEY(NOTICE_NUM)
);

select * from notice_tbl

