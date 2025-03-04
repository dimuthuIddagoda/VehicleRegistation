<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<%
    // Retrieve "id" parameter
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

    // Check if the form was submitted (POST)
    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        // Handle the update logic
        String customerId = request.getParameter("customer_id");
        String carId = request.getParameter("car_id");
        String driverId = request.getParameter("driver_id");
        String bookingDate = request.getParameter("booking_date");
        String destination = request.getParameter("destination");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String updateSql = "UPDATE booking SET customer_id=?, car_id=?, driver_id=?, booking_date=?, destination=? WHERE booking_id=?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setInt(1, Integer.parseInt(customerId));
            ps.setInt(2, Integer.parseInt(carId));
            ps.setInt(3, Integer.parseInt(driverId));
            ps.setString(4, bookingDate);
            ps.setString(5, destination);
            ps.setInt(6, bookingId);

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            conn.close();

            if (rowsUpdated > 0) {
                // Redirect back to bookings list
                response.sendRedirect("viewBookings.jsp");
            } else {
                out.println("<p class='text-danger'>Error: No rows updated. Check if the booking ID is valid.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error updating booking: " + e.getMessage() + "</p>");
        }
        return; // Stop processing the JSP after handling POST
    } else {
        // GET request: Load existing booking data to pre-fill the form
        String customerId = "";
        String carId = "";
        String driverId = "";
        String bookingDate = "";
        String destination = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String selectSql = "SELECT * FROM booking WHERE booking_id = ?";
            PreparedStatement ps = conn.prepareStatement(selectSql);
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customerId = rs.getString("customer_id");
                carId = rs.getString("car_id");
                driverId = rs.getString("driver_id");
                bookingDate = rs.getString("booking_date");
                destination = rs.getString("destination");
            } else {
                out.println("<p>Booking not found for ID: " + bookingId + "</p>");
                return;
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error loading booking: " + e.getMessage() + "</p>");
            return;
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Booking</h2>
    <form method="post">
        <!-- Customer ID -->
        <div class="mb-3">
            <label for="customer_id" class="form-label">Customer ID</label>
            <input type="text" class="form-control" id="customer_id" name="customer_id"
                   value="<%= customerId %>" required>
        </div>
        <!-- Car ID -->
        <div class="mb-3">
            <label for="car_id" class="form-label">Car ID</label>
            <input type="text" class="form-control" id="car_id" name="car_id"
                   value="<%= carId %>" required>
        </div>
        <!-- Driver ID -->
        <div class="mb-3">
            <label for="driver_id" class="form-label">Driver ID</label>
            <input type="text" class="form-control" id="driver_id" name="driver_id"
                   value="<%= driverId %>" required>
        </div>
        <!-- Booking Date -->
        <div class="mb-3">
            <label for="booking_date" class="form-label">Booking Date</label>
            <input type="text" class="form-control" id="booking_date" name="booking_date"
                   value="<%= bookingDate %>" required>
        </div>
        <!-- Destination -->
        <div class="mb-3">
            <label for="destination" class="form-label">Destination</label>
            <input type="text" class="form-control" id="destination" name="destination"
                   value="<%= destination %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Booking</button>
        <a href="viewBookings.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
<%
    } // end else (GET)
%>
