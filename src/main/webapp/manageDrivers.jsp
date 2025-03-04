<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Drivers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .container {
            flex: 1;
            background: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: none;
            margin: 0;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            color: #2c3e50;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 20px;
            font-size: 1rem;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .back-button {
            margin-top: 20px;
        }
        .btn btn-secondary{
           background-color: #5a5b5c;
        
        
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Manage Drivers</a>
        </div>
    </nav>

    <div class="container">
        <h2>Add New Driver</h2>
        <form id="driverForm" method="post" action="manageDrivers.jsp">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter driver name" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="licenseNumber">License Number</label>
                <input type="text" id="licenseNumber" name="licenseNumber" placeholder="Enter license number" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="contactNumber">Contact Number</label>
                <input type="text" id="contactNumber" name="contactNumber" placeholder="Enter contact number" class="form-control" required>
            </div>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Add Driver</button>
            </div>
        </form>

        <div class="text-center back-button">
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String licenseNumber = request.getParameter("licenseNumber");
            String contactNumber = request.getParameter("contactNumber");
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                String query = "INSERT INTO drivers (name, license_number, contact_number) VALUES (?, ?, ?)";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, name);
                ps.setString(2, licenseNumber);
                ps.setString(3, contactNumber);
                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    out.println("<p class='text-success text-center'>Driver added successfully!</p>");
                } else {
                    out.println("<p class='text-danger text-center'>Failed to add driver.</p>");
                }
                response.sendRedirect("manageDrivers.jsp");
            } catch (Exception e) {
                out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
