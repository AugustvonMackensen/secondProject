DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;
DROP TABLE ANSWER CASCADE CONSTRAINTS;
DROP TABLE BILL CASCADE CONSTRAINTS;
DROP TABLE NOTICE CASCADE CONSTRAINTS;
DROP TABLE BOARD CASCADE CONSTRAINTS;
commit;
CREATE TABLE MEMBER(
    USERID VARCHAR2(20) CONSTRAINT PK_MEMBER_UID PRIMARY KEY,
    USERPWD VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(100) NOT NULL,
    LOGINOK CHAR(1) DEFAULT 'Y',
    ADMIN CHAR(1) DEFAULT 'N',
    ENROLL_DATE DATE DEFAULT SYSDATE
);



-- 이메일 제약조건 추가 
ALTER TABLE MEMBER
ADD CONSTRAINT MAIL_UNIQUE UNIQUE(EMAIL);

COMMENT ON COLUMN MEMBER.USERID IS '아이디';
COMMENT ON COLUMN MEMBER.USERPWD IS '패스워드';
COMMENT ON COLUMN MEMBER.USERNAME IS '이름';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.LOGINOK IS '로그인 활성/비활성 여부';
COMMENT ON COLUMN MEMBER.ADMIN IS '관리자 모드인지 확인여부';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입한 날짜';
-- TRIGGER 작성 : 이름 - TRI_INSERT_USERS
-- MEMBER 테이블에 새 회원정보가 기록되면, 자동으로 USERS 테이블에 아이디, 암호, 이름이
-- INSERT 되게 함


CREATE TABLE BILL (
   ID   NUMBER generated always as identity,
   USERID   VARCHAR2(20)      NOT NULL,
   BILL_TIMESTAMP   TIMESTAMP     NOT NULL,
   BILL_PRICE   NUMBER      NOT NULL,
   BILL_CONTENT   VARCHAR2(1000)      NULL,
   BILL_CATEGORY   VARCHAR2(20)     NOT NULL,
   BILL_CARDINFO  VARCHAR2(30)      NULL,
   BILL_STOREINFO_NAME VARCHAR2(30) NULL,
   BILL_STOREINFO_BIZNUM VARCHAR2(30) NULL,
   BILL_STOREINFO_TEL VARCHAR2(20) NULL
);

COMMENT ON COLUMN BILL.ID IS 'PK 생성 용도';

COMMENT ON COLUMN BILL.USERID IS '회원 아이디';

COMMENT ON COLUMN BILL.BILL_TIMESTAMP IS '영수증 날짜, 시간';

COMMENT ON COLUMN BILL.BILL_PRICE IS '영수증 총액';

COMMENT ON COLUMN BILL.BILL_CONTENT IS '영수증 결제된 내역 점표명 및 장소';

COMMENT ON COLUMN BILL.BILL_CATEGORY IS '영수증 지출 내역 분류';

COMMENT ON COLUMN BILL.BILL_CARDINFO IS '카드정보';

COMMENT ON COLUMN BILL.BILL_STOREINFO_NAME IS '상호명';

COMMENT ON COLUMN BILL.BILL_STOREINFO_BIZNUM IS '사업자번호';

COMMENT ON COLUMN BILL.BILL_STOREINFO_TEL IS '매장 전화번호';

CREATE TABLE QUESTION (
   Q_NO   NUMBER  generated always as identity,
   Q_WRITER   VARCHAR2(20)      NOT NULL,
   Q_TITLE   VARCHAR2(200)      NOT NULL,
   Q_DATE   DATE      NOT NULL,
   Q_CONTENT   VARCHAR2(1000)      NOT NULL,
   Q_ORIGINAL_FILENAME	VARCHAR2(100),
   Q_RENAME_FILENAME   VARCHAR2(100),
   Q_READCOUNT   NUMBER DEFAULT 0
);

COMMENT ON COLUMN QUESTION.Q_NO IS '질문번호(시퀀스)';

COMMENT ON COLUMN QUESTION.Q_WRITER IS '사용자(User) 아이디';

COMMENT ON COLUMN QUESTION.Q_CONTENT IS '질문내용';

COMMENT ON COLUMN QUESTION.Q_ORIGINAL_FILENAME IS '원본파일';

COMMENT ON COLUMN QUESTION.Q_RENAME_FILENAME IS '수정파일';

COMMENT ON COLUMN QUESTION.Q_READCOUNT IS '조회수';


CREATE TABLE ANSWER (
   A_ID   NUMBER generated always as identity,
   A_REF   NUMBER      NOT NULL,
   A_WRITER   VARCHAR2(20)      NOT NULL,
   A_TITLE   VARCHAR2(200)      NOT NULL,
   A_DATE   DATE      NOT NULL,
   A_CONTENT   VARCHAR2(1000)      NOT NULL
);

COMMENT ON COLUMN ANSWER.A_REF IS '원글 질문에 대한 답변 번호';

COMMENT ON COLUMN ANSWER.A_WRITER IS '관리자(Manager) 아이디';

