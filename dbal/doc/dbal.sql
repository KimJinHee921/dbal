
/* Drop Tables */

DROP TABLE CheckItem CASCADE CONSTRAINTS;
DROP TABLE CheckList CASCADE CONSTRAINTS;
DROP TABLE Comments CASCADE CONSTRAINTS;
DROP TABLE Card CASCADE CONSTRAINTS;
DROP TABLE BoardList CASCADE CONSTRAINTS;
DROP TABLE Board CASCADE CONSTRAINTS;
DROP TABLE ID_REPOSITORY CASCADE CONSTRAINTS;
DROP TABLE Invite CASCADE CONSTRAINTS;
DROP TABLE TeamInfo CASCADE CONSTRAINTS;
DROP TABLE Members CASCADE CONSTRAINTS;
DROP TABLE Team CASCADE CONSTRAINTS;




/* Create Tables */

-- 보드
CREATE TABLE Board
(
	-- 보드 ID : B_000000001
	board_id varchar2(10) NOT NULL,
	-- 보드 이름
	board_name varchar2(100) NOT NULL,
	-- 팀 ID : T_00000001
	team_id varchar2(10) NOT NULL,
	PRIMARY KEY (board_id)
);


-- 리스트
CREATE TABLE BoardList
(
	-- 리스트 ID : L_00000001
	list_id varchar2(10) NOT NULL,
	-- 리스트 이름
	list_name varchar2(100) NOT NULL,
	-- 순서
	order_no number NOT NULL,
	-- 보드 ID : B_000000001
	board_id varchar2(10) NOT NULL,
	PRIMARY KEY (list_id)
);


-- 카드
CREATE TABLE Card
(
	-- 카드 ID : C_00000001
	card_id varchar2(10) NOT NULL,
	-- 카드 이름
	card_name varchar2(100) NOT NULL,
	-- 설명
	description varchar2(500),
	-- 완료 날짜
	due_date date DEFAULT NULL,
	-- 완료 유무 : T/F
	done char DEFAULT 'F',
	-- 리스트 ID : L_00000001
	list_id varchar2(10) NOT NULL,
	PRIMARY KEY (card_id)
);


-- 체크 아이템
CREATE TABLE CheckItem
(
	-- 체크 아이템 ID : I_00000001
	item_id varchar2(10) NOT NULL,
	-- 내용
	item_name varchar2(100) NOT NULL,
	-- 완료 유무
	checked char DEFAULT 'F' NOT NULL,
	-- 체크리스트 ID : CH_0000001
	check_id varchar2(10) NOT NULL,
	-- 카드 ID : C_00000001
	card_id varchar2(10) NOT NULL,
	PRIMARY KEY (item_id)
);


-- 체크리스트
CREATE TABLE CheckList
(
	-- 체크리스트 ID : CH_0000001
	check_id varchar2(10) NOT NULL,
	-- 이름
	check_name varchar2(100) NOT NULL,
	-- 카드 ID : C_00000001
	card_id varchar2(10) NOT NULL,
	PRIMARY KEY (check_id)
);


-- 코멘트
CREATE TABLE Comments
(
	-- 코멘트 ID : C_00000001
	comment_id varchar2(10) NOT NULL,
	-- 코멘트 내용
	reply_comment varchar2(500) NOT NULL,
	-- 작성 시간
	create_date date DEFAULT SYSDATE,
	-- 카드 ID : C_00000001
	card_id varchar2(10) NOT NULL,
	-- 사용자 ID
	member_id varchar2(20) NOT NULL UNIQUE,
	PRIMARY KEY (comment_id)
);


-- 시퀀스
CREATE TABLE ID_REPOSITORY
(
	-- 테이블명
	Name varchar2(25) NOT NULL,
	-- 값
	Value number DEFAULT 0 NOT NULL
);


