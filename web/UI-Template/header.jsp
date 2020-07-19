<%-- 
    Document   : header
    Created on : 24 Jul, 2019, 8:22:36 PM
    Author     : Nevets
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="links.jsp" %>
<!doctype html>
<header>
    <title>VIDUR</title>
    <nav class="navbar navbar-expand-md fixed-top site-header">
        <div class="container">
            <a class="headtab navbar-brand px-2" href="${pageContext.request.contextPath}/Jsp-files/Front/dashboardPage.jsp" style="display: inline-flex;border: 1px solid white;border-radius: 3px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="d-block mx-auto"><circle cx="12" cy="12" r="10"></circle><line x1="14.31" y1="8" x2="20.05" y2="17.94"></line><line x1="9.69" y1="8" x2="21.17" y2="8"></line><line x1="7.38" y1="12" x2="13.12" y2="2.06"></line><line x1="9.69" y1="16" x2="3.95" y2="6.06"></line><line x1="14.31" y1="16" x2="2.83" y2="16"></line><line x1="16.62" y1="12" x2="10.88" y2="21.94"></line></svg>&nbsp;&nbsp;&nbsp; VIDUR
            </a>
            <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="navbar-collapse collapse" id="navbarsExampleDefault" style="">
                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <%@include file="../Jsp-files/AdminPages/AdminHeader.jsp" %>
                </c:if>
                <c:if test="${sessionScope.role == 'AC'}">
                    <%@include file="../Jsp-files/ACPages/ACHeader.jsp" %>
                </c:if>
                <c:if test="${sessionScope.role == 'DOCTOR'}">
                    <%@include file="../Jsp-files/DoctorPages/DoctorHeader.jsp" %>
                </c:if>
                <c:if test="${sessionScope.role == 'TECH'}">
                    <%@include file="../Jsp-files/TechStaffPages/TechStaffHeader.jsp" %>
                </c:if>
            </div>
        </div>
    </nav>

    <!--<nav class="site-header sticky-top py-3">
        <div class="container d-flex flex-column flex-md-row justify-content-start ml-5">
            <a class="headtab py-2 px-2" href="${pageContext.request.contextPath}/Jsp-files/Front/dashboardPage.jsp" style="display: inline-flex;border: 1px solid white;border-radius: 3px;">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="d-block mx-auto"><circle cx="12" cy="12" r="10"></circle><line x1="14.31" y1="8" x2="20.05" y2="17.94"></line><line x1="9.69" y1="8" x2="21.17" y2="8"></line><line x1="7.38" y1="12" x2="13.12" y2="2.06"></line><line x1="9.69" y1="16" x2="3.95" y2="6.06"></line><line x1="14.31" y1="16" x2="2.83" y2="16"></line><line x1="16.62" y1="12" x2="10.88" y2="21.94"></line></svg>&nbsp;&nbsp;&nbsp; VIDUR
            </a>
    <%--<c:if test="${sessionScope.role == 'ADMIN'}">
        <%@include file="../Jsp-files/AdminPages/AdminHeader.jsp" %>
    </c:if>
    <c:if test="${sessionScope.role == 'AC'}">
        <%@include file="../Jsp-files/ACPages/ACHeader.jsp" %>
    </c:if>
    <c:if test="${sessionScope.role == 'DOCTOR'}">
        <%@include file="../Jsp-files/DoctorPages/DoctorHeader.jsp" %>
    </c:if>
    <c:if test="${sessionScope.role == 'TECH'}">
        <%@include file="../Jsp-files/TechStaffPages/TechStaffHeader.jsp" %>
    </c:if>--%>
</div>
</nav>-->

    <script>
        $(document).ready(function () {
            $.ajax({
                url: '/VIDUR/getPriceTagsServlet?for=2',
                type: "GET",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $.each(data, function (i, v) {
                        var bday = (new Date().getFullYear() - new Date(v.Birthdate).getFullYear())
                        $('.appendPatients').append('<option value="' + v.patientId + '">' + v.patientName + ' (' + bday + ')</option>');
                    });
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });
        });
    </script>
    <!--    <div class="navbar navbar-default navbar-fixed-top" style="box-shadow: 1px -2px 13px 2px black">
            <div class="container-fluid">
                <div class="navbar-header navbar-default">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                
    
            </div>
        </div>-->
</header>
