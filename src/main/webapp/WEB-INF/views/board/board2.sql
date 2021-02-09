/*board2.sql*/

create table board2(
	idx 	int not null auto_increment,
	mid 	varchar(20) not null,
	name	varchar(20) not null,
	title	varchar(100) not null,
	email 	varchar(60),
	homepage varchar(60),
	pwd 	varchar(20) not null,
	wdate	datetime default now(),
	readnum int default 0,
	hostip  varchar(50) not null,
	content text not null,
	primary key(idx)
);

drop table board2;
desc board2;
select * from board2;
insert into board2 values (default,'admin','관리자','테스트1','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트2','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트3','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트4','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트5','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트6','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트7','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트8','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트9','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트10','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');
insert into board2 values (default,'admin','관리자','테스트11','admin@naver.com','www.admin.com','1234',default,default,'127.0.0.1','테스트');

/*대댓글 달기*/
create table boardReply2(
	idx			int not null auto_increment,
	boardIdx 	int not null,
	mid 		varchar(20) not null, /*수정, 삭제시 mid와 같을 때에만 할 수 있도록*/
	nickname 	varchar(20) not null,
	wdate		datetime not null default now(),
	hostip		varchar(50) not null,
	content 	text not null,
	level		int not null default 0,
	levelOrder	int not null default 0,
	primary key(idx),
	foreign key(boardIdx) references board2(idx)
);

drop table boardCont2;
desc boardCont2;

