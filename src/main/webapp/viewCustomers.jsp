<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Customers</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .container {
            margin-top: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        th {
            background-color: #f8f9fa;
        }
        .back-button {
            margin-top: 20px;
        }
        .btn-edit, .btn-delete {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">View Customers</a>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Customers List</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact Number</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicleReservationDb", "root", "");
                        String sql = "SELECT customer_id, name, email, contact_number FROM customers";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int customerId = rs.getInt("customer_id");
                            String name = rs.getString("name");
                            String email = rs.getString("email");
                            String contactNumber = rs.getString("contact_number");
                %>
                <tr>
                    <td><%= customerId %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= contactNumber %></td>
                    <td>
                        <a href='editCustomer.jsp?id=<%= customerId %>' class='btn btn-primary btn-sm btn-edit'>Edit</a>
                        <a href='javascript:void(0);' onclick='confirmDelete(<%= customerId %>)' class='btn btn-danger btn-sm btn-delete'>Delete</a>
                    </td>
                </tr>
                <%
                        }
                    } catch(Exception e) {
                %>
                <tr>
                    <td colspan="5" class="text-center text-danger">Error: <%= e.getMessage() %></td>
                </tr>
                <%
                    } finally {
                        if(rs != null) try { rs.close(); } catch(Exception e){}
                        if(ps != null) try { ps.close(); } catch(Exception e){}
                        if(conn != null) try { conn.close(); } catch(Exception e){}
                    }
                %>
            </tbody>
        </table>
        <div class="text-center back-button">
            <a href="adminDashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>

    <!-- JavaScript for Confirmation -->
    <script>
        function confirmDelete(customerId) {
            if (confirm("Are you sure you want to delete this customer?")) {
                window.location.href = "deleteCustomer.jsp?id=" + customerId;
            }
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
