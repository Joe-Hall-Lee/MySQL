package com.xxxx;

import java.sql.*;

public class Hello01Jdbc {
    // MySQL 连接的配置信息
    private static String driver = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://localhost:3306/scott?" +
            "useSSL=false&useUnicode=true&characterEncoding=UTF8&serverTimezone=GMT";
    private static final String user = "root";
    private static final String password = "123456";

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        dql();
    }

    /*
     * 数据库查询语句
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void dql() throws ClassNotFoundException, SQLException {
        // 加载驱动
        Class.forName(driver);
        // 获取连接
        Connection connection = DriverManager.getConnection(url, user, password);
        // 获取发送 SQL 对象
        Statement statement = connection.createStatement();
        // 创建 SQL
        String sql = "SELECT * FROM emp";
        // 执行 SQL 获取结果集
        ResultSet resultSet = statement.executeQuery(sql);
        // 打印 resultSet（打印的是对象的 Hash，一般没什么意义）
        // System.out.println(resultSet);
        // 打印数据
        while (resultSet.next()) {
            // 获取数据
            int empno = resultSet.getInt("EMPNO");
            String ename = resultSet.getString("ENAME");
            String job = resultSet.getString("JOB");
            int mgr = resultSet.getInt("MGR");
            Date hiredate = resultSet.getDate("HIREDATE");
            int sal = resultSet.getInt("SAL");
            double comm = resultSet.getDouble("comm");
            int deptno = resultSet.getInt("DEPTNO");

            System.out.println(empno + "\t\t" + ename + "\t\t" + job + "\t\t" + mgr + "\t\t" + hiredate + "\t\t" + comm + "\t\t" + deptno);

        }
    }

    /*
     * 数据库的增删改
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void dml() throws ClassNotFoundException, SQLException {
        // 加载驱动
        Class.forName(driver);
        // 创建连接
        Connection connection = DriverManager.getConnection(url, user, password);
        // 创建对象可以发送 SQL 语句
        Statement statement = connection.createStatement();
        // 写一个 SQL 语句（不要带分号）
        // String sql = "DELETE FROM emp WHERE EMPNO = 8888";
        // String sql = "UPDATE emp SET SAL = 8888 WHERE EMPNO = 7788";
        String sql = "INSERT INTO dept VALUES(11, '行政部', '北京')";
        // 执行 SQL 获取结果
        int rows = statement.executeUpdate(sql);

        System.out.println("Hello01Jdbc.main【Affected rows: " + rows + "】");
    }
}