<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/22
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加新闻</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="tinymce/tinymce.js"></script>
    <script>
        tinymce.init({
            selector: '#mytextarea',
            language: 'zh_CN',
        });
    </script>
</head>
<body>

<h1>TinyMCE Quick Start Guide</h1>

<div id="mytextarea">Hello, World!</div>

<button class="btn btn-primary" id="btn"></button>

<script>
    $("#btn").click(function () {
        //method2 getting the content by id of a particular textarea
        alert(tinymce.get('mytextarea').getContent());

    })
</script>

</body>
</html>
