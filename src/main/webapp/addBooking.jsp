<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Booking</title>
    <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
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
        .form-label {
            font-weight: bold;
        }
        .btn-primary {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 8px;
            background-color: #007bff;
            border: none;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 8px;
            background-color: #6c757d;
            border: none;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Add Booking</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h2 class="text-center mb-4">Add New Booking</h2>
                <form id="bookingForm" method="post" action="addBooking.jsp">
                    <!-- Customer ID -->
                    <div class="mb-3">
                        <label for="customerId" class="form-label">Customer ID</label>
                        <input type="number" class="form-control" id="customerId" name="customerId" required>
                    </div>
                    <!-- Car ID -->
                    <div class="mb-3">
                        <label for="carId" class="form-label">Car ID</label>
                        <input type="number" class="form-control" id="carId" name="carId" required>
                    </div>
                    <!-- Driver ID -->
                    <div class="mb-3">
                        <label for="driverId" class="form-label">Driver ID</label>
                        <input type="number" class="form-control" id="driverId" name="driverId">
                    </div>
                    <!-- Booking Date -->
                    <div class="mb-3">
                        <label for="bookingDate" class="form-label">Booking Date</label>
                        <input type="date" class="form-control" id="bookingDate" name="bookingDate" required>
                    </div>
                    <!-- Destination -->
                    <div class="mb-3">
                        <label for="destination" class="form-label">Destination</label>
                        <input type="text" class="form-control" id="destination" name="destination" required>
                    </div>
                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <!-- Back to Dashboard Button -->
                    <div class="text-center mt-3">
                        <a href="customerDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <%-- Scriptlet to handle form submission --%>
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Get form data
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int carId = Integer.parseInt(request.getParameter("carId"));
            int driverId = request.getParameter("driverId") != null && !request.getParameter("driverId").isEmpty()
                    ? Integer.parseInt(request.getParameter("driverId"))
                    : 0; // Default to 0 if driverId is not provided
            String bookingDate = request.getParameter("bookingDate");
            String destination = request.getParameter("destination");

            // Save booking to the database
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                String query = "INSERT INTO booking (customer_id, car_id, driver_id, booking_date, destination) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setInt(1, customerId);
                ps.setInt(2, carId);
                ps.setInt(3, driverId);
                ps.setString(4, bookingDate);
                ps.setString(5, destination);
                ps.executeUpdate();

                // Redirect to viewBookings.jsp after successful submission
                response.sendRedirect("customerDashboard.jsp");
            } catch (Exception e) {
                out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>