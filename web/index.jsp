<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>VIDUR</title>
        <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/images/favicon-32x32.png">
    </head>
    <body style="background: antiquewhite"> 
        <%
            session = request.getSession();
            session.invalidate();
        %>
        <jsp:include page="UI-Template/links.jsp"></jsp:include>
        <div class="wrapper fadeInDown" style="background: antiquewhite;">
            <div id="formContent">
                <!-- Tabs Titles -->

                <!-- Icon -->
                <div class="fadeIn first p-3">
                    <h3><span class="text-info"><b>VIDUR</b></span></h3>
                </div>

                <!-- Login Form -->
                <form action="sessionCreateServlet" method="POST">
                    <label>User Name:</label>
                    <input type="text" id="loginName" class="fadeIn second inputLogin" name="loginName" placeholder="Enter Your Name" value="" required="">
                    <label>Password:</label>
                    <input type="password" id="loginpassword" class="fadeIn third inputLogin" name="loginPwd" placeholder="Enter Your Password" value="" required="">
                    <input type="submit" class="fadeIn fourth" style="cursor: pointer;" value="Log In">
                </form>
            </div>
        </div>
    </body>
</html>