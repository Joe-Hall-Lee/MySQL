题目要求：

0．构建 PDM，自动生成 SQL，然后去 MySQL 数据库建表

1．以用户为例：唯一性校验
    Scanner 提示“让用户输入用户名”，然后去数据库判断用户名是否存在
    例如：
        输入 admin 提示：用户名已经被占用
        输入 zhangsan 提示：用户名可用

2．以用户为例：增加
    Scanner 提示让用户输入用户名、密码、电话号码
    ID 自动生成
    创建时间：当前系统时间
    角色 ID：默认普通会员
    然后将收集到的数据插入到数据库

3．以用户为例：删除
    Scanner 提示让用户输入用户名，去数据库删除对应的用户记录

4．以用户为例：修改密码
    Scanner 提示让用户输入用户名、旧密码、新密码
    如果用户名和旧密码匹配就修改为新密码

5．以用户为例：登录
    Scanner 提示让用户输入用户名、密码，判断是否匹配

6．以用户为例：批量生成记录
    所有的数据项全部随机生成

    // ID： UUID
    // 用户名：长度为 8 位的数字
    // 密码：长度为 6 位的数字
    // 电话号码：长度为 8 位的数字
    // 创建时间：当前系统时间
    // 角色ID：默认普通会员

7．修改用户角色
    Scanner 提示让用户输入用户名
    首先显示出当前用户的角色，并显示出所有的角色
    然后 Scanner 提示让用户输入新角色名称，根据角色名称修改用户的角色 rid

    向角色表和权限表添加 20 条记录
8．当用户登录成功后，打印出用户的角色和所有权限
    普通会员 1
    管理员 2

9．当用户登录成功后，打印出用户的角色和所有权限

10．可以对权限和角色关系进行增、删、改、查，例如删除角色的权限