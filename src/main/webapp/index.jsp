<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vehicle Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Global Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://via.placeholder.com/1920x1080') no-repeat center center/cover;
            color: #2c3e50;
            margin: 0;
            padding: 0;
        }

        /* Navbar */
        .custom-navbar {
            background-color: rgba(44, 62, 80, 0.95);
            padding: 1rem 0;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .custom-navbar .navbar-brand {
            color: #ffffff !important;
            font-weight: 700;
            font-size: 1.75rem;
        }
        .custom-navbar .nav-link {
            color: #ffffff !important;
            font-size: 1rem;
            font-weight: 500;
            transition: color 0.3s ease-in-out;
        }
        .custom-navbar .nav-link:hover {
            color: #f39c12 !important;
        }
        .custom-navbar .btn-light {
            background-color: #09d006;
            border: none;
            color: #fff !important;
            font-weight: 600;
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .custom-navbar .btn-light:hover {
            background-color: #09a206;
        }

        /* Hero Section */
        .hero-text {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 3rem;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            margin-top: 100px;
            text-align: center;
        }
        .hero-text h1 {
            font-size: 3.5rem;
            font-weight: 700;
            color: #2c3e50;
        }
        .hero-text p {
            font-size: 1.5rem;
            color: #7f8c8d;
        }

        /* Buttons */
        .btn-custom {
            font-size: 1.2rem;
            padding: 0.75rem 2rem;
            border-radius: 30px;
            background-color: #3498db;
            border: none;
            color: #fff;
            transition: background 0.3s ease-in-out;
        }
        .btn-custom:hover {
            background-color: #2980b9;
        }

        /* Sections */
        .section {
            padding: 4rem 2rem;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
            margin: 2rem 0;
        }
        .section h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2c3e50;
        }
        .section p {
            font-size: 1.2rem;
            color: #7f8c8d;
            line-height: 1.8;
        }

        /* Footer */
        .footer {
            background-color: #2c3e50;
            color: #ffffff;
            text-align: center;
            padding: 1.5rem;
            margin-top: 3rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">Vehicle Reservation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about-us">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact-us">Contact</a></li>
                </ul>
                <a href="login.jsp" class="btn btn-light ms-3">Login</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 pt-5">
        <div id="home" class="hero-text">
            <h1>Find Your Dream Car</h1>
            <p>Over a thousand cars to choose from.</p>
            <a href="signup.jsp" class="btn btn-custom">Sign Up Now</a>
        </div>
    </div>

    <div class="container">
        <div id="about-us" class="section">
            <h2>About Us</h2>
            <p>We provide a seamless vehicle reservation experience with a variety of cars for every occasion.</p>
        </div>

        <div id="contact-us" class="section">
            <h2>Contact Us</h2>
            <p>Email: vehiclereservationt@gmail.com | Phone: +94-456-7890</p>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Vehicle Reservation. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
