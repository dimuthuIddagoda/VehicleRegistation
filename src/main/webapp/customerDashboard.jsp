<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <script>
        function confirmLogout() {
            var result = confirm("Are you sure you want to log out?");
            if (result) {
                window.location.href = "CustomerLogOut.jsp";
            }
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Customer Dashboard</a>
            <div class="navbar-nav">
                <button class="btn btn-danger" onclick="confirmLogout()">Logout</button>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2 class="text-center mb-4">Welcome to Your Dashboard</h2>
        <div class="dashboard-cards-container">
            <div class="row row-centered">
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>View Bookings</h3>
                        <p>View all your current and past bookings.</p>
                        <a href="viewBookingsCustomer.jsp" class="btn">View Bookings</a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>Add Bookings</h3>
                        <p>Create a new booking for your vehicle.</p>
                        <a href="addBooking.jsp" class="btn">Add Bookings</a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>Calculate Bill</h3>
                        <p>Calculate the bill for your bookings.</p>
                        <a href="calculateBill.jsp" class="btn">Calculate Bill</a>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="dashboard-card">
                        <h3>View Available Cars</h3>
                        <p>View Available Cars for your bookings.</p>
                        <a href="viewAvailableCars.jsp" class="btn">View Available Cars</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
