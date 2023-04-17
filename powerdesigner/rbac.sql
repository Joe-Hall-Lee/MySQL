/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2023/3/18 12:52:08                           */
/*==============================================================*/


alter table t_rolepower 
   drop foreign key FK_T_ROLEPO_REFERENCE_T_ROLE;

alter table t_rolepower 
   drop foreign key FK_T_ROLEPO_REFERENCE_T_POWER;

alter table t_user 
   drop foreign key FK_T_USER_RP_USER_R_T_ROLE;

drop table if exists t_power;

drop table if exists t_role;


alter table t_rolepower 
   drop foreign key FK_T_ROLEPO_REFERENCE_T_ROLE;

alter table t_rolepower 
   drop foreign key FK_T_ROLEPO_REFERENCE_T_POWER;

drop table if exists t_rolepower;


alter table t_user 
   drop foreign key FK_T_USER_RP_USER_R_T_ROLE;

drop table if exists t_user;

/*==============================================================*/
/* Table: t_power                                               */
/*==============================================================*/
create table t_power
(
   pid                  varchar(40) not null  comment '',
   powername            varchar(40)  comment '',
   primary key (pid)
);

/*==============================================================*/
/* Table: t_role                                                */
/*==============================================================*/
create table t_role
(
   rid                  varchar(40 ) not null  comment '',
   rolename             varchar(40)  comment '',
   primary key (rid)
);

/*==============================================================*/
/* Table: t_rolepower                                           */
/*==============================================================*/
create table t_rolepower
(
   rpid                 varchar(40)  comment '',
   rid                  varchar(40)  comment '',
   pid                  varchar(40)  comment ''
);

/*==============================================================*/
/* Table: t_user                                                */
/*==============================================================*/
create table t_user
(
   uid                  varchar(40) not null  comment '',
   rid                  varchar(40 )  comment '',
   username             varchar(40)  comment '',
   password             varchar(40)  comment '',
   phonenumber          int  comment '',
   createtime           timestamp  comment '',
   primary key (uid)
);

alter table t_rolepower add constraint FK_T_ROLEPO_REFERENCE_T_ROLE foreign key (rid)
      references t_role (rid) on delete restrict on update restrict;

alter table t_rolepower add constraint FK_T_ROLEPO_REFERENCE_T_POWER foreign key (pid)
      references t_power (pid) on delete restrict on update restrict;

alter table t_user add constraint FK_T_USER_RP_USER_R_T_ROLE foreign key (rid)
      references t_role (rid) on delete restrict on update restrict;

