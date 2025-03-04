@WebServlet("/updateDriver")
public class UpdateDriverServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String licenseNumber = request.getParameter("licenseNumber");
        String contactNumber = request.getParameter("contactNumber");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String query = "UPDATE drivers SET name = ?, license_number = ?, contact_number = ? WHERE driver_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, licenseNumber);
            ps.setString(3, contactNumber);
            ps.setString(4, id);

            ps.executeUpdate();

            ps.close();
            connection.close();

            response.sendRedirect("listDrivers.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("listDrivers.jsp?error=1");
        }
    }
}