<%-- 
    Document   : dashboardPage
    Created on : 5 Aug, 2019, 9:01:37 PM
    Author     : Nevets
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../UI-Template/header.jsp"></jsp:include>
        <body>
            <div class="container-fluid">
                <div class="row">
                    <div id="welcomeDiv" class="col-lg-6 col-xs-12">
                        <span>Welcome</span><br><span>To</span><br><span>VIDUR</span><br>
                        <small style="font-size: 15px;text-align: left;position: absolute;width: 250px;">( Virtual Interface For Dialysis Unit Review )</small>
                    </div>
                    <div id="imageDiv" class="col-lg-6 col-xs-12">
                        <div>
                            <img src="${pageContext.request.contextPath}/resources/images/welcomeRightImage.jpg" class="image-responsive" width="100%"/>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>