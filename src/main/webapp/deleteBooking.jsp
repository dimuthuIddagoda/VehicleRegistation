<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%
    String bookingIdParam = request.getParameter("id");
    if (bookingIdParam == null || bookingIdParam.isEmpty()) {
        out.println("<p>Missing booking ID.</p>");
        return;
    }

    int bookingId = 0;
    try {
        bookingId = Integer.parseInt(bookingIdParam);
    } catch (NumberFormatException e) {
        out.println("<p>Invalid booking ID.</p>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

        String deleteSql = "DELETE FROM booking WHERE booking_id = ?";
        PreparedStatement ps = conn.prepareStatement(deleteSql);
        ps.setInt(1, bookingId);

        int rowsDeleted = ps.executeUpdate();
        ps.close();
        conn.close();

        if (rowsDeleted > 0) {
            // Successfully deleted
        }
        // Redirect back to bookings list
        response.sendRedirect("viewBookings.jsp");

    } catch (Exception e) {
        out.println("<p class='text-danger'>Error deleting booking: " + e.getMessage() + "</p>");
    }
%>