COMMENT ON COLUMN ANSWER.A_CONTENT IS '답변내용';

ALTER TABLE BILL ADD CONSTRAINT PK_BILL PRIMARY KEY (
   ID
);



ALTER TABLE QUESTION ADD CONSTRAINT PK_QUESTION PRIMARY KEY (
   Q_NO
);

ALTER TABLE ANSWER ADD CONSTRAINT PK_ANSWER PRIMARY KEY (
   A_ID
);

ALTER TABLE BILL ADD CONSTRAINT FK_LOGIN_TO_BILL_1 FOREIGN KEY (
   USERID
)
REFERENCES MEMBER (
   USERID
);

ALTER TABLE QUESTION ADD CONSTRAINT FK_LOGIN_TO_QUESTION_1 FOREIGN KEY (
   Q_WRITER
)
REFERENCES MEMBER (
   USERID
);

ALTER TABLE ANSWER ADD CONSTRAINT FK_QUESTION_TO_ANSWER_1 FOREIGN KEY (
   A_REF
)
REFERENCES QUESTION (
   Q_NO
);

ALTER TABLE ANSWER ADD CONSTRAINT FK_LOGIN_TO_ANSWER_1 FOREIGN KEY (
   A_WRITER
)
REFERENCES MEMBER (
   USERID
);

INSERT INTO MEMBER VALUES('admin', '$2a$10$eMMSX0zYIgkpGCVmmRP0lOMan8lXTlU5vY1mJbICBKNKsJYdNMSsS', '관리자', 'admin@deepaccount.com', 'Y', 'Y', sysdate);
INSERT INTO MEMBER VALUES('user02', '$2a$10$eMMSX0zYIgkpGCVmmRP0lOMan8lXTlU5vY1mJbICBKNKsJYdNMSsS', '사용자2', 'user02@deepaccount.com', 'Y', 'N', sysdate);
INSERT INTO MEMBER VALUES('user03', '$2a$10$eMMSX0zYIgkpGCVmmRP0lOMan8lXTlU5vY1mJbICBKNKsJYdNMSsS', '사용자3', 'user03@deepaccount.com', 'Y', 'N', sysdate);
INSERT INTO MEMBER VALUES('user04', '$2a$10$eMMSX0zYIgkpGCVmmRP0lOMan8lXTlU5vY1mJbICBKNKsJYdNMSsS', '사용자4', 'user04@deepaccount.com', 'Y', 'N', sysdate);

INSERT INTO QUESTION VALUES(default, 'user02', '2질문 사항이 있습니다.', sysdate, '이 사이트는 어떻게 사용하나요?', null, null, default);
INSERT INTO QUESTION VALUES(default, 'user03', '3질문 사항이 있습니다.', sysdate, '이 사이트는 어떻게 탈퇴하나요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '4질문 사항이 있습니다.', sysdate, '이 사이트는 요청사항이 언제 개선되나요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '5질문 사항이 있습니다.', sysdate, '기한내에 마감이 가능한가요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '6질문 사항이 있습니다.', sysdate, '무사히 끝날 수 있을까요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '7질문 사항이 있습니다.', sysdate, '어디로 가야할까요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '8질문 사항이 있습니다.', sysdate, '어디를 수정해야할까요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '9질문 사항이 있습니다.', sysdate, '오늘 점심은 무엇을 먹을까요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '10질문 사항이 있습니다.', sysdate, '무엇을 눌러야 하는 지 모르겠네요', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '11질문 사항이 있습니다.', sysdate, '회원가입을 어떻게 하나요?', null, null,  default);
INSERT INTO QUESTION VALUES(default, 'user04', '12질문 사항이 있습니다.', sysdate, '테스트가 무사히 끝났으면 하네요?', null, null,  default);

INSERT INTO ANSWER VALUES(default, 1, 'admin', '사이트 사용법', sysdate, '이 사이트는 이렇게 사용합니다. 참고하세요.');
INSERT INTO ANSWER VALUES(default, 2, 'admin', '사이트 사용법', sysdate, '이 사이트 탈퇴 메뉴얼을 참고하세요.');
INSERT INTO ANSWER VALUES(default, 3, 'admin', '사이트 사용법', sysdate, '곧 개선됩니다. 조금만 기다려주세요.');

INSERT INTO BILL VALUES(default, 'user02', sysdate, 10000, '즉석떡볶이', '음식',null,null,null,null);
INSERT INTO BILL VALUES(default, 'user03', sysdate, 30800, '피아노 학원 등록', '취미',null,null,null,null);
INSERT INTO BILL VALUES(default, 'user04', sysdate, 42000, '택시비 및 버스비', '교통비',null,null,null,null);
COMMIT;

-- 관리자인 'admin' 인 아이디의 컬럼값 변경
UPDATE MEMBER
SET ADMIN = 'Y'
WHERE USERID = 'admin';

commit;


-- notice 테이블
DROP TABLE NOTICE;

CREATE TABLE NOTICE(
  NOTICENO NUMBER CONSTRAINT PK_NOTICENO PRIMARY KEY,
  NOTICETITLE VARCHAR2(50) NOT NULL,
  NOTICEDATE DATE DEFAULT SYSDATE,
  NOTICEWRITER VARCHAR2(15) NOT NULL,
  NOTICECONTENT VARCHAR2(2000),
  original_filepath VARCHAR2(100),
  rename_filepath VARCHAR2(100),
  readcount number default 0 ,
  importance NUMBER default 1, -- 중요도, 1이 일반, 2가 중요도
  CONSTRAINT FK_NOTICEWRITER FOREIGN KEY (NOTICEWRITER) 
      REFERENCES MEMBER ON DELETE CASCADE
);

COMMIT;

INSERT INTO NOTICE VALUES (1, '공지 서비스 오픈', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), 
'공지 서비스 오픈2', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈3', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈4', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈5', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈6', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈7', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈8', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈9', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '공지 서비스 오픈10', SYSDATE, 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '신입사원 모집공고', 
TO_DATE('2016-07-15', 'RRRR-MM-DD'), 'user02', 
'공지 서비스가 오픈되었습니다. 많이 이용해 주세요.', null, null, default, default);
INSERT INTO NOTICE VALUES ((select max(noticeno) + 1 from notice), '신입사원 모집공고 마감', 
TO_DATE('2016-07-20', 'RRRR-MM-DD'), 'user02', 
'2016년 7월 20일 18시에 신입사원 모집을 마감합니다.', null, null, default, default);

