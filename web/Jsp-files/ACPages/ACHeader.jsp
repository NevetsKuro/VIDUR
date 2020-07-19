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
        color: #461b2f!important;
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
        color: #461b2f!important;
        text-decoration: none;
    }
</style>
<!-- New header -->
<ul class="navbar-nav mr-auto">
    <li class="nav-item">
        <a class="nav-link AChead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/AdministratorCorner.jsp">Registration Corner</a>
    </li>
    <li class="nav-item">
        <a class="nav-link ACDhead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/ACUploader.jsp">Document-Upload</a>
    </li>
    <li class="nav-item">
        <a class="nav-link ACLhead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/ACPatientList.jsp">Patient List</a>
    </li>
    <li class="nav-item">
        <form action="/VIDUR/sessionCreateServlet" method="GET">
            <input type="hidden" name="roles" value="TECH">
            <button type="submit" class="btn btn-sm py-2 d-inline px-3 mx-2">To Tech Page</button>
        </form>
    </li>
</ul>
<div class="form-inline">
    <a href="#" class="headtab nav-link">Welcome User, ${sessionScope.sessname}</a>
    <a class="" href="${pageContext.request.contextPath}/index.jsp" title="Log out"><i class="fas fa-power-off"></i></a>
</div>
<!-- Old header
<a class="py-2 d-inline px-3 mx-2 AChead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/AdministratorCorner.jsp">Registration Corner</a>
<a class="py-2 d-inline px-3 mx-2 ACDhead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/ACUploader.jsp">Document-Upload</a>
<a class="py-2 d-inline px-3 mx-2 ACLhead" href="${pageContext.request.contextPath}/Jsp-files/ACPages/ACPatientList.jsp">Patient List</a>
<form action="/VIDUR/sessionCreateServlet" method="GET">
    <input type="hidden" name="roles" value="TECH">
    <button type="submit" class="btn btn-sm py-2 d-inline px-3 mx-2">To Tech Page</button>
</form>
<a class="py-2 d-inline px-3 mx-2 ml-auto headtab" href="#">Welcome User, ${sessionScope.sessname}</a>
<a class="py-2 d-inline px-3" href="${pageContext.request.contextPath}/index.jsp" title="Log out"><i class="fas fa-power-off"></i></a>-->


