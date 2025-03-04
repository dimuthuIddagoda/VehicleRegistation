<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Drivers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function confirmDelete(driverId) {
            if (confirm("Are you sure you want to delete this driver?")) {
                window.location.href = "deleteDriver.jsp?id=" + driverId;
            }
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Manage Drivers</a>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center mb-4">List of Drivers</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Driver ID</th>
                    <th>Name</th>
                    <th>License Number</th>
                    <th>Contact Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery("SELECT * FROM drivers");

                        while (resultSet.next()) {
                            int driverId = resultSet.getInt("driver_id");
                            String name = resultSet.getString("name");
                            String licenseNumber = resultSet.getString("license_number");
                            String contactNumber = resultSet.getString("contact_number");
                %>
                            <tr>
                                <td><%= driverId %></td>
                                <td><%= name %></td>
                                <td><%= licenseNumber %></td>
                                <td><%= contactNumber %></td>
                                <td>
                                    <a href="editDriver.jsp?id=<%= driverId %>" class="btn btn-primary btn-sm">Edit</a>
                                    <a href="javascript:void(0);" onclick="confirmDelete(<%= driverId %>)" class="btn btn-danger btn-sm">Delete</a>
                                </td>
                            </tr>
                <%
                        }
                        resultSet.close();
                        statement.close();
                        connection.close();
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>

        <a href="adminDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    </div>
</body>
</html>
