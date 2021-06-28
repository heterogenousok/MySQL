-- 例10：查询编号是1或3或8的学生
select * from students where id in(1,3,8);
-- 例11：查询编号为3至8的学生
select * from students where id between 3 and 8;

-- 比较两个表中数据的不同不可以使用not in 或者 in


-- 例13：查询没有填写身高的学生
select * from students where height is null;

-- 例14：查询填写了身高的男生
select * from students where height is not null and gender=1;


-- 例1：查询未删除男生信息，按学号降序
select * from students where gender=1 and is_delete=0 order by id;


-- 例2：查询未删除学生信息，按名称升序
select * from students where is_delete=0 order by name;


-- 例3：显示所有的学生信息，先按照年龄从大-->小排序，当年龄相同时 按照身高从高-->矮排序
select * from students  order by age desc,height desc;


-- 15.4聚合函数

-- 例1：查询学生总数
select count(*) from students;

-- 例2：查询女生的编号最大值
select max(height) from students where gender=2;

-- 例3：查询未删除的学生最小编号
select min(id) from students where is_delete=0;

-- 例4：查询男生的总年龄
select sum(age) from students where gender=1;

-- 平均年龄
select sum(age)/count(*) from students where gender=1;

select avg(age) from students where gender=1;


-- 15.5分组

select gender,count(gender) from students group by gender;
-- 每一种性别的平均年龄
select gender,avg(age) from students group by gender;
-- group_concat把字符串拼接在一起
select gender,group_concat(name) as name_list from students group by gender;

-- having是对groupby后的结果进行过滤
select gender,count(*) from students where is_delete=0 group by gender HAVING count(*)>2 ;

-- rollup是对数据进行一个汇总求和
select gender,count(*) from students group by gender with rollup;

-- limit使用
-- 例1：查询前3行男生信息
select * from students limit 2,4;

-- •求第1页的数据
select * from students limit 0,10;

SELECT CEILING(count(*)/5) from students;

-- 连接
-- 例1：使用内连接查询班级表与学生表
select * from students s inner join classes c on s.cls_id = c.id;

-- •此处使用了as为表起别名，目的是编写简单
select s.id,c.id as cid from students s left join classes as c on s.cls_id = c.id where c.id is null;

-- 新表在左边，备份表在右边,比较两个表中的不同，用left join,right join 

-- 例3：使用右连接查询班级表与学生表
select * from students as s right join classes as c on s.cls_id = c.id;

-- 自关联
create table areas(
    aid int primary key,
    atitle varchar(20),
    pid int
);

select count(*) from areas;

-- 和delete from区别是id会归位
truncate TABLE students;


-- •查询一共有多少个省
select * from areas where pid is null;


-- •例1：查询省的名称为“山西省”的所有城市
select c.* from areas c inner join areas p on c.pid=p.aid where p.atitle='山西省';

-- •例2：查询市的名称为“广州市”的所有区县
select dis.* from areas as dis
inner join areas as city on city.aid=dis.pid
where city.atitle='广州市';

-- 查询班级哪些学生的身高大于平均身高
select * from students where height > (select avg(height) from students);

-- 查询班里有学生的班级
select name from classes where id in (select DISTINCT cls_id from students);

select * from students where (height,age) = (select height,age from students where height=(select max(height) from students));

show create database python4;

show create table students;

CREATE TABLE `students_old` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT '',
  `age` tinyint unsigned DEFAULT '0',
  `height` decimal(5,2) DEFAULT NULL,
  `gender` enum('男','女','中性','保密') DEFAULT '保密',
  `cls_id` int unsigned DEFAULT '0',
  `is_delete` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- 把一个表的数据直接查出来插入到另外一个表
insert into students_old select * from students;

create table goods(
    id int unsigned primary key auto_increment not null,
    name varchar(150) not null,
    cate_name varchar(40) not null,
    brand_name varchar(40) not null,
    price decimal(10,3) not null default 0,
    is_show bit not null default 1,
    is_saleoff bit not null default 0
);

