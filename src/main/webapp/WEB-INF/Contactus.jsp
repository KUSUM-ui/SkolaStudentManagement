<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA – Contact Us</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/home.css"/>
</head>
<body>

  <jsp:include page="/WEB-INF/header.jsp">
    <jsp:param name="activePage" value="contact"/>
  </jsp:include>

  <!-- CONTACT MAIN -->
  <section class="pub-contact">

    <!-- LEFT INFO -->
    <div class="pub-contact-info">
      <p class="home-eyebrow">Get in touch</p>
      <h2>Let's start a <span>conversation.</span></h2>

      <div class="pub-contact-items">
        <div class="pub-contact-item">
          <div class="pub-contact-icon"><i class="ri-map-pin-line"></i></div>
          <div>
            <p class="pub-contact-label">Address</p>
            <p class="pub-contact-value">Suryabinayak, Bhaktapur</p>
          </div>
        </div>
        <div class="pub-contact-item">
          <div class="pub-contact-icon"><i class="ri-phone-line"></i></div>
          <div>
            <p class="pub-contact-label">Phone number</p>
            <p class="pub-contact-value">977+ 9741877269</p>
          </div>
        </div>
        <div class="pub-contact-item">
          <div class="pub-contact-icon"><i class="ri-mail-line"></i></div>
          <div>
            <p class="pub-contact-label">Email</p>
            <p class="pub-contact-value">skola@email.np</p>
          </div>
        </div>
      </div>

      <div class="pub-social">
        <p class="pub-social-title">Follow us</p>
        <div class="pub-social-icons">
          <a href="#" class="pub-social-btn" aria-label="Twitter"><i class="ri-twitter-x-line"></i></a>
          <a href="#" class="pub-social-btn" aria-label="Facebook"><i class="ri-facebook-line"></i></a>
          <a href="#" class="pub-social-btn" aria-label="Instagram"><i class="ri-instagram-line"></i></a>
        </div>
      </div>
    </div>

    <!-- RIGHT FORM -->
    <div class="pub-contact-form-card">
      <p class="home-eyebrow">Send a message</p>
      <h3>We'd love to hear from you</h3>

      <% String msg = (String) request.getAttribute("message"); %>
      <% if (msg != null) { %>
        <div class="pub-form-msg <%= "error".equals(request.getAttribute("msgType")) ? "pub-form-error" : "pub-form-success" %>">
          <i class="<%= "error".equals(request.getAttribute("msgType")) ? "ri-error-warning-line" : "ri-checkbox-circle-line" %>"></i>
          <%= msg %>
        </div>
      <% } %>

      <form action="<%=request.getContextPath()%>/ContactUsServlet" method="post" class="pub-form">
        <div class="pub-form-row">
          <div class="pub-form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Your name" required
                   value="<%= request.getAttribute("formName") != null ? request.getAttribute("formName") : "" %>"/>
          </div>
          <div class="pub-form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required
                   value="<%= request.getAttribute("formEmail") != null ? request.getAttribute("formEmail") : "" %>"/>
          </div>
        </div>
        <div class="pub-form-group">
          <label for="message">Your Message</label>
          <textarea id="message" name="message" rows="6" placeholder="Write your message here..." required></textarea>
        </div>
        <button type="submit" class="home-btn-primary">
          Send Message <i class="ri-send-plane-line"></i>
        </button>
      </form>
    </div>

  </section>

  <!-- FOOTER -->
  <jsp:include page="/WEB-INF/footer.jsp"/>

</body>
</html>