-- 초대발송
CREATE TABLE Invite
(
	-- 초대ID : V_00000001
	invite_id varchar2(10) NOT NULL,
	-- 초대 시간
	invite_date date DEFAULT SYSDATE,
	-- 초대 확인 유무
	confirm char DEFAULT 'F',
	-- 발송자 ID
	sender_id varchar2(20) NOT NULL,
	-- 수신자 ID
	receiver_id varchar2(20) NOT NULL,
	-- 팀 ID : T_00000001
	team_id varchar2(10) NOT NULL,
	PRIMARY KEY (invite_id)
);


-- 사용자
CREATE TABLE Members
(
	-- 사용자 ID
	member_id varchar2(20) NOT NULL,
	-- 이름
	name varchar2(20) NOT NULL,
	-- 비밀번호
	passwd varchar2(20) NOT NULL,
	-- 이메일
	email varchar2(30) NOT NULL UNIQUE,
	-- 가입날짜
	join_date date DEFAULT SYSDATE,
	PRIMARY KEY (member_id)
);


-- 팀
CREATE TABLE Team
(
	-- 팀 ID : T_00000001
	team_id varchar2(10) NOT NULL,
	-- 이름
	team_name varchar2(20) NOT NULL,
	PRIMARY KEY (team_id)
);


-- 팀 가입 정보
CREATE TABLE TeamInfo
(
	-- 팀 ID : T_00000001
	team_id varchar2(10) NOT NULL,
	-- 사용자 ID
	member_id varchar2(20) NOT NULL,
	-- 가입 날짜
	join_date date DEFAULT SYSDATE,
	PRIMARY KEY (team_id, member_id)
);



/* Create Foreign Keys */

ALTER TABLE BoardList
	ADD FOREIGN KEY (board_id)
	REFERENCES Board (board_id)
	ON DELETE CASCADE
;


ALTER TABLE Card
	ADD FOREIGN KEY (list_id)
	REFERENCES BoardList (list_id)
	ON DELETE CASCADE
;


ALTER TABLE CheckItem
	ADD FOREIGN KEY (card_id)
	REFERENCES Card (card_id)
	ON DELETE CASCADE
;


ALTER TABLE CheckList
	ADD FOREIGN KEY (card_id)
	REFERENCES Card (card_id)
	ON DELETE CASCADE
;


ALTER TABLE Comments
	ADD FOREIGN KEY (card_id)
	REFERENCES Card (card_id)
	ON DELETE CASCADE
;


ALTER TABLE CheckItem
	ADD FOREIGN KEY (check_id)
	REFERENCES CheckList (check_id)
	ON DELETE CASCADE
;


ALTER TABLE Comments
	ADD FOREIGN KEY (member_id)
	REFERENCES Members (member_id)
	ON DELETE CASCADE
;


ALTER TABLE Invite
	ADD FOREIGN KEY (sender_id)
	REFERENCES Members (member_id)
;


ALTER TABLE Invite
	ADD FOREIGN KEY (receiver_id)
	REFERENCES Members (member_id)
	ON DELETE CASCADE
;


ALTER TABLE TeamInfo
	ADD FOREIGN KEY (member_id)
	REFERENCES Members (member_id)
	ON DELETE CASCADE
;


ALTER TABLE Board
	ADD FOREIGN KEY (team_id)
	REFERENCES Team (team_id)
	ON DELETE CASCADE
;


ALTER TABLE Invite
	ADD FOREIGN KEY (team_id)
	REFERENCES Team (team_id)
	ON DELETE CASCADE
;


ALTER TABLE TeamInfo
	ADD FOREIGN KEY (team_id)
	REFERENCES Team (team_id)
	ON DELETE CASCADE
;



/* Comments */