SELECT * FROM NOTICE;
 
commit;

-- 관리자인 'admin' 인 아이디의 컬럼값 변경
UPDATE MEMBER
SET ADMIN = 'Y'
WHERE USERID = 'user11';

commit;

-- notice 의 공지글 등록은 관리자만 등록/수정할 수 있게 처리함
-- 공지글 등록자 아이디를 수정 : user01 >> admin 으로 변경
UPDATE NOTICE
SET NOTICEWRITER = 'admin';

commit;

select * from notice;

update notice
set importance = 1
where importance = 0;

DROP TABLE BOARD;

CREATE TABLE BOARD(
	BOARD_NUM	NUMBER,	
	BOARD_WRITER	 VARCHAR2(20) NOT NULL,
	BOARD_TITLE	VARCHAR2(50) NOT NULL,
	BOARD_CONTENT	VARCHAR2(2000) NOT NULL,
	BOARD_ORIGINAL_FILENAME	VARCHAR2(100),
    BOARD_RENAME_FILENAME VARCHAR2(100),
    BOARD_REF NUMBER,
	BOARD_REPLY_REF	NUMBER,
	BOARD_LEV	NUMBER DEFAULT 1,
	BOARD_REPLY_SEQ NUMBER DEFAULT 1,
	BOARD_READCOUNT	NUMBER DEFAULT 0,
	BOARD_DATE	DATE DEFAULT SYSDATE,
  CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_NUM),
  CONSTRAINT FK_BOARD_WRITER FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER (USERID) ON DELETE CASCADE
);

COMMENT ON COLUMN BOARD.BOARD_NUM IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '작성자아이디';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.BOARD_DATE IS '작성날짜';
COMMENT ON COLUMN BOARD.BOARD_ORIGINAL_FILENAME IS '원본첨부파일명';
COMMENT ON COLUMN BOARD.BOARD_RENAME_FILENAME IS '바뀐첨부파일명';
COMMENT ON COLUMN BOARD.BOARD_REF IS '원글번호';  -- 원글번호
COMMENT ON COLUMN BOARD.BOARD_REPLY_REF IS '참조답글번호';  -- 원글 : null, 원글의 답/댓글 : 자기번호, 답글의 답글 : 참조답글번호
COMMENT ON COLUMN BOARD.BOARD_LEV IS '답글단계'; -- 원글 : 1, 원글의 답글 : 2, 답글의 답글 : 3
COMMENT ON COLUMN BOARD.BOARD_REPLY_SEQ IS '답글순번'; -- 원글 : 0, 같은 원글의 답글일 때 : 1 ....... 순차처리

INSERT INTO BOARD 
VALUES (1, 'admin', '관리자 게시글', '저희 사이트를 이용해 주셔서 감사합니다.', 
NULL, NULL, 1, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (2, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 2, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (3, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 3, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (4, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 4, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (5, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 5, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (6, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 6, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (7, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 7, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (8, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 8, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (9, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 9, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (10, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 10, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (11, 'user01', 'MVC Model2', '웹 어플리케이션 설계 방식 중 MVC 디자인 패턴 모델2 방식의 한 유형입니다.', 
NULL, NULL, 11, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (12, 'user02', '설계방식2', '설계방식 2번째로는 First Controller 를 사용하는 방식이 있습니다.', 
NULL, NULL, 12, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD 
VALUES (13, 'user01', '설계방식3', '3번째 방식은 액션을 이용하는 방식입니다.', 
NULL, NULL, 13, null, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

SELECT * FROM BOARD;

COMMIT;

