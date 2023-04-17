-- 1．建立学生表
CREATE TABLE student ( 
    sno CHAR ( 3 ) PRIMARY KEY, 
	sname CHAR ( 4 ), 
	sgender CHAR ( 2 ), 
	sage INT, 
	sclass CHAR ( 5 ) 
);
	
INSERT INTO student VALUES('108', '曾华', '男', 19, '95033');
INSERT INTO student VALUES('105', '匡明', '男', 20, '95031');
INSERT INTO student VALUES('107', '王丽', '女', 20, '95033');
INSERT INTO student VALUES('101', '李军', '男', 19, '95033');
INSERT INTO student VALUES('109', '王芳', '女', 22, '95031');
INSERT INTO student VALUES('103', '陆君', '男', 20, '95031');

-- 2．建立教师表
CREATE TABLE teacher (
	tno CHAR ( 3 ) PRIMARY KEY,
	tname CHAR ( 4 ),
	tgender CHAR ( 2 ),
	tage INT,
	tlevel CHAR ( 6 ),
    tlesson CHAR ( 8 ) 
);

INSERT INTO teacher VALUES('804', '李成', '男', 42, '副教授', '计算机系');
INSERT INTO teacher VALUES('856', '张旭', '男', 35, '讲师', '电子工程');
INSERT INTO teacher VALUES('825', '王萍', '女', 28, '助教', '计算机系');
INSERT INTO teacher VALUES('831', '刘冰', '女', 25, '助教', '电子工程');

-- 3．建立课程表
CREATE TABLE course (
	cno CHAR ( 5 ) PRIMARY KEY,
	cname CHAR ( 10 ),
    FOREIGN KEY ( tno ) REFERENCES teacher ( tno ) 
	tno CHAR ( 3 ),
);

INSERT INTO course VALUES('3-105', '计算机导论', '825');
INSERT INTO course VALUES('3-245', '操作系统', '804');
INSERT INTO course VALUES('6-166', '数字电路', '856');
INSERT INTO course VALUES('9-888', '高等数学', '831');

-- 4．建立选课表
CREATE TABLE sc (
	sno CHAR ( 3 ),
	cno CHAR ( 5 ),
	PRIMARY KEY ( sno, cno ),
	score INT,
	FOREIGN KEY ( sno ) REFERENCES student ( sno ),
	FOREIGN KEY ( cno ) REFERENCES course ( cno ) 
);

INSERT INTO sc VALUES('103', '3-245', 86);
INSERT INTO sc VALUES('105', '3-245', 75);
INSERT INTO sc VALUES('109', '3-245', 68);
INSERT INTO sc VALUES('103', '3-105', 92);
INSERT INTO sc VALUES('105', '3-105', 88);
INSERT INTO sc VALUES('109', '3-105', 76);
INSERT INTO sc VALUES('101', '3-105', 64);
INSERT INTO sc VALUES('107', '3-105', 91);
INSERT INTO sc VALUES('108', '3-105', 78);
INSERT INTO sc VALUES('101', '6-166', 85);
INSERT INTO sc VALUES('107', '6-166', 79);
INSERT INTO sc VALUES('108', '6-166', 81);

-- 5．所有表内容
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM teacher;
SELECT * FROM sc;

-- 作业题
# 1．查询选修课程“3-105”且成绩在 60 到 80 之间的所有记录。
# 注释：用于指定某个范围使用 BETWEEN AND，也可以使用 AND 连接符。
SELECT * FROM sc s JOIN course c USING(cno) WHERE score BETWEEN 60 AND 80;

# 2．查询成绩为 85、86 或 88 的记录。
# 注释：用于指定某个集合使用 IN 关键字，也可以使用 OR 连接符。
SELECT * FROM sc WHERE SCORE IN (85, 86, 88);

# 3．查询“95031”班的学生人数
# 注释：COUNT(*) 用于计算结果总数
SELECT COUNT(*) FROM student WHERE SCLASS = '95031';

