import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteCar")
public class DeleteCarServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        System.out.println("Deleting car with ID: " + carId); // Log the car ID

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
            String query = "DELETE FROM cars WHERE car_id = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, carId);
            int rowsDeleted = ps.executeUpdate();
            System.out.println("Rows deleted: " + rowsDeleted); // Log the number of rows deleted

            if (rowsDeleted > 0) {
                response.sendRedirect("manageCars.jsp"); // Redirect to manageCars.jsp after deletion
            } else {
                response.sendRedirect("deleteCar.jsp?id=" + carId); // Redirect back if deletion fails
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            response.sendRedirect("deleteCar.jsp?id=" + carId); // Redirect back if an error occurs
        }
    }
}