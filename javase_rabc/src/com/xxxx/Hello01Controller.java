package com.xxxx;

import java.sql.*;
import java.util.Scanner;
import java.util.UUID;

public class Hello01Controller {

    // MySQL 连接的配置信息
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/crm?" + "useSSL=false&useUnicode=true&characterEncoding=UTF8&serverTimezone=GMT";
    private static final String USER = "root";
    private static final String PASSWORD = "123456";
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        // 显示出所有的映射关系
        String sql = "SELECT * FROM t_role r JOIN t_rolepower USING(rid) JOIN t_power p USING(pid) ORDER BY rolename";
        ResultSet resultSet = jdbcDQL(sql);
        while (resultSet.next()) {
            System.out.println("角色【" + resultSet.getString("rolename") + "】[" + resultSet.getString("rid") + "]\t\t权限【" + resultSet.getString("powername") + "】[" + resultSet.getString("pid") + "]");
        }
        // 收集信息
        System.out.println("请输入您要操作的角色 ID");
        String rid = scanner.next();
        System.out.println("请输入您要操作的方式[新增 删除]");
        String operation = scanner.next();
        System.out.println("请输入您要操作的权限 ID");
        String pid = scanner.next();

        // SQL
        String sqlOper = "";
        if ("新增".equals(operation)) {
            String rpid = UUID.randomUUID().toString();
            sqlOper = "INSERT INTO t_rolepower VALUES ('" + rpid + "','" + rid + "','" + pid + "')";
        } else if ("删除".equals(operation)) {
            sqlOper = "DELETE FROM t_rolepower WHERE rid = '" + rid + "' AND pid = '" + pid + "'";
        }

