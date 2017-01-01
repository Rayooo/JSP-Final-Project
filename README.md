
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
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  userName VARCHAR(30) NOT NULL UNIQUE,     # 用户名
  password TEXT NOT NULL,                   # 密码
  headImage VARCHAR(255),                   # 头像url
  sex SMALLINT DEFAULT 1,                   # 性别
  name VARCHAR(30) NOT NULL,                # 姓名
  createTime DATETIME NOT NULL,             # 创建时间
  mobile VARCHAR(11),                       # 手机号
  introduction TEXT,                        # 介绍
  isManager SMALLINT NOT NULL,              # 是否是管理员
  isDeleted SMALLINT DEFAULT 0 NOT NULL,    # 是否删除
  isPassed SMALLINT DEFAULT 0               # 是否通过验证
);

CREATE TABLE achievement
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  userId INT,                               # 外键，用户id
  title VARCHAR(255) NOT NULL,              # 标题
  content TEXT NOT NULL,                    # 内容
  isDeleted SMALLINT DEFAULT 0,             # 是否删除
  createTime DATETIME,                      # 创建时间
  FOREIGN KEY (userId) REFERENCES user(id)  
);

CREATE TABLE news
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  userId INT,                               # 外键 用户id
  title VARCHAR(255) NOT NULL,              # 标题
  content TEXT NOT NULL,                    # 内容
  isDeleted SMALLINT DEFAULT 0,             # 是否删除
  createTime DATETIME,                      # 创建时间
  FOREIGN KEY (userId) REFERENCES user(id)  # 外键
);

CREATE TABLE photo
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  userId INT NOT NULL ,                     # 外键 用户id
  description VARCHAR(100),                 # 描述
  url VARCHAR(50) NOT NULL,                 # 图片相对路径
  isDeleted SMALLINT DEFAULT 0,             # 是否删除  
  createTime DATETIME NOT NULL,             # 创建时间
  FOREIGN KEY (userId) REFERENCES user(id)  
);

CREATE TABLE file
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  userId INT NOT NULL ,                     # 外键用户id
  description VARCHAR(100),                 # 描述
  url VARCHAR(50) NOT NULL ,                # 文件相对路径
  isDeleted SMALLINT DEFAULT 0,             # 是否删除  
  fileName VARCHAR(100),                    # 文件名
  createTime DATETIME NOT NULL ,            # 创建时间
  FOREIGN KEY (userId) REFERENCES user(id)
);

CREATE TABLE newsComment
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  content TEXT NOT NULL,                    # 内容
  userId INT,                               # 外键用户id
  newsId INT,                               # 外键新闻id
  createTime DATETIME,                      # 创建时间
  isDeleted SMALLINT DEFAULT 0 NOT NULL,    # 是否删除
  FOREIGN KEY (userId) REFERENCES user(id),
  FOREIGN KEY (newsId) REFERENCES news(id)
);

CREATE TABLE achievementComment
(
  id INT AUTO_INCREMENT PRIMARY KEY,        # 主键
  content TEXT NOT NULL,                    # 内容
  userId INT,                               # 外键用户id
  achievementId INT,                        # 外键评论id
  createTime DATETIME,                      # 创建时间
  isDeleted SMALLINT DEFAULT 0 NOT NULL,    # 是否删除
  FOREIGN KEY (userId) REFERENCES user(id), 
  FOREIGN KEY (achievementId) REFERENCES achievement(id)
);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("1","sWx4VF4Ql3jq8S6LF1Zbl61HFl78xwxNkcO9J1neviI=$NbhuVoI9+tqduS+/VdFXO+YkviBgGwjkJOzAVfqNB1M=","image/headImage.png",0,"Ray","2016-11-30 20:02:05","1050123","asd",1,0,1);

INSERT INTO user (userName, password, headImage, sex, name, createTime, mobile, introduction, isManager, isDeleted, isPassed)
VALUES("2","IrZmsYjDFimu0uBMwov2uNKtMz+05G5v/jPqsUdwlbU=$/dw8gPgnHff40mcmQznpwqEQMvdp++p1QqcoXapptnU=","image/headImage.png",0,"Ray","2016-11-30 20:02:05","1050123","asd",0,0,1);
