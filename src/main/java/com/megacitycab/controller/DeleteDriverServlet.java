@WebServlet("/deleteDriver")
public class DeleteDriverServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");

            String query = "DELETE FROM drivers WHERE driver_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, id);

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