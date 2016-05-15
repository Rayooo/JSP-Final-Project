# JSP-Final-Project
JSP Final Project

copyright Ray 2016

使用了Bootstrap,Vue.js,font-awesome


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