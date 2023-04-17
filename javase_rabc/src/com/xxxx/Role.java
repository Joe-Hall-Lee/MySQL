package com.xxxx;

import java.io.Serializable;

/*
* 角色信息-对应权限
* <p>
* 表关系：一个角色可以有多种权限，一个权限可以被多个角色所拥有
* <p>
* 例如：
* 普通用户：查
* 管理员：查、增
* 超级管理员：增、删、改、查
* */
public class Role implements Serializable {
    // 角色 ID
    private String rid;
    // 角色名称
    private String rolename;

}