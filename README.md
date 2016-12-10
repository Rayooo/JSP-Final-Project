# JSP-Final-Project
JSP Final Project


使用了Bootstrap,Vue.js,sweetAlert,TinyMCE,jQuery和三个Canvas背景

管理员功能:

1.新闻管理:查询所有新闻,实现搜索,删 改 新闻,添加新闻

2.成员管理:成员,管理员注册审核,做一张表列出。成员信息,能够查询,修改,删除

3.上传文件库,图片库

4.个人信息修改

用户功能:

1.个人信息

2.上传成果,修改成果,删除成果

3.上传文件库,图片库

未登录:能够看新闻,成果,用户

文件库,照片库模块



下面是创建数据库的语句

user记录管理员和用户

achievement记录用户上传的成果

news记录管理员创建的新闻

newsComment和achievementComment记录新闻和成果的评价

photo记录用户管理员上传的图片

file记录用户管理员上传的文件

以上两个一般在新闻和成果中引用


CREATE DATABASE JavaFinalProject CHARACTER SET  utf8  COLLATE utf8_general_ci;

USE JavaFinalProject;

CREATE TABLE user
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userName VARCHAR(30) NOT NULL UNIQUE,
  password TEXT NOT NULL,
  headImage VARCHAR(255),
  sex SMALLINT DEFAULT 1,
  name VARCHAR(30) NOT NULL,
  createTime DATETIME NOT NULL,
  mobile VARCHAR(11),
  introduction TEXT,
  isManager SMALLINT NOT NULL,
  isDeleted SMALLINT DEFAULT 0 NOT NULL,
  isPassed SMALLINT DEFAULT 0
);

CREATE TABLE achievement
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  isDeleted SMALLINT DEFAULT 0,
  createTime DATETIME,
  FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE news
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  isDeleted SMALLINT DEFAULT 0,
  createTime DATETIME,
  FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE photo
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL ,
  description VARCHAR(100),
  url VARCHAR(50) NOT NULL,
  isDeleted SMALLINT DEFAULT 0,
  createTime DATETIME NOT NULL,
  FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE file
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userId INT NOT NULL ,
  description VARCHAR(100),
  url VARCHAR(50) NOT NULL ,
  isDeleted SMALLINT DEFAULT 0,
  fileName VARCHAR(100),
  createTime DATETIME NOT NULL ,
  FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE newsComment
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  content TEXT NOT NULL,
  userId INT,
  newsId INT,
  createTime DATETIME,
  isDeleted SMALLINT DEFAULT 0 NOT NULL,
  FOREIGN KEY (userId) REFERENCES user(id),
  FOREIGN KEY (newsId) REFERENCES news(id)
);

CREATE TABLE achievementComment
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  content TEXT NOT NULL,
  userId INT,
  achievementId INT,
  createTime DATETIME,
  isDeleted SMALLINT DEFAULT 0 NOT NULL,
  FOREIGN KEY (userId) REFERENCES user(id),
  FOREIGN KEY (achievementId) REFERENCES achievement(id)
);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("1","sWx4VF4Ql3jq8S6LF1Zbl61HFl78xwxNkcO9J1neviI=$NbhuVoI9+tqduS+/VdFXO+YkviBgGwjkJOzAVfqNB1M=","image/headImage.png",0,"Ray","2016-11-30 20:02:05","1050123","asd",1,0,1);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("2","IrZmsYjDFimu0uBMwov2uNKtMz+05G5v/jPqsUdwlbU=$/dw8gPgnHff40mcmQznpwqEQMvdp++p1QqcoXapptnU=","image/headImage.png",0,"Ray","2016-11-30 20:02:05","1050123","asd",0,0,1);
