<%@ page import="maeji_eats.UserDAO" %>

<%
    // Invalidate the session to logout the user
    session.invalidate();
    response.sendRedirect("home.jsp"); // Redirect to the home page after logout
%>