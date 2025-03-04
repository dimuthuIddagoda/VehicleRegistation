<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            margin-top: 30px;
        }
        .dashboard-card {
            background: #fff;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            border-color: #007bff;
        }
        .dashboard-card h3 {
            font-size: 1.5rem;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        .dashboard-card p {
            color: #666;
            font-size: 1rem;
        }
        .dashboard-card .btn {
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 8px;
            background-color: #007bff;
            border: none;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .dashboard-card .btn:hover {
            background-color: #0056b3;
        }
        .dashboard-cards-container {
            margin-top: 140px;
        }
        .row-centered {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Admin Dashboard</a>
            <div class="navbar-nav">
                <a href="logout.jsp" class="btn btn-danger">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container">
        <h2 class="text-center mb-4">Welcome to Admin Dashboard</h2>
        <div class="dashboard-cards-container">
            <div class="row row-centered">
                <!-- Manage Cars Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>Manage Cars</h3>
                        <p>Edit, or remove cars from the system.</p>
                        <a href="manageCars.jsp" class="btn">Manage Cars</a>
                    </div>
                </div>
                <!-- Manage Drivers Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>Add Drivers</h3>
                        <p>Add  drivers to the system.</p>
                        <a href="manageDrivers.jsp" class="btn">Manage Drivers</a>
                    </div>
                </div>
                <!-- View Bookings Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>View Bookings</h3>
                        <p>View ,Edit OR Delete all bookings made by customers.</p>
                        <a href="viewBookings.jsp" class="btn">View Bookings</a>
                    </div>
                </div>
                <!-- Add Vehicle Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>Add Vehicle</h3>
                        <p>Add a new vehicle to the system.</p>
                        <a href="bookVehicle.jsp" class="btn">Add Vehicle</a>
                    </div>
                </div>
                <!-- List of Drivers Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>List of Drivers</h3>
                        <p>View the list of all drivers in the system.</p>
                        <a href="listDrivers.jsp" class="btn">List of Drivers</a>
                    </div>
                </div>
                <!-- New: View Customers Card -->
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>View Customers</h3>
                        <p>View all customers in the system.</p>
                        <a href="viewCustomers.jsp" class="btn">View Customers</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
