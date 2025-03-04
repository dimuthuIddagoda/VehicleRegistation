
<!-- deleteCustomer.jsp -->
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    String customerIdParam = request.getParameter("id");
    if (customerIdParam == null || customerIdParam.isEmpty()) {
        out.println("<p>Missing customer ID.</p>");
        return;
    }

    int customerId = 0;
    try {
        customerId = Integer.parseInt(customerIdParam);
    } catch (NumberFormatException e) {
        out.println("<p>Invalid customer ID.</p>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

        String deleteSql = "DELETE FROM customers WHERE customer_id = ?";
        PreparedStatement ps = conn.prepareStatement(deleteSql);
        ps.setInt(1, customerId);

        int rowsDeleted = ps.executeUpdate();
        ps.close();
        conn.close();

        response.sendRedirect("viewCustomers.jsp");
    } catch (Exception e) {
        out.println("<p class='text-danger'>Error deleting customer: " + e.getMessage() + "</p>");
    }
%>
