<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    // Get form data
    int carId = Integer.parseInt(request.getParameter("carId"));
    String model = request.getParameter("model");
    String licensePlate = request.getParameter("licensePlate");
    String yearMade = request.getParameter("yearMade");

    // Update car in the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
        String query = "UPDATE cars SET model = ?, license_plate = ?, year_made = ? WHERE car_id = ?";
        PreparedStatement ps = connection.prepareStatement(query);
        ps.setString(1, model);
        ps.setString(2, licensePlate);
        ps.setString(3, yearMade);
        ps.setInt(4, carId);
        ps.executeUpdate();

        // Redirect to manageCars.jsp after successful update
        response.sendRedirect("manageCars.jsp");
    } catch (Exception e) {
        out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
    }
%>