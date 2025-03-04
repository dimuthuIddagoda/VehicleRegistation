<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Cars</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            margin-top: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
        }
        .btn-edit, .btn-delete {
            margin-right: 5px;
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
            <a class="navbar-brand" href="#">Manage Cars</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2>Manage Cars</h2>
        <table id="carTable">
            <thead>
                <tr>
                    <th>Model</th>
                    <th>License Plate</th>
                    <th>Year Made</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery("SELECT * FROM cars");

                        while (resultSet.next()) {
                            int carId = resultSet.getInt("car_id");
                            String model = resultSet.getString("model");
                            String licensePlate = resultSet.getString("license_plate");
                            String yearMade = resultSet.getString("year_made");
                %>
                            <tr>
                                <td><%= model %></td>
                                <td><%= licensePlate %></td>
                                <td><%= yearMade %></td>
                                <td>
                                    <a href='editCar.jsp?id=<%= carId %>' class='btn btn-primary btn-sm btn-edit'>Edit</a>
                                    <a href='javascript:void(0);' onclick='confirmDelete(<%= carId %>)' class='btn btn-danger btn-sm btn-delete'>Delete</a>
                                </td>
                            </tr>
                <%
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

        <!-- Back to Dashboard Button -->
        <div class="text-center back-button">
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>

    <!-- JavaScript for Confirmation -->
    <script>
        function confirmDelete(carId) {
            if (confirm("Are you sure you want to delete this car?")) {
                window.location.href = "deleteCar.jsp?id=" + carId;
            }
        }
    </script>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
