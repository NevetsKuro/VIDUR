<%-- 
    Document   : footer
    Created on : 24 July, 2019, 4:49:20 PM
    Author     : itachi
--%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="year" value="${now}" pattern="yyyy" />
<footer class="" style="padding: 9px 80px;background: cadetblue;position: relative;left: 0;bottom: 0;width: 100%;">
    <div class="row" style="color: #461b2f;">
        <div class="col p-4">
            <ul>
                <li class="cursorOnHover"><i class="fas fa-home"></i> About</li>
                <li class="cursorOnHover"><i class="fas fa-handshake"></i> Service</li>
                <li class="cursorOnHover"><i class="fas fa-address-book"></i> Contact</li>
                <li class="cursorOnHover"><i class="fas fa-images"></i> Gallery</li>
            </ul>
        </div>
        <div class="col-6">
            <a href="https://goo.gl/maps/KZKGdJpjHqay6rkR7" class="ignoreA" target="_blank">
                <img class="img-fluid cursorOnHover" src="${pageContext.request.contextPath}/resources/images/Atal-map.PNG" alt="Add plus code to google - ( 4R3P+7J Mumbai, Maharashtra )" title="Plus code ( 4R3P+7J Mumbai, Maharashtra )"
                     style="width: 450px;height: 170px;border: 2px solid black;border-radius: 7px;"/>
            </a>
        </div>
        <div class="col p-4">
            <ul>
                <li class="cursorOnHover"><i class="fab fa-instagram "></i> Instagram</li>
                <li class="cursorOnHover"><i class="fab fa-facebook-square"></i> Facebook</li>
                <li class="cursorOnHover"><i class="fab fa-twitter"></i> Twitter</li>
                <li class="cursorOnHover"><i class="fas fa-envelope"></i> Email</li>
            </ul>
        </div>
    </div>
</footer>
