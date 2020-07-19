<%-- 
    Document   : tseAdminHeader
    Created on : 31 Jul, 2017, 2:54:14 PM
    Author     : 00507469
--%>
<style>
    .dropdown-toggle:after {
        display: inline-block;
        width: 0;
        height: 0;
        margin-left: .255em;
        vertical-align: .255em;
        content: "";
        border-top: .3em solid;
        border-right: .3em solid transparent;
        border-bottom: 0;
        border-left: .3em solid transparent;
    }
    a:hover:not(.headtab) {
        padding: 8px;
        background: #bd8ca3;
        border-radius: 3px;
        color: #461b2f;
        text-decoration: none;
    }
    a.headtab:hover{
        text-decoration: none;
        color: white;
    }
    a.active:not(.headtab){
        padding: 8px;
        background: #bd8ca3;
        border-radius: 3px;
        color: #461b2f;
        text-decoration: none;
    }
</style>
<!--New header-->
<ul class="navbar-nav mr-auto">
    <li class="nav-item">
        <a class="nav-link AdChead" href="${pageContext.request.contextPath}/Jsp-files/AdminPages/AdminController.jsp">Admin Controller</a>
    </li>
    <li class="nav-item">
        <a class="nav-link UsChead" href="${pageContext.request.contextPath}/Jsp-files/AdminPages/userController.jsp">Users Master</a>
    </li>
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Navigate to
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <a class="dropdown-item roleChange cursorOnHover" data-role="AC">Register's Page</a>
            <a class="dropdown-item roleChange cursorOnHover" data-role="TECH">Technical's Page</a>
            <a class="dropdown-item roleChange cursorOnHover" data-role="DOC">Doctor's Page</a>
            <a class="dropdown-item roleChange cursorOnHover" data-role="ADMIN">ADMIN's Page</a>
        </div>
    </li>
</ul>
<div class="form-inline">
    <a href="#" class="headtab nav-link">Welcome User, ${sessionScope.sessname}</a>
    <a class="" href="${pageContext.request.contextPath}/index.jsp" title="Log out"><i class="fas fa-power-off"></i></a>
</div>


<!--Old header-->
<!--
<a class="py-2 d-inline px-3 mx-2 AChead" href="${pageContext.request.contextPath}/Jsp-files/AdminPages/AdminController.jsp">AdminController</a>
<a class="py-2 d-inline px-3 mx-2 ml-auto headtab" href="#">Welcome User, ${sessionScope.sessname}</a>
<a class="py-2 d-inline px-3" href="${pageContext.request.contextPath}/index.jsp" title="Log out"><i class="fas fa-power-off"></i></a>
-->


