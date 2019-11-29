DROP TABLE NOTICE;

CREATE TABLE NOTICE(
NOTICE_NUMBER NUMBER PRIMARY KEY,
NOTICE_NAME VARCHAR2(40) REFERENCES  USERS (USER_ID),
NOTICE_SUBJECT VARCHAR2(100),
NOTICE_CONTENT VARCHAR2(300),
NOTICE_DATE DATE
);	


INSERT INTO NOTICE VALUES((select nvl(max(NOTICE_NUMBER),0) from NOTICE)+1,
'admin1','공지사항 1','공지사항 1 입니다.',sysdate
);

INSERT INTO NOTICE VALUES((select nvl(max(NOTICE_NUMBER),0) from NOTICE)+1,
'admin3','공지사항 2','공지사항 2 입니다.',sysdate
);

INSERT INTO NOTICE VALUES((select nvl(max(NOTICE_NUMBER),0) from NOTICE)+1,
'admin2','공지사항 3','공지사항 3 입니다.',sysdate
);