        // JDBC
        int rows = jdbcDML(sqlOper);
        System.out.println(rows == 1 ? "成功" : "失败");
    }

    private static void Q09SelectPowerUser() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您要查询的权限名");
        String powername = scanner.next();

        // SQL
        String sql = "SELECT * FROM t_user u JOIN t_role r USING(rid) JOIN t_rolepower USING(rid) JOIN t_power p USING(pid) WHERE powername = '" + powername + "'";
        System.out.println(sql);

        // JDBC
        ResultSet resultSet = jdbcDQL(sql);

        // 显示
        while (resultSet.next()) {
            System.out.println("权限【" + powername + "】被用户【" + resultSet.getString("username") + "】所拥有");
        }
    }

    /*
     * 登录成功后打印出角色和权限
     *
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q08UserPower() throws ClassNotFoundException, SQLException {
        // 标识
        boolean loginFlag = false;
        // 收集数据
        System.out.println("请输入您的用户名");
        String username = scanner.next();
        System.out.println("请输入您的密码");
        String password = scanner.next();
        // SQL
        String sql = "SELECT * FROM t_user u JOIN t_role r USING(rid) JOIN t_rolepower USING(rid) JOIN t_power p USING(pid) WHERE username = '" + username + "' AND password = '" + password + "'";
        System.out.println(sql);
        // JDBC
        ResultSet resultSet = jdbcDQL(sql);
        // 打印
        while (resultSet.next()) {
            loginFlag = true;
            System.out.println("用户【" + username + "】的角色为【" + resultSet.getString("rolename") + "】，权限为【" + resultSet.getString("powername") + "】");
        }

        if (!loginFlag) {
        } else {
            System.out.println("用户【" + username + "】【" + password + "】登录失败");
        }
    }

    /*
     * 修改用户的角色信息
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q07UpdateRole() throws ClassNotFoundException, SQLException {
        System.out.println("请输入您的用户名");
        String username = scanner.next();
        // SQL
        String sql = "SELECT u.username, r.rolename FROM t_user u JOIN t_role r using(rid) WHERE username = '" + username + "'";
        // JDBC
        ResultSet resultSet = jdbcDQL(sql);
        // 显示
        if (resultSet.next()) {
            System.out.println("用户【" + resultSet.getString("u.username") + "】的角色为【" + resultSet.getString("r.rolename") + "】");
            // 显示所有的角色信息
            String sqlRole = "SELECT * FROM t_role";
            ResultSet resultSetRole = jdbcDQL(sqlRole);
            System.out.println("当前可选的角色为：");
            while (resultSetRole.next()) {
                System.out.println(resultSetRole.getString("rolename") + "\t");
            }
            System.out.println();
            System.out.println("-----------------------");
            // 收集信息
            System.out.println("请输入您要修改的角色名称");
            String rolename = scanner.next();
            // SQL
            String sqlUpdateRole = "UPDATE t_user SET rid = (SELECT rid FROM t_role WHERE rolename = '" + rolename + "') WHERE username = '" + username + "'";
            // JDBC
            int rows = jdbcDML(sqlUpdateRole);
            // 显示
            System.out.println(rows == 1 ? "修改用户【" + username + "】的角色为【" + rolename + "】成功" : "修改用户【" + username + "】的角色为【" + rolename + "】失败");
        } else {
            System.out.println("用户名【" + username + "】查无此人");
        }
    }

    /*
     * 向数据库批量插入数据
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q06InsertUsers() throws ClassNotFoundException, SQLException {
        // 循环插入
        for (int i = 0; i < 50; i++) {
            // 收集数据
            String uid = UUID.randomUUID().toString();
            String username = UUID.randomUUID().toString().substring(0, 8);
            String password = (int) (Math.random() * 900000 + 100000) + "";
            String phoneNumber = (int) (Math.random() * 90000000 + 10000000) + "";
            String rid = "111";

            // SQL
            String sql = "INSERT INTO t_user VALUES('" + uid + "', '" + rid + "', '" + username + "', '" + password + "', " + phoneNumber + ", now());";
            System.out.println(sql);

            // 使用 JDBC 将数据更新到数据库
            int rows = jdbcDML(sql);

            // 打印结果
            System.out.println(rows == 1 ? "数据【" + username + "】添加成功" : "用户【" + username + "】添加失败");
        }
    }

    private static void Q05Login() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您的用户名");
        String username = scanner.next();
        System.out.println("请输入您的密码");
        String password = scanner.next();
        // SQL
        String sql = "SELECT * FROM t_user WHERE username = '" + username + "' AND password = '" + password + "'";
        System.out.println(sql);
        // JDBC
        ResultSet resultSet = jdbcDQL(sql);
        // 打印
        if (resultSet.next()) {
            System.out.println("用户【" + username + "】【" + password + "】登录成功");
        } else {
            System.out.println("用户【" + username + "】【" + password + "】登录失败");
        }
    }


    private static void Q04UpdatePassword() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您的用户名");
        String username = scanner.next();
        System.out.println("请输入您的旧密码");
        String oldPassword = scanner.next();
        System.out.println("请输入您的新密码");
        String newPassword = scanner.next();
        // SQL
        String sql = "UPDATE t_user SET password = '" + newPassword + "' WHERE username = '" + username + "' AND password = '" + oldPassword + "'";
        System.out.println(sql);
        // JDBC
        int rows = jdbcDML(sql);
        // 打印结果
        System.out.println(rows == 1 ? "用户【" + username + "】密码修改成功" : "用户【" + username + "】密码修改失败");
    }


    /*
     * 删除用户信息
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q03DeleteUser() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您的用户名");
        Scanner scanner = new Scanner(System.in);
        String username = scanner.next();
        // SQL语句
        String sql = "DELETE FROM t_user WHERE username = '" + username + "'";
        System.out.println(sql);
        // JDBC 删除
        int rows = jdbcDML(sql);

        // 打印消息
        System.out.println(rows == 1 ? "删除[" + username + "]成功" : "删除[" + username + "]失败");
    }

    /*
     * 插入用户信息
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q02InsertUser() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您的用户名");
        String username = scanner.next();
        System.out.println("请输入您的密码");
        String password = scanner.next();
        System.out.println("请输入您的电话号码");
        String phoneNumber = scanner.next();
        String uid = UUID.randomUUID().toString();
        String rid = "111";

        // SQL
        String sql = "INSERT INTO t_user VALUES('" + uid + "', '" + rid + "', '" + username + "', '" + password + "', " + phoneNumber + ", now());";
        System.out.println(sql);

        // 使用 JDBC 将数据更新到数据库
        Class.forName(DRIVER);
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        Statement statement = connection.createStatement();
        int rows = statement.executeUpdate(sql);

        // 打印结果
        System.out.println(rows == 1 ? "数据添加成功" : "数据添加失败");
    }

    /*
     * 验证用户名唯一
     *
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static void Q01validateUsernameOnly() throws ClassNotFoundException, SQLException {
        // 收集数据
        System.out.println("请输入您的用户名");
        String username = scanner.next();

        // 查询数据库中是否存在
        Class.forName(DRIVER);
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);

        Statement statement = connection.createStatement();
        String sql = "SELECT * FROM t_user WHERE username = '" + username + "'";
        ResultSet resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            System.out.println("您的用户名【" + username + "】已经被占用！");
        } else {
            System.out.println("您的用户名【" + username + "】可以使用");
        }
        // 关闭数据库连接
        resultSet.close();
        statement.close();
        connection.close();
    }

    /*
     * 执行 DML
     *
     * @param sql
     * @return
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static int jdbcDML(String sql) throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        Statement statement = connection.createStatement();
        int rows = statement.executeUpdate(sql);
        return rows;
    }

    /*
     * 执行 DQL
     *
     * @param sql
     * @return
     * @throws ClassNotFoundException
     * @throws SQLException
     * */
    private static ResultSet jdbcDQL(String sql) throws ClassNotFoundException, SQLException {
        Class.forName(DRIVER);
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        return resultSet;
    }
}