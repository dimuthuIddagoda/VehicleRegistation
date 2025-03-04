<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Car</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Edit Car</a>
        </div>
    </nav>

    <div class="container mt-5">
        <h2>Edit Car</h2>
        <form action="updateCar.jsp" method="post" onsubmit="return validateYear()">
            <%
                // Get the car ID from the request
                int carId = Integer.parseInt(request.getParameter("id"));

                // Fetch car details from the database
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                    String query = "SELECT * FROM cars WHERE car_id = ?";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setInt(1, carId);
                    ResultSet resultSet = ps.executeQuery();

                    if (resultSet.next()) {
                        out.println("<input type='hidden' name='carId' value='" + carId + "'>");
                        out.println("<div class='mb-3'>");
                        out.println("<label for='model' class='form-label'>Model</label>");
                        out.println("<input type='text' class='form-control' id='model' name='model' value='" + resultSet.getString("model") + "' required>");
                        out.println("</div>");
                        out.println("<div class='mb-3'>");
                        out.println("<label for='licensePlate' class='form-label'>License Plate</label>");
                        out.println("<input type='text' class='form-control' id='licensePlate' name='licensePlate' value='" + resultSet.getString("license_plate") + "' required>");
                        out.println("</div>");
                        out.println("<div class='mb-3'>");
                        out.println("<label for='yearMade' class='form-label'>Year Made</label>");
                        out.println("<input type='text' class='form-control' id='yearMade' name='yearMade' value='" + resultSet.getString("year_made") + "' required>");
                        out.println("<small id='yearError' class='text-danger'></small>");
                        out.println("</div>");
                    }

                    resultSet.close();
                    ps.close();
                    connection.close();
                } catch (Exception e) {
                    out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                }
            %>
            <button type="submit" class="btn btn-primary">Update Car</button>
        </form>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <!-- JavaScript for Validation -->
    <script>
        function validateYear() {
            const yearInput = document.getElementById("yearMade").value;
            const yearError = document.getElementById("yearError");

            // Check if the input is a 4-digit number between 1901 and 2155
            if (!/^\d{4}$/.test(yearInput)) {
                yearError.textContent = "Year must be a 4-digit number.";
                return false;
            }

            const year = parseInt(yearInput);
            if (year < 1901 || year > 2155) {
                yearError.textContent = "Year must be between 1901 and 2155.";
                return false;
            }

            yearError.textContent = "";
            return true;
        }
    </script>
</body>
</html>