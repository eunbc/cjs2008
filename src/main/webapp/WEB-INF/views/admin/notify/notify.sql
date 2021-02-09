create table notify (
	idx		int not null auto_increment primary key,
	name	varchar(20) not null,
	title	varchar(100) not null,	
	content text not null,
	startDate datetime default now(),
	endDate datetime default now(),
	popupSw	char(1) default 'N'
);

desc notify;

insert into notify values(default, '관리자', '설 특별대전','2021 설날을 맞이하여 세일행사를 진행합니다',default, default, default);
insert into notify values(default,'관리자','테스트1','테스트1',default,default,default);
insert into notify values(default,'관리자','테스트2','테스트2',default,default,default);
insert into notify values(default,'관리자','테스트3','테스트3',default,default,default);
insert into notify values(default,'관리자','테스트4','테스트4',default,default,default);
insert into notify values(default,'관리자','테스트5','테스트5',default,default,default);
insert into notify values(default,'관리자','테스트6','테스트6',default,default,default);
insert into notify values(default,'관리자','테스트7','테스트7',default,default,default);
insert into notify values(default,'관리자','테스트8','테스트8',default,default,default);
insert into notify values(default,'관리자','테스트9','테스트9',default,default,default);
insert into notify values(default,'관리자','테스트10','테스트10',default,default,default);
insert into notify values(default,'관리자','테스트11','테스트11',default,default,default);
select * from notify;