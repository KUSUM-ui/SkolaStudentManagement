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
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;0,900;1,700&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/contactus.css" />
</head>
<body>

  <!-- ── NAVBAR (matches home/about) ── -->
   <nav>
        <a href="HomeServlet" class="nav-brand">
          <div class="nav-logo">
      <img src="<%=request.getContextPath()%>/resources/images/logo.png" alt="SKOLA" class="logo-img" />
      
    </div>
            <span class="nav-wordmark">Skola</span>
        </a>

        <ul class="nav-links">
      <li><a href="${pageContext.request.contextPath}/HomeServlet">Home</a></li>
      <li><a href="${pageContext.request.contextPath}/AboutUsServlet">About Us</a></li>
      <li><a href="${pageContext.request.contextPath}/ContactUsServlet" class="active">Contact Us</a></li>
    </ul>

        <div class="nav-right">
            <a href="login.jsp" class="btn-nav-login">Login</a>
        </div>
    </nav>

  <!-- ── HERO BANNER ── -->
  <section class="cu-banner">
    <img src="<%=request.getContextPath()%>/resources/images/contactbg.png" alt="Contact Banner" />
    <div class="cu-banner-overlay">
      <p class="banner-eyebrow"><i class="fa-solid fa-envelope"></i> &nbsp; Reach Out</p>
      <h1>Contact Us</h1>
      
    </div>
  </section>

  <!-- ── MAIN CONTENT ── -->
  <section class="cu-main">

    <!-- LEFT: Info -->
    <div class="cu-info">
      <p class="cu-info-eyebrow">Get in touch</p>
      <h2 class="cu-info-heading">Let's start a <em>conversation.</em></h2>

      <div class="cu-info-details">
        <div class="cu-info-item">
          <div class="cu-info-icon"><i class="fa-solid fa-location-dot"></i></div>
          <div>
            <p class="cu-info-label">Address</p>
            <p class="cu-info-value">Suryabinayak, Bhaktapur</p>
          </div>
        </div>
        <div class="cu-info-item">
          <div class="cu-info-icon"><i class="fa-solid fa-phone"></i></div>
          <div>
            <p class="cu-info-label">Phone number</p>
            <p class="cu-info-value">977+ 9741877269</p>
          </div>
        </div>
        <div class="cu-info-item">
          <div class="cu-info-icon"><i class="fa-solid fa-envelope"></i></div>
          <div>
            <p class="cu-info-label">Email</p>
            <p class="cu-info-value">skola@email.np</p>
          </div>
        </div>
      </div>

      <div class="cu-social">
        <p class="cu-social-title">Follow us</p>
        <div class="cu-social-icons">
          <a href="#" class="cu-social-btn" aria-label="Twitter">
            <i class="fa-brands fa-x-twitter"></i>
          </a>
          <a href="#" class="cu-social-btn" aria-label="Facebook">
            <i class="fa-brands fa-facebook-f"></i>
          </a>
          <a href="#" class="cu-social-btn" aria-label="Instagram">
            <i class="fa-brands fa-instagram"></i>
          </a>
        </div>
      </div>
    </div>

    <!-- RIGHT: Form -->
    <div class="cu-form-card">
      <p class="form-card-eyebrow">Send a message</p>
     

      <% String msg = (String) request.getAttribute("message"); %>
      <% if (msg != null) { %>
        <p class="form-message <%= request.getAttribute("msgType") != null && request.getAttribute("msgType").equals("error") ? "error" : "success" %>">
          <i class="fa-solid <%= request.getAttribute("msgType") != null && request.getAttribute("msgType").equals("error") ? "fa-circle-exclamation" : "fa-circle-check" %>"></i>
          &nbsp;<%= msg %>
        </p>
      <% } %>

      <form action="<%=request.getContextPath()%>/ContactUsServlet" method="post">
        <div class="form-row">
          <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Your name" required
                   value="<%= request.getAttribute("formName") != null ? request.getAttribute("formName") : "" %>" />
          </div>
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required
                   value="<%= request.getAttribute("formEmail") != null ? request.getAttribute("formEmail") : "" %>" />
          </div>
        </div>
        <div class="form-group">
          <label for="message">Your Message</label>
          <textarea id="message" name="message" rows="6" placeholder="Write your message here..." required></textarea>
        </div>
        <button type="submit" class="btn-send">
          Send Message &nbsp;<i class="fa-solid fa-paper-plane"></i>
        </button>
      </form>
    </div>

  </section>

  <!-- ── FOOTER (matches home/about) ── -->
  <footer class="footer">
    <div class="footer-inner">
      <div class="footer-brand">
        <div class="footer-logo">
          <div class="footer-logo-mark"><i class="fa-solid fa-dove"></i></div>
          <span class="footer-logo-text">SKOLA</span>
        </div>
        <p>The Academic Curator for institutions that value excellence, aesthetics, and efficiency in every digital touchpoint.</p>
      </div>

      <div class="footer-col">
        <p class="footer-col-title">Navigation</p>
        <div class="footer-links">
          <a href="<%=request.getContextPath()%>/HomeServlet">Home</a>
          <a href="<%=request.getContextPath()%>/AboutusServlet">About Us</a>
          <a href="<%=request.getContextPath()%>/ContactUsServlet">Contact Us</a>
        </div>
      </div>

      <div class="footer-col">
        <p class="footer-col-title">Contact</p>
        <div class="footer-contact">
          <p><i class="fa-solid fa-envelope"></i> &nbsp;skola@edu.np</p>
          <p><i class="fa-solid fa-phone"></i> &nbsp;977+ 9741877269</p>
          <p><i class="fa-solid fa-location-dot"></i> &nbsp;Suryabinayak, BKT</p>
        </div>
      </div>
    </div>

    <div class="footer-bottom">
      <span>&copy; 2024 SKOLA. All rights reserved.</span>
      <div class="footer-bottom-links">
        <a href="#">Privacy Policy</a>
        <a href="#">Terms of Service</a>
        <a href="#">Cookie Settings</a>
      </div>
    </div>
  </footer>

</body>
</html>
