<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%
    // Retrieve "id" parameter
    String driverIdParam = request.getParameter("id");
    if (driverIdParam == null || driverIdParam.isEmpty()) {
        out.println("<p>Missing driver ID.</p>");
        return;
    }

    int driverId = 0;
    try {
        driverId = Integer.parseInt(driverIdParam);
    } catch (NumberFormatException e) {
        out.println("<p>Invalid driver ID.</p>");
        return;
    }

    // Check if the form was submitted (POST)
    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        // Handle the update logic
        String name = request.getParameter("name");
        String licenseNumber = request.getParameter("license_number");
        String contactNumber = request.getParameter("contact_number");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String updateSql = "UPDATE drivers SET name=?, license_number=?, contact_number=? WHERE driver_id=?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, name);
            ps.setString(2, licenseNumber);
            ps.setString(3, contactNumber);
            ps.setInt(4, driverId);

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            conn.close();

            if (rowsUpdated > 0) {
                // Redirect back to drivers list
                response.sendRedirect("listDrivers.jsp");
            } else {
                out.println("<p class='text-danger'>Error: No rows updated. Check if the driver ID is valid.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error updating driver: " + e.getMessage() + "</p>");
        }
        return; // Stop processing the JSP after handling POST
    } else {
        // GET request: Load existing driver data to pre-fill the form
        String name = "";
        String licenseNumber = "";
        String contactNumber = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String selectSql = "SELECT * FROM drivers WHERE driver_id = ?";
            PreparedStatement ps = conn.prepareStatement(selectSql);
            ps.setInt(1, driverId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                licenseNumber = rs.getString("license_number");
                contactNumber = rs.getString("contact_number");
            } else {
                out.println("<p>Driver not found for ID: " + driverId + "</p>");
                return;
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error loading driver: " + e.getMessage() + "</p>");
            return;
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Driver</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Driver</h2>
    <form method="post">
        <!-- Driver ID (hidden) -->
        <input type="hidden" name="driverId" value="<%= driverId %>">

        <!-- Name -->
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
        </div>

        <!-- License Number -->
        <div class="mb-3">
            <label for="license_number" class="form-label">License Number</label>
            <input type="text" class="form-control" id="license_number" name="license_number" value="<%= licenseNumber %>" required>
        </div>

        <!-- Contact Number -->
        <div class="mb-3">
            <label for="contact_number" class="form-label">Contact Number</label>
            <input type="text" class="form-control" id="contact_number" name="contact_number" value="<%= contactNumber %>" required>
        </div>

        <button type="submit" class="btn btn-primary">Update Driver</button>
        <a href="listDrivers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
<%
    } // end else (GET)
%>
