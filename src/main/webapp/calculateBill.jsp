<!DOCTYPE html>
<html>
<head>
    <title>Calculate Bill</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 50px;
            max-width: 600px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .btn-calculate {
            background-color: #007bff;
            border: none;
            color: #fff;
            width: 100%;
            padding: 10px;
            font-size: 1rem;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-calculate:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center">Calculate Your Bill</h2>
        <form action="calculateBillProcess.jsp" method="post">
            <label for="bookingId">Booking ID</label>
            <input type="text" id="bookingId" name="bookingId" required class="form-control mb-3">
            
            <label for="km">Distance in Km</label>
            <input type="number" id="km" name="km" required class="form-control mb-3">
            
            <button type="submit" class="btn-calculate">Calculate Bill</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
