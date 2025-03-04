<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Available Cars</title>
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
        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">View Available Cars</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2>View Available Cars</h2>
        <table id="carTable">
            <thead>
                <tr>
                    <th>Car Id</th>
                    <th>Model</th>
                    <th>License Plate</th>
                    <th>Year Made</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Pagination setup
                    int recordsPerPage = 10; // Number of records per page
                    int currentPage = 1; // Default to the first page
                    if (request.getParameter("page") != null) {
                        currentPage = Integer.parseInt(request.getParameter("page"));
                    }

                    int startFrom = (currentPage - 1) * recordsPerPage; // Calculate the offset

                    // Initialize totalPages variable outside try-catch to be in scope for pagination controls
                    int totalPages = 1; // Default in case of an error

                    // Database connection
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                        Statement statement = connection.createStatement();

                        // Count total records for pagination
                        String countQuery = "SELECT COUNT(*) FROM cars";
                        ResultSet countResultSet = statement.executeQuery(countQuery);
                        int totalRecords = 0;
                        if (countResultSet.next()) {
                            totalRecords = countResultSet.getInt(1);
                        }

                        // Calculate total pages
                        totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

                        // Fetch data for the current page
                        String sql = "SELECT * FROM cars LIMIT " + recordsPerPage + " OFFSET " + startFrom;
                        ResultSet resultSet = statement.executeQuery(sql);

                        while (resultSet.next()) {
                            int car_id = resultSet.getInt("car_id");
                            String model = resultSet.getString("model");
                            String licensePlate = resultSet.getString("license_plate");
                            String yearMade = resultSet.getString("year_made");
                %>
                            <tr>
                                <td><%= car_id %></td>
                                <td><%= model %></td>
                                <td><%= licensePlate %></td>
                                <td><%= yearMade %></td>
                            </tr>
                <%
                        }
                        resultSet.close();
                        countResultSet.close();
                        statement.close();
                        connection.close();
                    } catch (Exception e) {
                        out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>

        <!-- Pagination Controls -->
        <div class="pagination">
            <%
                // Display previous page button
                if (currentPage > 1) {
            %>
                <a href="?page=<%= currentPage - 1 %>" class="btn btn-secondary mx-1">Previous</a>
            <%
                }

                // Display page numbers
                for (int i = 1; i <= totalPages; i++) {
            %>
                <a href="?page=<%= i %>" class="btn <%= (i == currentPage) ? "btn-primary" : "btn-outline-primary" %> mx-1">
                    <%= i %>
                </a>
            <%
                }

                // Display next page button
                if (currentPage < totalPages) {
            %>
                <a href="?page=<%= currentPage + 1 %>" class="btn btn-secondary mx-1">Next</a>
            <%
                }
            %>
        </div>

        <!-- Back to Dashboard Button -->
        <div class="text-center back-button">
            <a href="customerDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
