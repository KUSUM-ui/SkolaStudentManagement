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
<!-- CONTACT SECTION -->
  <section class="contact-section" id="contact">
    <div class="contact-bg">
      <img src="${pageContext.request.contextPath}/resources/images/contactbg.png"
           alt="Auditorium" />
      <div class="contact-overlay"></div>
    </div>
    <div class="contact-card">
      <h2>Contact Us</h2>

      <% String msg = (String) request.getAttribute("message"); %>
      <% if (msg != null) { %>
        <p class="form-message"><%= msg %></p>
      <% } %>

      <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" required />
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required />
        </div>
        <div class="form-group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="5" required></textarea>
        </div>
        <button type="submit" class="btn-send">Send</button>
      </form>
    </div>
  </section>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer-inner">
      <div class="footer-brand">
        <div class="footer-logo">
          <span class="logo-icon">🦢</span>
          <span class="logo-text white">SKOLA</span>
        </div>
        <p>The Academic Curator for institutions that value excellence, aesthetics,
           and efficiency in every digital touchpoint.</p>
      </div>
      <div class="footer-links">
        <a href="${pageContext.request.contextPath}/HomeServlet">Home</a>
        <a href="#about">About Us</a>
        <a href="#contact">Contact Us</a>
      </div>
      <div class="footer-contact">
        <p class="footer-col-title">Contact</p>
        <p>✉ skola@edu.np</p>
        <p>📞 977+ 9741877269</p>
        <p>📍 Suryabinayak, BKT</p>
      </div>
    </div>
    <div class="footer-bottom">
      <span>&copy; 2024 Relume. All rights reserved.</span>
      <div class="footer-bottom-links">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Cookies Settings</a>
      </div>
    </div>
  </footer>



</body>
</html>
