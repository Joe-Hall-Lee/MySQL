/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2023/3/18 12:04:22                           */
/*==============================================================*/


alter table t_student 
   drop foreign key FK_T_STUDEN_RS_T1_SN_T_TEACHE;

alter table t_student_course 
   drop foreign key FK_T_STUDEN_REFERENCE_T_COURSE;

alter table t_student_course 
   drop foreign key FK_T_STUDEN_R_STUDENT_T_STUDEN;

drop table if exists t_course;


alter table t_student 
   drop foreign key FK_T_STUDEN_RS_T1_SN_T_TEACHE;

drop table if exists t_student;


alter table t_student_course 
   drop foreign key FK_T_STUDEN_R_STUDENT_T_STUDEN;

alter table t_student_course 
   drop foreign key FK_T_STUDEN_REFERENCE_T_COURSE;

drop table if exists t_student_course;

drop table if exists t_teacher;

/*==============================================================*/
/* Table: t_course                                              */
/*==============================================================*/
create table t_course
(
   cno                  int(11) not null  comment '',
   cname                varchar(25)  comment '',
   primary key (cno)
);

/*==============================================================*/
/* Table: t_student                                             */
/*==============================================================*/
create table t_student
(
   sno                  int not null  comment '',
   tno                  int  comment '',
   sname                char(40)  comment '',
   primary key (sno)
);

/*==============================================================*/
/* Table: t_student_course                                      */
/*==============================================================*/
create table t_student_course
(
   sno                  int  comment '',
   cno                  int(11)  comment '',
   scno                 int(11)  comment ''
);

/*==============================================================*/
/* Table: t_teacher                                             */
/*==============================================================*/
create table t_teacher
(
   tno                  int not null  comment '',
   tname                char(40)  comment '',
   tgender              char(2)  comment '',
   primary key (tno)
);

alter table t_teacher comment '存放老师信息';

alter table t_student add constraint FK_T_STUDEN_RS_T1_SN_T_TEACHE foreign key (tno)
      references t_teacher (tno) on delete restrict on update restrict;

alter table t_student_course add constraint FK_T_STUDEN_REFERENCE_T_COURSE foreign key (cno)
      references t_course (cno) on delete restrict on update restrict;

alter table t_student_course add constraint FK_T_STUDEN_R_STUDENT_T_STUDEN foreign key (sno)
      references t_student (sno) on delete restrict on update restrict;

