<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    String carIdParam = request.getParameter("id");
    if (carIdParam == null || carIdParam.isEmpty()) {
        out.println("<p>Missing car ID.</p>");
        return;
    }

    int carId = 0;
    try {
        carId = Integer.parseInt(carIdParam);
    } catch (NumberFormatException e) {
        out.println("<p>Invalid car ID.</p>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

        String deleteSql = "DELETE FROM cars WHERE car_id = ?";
        PreparedStatement ps = conn.prepareStatement(deleteSql);
        ps.setInt(1, carId);

        int rowsDeleted = ps.executeUpdate();
        ps.close();
        conn.close();

        if (rowsDeleted > 0) {
            // Successfully deleted
        }
        // Redirect back to car management page
        response.sendRedirect("manageCars.jsp");

    } catch (Exception e) {
        out.println("<p class='text-danger'>Error deleting car: " + e.getMessage() + "</p>");
    }
%>
