# 01．列出至少有三个员工的所有部门。
SELECT d.DNAME FROM emp e JOIN dept d ON(e.DEPTNO = d.DEPTNO) GROUP BY d.DNAME HAVING COUNT(e.ENAME) >= 3;

# 02．列出薪金比“SMITH”多的员工。 
SELECT * FROM emp e WHERE SAL > (SELECT SAL FROM emp WHERE ENAME = 'SMITH');

# 03．列出所有员工的姓名以及直接上级的姓名。
SELECT e.ENAME, m.ENAME FROM emp e, emp m WHERE e.MGR = m.EMPNO;

# 04．列出受雇日期早于其直接上级的所有员工。
SELECT e.ENAME en, m.ENAME mn, e.HIREDATE eh, m.HIREDATE mh FROM emp e, emp m WHERE e.MGR = m.EMPNO AND m.HIREDATE > e.HIREDATE; 

# 05．列出部门名称和这些部门的员工信息，包括那些没有员工的部门
SELECT d.DNAME, e.ENAME FROM emp e RIGHT JOIN dept d USING(DEPTNO); 

# 06．列出所有 job 为“CLERK”（办事员）的姓名以及部门名称。
SELECT d.DNAME, e.ENAME FROM emp e JOIN dept d USING(DEPTNO) WHERE e.JOB = "CLERK";

# 07．列出最低薪金大于 1500 的工作。
SELECT JOB FROM emp e GROUP BY JOB HAVING MIN(SAL) < 1500;

# 08．列出在部门“SALES”（销售部）工作的员工的姓名，假定不知道销售部的部门编号。
SELECT * FROM emp e JOIN dept d USING(DEPTNO) WHERE d.DNAME = 'SALES';

# 09．列出薪金高于公司平均薪金的所有员工。
SELECT * FROM emp WHERE SAL > (SELECT AVG(SAL) FROM EMP);

# 10．列出与“SCOTT”从事相同工作的所有员工。
SELECT * FROM emp WHERE JOB = (SELECT JOB FROM emp WHERE ENAME = 'SCOTT') AND ENAME <> 'SCOTT';

# 11．列出薪金等于部门 30 中员工的薪金的所有员工的姓名和薪金。
SELECT ENAME, SAL FROM emp WHERE SAL IN (SELECT SAL FROM emp WHERE DEPTNO = 30) AND DEPTNO <> 30;

# 12．列出薪金高于在部门 30 工作的所有员工的薪金的员工姓名和薪金。
SELECT ENAME, SAL FROM emp WHERE SAL > ALL(SELECT SAL FROM emp WHERE DEPTNO = 30) AND DEPTNO <> 30;

SELECT ENAME, SAL FROM emp WHERE SAL > (SELECT MAX(SAL) FROM emp WHERE DEPTNO = 30) AND DEPTNO <> 30;

# 13．列出在每个部门工作的员工数量、平均工资和平均服务期限。
SELECT DEPTNO, COUNT(ENAME), AVG(SAL), AVG(Datediff (NOW(), HIREDATE)) FROM emp e RIGHT JOIN dept d USING(DEPTNO) GROUP BY DEPTNO;

# 14．列出所有员工的姓名、部门和工资。
SELECT e.ENAME, d.DNAME, E.SAL FROM emp e JOIN dept d USING(DEPTNO);

# 15．列出从事同一种工作但属于不同部门的员工的一种组合。
SELECT e.EMPNO, e.ENAME, m.EMPNO, m.ENAME, m.JOB FROM emp e, emp m WHERE e.JOB = m.JOB AND e.EMPNO > m.EMPNO AND e.DEPTNO <> m.DEPTNO;

# 16．列出所有部门的详细信息和部门人数
SELECT d.DNAME, COUNT(EMPNO) FROM emp e JOIN dept d USING(DEPTNO) GROUP BY d.DNAME;

# 17．列出各种工作的最低工资
SELECT MIN(SAL) FROM emp GROUP BY JOB;

# 18．列出各个部门的 MANAGER （经理）的最低薪资（JOB 为 MANAGER)
SELECT MIN(SAL) FROM emp WHERE emp.JOB = 'MANAGER' GROUP BY DEPTNO;
# 19．列出所有员工的年工资，按年薪从低到高排序。
SELECT ENAME, (SAL + IFNULL(COMM, 0)) * 12 sm FROM emp ORDER BY sm;

# 20．列出所有　JOB = 'CLERK' 的员工的平均薪资
SELECT AVG(SAL) FROM emp WHERE JOB = 'CLERK';

# 21．列出 JOB = 'CLERK' 员工的平均薪资，按照部门分组
SELECT DEPTNO, AVG(SAL) FROM emp WHERE JOB = 'CLERK' GROUP BY DEPTNO;

# 22．列出 JOB = 'CLERK' 员工的平均薪资，按照部门分组，并且部门编号 IN (10, 30)，按照平均薪资降序排列
SELECT DEPTNO, AVG(SAL) FROM emp WHERE JOB = 'CLERK' AND DEPTNO IN (10, 30) GROUP BY DEPTNO ORDER BY AVG(SAL) DESC;

# 23．列出 JOB = 'CLERK' 员工的平均薪资，按照部门分组，并且部门编号 IN (20, 30)，并且部门员工数量 >= 2 人，按照平均薪资降序排列
SELECT DEPTNO, AVG(SAL) FROM emp WHERE JOB = 'CLERK' AND DEPTNO IN (20, 30) GROUP BY DEPTNO HAVING COUNT(EMPNO) >= 2 ORDER BY AVG(SAL) DESC;