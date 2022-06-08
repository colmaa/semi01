-- movie.sql
drop table comments;
drop table movie;
create table movie
(
	mnum number(5) primary key,
	title varchar2(50),
	content varchar2(100),
	director varchar2(20)
);
create table comments
(
	num number(5) primary key, -- 댓글번호
	mnum number(5) references movie(mnum), -- 영화번호
	id varchar2(10), -- 작성자
	comments varchar2(100) -- 내용
);
create sequence movie_seq;
create sequence comments_seq;

insert into movie values(movie_seq.nextval,'닥터스트레인지','무서운영화','이감독');
insert into movie values(movie_seq.nextval,'토르','재밌는영화','김감독');
insert into comments values(comments_seq.nextval,1,'길동이','재미나요!');
insert into comments values(comments_seq.nextval,1,'삼동이','무서워요!');
insert into comments values(comments_seq.nextval,2,'사동이','신나요!');
commit;