# 查询最低分大于 70，且最高分小于 90 的学生信息。
# 注释：HAVING 后面跟聚合函数：AVG，MIN，MAX，COUNT；HAVING 语句只能跟在 GROUP BY 语句后面。
SELECT sno, sname FROM student st JOIN sc sc USING(sno) GROUP BY sno HAVING MAX(SCORE) < 90 AND MIN(SCORE) > 70;

# 5．查询至少有 5 名学生选修并以 3 开头的课程的平均成绩。
# 注释：GROUP BY 语句置于 WHERE 语句后面表示根据什么条件来分组。
SELECT cno, cname, avg(score) FROM student st JOIN sc sc USING (sno) JOIN course c USING(cno) WHERE cno LIKE '3%' GROUP BY cno, cname HAVING COUNT(SNO) >= 5;

# 6．查询平均分大于 80 分的学生的成绩表
# 注释：HAVING 后面跟聚合函数 AVG()。
SELECT st.*, sc.score FROM student st JOIN sc sc USING(sno) WHERE st.sno IN (SELECT sno FROM student st JOIN sc sc USING(sno) GROUP BY sno HAVING AVG(score) > 80);

# 7．查询“95033”班每个学生所选课程的平均分。
# 注释：此题是根据“95033”班学生的学号进行的分组，使用 WHERE 语句限制 GROUP BY 语句的分组条件。
SELECT sc.cno, AVG(score) FROM student st JOIN sc sc USING(sno) WHERE st.sclass = '95033' GROUP BY sc.cno;

# 8．以选修“3-105”为例，查询成绩高于“109”号同学的所有同学的记录
# 注释：此题使用典型的嵌套查询，层层深入
SELECT * FROM student st JOIN sc sc USING(sno) WHERE sc.score > (SELECT score from sc WHERE sno = '109' AND cno = '3-105') AND cno = '3-105';

# 9．查询与学号为“108”的同学同岁的所有学生的学号、姓名和年龄。
# 注释：当查询的结果集返回只有一个时关键字 IN 的作用等价于“=”的作用，但是注意“=”只能用于返回结果集只有一个，而 IN 可以有多个结果。
SELECT sno, sname, sage FROM student WHERE sage = (SELECT sage FROM student WHERE sno = '108');

# 10．查询每个老师授课不及格学生名单
SELECT * FROM teacher t JOIN course c USING(tno) JOIN sc sc USING(cno) JOIN student st USING(sno) WHERE sc.score < 60;

# 11．查询所有学生的平均成绩
SELECT sno, AVG(score) FROM sc JOIN student USING(sno) GROUP BY sno;

# 12．查询每个课程的最高分，显示课程名字和学生姓名和分数
SELECT cname, sname, maxscore FROM sc sc JOIN course USING (cno) JOIN (SELECT cno, MAX(score) maxscore FROM sc GROUP BY cno) cm ON (sc.cno = cm.cno AND sc.score = cm.maxscore) JOIN student st USING (sno) ;

# 13. 查询每个学生的授课老师
SELECT sno, sname, tno, tname FROM sc sc JOIN course c USING(cno) JOIN teacher t USING(tno) JOIN student s USING(sno);

# 14．查询每个班级每个课程的及格率
SELECT
	t1.sclass,
	t1.cno,
	CONCAT( TRUNCATE ( jg / zong * 100, 2 ), '%' ) 
FROM
	( SELECT sclass, cno, count(*) zong FROM student st JOIN sc sc USING ( sno ) GROUP BY sclass, cno ) t1
	JOIN 
	(SELECT sclass, cno, COUNT(*) jg FROM student st JOIN sc sc USING ( sno ) WHERE score > 60 GROUP BY sclass, cno ) t2 
	ON ( t1.sclass = t2.sclass AND t1.cno = t2.cno );