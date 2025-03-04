<!-- editCustomer.jsp -->
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
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

    String method = request.getMethod();
    if ("POST".equalsIgnoreCase(method)) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contact_number");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String updateSql = "UPDATE customers SET name=?, email=?, contact_number=? WHERE customer_id=?";
            PreparedStatement ps = conn.prepareStatement(updateSql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, contactNumber);
            ps.setInt(4, customerId);

            int rowsUpdated = ps.executeUpdate();
            ps.close();
            conn.close();

            if (rowsUpdated > 0) {
                response.sendRedirect("viewCustomers.jsp");
            } else {
                out.println("<p class='text-danger'>Error: No rows updated. Check if the customer ID is valid.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error updating customer: " + e.getMessage() + "</p>");
        }
        return;
    } else {
        String name = "";
        String email = "";
        String contactNumber = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String selectSql = "SELECT * FROM customers WHERE customer_id = ?";
            PreparedStatement ps = conn.prepareStatement(selectSql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                email = rs.getString("email");
                contactNumber = rs.getString("contact_number");
            } else {
                out.println("<p>Customer not found for ID: " + customerId + "</p>");
                return;
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p class='text-danger'>Error loading customer: " + e.getMessage() + "</p>");
            return;
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Customer</h2>
    <form method="post">
        <input type="hidden" name="customerId" value="<%= customerId %>">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= name %>" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
        </div>
        <div class="mb-3">
            <label for="contact_number" class="form-label">Contact Number</label>
            <input type="text" class="form-control" id="contact_number" name="contact_number" value="<%= contactNumber %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Customer</button>
        <a href="viewCustomers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
<%
    }
%>