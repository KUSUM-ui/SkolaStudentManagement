<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8" isELIgnored="false"%>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA – About Us</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/aboutus.css" />
</head>
<body>

  <!-- NAVBAR -->
   <nav>
        <a href="HomeServlet" class="nav-brand">
          <div class="nav-logo">
      <img src="<%=request.getContextPath()%>/resources/images/logo.png" alt="SKOLA" class="logo-img" />
      
    </div>
            <span class="nav-wordmark">Skola</span>
        </a>
    <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/AboutusServlet" class="active">About Us</a></li>
      <li><a href="${pageContext.request.contextPath}/ContactUsServlet">Contact Us</a></li>
    </ul>
    <a href="${pageContext.request.contextPath}/login.jsp">
      <button class="btn-login">Login</button>
    </a>
  </nav>

  <!-- ABOUT HERO SECTION -->
  <section class="au-hero">
    <div class="au-hero-text">
      <h2>About us</h2>
      <p>Skola is a smart and user-friendly student management platform designed to simplify
         and enhance academic life. It provides a centralized space where students can easily
         access their class schedules, check teacher availability, organize notes, and stay
         updated with daily academic activities. By bringing essential tools together in one
         place, Skola reduces confusion and saves time, allowing students to focus more on
         learning and personal growth. In addition to academics, it also encourages student
         engagement through club registration and participation, helping build a more
         connected and active student community.</p>
    </div>
    <div class="au-hero-image">
      <img src="${pageContext.request.contextPath}/resources/images/abtus.png"
           alt="Students studying" />
    </div>
  </section>

  <!-- STATS SECTION -->
  <section class="au-stats">
    <div class="au-stat-item">
      <span class="au-stat-number">${institutionCount}</span>
      <span class="au-stat-label">Institutions</span>
      <span class="au-stat-desc">Trusted by institutions for quality education and impactful learning.</span>
    </div>
    <div class="au-stat-item">
      <span class="au-stat-number">${activeStudents}</span>
      <span class="au-stat-label">Active students</span>
      <span class="au-stat-desc">A growing community of engaged learners actively developing their skills and knowledge.</span>
    </div>
    <div class="au-stat-item">
      <span class="au-stat-number">${efficiencyRate}</span>
      <span class="au-stat-label">Efficiency rate</span>
      <span class="au-stat-desc">Proven success with high effectiveness in teaching methods and student outcomes.</span>
    </div>
    <div class="au-stat-item">
      <span class="au-stat-number">${userRating}</span>
      <span class="au-stat-label">User rating</span>
      <span class="au-stat-desc">Highly rated by users for excellent content, support, and overall learning experience.</span>
    </div>
  </section>

  <!-- WHAT SKOLA DOES SECTION -->
  <section class="au-what">
    <h2>What Skola does</h2>
    <p>Skola is a comprehensive student management system that helps students efficiently
       manage different aspects of their academic journey. It allows users to create and
       organize notes, view and track their schedules, register for clubs, and stay informed
       through announcements. The platform is designed to improve organization, communication,
       and participation, making it easier for students to stay on top of their responsibilities
       while also getting involved in extracurricular activities.</p>
  </section>

  <!-- MEET THE TEAM SECTION -->
  <section class="au-team">
    <h2>Meet the Team</h2>
    <div class="au-team-grid">

      <% 
        // Team members set by AboutUsServlet
        String[] names   = (String[]) request.getAttribute("teamNames");
        String[] roles   = (String[]) request.getAttribute("teamRoles");
        String[] photos  = (String[]) request.getAttribute("teamPhotos");

        if (names != null) {
          for (int i = 0; i < names.length; i++) {
      %>
        <div class="au-team-card">
          <div class="au-team-photo">
            <img src="${pageContext.request.contextPath}/resources/images/<%= photos[i] %>"
                 alt="<%= names[i] %>" />
          </div>
          <button class="au-team-name"><%= names[i] %></button>
        </div>
      <%
          }
        } else {
          // Fallback static cards if servlet has not set attributes
      %>
        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 1</button>
        </div>
        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 2</button>
        </div>
        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 3</button>
        </div>
        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 4</button>
        </div>
        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 5</button>
        </div>
      <% } %>

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
        <a href="${pageContext.request.contextPath}/AboutUsServlet">About Us</a>
        <a href="${pageContext.request.contextPath}/index.jsp#contact">Contact Us</a>
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
