<%--
  Created by IntelliJ IDEA.
  User: brian
  Date: 12/6/2024
  Time: 4:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Invalidate the session and remove cookies
    session.invalidate();

    // Redirect to login page
    response.sendRedirect("login");
%>

