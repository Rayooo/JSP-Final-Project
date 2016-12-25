
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="sweetalert/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="sweetalert/dist/sweetalert.css">

<body>
    <%
        String message = (String)request.getAttribute("message");
        boolean isError = (Boolean) request.getAttribute("isError");
        if(isError){
    %>
            <script>
                var url = document.referrer;
                var rawIndex = url.substring(url.lastIndexOf('/'));
                var indexArr = rawIndex.split('?');
                var preLocation = indexArr[0];

                swal({
                    title: "对不起",
                    text: "<%=message%>",
                    type: "error",
                    confirmButtonColor: "#79c9e0",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function(){
                    if(preLocation == "/userInfoEdit.jsp"){
                        window.close();
                    }else if(preLocation == "/editMyInfo.jsp"){
                        window.location = "editMyInfo.jsp";
                    }
                });
            </script>
    <%
        }
        else
        {
    %>
            <script>
                var url = document.referrer;
                var rawIndex = url.substring(url.lastIndexOf('/'));
                var indexArr = rawIndex.split('?');
                var preLocation = indexArr[0];

                swal({
                    title: "成功",
                    text: "<%=message%>",
                    type: "success",
                    confirmButtonColor: "#79c9e0",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function(){
                    if(preLocation == "/userInfoEdit.jsp"){
                        window.close();
                    }else if(preLocation == "/editMyInfo.jsp"){
                        window.location = "editMyInfo.jsp";
                    }
                });
            </script>
    <%
        }
    %>


</body>
