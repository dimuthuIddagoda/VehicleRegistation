<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Cars</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
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
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #2c3e50;
        }
        h2 {
            margin-top: 20px;
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
        .car-list {
            margin-top: 20px;
        }
        .car-list table {
            width: 100%;
            border-collapse: collapse;
        }
        .car-list th, .car-list td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        .car-list th {
            background-color: #f8f9fa;
            color: #2c3e50;
        }
        .back-button {
            margin-top: 20px;
        }
         }
         .btn btn-secondary{
           background-color: #5a5b5c;
        
        
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Manage Vehicles</a>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
        <h2>Add new Vehicles</h2>
        <form id="carForm" method="post" action="bookVehicle.jsp">
            <div class="form-group">
                <label for="model">Model</label>
                <input type="text" id="model" name="model" placeholder="Enter car model" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="licensePlate">License Plate</label>
                <input type="text" id="licensePlate" name="licensePlate" placeholder="Enter license plate" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="yearMade">Year Made</label>
                <input type="text" id="yearMade" name="yearMade" placeholder="Enter year made" class="form-control" required>
            </div>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Add Car</button>
            </div>
        </form>

        <div class="car-list">
            <h2>Car List</h2>
            <table class="table" id="carTable">
                <thead>
                    <tr>
                        <th>Model</th>
                        <th>License Plate</th>
                        <th>Year Made</th>
                    </tr>
                </thead>
                <tbody id="carTableBody">
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery("SELECT * FROM cars");

                            while (resultSet.next()) {
                                out.println("<tr>");
                                out.println("<td>" + resultSet.getString("model") + "</td>");
                                out.println("<td>" + resultSet.getString("license_plate") + "</td>");
                                out.println("<td>" + resultSet.getString("year_made") + "</td>");
                                out.println("</tr>");
                            }

                            resultSet.close();
                            statement.close();
                            connection.close();
                        } catch (Exception e) {
                            out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                        }
                    %>
                </tbody>
            </table>
        </div>

        <!-- Back to Dashboard Button -->
        <div class="text-center back-button">
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <!-- Scriptlet to handle form submission -->
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get form data
            String model = request.getParameter("model");
            String licensePlate = request.getParameter("licensePlate");
            String yearMade = request.getParameter("yearMade");

            // Save car to the database
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                String query = "INSERT INTO cars (model, license_plate, year_made) VALUES (?, ?, ?)";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, model);
                ps.setString(2, licensePlate);
                ps.setString(3, yearMade);
                int rowsInserted = ps.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<p class='text-success text-center'>Car added successfully!</p>");
                } else {
                    out.println("<p class='text-danger text-center'>Failed to add car.</p>");
                }

                // Redirect to the same page to refresh the car list
                response.sendRedirect("bookVehicle.jsp");
            } catch (Exception e) {
                out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
