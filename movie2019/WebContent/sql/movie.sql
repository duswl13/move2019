DROP TABLE MOVIE;

CREATE TABLE MOVIE(
MOVIE_ID NUMBER PRIMARY KEY,
MOVIE_NAME VARCHAR2(150),
MOVIE_POSTER VARCHAR2(150)
);

/**ALTER TABLE MOVIE DROP COLUMN MOVIE_POSTER;

ALTER TABLE MOVIE ADD(MOVIE_POSTER VARCHAR2(150));


ALTER TABLE MOVIE MODIFY(MOVIE_NAME VARCHAR2(150));
**/

SELECT * FROM MOVIE;
INSERT INTO MOVIE VALUES(330457,'�ܿ�ձ� 2');
INSERT INTO MOVIE VALUES(429617,'�����̴���: �� ���� Ȩ');
INSERT INTO MOVIE VALUES(9738,'��Ÿ��ƽ 4');
INSERT INTO MOVIE VALUES(475557,'��Ŀ');
INSERT INTO MOVIE VALUES(420818,'���̿� ŷ');
INSERT INTO MOVIE VALUES(474350,'�װ�: �� ��° �̾߱�');
INSERT INTO MOVIE VALUES(399579,'�˸�Ÿ: ��Ʋ ����');
