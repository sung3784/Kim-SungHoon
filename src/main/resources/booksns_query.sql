
--------------------------- 테이블 & 시퀀스 드랍

drop table snsuser purge;
drop table book purge;
drop table feed purge;
drop table dm_list purge;
drop table dm_content purge;
drop table dm_alarm purge;
drop table relationship purge;
drop table alarm purge;
drop table favorite purge;
drop table photo purge;

drop sequence snsuser_seq;
drop sequence book_seq;
drop sequence feed_seq;
drop sequence dmNum_seq;
drop sequence dmContentId_seq;
drop sequence rel_seq;
drop sequence alram_seq;
drop sequence fav_seq;
drop sequence photo_seq;

--------------------------- 01. 사용자 정보 테이블 & 시퀀스 생성

create table snsuser (
    userNum number primary key,
    userId varchar2(70) unique not null /* UNIQUE */,
    email varchar2(300),
    userPwd varchar2(100) not null,
    saveFile varchar2(2000),
    originFile varchar2(2000),
    introduce varchar2(4000)
);

create sequence snsuser_seq;

--------------------------- 02. 책 정보 테이블 & 시퀀스 생성

create table book (
    bookNum NUMBER primary key,
    isbn varchar2(200),
    title varchar2(200),
    authors varchar2(200),
    publisher varchar2(500),
    memo varchar2(3000),
    categories varchar2(200),
    contents varchar2(3000),
    userId varchar2(70) /* CONSTRAINT book_fk REFERENCES snsuser(userID) ON DELETE CASCADE NOT NULL*/,
    regDate date default sysdate,
    noticeDate date default sysdate,
    price varchar2(200),
    thumbnail varchar2(1000),
    readYN varchar2(2) default 'N' constraint book_check check(readYN='Y' OR readYN='N')
);

create sequence book_seq;

--------------------------- 03. 피드 정보 테이블 & 시퀀스 생성

create table feed (
    feedNum number primary key,
    content varchar2(4000) not null,
    userid varchar2(70) /* constraint feed_fk references snsuser(userid) on delete cascade not null */,
    targetId varchar2(70),
    targetFeedNum number,
    originalFeedNum number,
    regDate Date default sysdate not null,
    tag varchar2(3000) not null,
    likeCount number default 0,
    spreadCount number default 0,
    depth number default 0,
    photoYN varchar2(2) CONSTRAINT feed_check check(photoYN='Y' OR photoYN='N')
);

create sequence feed_seq;

--------------------------- 04. DM 리스트 테이블 & 시퀀스 생성

CREATE table dm_list (
    dmNum number primary key,
    fromId varchar2(50),
    toId varchar2(50),
    regdate date default sysdate,
    constraint FK_fromId foreign key(fromId) references snsuser(userId) on delete cascade,
    constraint FK_toId foreign key(toiD) references snsuser(userId) on delete cascade
);

create sequence dmNum_seq;

--------------------------- 05. DM 컨텐츠 테이블 & 시퀀스 생성

CREATE table dm_content (
    dmContentId number primary key,
    dmNum number,
    dmUserId  varchar2(50),
    dmContent varchar2(1000),
    dmRegdate date DEFAULT SYSDATE,
    constraint FK_dmNum foreign key(dmNum) references DM_LIST(dmNum)    
);

create sequence dmContentId_seq;

--------------------------- 06. DM 알람 테이블 & 시퀀스 생성

create table DM_Alarm (
    dmNum number primary key,
    userId varchar2(70),
    alarmCheck varchar2(2) check(alarmCheck='0' or alarmCheck='1')
);

-- SEQUENCE 없음

--------------------------- 07. 관계 테이블 & 시퀀스 생성

create table relationship (
    rNum number primary key,
    loginId varchar2(70),
    followId varchar2(70)
);

create sequence rel_seq;

--------------------------- 08. 알람 테이블 & 시퀀스 생성

create table Alarm(
    noticeNum number primary key,
    noticeType varchar2(50),
    ownerId varchar2(70),
    loginId varchar2(70),
    fkNum number,
    regdate date,
    noticeDate date,
    alarmCheck varchar2(2) default 'N' check(alarmCheck='Y' or alarmCheck='N') 
);

create sequence alram_seq;

