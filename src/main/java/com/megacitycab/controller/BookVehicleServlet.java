package com.megacitycab.controller;

import com.megacitycab.model.Booking;
import com.megacitycab.database.Database;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/bookVehicle")
public class BookVehicleServlet extends HttpServlet {
    private Database database = new Database();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int carId = Integer.parseInt(request.getParameter("carId"));
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String destination = request.getParameter("destination");

        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setCarId(carId);
        booking.setDriverId(driverId);
        booking.setDestination(destination);

        database.saveBooking(booking);
        response.sendRedirect("customerDashboard.jsp");
    }
}
