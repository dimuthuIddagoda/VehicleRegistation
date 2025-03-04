<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("bookingId");
    String kmStr = request.getParameter("km");
    double totalBill = 0;

    if (bookingId != null && !bookingId.isEmpty() && kmStr != null && !kmStr.isEmpty()) {
        try {
            // Convert km to double
            double km = Double.parseDouble(kmStr);
            totalBill = km * 200;  // Calculate total bill as km * 200

            // Database connection for additional data (if needed)
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehiclereservationdb", "root", "");

                // You can also query additional data using the bookingId if needed
                String sql = "SELECT total_amount FROM booking WHERE booking_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, bookingId);
                rs = pstmt.executeQuery();

               
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }

            // Output the calculated bill
            out.println("<h3>Your total bill is: lkr " + totalBill + "0</h3>");

        } catch (NumberFormatException e) {
            out.println("<h3>Error: Please enter a valid number for kilometers.</h3>");
        }
    } else {
        out.println("<h3>Please enter a valid Booking ID and Distance.</h3>");
    }
%>