insert into goods values(0,'r510vc 15.6英寸笔记本','笔记本','华硕','3399',default,default); 
insert into goods values(0,'y400n 14.0英寸笔记本电脑','笔记本','联想','4999',default,default);
insert into goods values(0,'g150th 15.6英寸游戏本','游戏本','雷神','8499',default,default); 
insert into goods values(0,'x550cc 15.6英寸笔记本','笔记本','华硕','2799',default,default); 
insert into goods values(0,'x240 超极本','超级本','联想','4880',default,default); 
insert into goods values(0,'u330p 13.3英寸超极本','超级本','联想','4299',default,default); 
insert into goods values(0,'svp13226scb 触控超极本','超级本','索尼','7999',default,default); 
insert into goods values(0,'ipad mini 7.9英寸平板电脑','平板电脑','苹果','1998',default,default);
insert into goods values(0,'ipad air 9.7英寸平板电脑','平板电脑','苹果','3388',default,default); 
insert into goods values(0,'ipad mini 配备 retina 显示屏','平板电脑','苹果','2788',default,default); 
insert into goods values(0,'ideacentre c340 20英寸一体电脑 ','台式机','联想','3499',default,default); 
insert into goods values(0,'vostro 3800-r1206 台式电脑','台式机','戴尔','2899',default,default); 
insert into goods values(0,'imac me086ch/a 21.5英寸一体电脑','台式机','苹果','9188',default,default); 
insert into goods values(0,'at7-7414lp 台式电脑 linux ）','台式机','宏碁','3699',default,default); 
insert into goods values(0,'z220sff f4f06pa工作站','服务器/工作站','惠普','4288',default,default); 
insert into goods values(0,'poweredge ii服务器','服务器/工作站','戴尔','5388',default,default); 
insert into goods values(0,'mac pro专业级台式电脑','服务器/工作站','苹果','28888',default,default); 
insert into goods values(0,'hmz-t3w 头戴显示设备','笔记本配件','索尼','6999',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default); 
insert into goods values(0,'x3250 m4机架式服务器','服务器/工作站','ibm','6888',default,default); 
insert into goods values(0,'商务双肩背包','笔记本配件','索尼','99',default,default);


-- 窗口函数
select *,rank() over (partition by cls_id order by age desc) as rank1,
								 dense_rank() over (partition by cls_id order by age desc) as dese_rank,
									row_number() over (partition by cls_id order by age desc) as row_num  from students;

-- rank排名是相同名次会记录数目，dense_rank不会记录

select *,rank() over (order by age desc) as rank1,
								 dense_rank() over (order by age desc) as dese_rank,
									row_number() over (order by age desc) as row_num  from students;
									
-- 分组，就要做聚合，使用聚合函数，窗口函数是不减少数据条数									
select cls_id,max(age) from students group by cls_id;


-- 多对多关系
create table TEACHER(
ID int primary key,
NAME varchar(100)
);
insert into TEACHER values(1,'math teacher');
insert into TEACHER values(2,'chinese teacher');
insert into TEACHER values(3,'english teacher');

create table STUDENT3(
ID int primary key,
NAME varchar(100)
);

insert into STUDENT3 values(1,"lily");
insert into STUDENT3 values(2,"lucy");
insert into STUDENT3 values(3,"lilei");
insert into STUDENT3 values(4,"xiongda");


create table TEACHER_STUDENT(
T_ID int,
S_ID int,
primary key(T_ID,S_ID),
constraint T_ID_FK foreign key(T_ID) references TEACHER(ID),
constraint S_ID_FK foreign key(S_ID) references STUDENT3(ID));

-- 开始选课，2号学生选1号老师
insert into TEACHER_STUDENT VALUES(1,2);
insert into TEACHER_STUDENT VALUES(2,2);
insert into TEACHER_STUDENT VALUES(1,3);

-- 哪些学生选了哪些课
select t.`NAME`,s.`NAME` from TEACHER as t INNER JOIN TEACHER_STUDENT as ts on ts.T_ID=t.ID INNER JOIN STUDENT3 as s on s.ID=ts.S_ID;


select t.`NAME`,ts.S_ID from TEACHER as t LEFT JOIN TEACHER_STUDENT as ts on ts.T_ID=t.ID;

select t.`NAME`,s.`NAME` from TEACHER as t LEFT JOIN TEACHER_STUDENT as ts on ts.T_ID=t.ID LEFT JOIN STUDENT3 as s on s.ID=ts.S_ID;



select * from goods where id=1 or 1=1;