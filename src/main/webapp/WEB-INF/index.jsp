<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA – Academic Curator</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<nav class="navbar">
  <div class="nav-logo">
    <span class="logo-icon">🦢</span>
    <span class="logo-text">SKOLA</span>
  </div>
  <ul class="nav-links">
    <li><a href="HomeServlet">Home</a></li>
    <li><a href="#about">About Us</a></li>
    <li><a href="#contact">Contact Us</a></li>
  </ul>
  <a href="login.jsp"><button class="btn-login">Login</button></a>
</nav>


	<%-- HERO SECTION --%>
	<section class="hero">
		<div class="hero-text">
			<p class="hero-welcome">Welcome to,</p>
			<h1 class="hero-title">SKOLA</h1>
			<p class="hero-desc">A professional digital ecosystem designed
				for curated academic management. Elevate institutional efficiency
				with SKOLA's airy, modern interface.</p>
			<div class="hero-buttons">
				<a href="admin/dashboard.jsp"><button class="btn-primary">Admin</button></a>
				<a href="student/dashboard.jsp"><button class="btn-secondary">Student</button></a>
			</div>
		</div>
		<div class="hero-image">
			<div class="image-blob">
				<img src="${pageContext.request.contextPath}/resources/images/image 96.png" 
     alt="School Building" />
			</div>
		</div>
	</section>

	<%-- STATS SECTION --%>
  <section class="stats">
    <div class="stat-item">
      <span class="stat-number">50+</span>
      <span class="stat-label">Institutions</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">1.2K</span>
      <span class="stat-label">Active Students</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">98%</span>
      <span class="stat-label">Efficiency Rate</span>
    </div>
    <div class="stat-item">
      <span class="stat-number">4.9/5</span>
      <span class="stat-label">User Rating</span>
    </div>
  </section>

  <%-- ABOUT SECTION --%>
  <section class="about" id="about">
    <div class="about-image">
      <div class="about-blob"></div>
      <img src="https://images.unsplash.com/photo-1529390079861-591de354faf5?w=500&q=80" alt="Students" />
    </div>
    <div class="about-text">
      <h2>About Us</h2>
      <p>Skola is a smart, user-friendly student management platform designed to simplify academic life.
         It lets students access schedules, check teacher availability, organize notes, and stay updated
         with daily activities. It also supports club registration and participation, helping students
         stay organized, connected, and in control of their learning.</p>
      <a href="about.jsp"><button class="btn-outline">View more</button></a>
    </div>
  </section>




</body>
</html>
