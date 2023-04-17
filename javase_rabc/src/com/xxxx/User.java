package com.xxxx;

import java.io.Serializable;
import java.util.Date;

/*
* 用户信息
* <p>
* 表关系：一个用户只能有一种角色，一个角色可以被多个用户所拥有
* */
public class User implements Serializable {
    // ID
    private String uid;
    // 用户名
    private String username;
    // 密码
    private String password;
    // 电话号码 【0-8】
    private Integer phoneNumber;
    // 创建时间
    private Date createTime;
    // 角色 ID
    private String rid;
}