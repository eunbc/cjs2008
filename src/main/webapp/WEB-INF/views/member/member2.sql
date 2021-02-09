create table member2(
	idx 	int not null auto_increment, 
	mid		varchar(20) not null,
	pwd 	varchar(100) not null,
	name	varchar(20) not null,
	nickname varchar(20) not null,
	gender 	char(2) not null,
	birthday datetime default now(),
	tel		varchar(15) not null,
	email	varchar(50) not null,
	homepage varchar(50),
	address varchar(60),
	job 	varchar(10),
	hobby	varchar(50) default '',
	joinday datetime default now(),
	photo	varchar(100) default '1.jpg',
	content	text,
	point	int not null default 0,
	level	int not null default 4,		/* 0:관리자, 1: 특별회원 , 2:우수회원, 3:정회원, 4:준회원*/
	userInfor char(2) default 'OK',		/* OK: 공개 NO: 비공개 */
	userDel   char(2) default 'NO',
	primary key(idx,mid),
	unique(mid,nickname)	/*중복불허키*/
);

desc member2;

insert into member2 values(default, 'admin','1234','관리자','관리맨','남자','1995-03-29','010-7777-7777','admin@naver.com','admin.com','(28428)충북 청주시 흥덕구','개발자','러닝',default,default,'관리자 입니다',default,0,default,default);
select * from member2;
drop table member2;