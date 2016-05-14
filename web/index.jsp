
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>主页</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/index.css" rel="stylesheet">
</head>

<body>

<%@ include file="navbar.jsp"%>

<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="image/1.jpg" alt="First slide">
        </div>
        <div class="item">
            <img src="image/2.jpg" alt="Second slide">
        </div>
        <div class="item">
            <img src="image/3.jpg" alt="Third slide">
        </div>
    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-6 col-md-6">
            <div class="thumbnail">
                <div class="caption">
                    <h3>新闻展示</h3>

                    <form role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>
                    </form>

                    <div class="list-group">
                        <a href="news.html" class="list-group-item">超链接新闻标题</a>
                        <a href="news.html" class="list-group-item">超链接新闻标题</a>
                        <a href="news.html" class="list-group-item">超链接新闻标题</a>
                        <a href="news.html" class="list-group-item">超链接新闻标题</a>
                    </div>

                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>
            </div>
        </div>
        <div class="col-sm-6 col-md-6">
            <div class="thumbnail">
                <div class="caption">

                    <h3>成果展示</h3>

                    <div class="list-group">
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                    </div>

                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail">
                <div class="caption">
                    <h3>成员介绍</h3>

                    <!--媒体对象,一头像一评论-->
                    <div class="media">
                        <div class="media-left media-middle">
                            <img class="media-object commentAvatarImage" src="image/headImage.png" alt="...">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">陈枭磊</h4>
                            aaaaaaaaaaaaaaaaaaaaaaaa
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-left media-middle">
                            <img class="media-object commentAvatarImage" src="image/headImage.png" alt="...">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">倪倩烨</h4>
                            aaaaaaaaaaaaaaaaaaaaaaaa
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-left media-middle">
                            <img class="media-object commentAvatarImage" src="image/headImage.png" alt="...">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">翁倩</h4>
                            aaaaaaaaaaaaaaaaaaaaaaaa
                        </div>
                    </div>
                    <div class="media">
                        <div class="media-left media-middle">
                            <img class="media-object commentAvatarImage" src="image/headImage.png" alt="...">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">A</h4>
                            aaaaaaaaaaaaaaaaaaaaaaaa
                        </div>
                    </div>
                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>