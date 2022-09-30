DROP TABLE MEMBER CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;
DROP TABLE ANSWER CASCADE CONSTRAINTS;
DROP TABLE BILL CASCADE CONSTRAINTS;
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
   BILL_STOREINFO_BIZNUM VARCHAR2(30) NULL
);

COMMENT ON COLUMN BILL.ID IS 'PK 생성 용도';

COMMENT ON COLUMN BILL.USERID IS '회원 아이디';

COMMENT ON COLUMN BILL.BILL_TIMESTAMP IS '영수증 날짜, 시간';

COMMENT ON COLUMN BILL.BILL_PRICE IS '영수증 총액';

COMMENT ON COLUMN BILL.BILL_CONTENT IS '영수증 결제된 내역 점표명 및 장소';

COMMENT ON COLUMN BILL.BILL_CATEGORY IS '영수증 지출 내역 분류';

COMMENT ON COLUMN BILL.BILL_CARDINFO IS '카드정보';

COMMENT ON COLUMN BILL.BILL_STOREINFO_NAME IS '가게이름';

COMMENT ON COLUMN BILL.BILL_STOREINFO_BIZNUM IS '사업자번호';

CREATE TABLE QUESTION (
   Q_NO   NUMBER  generated always as identity,
   Q_WRITER   VARCHAR2(20)      NOT NULL,
   Q_TITLE   VARCHAR2(200)      NOT NULL,
   Q_DATE   DATE      NOT NULL,
   Q_CONTENT   VARCHAR2(1000)      NOT NULL,
   Q_UPFILE   VARCHAR2(100)      NULL,
   READCOUNT   NUMBER      NOT NULL
);

COMMENT ON COLUMN QUESTION.Q_NO IS '질문번호(시퀀스)';

COMMENT ON COLUMN QUESTION.Q_WRITER IS '사용자(User) 아이디';

COMMENT ON COLUMN QUESTION.Q_CONTENT IS '질문내용';

COMMENT ON COLUMN QUESTION.Q_UPFILE IS '첨부파일';


CREATE TABLE ANSWER (
   A_ID   NUMBER generated always as identity,
   A_NO   NUMBER      NOT NULL,
   A_WRITER   VARCHAR2(20)      NOT NULL,
   A_TITLE   VARCHAR2(200)      NOT NULL,
   A_DATE   DATE      NOT NULL,
   A_CONTENT   VARCHAR2(1000)      NOT NULL,
   A_UPFILE   VARCHAR2(100)      NULL
);

COMMENT ON COLUMN ANSWER.A_NO IS '원글 질문에 대한 답변 번호(시퀀스)';

COMMENT ON COLUMN ANSWER.A_WRITER IS '관리자(Manager) 아이디';

COMMENT ON COLUMN ANSWER.A_CONTENT IS '답변내용';

COMMENT ON COLUMN ANSWER.A_UPFILE IS '첨부파일';

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
   A_NO
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

INSERT INTO QUESTION VALUES(default, 'user02', '2질문 사항이 있습니다.', sysdate, '이 사이트는 어떻게 사용하나요?', '첨부파일', 3);
INSERT INTO QUESTION VALUES(default, 'user03', '3질문 사항이 있습니다.', sysdate, '이 사이트는 어떻게 탈퇴하나요?', '첨부파일', 5);
INSERT INTO QUESTION VALUES(default, 'user04', '4질문 사항이 있습니다.', sysdate, '이 사이트는 요청사항이 언제 개선되나요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '5질문 사항이 있습니다.', sysdate, '기한내에 마감이 가능한가요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '6질문 사항이 있습니다.', sysdate, '무사히 끝날 수 있을까요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '7질문 사항이 있습니다.', sysdate, '어디로 가야할까요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '8질문 사항이 있습니다.', sysdate, '어디를 수정해야할까요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '9질문 사항이 있습니다.', sysdate, '오늘 점심은 무엇을 먹을까요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '10질문 사항이 있습니다.', sysdate, '무엇을 눌러야 하는 지 모르겠네요', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '11질문 사항이 있습니다.', sysdate, '회원가입을 어떻게 하나요?', '첨부파일', 7);
INSERT INTO QUESTION VALUES(default, 'user04', '12질문 사항이 있습니다.', sysdate, '테스트가 무사히 끝났으면 하네요?', '첨부파일', 7);

INSERT INTO ANSWER VALUES(default, 1, 'admin', '사이트 사용법', sysdate, '이 사이트는 이렇게 사용합니다. 참고하세요.', '첨부파일');
INSERT INTO ANSWER VALUES(default, 2, 'admin', '사이트 사용법', sysdate, '이 사이트 탈퇴 메뉴얼을 참고하세요.', '첨부파일');
INSERT INTO ANSWER VALUES(default, 3, 'admin', '사이트 사용법', sysdate, '곧 개선됩니다. 조금만 기다려주세요.', '첨부파일');

INSERT INTO BILL VALUES(default, 'user02', sysdate, 10000, '즉석떡볶이', '음식',null,null,null);
INSERT INTO BILL VALUES(default, 'user03', sysdate, 30800, '피아노 학원 등록', '취미',null,null,null);
INSERT INTO BILL VALUES(default, 'user04', sysdate, 42000, '택시비 및 버스비', '교통비',null,null,null);
COMMIT;

-- 관리자인 'admin' 인 아이디의 컬럼값 변경
UPDATE MEMBER
SET ADMIN = 'Y'
WHERE USERID = 'admin';

commit;