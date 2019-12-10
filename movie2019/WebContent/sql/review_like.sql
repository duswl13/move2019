DROP TABLE REVIEW_LIKE;

CREATE TABLE REVIEW_LIKE(
MOVIE_ID NUMBER REFERENCES MOVIE (MOVIE_ID),
USER_ID VARCHAR2(40) REFERENCES USERS (USER_ID),
LIKE_ID VARCHAR2(40) REFERENCES USERS (USER_ID),
CONSTRAINT REVIEW_LIKE_primarykey PRIMARY KEY (MOVIE_ID, USER_ID,LIKE_ID)
);

/*���̺� ������ on delete cascade �ٿ�����*/

INSERT INTO REVIEW_LIKE VALUES(330457,'duswl13','sonyeonsoo');
INSERT INTO REVIEW_LIKE VALUES(330457,'duswl13','jiyeon');
INSERT INTO REVIEW_LIKE VALUES(330457,'duswl13','duswl13');
INSERT INTO REVIEW_LIKE VALUES(429617,'duswl13','jiyeon');
INSERT INTO REVIEW_LIKE VALUES(429617,'sonyeonsoo','sonyeonsoo');
INSERT INTO REVIEW_LIKE VALUES(429617,'duswl13','duswl13');

INSERT INTO REVIEW_LIKE VALUES(330457,'sonyeonsoo','duswl13');
INSERT INTO REVIEW_LIKE VALUES(330457,'sonyeonsoo','sonyeonsoo');
INSERT INTO REVIEW_LIKE VALUES(330457,'sonyeonsoo','jiyeon');

INSERT INTO REVIEW_LIKE VALUES(330457,'jiyeon','jiyeon');


/*�ش� ��ȭ ������ ���ƿ� �� ���� 3�� ���� ���� ������ ���Ĥ����̤̤�*/
SELECT ROWNUM, USER_ID, MOVIE_ID, count FROM
(SELECT USER_ID,MOVIE_ID, (SELECT COUNT(*) FROM
				REVIEW_LIKE 
				WHERE REVIEW_LIKE.USER_ID = REVIEW.USER_ID AND 
				REVIEW_LIKE.MOVIE_ID = REVIEW.MOVIE_ID) count
FROM REVIEW WHERE MOVIE_ID= 330457 ORDER BY count DESC) where rownum <= 3;

SELECT * FROM REVIEW_LIKE WHERE MOVIE_ID = 429617 and USER_ID='duswl13';

/*
SELECT * FROM 
				(SELECT (SELECT COUNT(*) FROM 
								REVIEW_LIKE 
								WHERE REVIEW_LIKE.USER_ID = REVIEW.USER_ID AND 
								REVIEW_LIKE.MOVIE_ID = REVIEW.MOVIE_ID) count, USER_ID,MOVIE_ID,REVIEW_TITLE,REVIEW_CONTENT,REVIEW_DATE
				FROM REVIEW WHERE MOVIE_ID= 330457 ORDER BY count DESC) where rownum <= 3;

			*/	
				

SELECT REVIEW_TITLE, REVIEW_CONTENT, (SELECT count(*) FROM REVIEW_LIKE WHERE REVIEW_LIKE.MOVIE_ID =REVIEW.MOVIE_ID AND REVIEW_LIKE.USER_ID=REVIEW.USER_ID AND LIKE_ID=REVIEW.USER_ID)
FROM REVIEW WHERE MOVIE_ID =330457 AND USER_ID='duswl13';

 
 SELECT * FROM
(SELECT USER_ID, MOVIE_ID, (SELECT COUNT(*) FROM
				REVIEW_LIKE 
				WHERE REVIEW_LIKE.USER_ID = REVIEW.USER_ID AND 
				REVIEW_LIKE.MOVIE_ID = REVIEW.MOVIE_ID) count
FROM REVIEW WHERE MOVIE_ID= 330457 ORDER BY count DESC);




SELECT * FROM 
				(SELECT 
				
						(SELECT COUNT(*) FROM 
								REVIEW_LIKE 
								WHERE REVIEW_LIKE.USER_ID = REVIEW.USER_ID AND 
								REVIEW_LIKE.MOVIE_ID = REVIEW.MOVIE_ID) count, /*���ƿ�*/
				
						(SELECT RATING_FACE_value FROM 
								RATING_FACE 
								WHERE RATING_FACE.USER_ID = REVIEW.USER_ID AND 
								RATING_FACE.MOVIE_ID = REVIEW.MOVIE_ID) face, /*ǥ������*/
						(SELECT RATING_STAR_value FROM 
								RATING_STAR 
								WHERE RATING_STAR.USER_ID = REVIEW.USER_ID AND 
								RATING_STAR.MOVIE_ID = REVIEW.MOVIE_ID) star, /*��������*/
						USER_ID,MOVIE_ID,REVIEW_TITLE,REVIEW_CONTENT,REVIEW_DATE
						
				FROM REVIEW WHERE MOVIE_ID= 330457 ORDER BY count DESC) where rownum <= 3;

