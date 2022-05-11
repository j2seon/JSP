CREATE TABLE freeboard(
    id NUMBER CONSTRAINT PK_FREEBOARD_ID PRIMARY KEY, --자동 증가 걸럼 
    name VARCHAR2(10) NOT NULL,
    password VARCHAR2(100) NULL,
    email VARCHAR2(100) NULL,
    subject VARCHAR2(100) NOT NULL, -- 글제목
    content VARCHAR2(2000) NOT NULL, -- 글내용
    inputdate VARCHAR2(100) NOT NULL, -- 글을 쓴 날짜
    masterid NUMBER DEFAULT 0, -- 질문 답변형 게시판에서 답변의 글을 그루핑
    readcount NUMBER DEFAULT 0, -- 조회수
    replaynum NUMBER DEFAULT 0, -- 
    step NUMBER DEFAULT 0 -- 
);
SELECT * FROM FREEBOARD;