-- 查询所有员工信息（* 通配符，默认查询所有的列）
SELECT * FROM emp;

-- 查询员工的姓名
SELECT ENAME FROM emp;

-- 查询员工的薪资
SELECT SAL FROM emp;

-- 查询员工的姓名和薪资
SELECT ENAME, SAL FROM emp;

-- 查询员工的姓名和薪资，推荐使用单引号
SELECT ENAME '员工姓名', SAL "薪资" FROM emp;

-- 查询到的数据可以直接进行运算
SELECT ENAME, SAL, SAL * 12 FROM emp;
SELECT ENAME, SAL, COMM, (SAL + COMM) * 12 FROM emp;

-- 查询员工编号为 7369 的员工
SELECT ENAME, SAL FROM emp WHERE EMPNO = 7369;

-- 查询员工姓名叫做 SMITH
SELECT ENAME, DEPTNO, JOB FROM emp WHERE ENAME = 'SMITH';

-- 查询薪资大于 2000 的员工姓名
SELECT ENAME FROM emp WHERE SAL > 2000;

-- 查询部门在 20 的员工
SELECT * FROM emp WHERE DEPTNO = 20;

-- 查询薪资不等于 2000 的员工
SELECT * FROM emp WHERE SAL != 2000;

-- 查询员工编号为 7369、7788、7881 的员工信息
SELECT * FROM emp WHERE EMPNO IN (7369, 7788, 7881);

-- 查询员工编号除了 7369、7788、7881 之外的所有员工信息
SELECT * FROM emp WHERE EMPNO NOT IN (7369, 7788, 7881);

-- 查询除了 10、20 部门之外的所有员工
SELECT * FROM emp WHERE DEPTNO NOT IN (10, 20);

-- 查询不发放津贴的员工信息
SELECT * FROM emp WHERE COMM IS NULL;

-- 查询发放津贴的员工信息
SELECT * FROM emp WHERE COMM IS NOT NULL;

-- 查询薪资范围在 1000～4000 之间的员工信息 [1000, 4000]
SELECT * FROM emp WHERE SAL BETWEEN 1000 AND 4000;

-- 查询名字中有 S 的员工
SELECT * FROM emp WHERE ENAME LIKE '%S%';

-- 查询名字最后一个字符是 S
SELECT * FROM emp WHERE ENAME LIKE '%S';

-- 查询名字第二个字符是 A
SELECT * FROM emp WHERE ENAME LIKE '_A%';

-- 查询名字中有 % 的员工
SELECT * FROM emp WHERE ENAME LIKE '%\%%';

-- 查询在 20 部门并且薪资大于 2000 的员工
SELECT * FROM emp WHERE DEPTNO = 20 AND SAL > 2000;

-- 查询在 20 部门或者薪资大于 2000 的员工
SELECT * FROM emp WHERE DEPTNO = 20 or SAL > 2000;

-- 查询不在 20 部门并且薪资小于 2000 的员工
SELECT * FROM emp WHERE DEPTNO <> 20 AND SAL < 2000;

-- 按照薪资进行排序（默认升序）
SELECT * FROM emp ORDER BY SAL;

-- 按照薪资进行排序（降序）
SELECT * FROM emp ORDER BY SAL DESC;

-- 按照薪资进行排序（升序）
SELECT * FROM emp ORDER BY SAL ASC;

-- 按照津贴进行排序（Null 排在最前面）
SELECT * FROM emp ORDER BY COMM;

-- 多个排序的列
SELECT * FROM emp ORDER BY DEPTNO, SAL;

-- 多个排序的列（部门升序，薪资降序）
SELECT * FROM emp ORDER BY DEPTNO, SAL DESC;

-- 多个排序的列（工作，薪资）
SELECT * FROM emp ORDER BY JOB, SAL;

-- 每次查询前 4 行
SELECT * FROM emp LIMIT 4;

-- 查询第 1 页，每页显示 3 个
SELECT * FROM emp LIMIT 0, 3;

-- 查询第 2 页，每次显示 3 个
SELECT * FROM emp LIMIT 3, 3;

-- 查询第 2 页，每页显示 3 个
SELECT * FROM emp LIMIT 6, 3;

-- 查询薪资大于 1000 的逆序排列，然后显示前 5 条记录
SELECT * FROM emp WHERE SAL > 1000 ORDER BY SAL DESC LIMIT 0, 5;

-- 查询每种工作的平均薪资
SELECT JOB, AVG(SAL) FROM emp GROUP BY JOB;

-- 查询每个部门的最高薪资和最低薪资
SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM emp GROUP BY DEPTNO;

-- 查询每个部门的人数和每月工资总数
SELECT DEPTNO, COUNT(EMPNO), SUM(SAL) FROM emp GROUP BY DEPTNO;

-- 查询每个部门、每种工作的平均薪资
SELECT DEPTNO, JOB, AVG(SAL) FROM emp GROUP BY DEPTNO, JOB;

-- 查询个人姓名的平均薪资——尽量对多数据进行分组
SELECT ENAME, MAX(SAL), MIN(SAL) FROM emp GROUP BY ENAME;

-- 查询平均薪资高于 2500 的部门
SELECT DEPTNO, AVG(SAL) FROM emp GROUP BY DEPTNO HAVING AVG(SAL) >= 2500;

-- 查询 20 部门的平均薪资
SELECT DEPTNO, AVG(SAL) FROM emp GROUP BY DEPTNO HAVING DEPTNO = 20;
SELECT DEPTNO, AVG(SAL) FROM emp WHERE DEPTNO = 20 GROUP BY DEPTNO;

-- 查询 10、20 部门中，并且在二月份入职员工中，每个部门平均薪资高于 1500 的工作是什么，并按照部门、工作平均薪资进行排序
SELECT DEPTNO, JOB, AVG(SAL) FROM emp WHERE DEPTNO IN (10, 20) GROUP BY DEPTNO, JOB HAVING AVG(SAL) > 1500 ORDER BY DEPTNO, AVG(SAL);