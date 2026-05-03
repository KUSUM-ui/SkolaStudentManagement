<%@ page language="java" contentType="text/html; charset=UTF-8" 
         pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA – Contact Us</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/contactus.css" />
</head>
<body>

  <!-- NAVBAR -->
  <nav class="navbar">
    <div class="nav-logo">
      <img src="<%=request.getContextPath()%>/resources/images/logo.png" alt="SKOLA" class="logo-img" />
      <span class="logo-text">SKOLA</span>
    </div>
    <ul class="nav-links">
      <li><a href="<%=request.getContextPath()%>/HomeServlet">Home</a></li>
      <li><a href="<%=request.getContextPath()%>/AboutUsServlet">About Us</a></li>
      <li><a href="<%=request.getContextPath()%>/ContactUsServlet" class="active">Contact Us</a></li>
    </ul>
    <a href="<%=request.getContextPath()%>/login.jsp">
      <button class="btn-login">Login</button>
    </a>
  </nav>

  <!-- HERO BANNER -->
  <section class="cu-banner">
    <img src="<%=request.getContextPath()%>/resources/images/contactbg.png" alt="Contact Banner" />
    <div class="cu-banner-overlay">
      <h1>Contact Us</h1>
    </div>
  </section>

  <!-- MAIN CONTENT -->
  <section class="cu-main">

    <!-- LEFT: Get in touch info -->
    <div class="cu-info">
      <h2>Get in touch</h2>

      <div class="cu-info-details">
        <div class="cu-info-item">
          <p class="cu-info-label">Address</p>
          <p class="cu-info-value">Suryabinayak, Bhaktapur</p>
        </div>
        <div class="cu-info-item">
          <p class="cu-info-label">Phone number</p>
          <p class="cu-info-value">977+ 9741877269</p>
        </div>
        <div class="cu-info-item">
          <p class="cu-info-label">Email</p>
          <p class="cu-info-value">skola@email.np</p>
        </div>
      </div>

      <div class="cu-social">
        <p class="cu-social-title">Follow us</p>
        <div class="cu-social-icons">
          <a href="#" class="cu-social-btn" aria-label="Twitter">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 3a10.9 10.9 0 01-3.14 1.53A4.48 4.48 0 0012 7v1A10.66 10.66 0 013 4s-4 9 5 13a11.64 11.64 0 01-7 2c9 5 20 0 20-11.5a4.5 4.5 0 00-.08-.83A7.72 7.72 0 0023 3z"/></svg>
          </a>
          <a href="#" class="cu-social-btn" aria-label="Facebook">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"/></svg>
          </a>
          <a href="#" class="cu-social-btn" aria-label="Instagram">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"/><path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>
          </a>
        </div>
      </div>
    </div>

    <!-- RIGHT: Contact Form -->
    <div class="cu-form-card">

      <% String msg = (String) request.getAttribute("message"); %>
      <% if (msg != null) { %>
        <p class="form-message <%= (String) request.getAttribute("msgType") != null && request.getAttribute("msgType").equals("error") ? "error" : "" %>">
          <%= msg %>
        </p>
      <% } %>

      <form action="<%=request.getContextPath()%>/ContactUsServlet" method="post">
        <div class="form-group">
          <label for="name">Name</label>
          <input type="text" id="name" name="name" required
                 value="<%= request.getAttribute("formName") != null ? request.getAttribute("formName") : "" %>" />
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required
                 value="<%= request.getAttribute("formEmail") != null ? request.getAttribute("formEmail") : "" %>" />
        </div>
        <div class="form-group">
          <label for="message">Message</label>
          <textarea id="message" name="message" rows="7" required></textarea>
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
        <a href="<%=request.getContextPath()%>/HomeServlet">Home</a>
        <a href="<%=request.getContextPath()%>/AboutUsServlet">About Us</a>
        <a href="<%=request.getContextPath()%>/ContactUsServlet">Contact Us</a>
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
