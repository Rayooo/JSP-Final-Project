# JSP-Final-Project
JSP Final Project

copyright Ray 2016

使用了Bootstrap,Vue.js,font-awesome

管理员功能:

1.新闻管理:查询所有新闻,实现搜索,删 改 新闻,添加新闻

2.成员管理:成员,管理员注册审核,做一张表列出。成员信息,能够查询,修改,删除(删除用ajax过几天写)

3.个人信息修改,已完成

用户功能:

1.个人信息

2.上传成果

未登录情况下能够看新闻等


下面是创建数据库的语句

CREATE DATABASE JSPFinalProject CHARACTER SET  utf8  COLLATE utf8_general_ci;

CREATE TABLE user
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userName VARCHAR(30) NOT NULL UNIQUE,
  password VARCHAR(30) NOT NULL,
  headImage VARCHAR(255),
  sex SMALLINT,
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
  userName VARCHAR(30),
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  isDeleted INT DEFAULT 0,
  createTime DATETIME,
  FOREIGN KEY (userName) REFERENCES user(userName)
);

CREATE TABLE news
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  userName VARCHAR(30),
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  isDeleted INT DEFAULT 0,
  createTime DATETIME,
  FOREIGN KEY (userName) REFERENCES user(userName)
);

CREATE TABLE newsPhoto
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  newsId INT,
  FOREIGN KEY (newsId) REFERENCES news(id)
);

CREATE TABLE achievementPhoto
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  achievementId INT,
  FOREIGN KEY (achievementId) REFERENCES achievement(id)
);

CREATE TABLE newsComment
(
  id INT AUTO_INCREMENT PRIMARY KEY,
  content TEXT NOT NULL,
  userId INT,
  newsId INT,
  createTime DATETIME,
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
  FOREIGN KEY (userId) REFERENCES user(id),
  FOREIGN KEY (achievementId) REFERENCES achievement(id)
);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("aa","bb","headImage",0,"Ray","2016-05-16 20:02:05","1050123","asd",1,0,0);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("23e","b2b","headImage",0,"Ray2","2016-05-16 20:02:05","1050123","asd",1,0,0);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("23e3","b2w2b","headImage",0,"Ray2","2016-05-16 20:02:05","1050123","asd",1,0,0);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("23e3223","b2w2b","headImag2e",0,"R43ay2","2016-05-16 20:02:05","34234","asdewq",1,0,0);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("23e23223","b2w2b","headImag2e",0,"R43ay2","2016-05-16 20:02:05","34234","asdewq",1,0,0);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("223223","b2w2b","headImag2e",0,"R43ay2","2016-05-16 20:02:05","34234","asdewq",0,1,1);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("22334","b2w2b","headImag2e",0,"R43ay2","2016-05-16 20:02:05","34234","asdewq",0,1,0);