COMMENT ON TABLE Board IS '보드';
COMMENT ON COLUMN Board.board_id IS '보드 ID : B_000000001';
COMMENT ON COLUMN Board.board_name IS '보드 이름';
COMMENT ON COLUMN Board.team_id IS '팀 ID : T_00000001';
COMMENT ON TABLE BoardList IS '리스트';
COMMENT ON COLUMN BoardList.list_id IS '리스트 ID : L_00000001';
COMMENT ON COLUMN BoardList.list_name IS '리스트 이름';
COMMENT ON COLUMN BoardList.order_no IS '순서';
COMMENT ON COLUMN BoardList.board_id IS '보드 ID : B_000000001';
COMMENT ON TABLE Card IS '카드';
COMMENT ON COLUMN Card.card_id IS '카드 ID : C_00000001';
COMMENT ON COLUMN Card.card_name IS '카드 이름';
COMMENT ON COLUMN Card.description IS '설명';
COMMENT ON COLUMN Card.due_date IS '완료 날짜';
COMMENT ON COLUMN Card.done IS '완료 유무 : T/F';
COMMENT ON COLUMN Card.list_id IS '리스트 ID : L_00000001';
COMMENT ON TABLE CheckItem IS '체크 아이템';
COMMENT ON COLUMN CheckItem.item_id IS '체크 아이템 ID : I_00000001';
COMMENT ON COLUMN CheckItem.item_name IS '내용';
COMMENT ON COLUMN CheckItem.checked IS '완료 유무';
COMMENT ON COLUMN CheckItem.check_id IS '체크리스트 ID : CH_0000001';
COMMENT ON COLUMN CheckItem.card_id IS '카드 ID : C_00000001';
COMMENT ON TABLE CheckList IS '체크리스트';
COMMENT ON COLUMN CheckList.check_id IS '체크리스트 ID : CH_0000001';
COMMENT ON COLUMN CheckList.check_name IS '이름';
COMMENT ON COLUMN CheckList.card_id IS '카드 ID : C_00000001';
COMMENT ON TABLE Comments IS '코멘트';
COMMENT ON COLUMN Comments.comment_id IS '코멘트 ID : C_00000001';
COMMENT ON COLUMN Comments.reply_comment IS '코멘트 내용';
COMMENT ON COLUMN Comments.create_date IS '작성 시간';
COMMENT ON COLUMN Comments.card_id IS '카드 ID : C_00000001';
COMMENT ON COLUMN Comments.member_id IS '사용자 ID';
COMMENT ON TABLE ID_REPOSITORY IS '시퀀스';
COMMENT ON COLUMN ID_REPOSITORY.Name IS '테이블명';
COMMENT ON COLUMN ID_REPOSITORY.Value IS '값';
COMMENT ON TABLE Invite IS '초대발송';
COMMENT ON COLUMN Invite.invite_id IS '초대ID : V_00000001';
COMMENT ON COLUMN Invite.invite_date IS '초대 시간';
COMMENT ON COLUMN Invite.confirm IS '초대 확인 유무';
COMMENT ON COLUMN Invite.sender_id IS '발송자 ID';
COMMENT ON COLUMN Invite.receiver_id IS '수신자 ID';
COMMENT ON COLUMN Invite.team_id IS '팀 ID : T_00000001';
COMMENT ON TABLE Members IS '사용자';
COMMENT ON COLUMN Members.member_id IS '사용자 ID';
COMMENT ON COLUMN Members.name IS '이름';
COMMENT ON COLUMN Members.passwd IS '비밀번호';
COMMENT ON COLUMN Members.email IS '이메일';
COMMENT ON COLUMN Members.join_date IS '가입날짜';
COMMENT ON TABLE Team IS '팀';
COMMENT ON COLUMN Team.team_id IS '팀 ID : T_00000001';
COMMENT ON COLUMN Team.team_name IS '이름';
COMMENT ON TABLE TeamInfo IS '팀 가입 정보';
COMMENT ON COLUMN TeamInfo.team_id IS '팀 ID : T_00000001';
COMMENT ON COLUMN TeamInfo.member_id IS '사용자 ID';
COMMENT ON COLUMN TeamInfo.join_date IS '가입 날짜';



