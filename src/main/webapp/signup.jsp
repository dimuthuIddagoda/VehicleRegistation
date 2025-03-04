<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .signup-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .signup-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-control {
            margin-bottom: 15px;
        }
        .btn-signup {
            width: 100%;
            background-color: #007bff;
            color: #fff;
        }
        .btn-signup:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form action="signup.jsp" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number</label>
                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-signup">Sign Up</button>
        </form>

        <%-- Scriptlet to handle signup logic --%>
        <%
            // Get form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String password = request.getParameter("password");

            if (name != null && email != null && contactNumber != null && password != null) {
                // Save customer data to the database
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                    String query = "INSERT INTO customers (name, email, contact_number, password) VALUES (?, ?, ?, ?)";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setString(3, contactNumber);
                    ps.setString(4, password);
                    ps.executeUpdate();

                    // Redirect to customerDashboard.jsp after successful signup
                    response.sendRedirect("customerDashboard.jsp");
                } catch (Exception e) {
                    out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>