--------------------------- 09. 좋아요 테이블 & 시퀀스 생성

create table favorite (
    favNum number primary key,
    feedNum number constraint fav_fk references FEED(feedNum) on delete cascade not null, 
    id varchar2(50) 
);

create sequence fav_seq;

--------------------------- 10. photo 테이블 & 시퀀스 생성

create table photo (
    pNum number primary key,
    feedNum number constraint photo_fk references 
    feed(feedNum) on delete cascade,
    saveImg varchar2(100),
    originImg varchar2(100)
);

create sequence photo_seq;

--------------------------- 테이블 구조 확인

desc snsuser;
desc book;
desc feed;
desc dm_list;
desc dm_content;
desc dm_alarm;
desc relationship;
desc alarm;
desc favorite;
desc photo;

--------------------------- 테이블 데이터 확인

select * from snsuser;
select * from book;
select * from feed;
select content, to_char(regdate, 'yyyy/MM/dd HH:mm:ss') from feed;
select * from dm_list;
select * from dm_alarm;
select * from relationship;
select * from alarm;
select * from favorite;
select * from photo;

--------------------------- 사용 쿼리

commit;

select * from snsuser order by usernum;

-- 특정 유저의 소장 책 목록 중 특정 카테고리의 책을 북넘버별 정렬로 검색
select * from book where userid = 'bbb' and categories = '경제/경영' order by booknum desc;

-- 특정 유저의 소장 책 목록 카테고리별 정렬로 검색
select booknum, title, authors, categories, regdate, noticedate, userid from book 
where userid = 'bbb' order by categories desc;

-- 특정 유저의 소장 책 목록 등록날짜별 정렬로 검색
select booknum, title, authors, categories, regdate, noticedate, userid 
from book where userid = 'test' order by regdate;

-- 책 등록날짜 및 알람 날짜 변경
update book 
set 
    regdate = to_date('2018/06/12', 'yyyy/MM/dd'), 
    noticedate = to_date('2018/05/14', 'yyyy/MM/dd') 
where booknum = 272;

-- 특정 북넘버의 책 검색
select booknum, title, authors, categories, publisher, regdate, noticedate, userid 
from book where booknum = 58;

-- 특정 북 넘버의 작가 변경
update book set authors = '김훈' where booknum = 57;

-- 특정 북넘버의 작가 앞자리의 공백 제거하기
update book
set authors = substr(authors, 2)
where booknum = 54;

-- 작가가 null 이 아니면서 작가 컬럼의 가장 첫 글자가 공백인 경우의 북넘버 찾아오기    
select booknum from book 
where 
    authors is not null
    and
    authors like ' %';

-- 전체 등록되어있는 책 가져오기
select userid, booknum, title, authors, regdate, categories from book order by regdate desc;

-- 이번 달 사용자의 책 구매량
select count(*) bookCount from book 
where regdate between trunc(sysdate, 'MM') and sysdate
group by userId;

-- 책 구매량 별 사용자 수
select (
    case
        when bookCount <= 5 then '0~5권'
        when bookCount > 5  AND bookCount <= 10 THEN '6~10권'
        when bookCount > 10  AND bookCount <= 15 THEN '11~15권'
        when bookCount > 15  AND bookCount <= 20 THEN '16~20권'
        when bookCount > 20  AND bookCount <= 25 THEN '21~25권'
        else '25권 이상'
    end
) bookCount, count(*) userCount from
(select count(*) bookCount from book 
where regdate between trunc(sysdate, 'MM') and sysdate
group by userId) 
group by (
    case
        when bookCount <= 5 then '0~5권' -- 1 (1권)
        when bookCount > 5  AND bookCount <= 10 THEN '6~10권' -- 1 (7권)
        when bookCount > 10  AND bookCount <= 15 THEN '11~15권' -- 2 (11권, 15권)
        when bookCount > 15  AND bookCount <= 20 THEN '16~20권' -- 5 (16권 x2, 19권, 20권 x2)
        when bookCount > 20  AND bookCount <= 25 THEN '21~25권' -- 3 (21권)
        else '25권 이상'
    end
)
order by bookcount;

-- 가장 많은 책을 보유하고 있는 사람 3
select *
from 
    (select userid, count(*) bookCount from book
    group by userid order by bookcount desc)
where rownum <  4; 

