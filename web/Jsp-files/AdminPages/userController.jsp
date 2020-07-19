<%-- 
    Document   : AdministratorCorner
    Created on : 24 Jul, 2019, 8:52:31 PM
    Author     : Nevets
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        session = request.getSession(false);
        String sessname = (String) session.getAttribute("sessname");
        System.out.print("Session : " + sessname);
        if (sessname == null || sessname == "") {
            System.out.print("(IN)Session : " + sessname);
            response.sendRedirect("/VIDUR");
            return;
        }
    %>
    <jsp:include page="../../UI-Template/header.jsp"></jsp:include>
    <body>
        <div class="container-fluid pt-3">
            <fieldset class="mt-3 pt-3 fieldBorder">
                <h1><center>User Master</center></h1>
                <div class="row">
                    <div class="col">
                        <center><h3>Add/Update Users</h3></center>
                    </div>
                </div>
                <form>
                    <div class="row justify-content-md-center justify-content-sm-center">
                        <div class="col-sm-8 col-md-3 col-lg-2">
                            <div class="form-group">
                                <label for="userName">User Name:</label>
                                <input type="text" id="userName" class="form-control" placeholder="Enter Name">
                            </div>  
                        </div>
                        <div class="col-sm-8 col-md-3 col-lg-2">
                            <div class="form-group">
                                <label for="userPwd">Password:</label>
                                <input type="text" id="userPwd" class="form-control" placeholder="Enter Password">
                            </div>  
                        </div>
                        <div class="col-sm-8 col-md-3 col-lg-2">
                            <div class="form-group">
                                <label for="userRole">Role:</label>
                                <select id="userRole" class="form-control">
                                    <option value="">Select..</option>
                                    <option value="AC">AC</option>
                                    <option value="Tech">Tech</option>
                                    <option value="Doctor">Doctor</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-8 col-md-3 col-lg-2">
                            <div class="form-group">
                                <label for="userCentre">Centre:<span class="text-danger">*</span></label>
                                <select id="userCentre" class="form-control">
                                    <option value="">Select..</option>
                                    <option value="GORAI">Gorai</option>
                                    <option value="MIRAROAD">Mira Road</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-9"></div>
                        <div class="col align-self-end">
                            <div class="form-group">
                                <button class="btn btn-primary" id="userAdd">Add Users</button>
                            </div> 
                        </div>
                    </div>
                </form>
                <div class="row justify-content-md-center">
                    <div class="col-md-12 col-lg-10 col-sm-12">
                        <table id="userTable" class="table table-striped table-bordered mb-5" width="100%">
                            <thead>
                                <tr>
                                    <td>Sr No.</td>
                                    <td>Name</td>
                                    <td>Password</td>
                                    <td>Role</td>
                                    <td>Location</td>
                                    <td>Updated Date</td>
                                    <td>Action</td>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="7"><center> No Records found!!!</center></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="modal" id="userModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Modal title</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <input type="hidden" id="modaluId" value=""/> 
                            <div class="row justify-content-md-center">
                                <div class="col-md-5 col-lg-3">
                                    <div class="form-group">
                                        <label for="modaluName">Name:</label>
                                        <input type="text" id="modaluName" class="form-control" placeholder="">
                                    </div>  
                                </div>
                                <div class="col-md-5 col-lg-3">
                                    <div class="form-group">
                                        <label for="modaluPassword">Password:</label>
                                        <input type="text" id="modaluPassword" class="form-control" placeholder="">
                                    </div>  
                                </div>
                                <div class="col-md-5 col-lg-3">
                                    <div class="form-group">
                                        <label for="modaluRole">Role:</label>
                                        <select id="modaluRole" class="form-control">
                                            <option value="">Select..</option>
                                            <option value="AC">AC</option>
                                            <option value="Tech">Tech</option>
                                            <option value="Doctor">Doctor</option>
                                        </select>
                                    </div>  
                                </div>
                                <div class="col-md-5 col-lg-3">
                                    <div class="form-group">
                                        <label for="modaluCentre">Centre:<span class="text-danger">*</span></label>
                                        <select id="modaluCentre" class="form-control">
                                            <option value="">Select..</option>
                                            <option value="GORAI">Gorai</option>
                                            <option value="MIRAROAD">Mira Road</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="userUpdate">Save changes</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>