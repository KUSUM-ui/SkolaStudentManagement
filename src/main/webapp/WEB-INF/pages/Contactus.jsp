<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
 <%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contactus.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>

 <jsp:include page="/WEB-INF/fragments/header.jsp">
        <jsp:param name="activePage" value="contact"/>
    </jsp:include>


  <section class="cu-banner">
    <img src="${pageContext.request.contextPath}/images/contactbg.png" alt="Contact Banner" />
    <div class="cu-banner-overlay">
      <p class="banner-eyebrow"><i class="fa-solid fa-envelope"></i> &nbsp; Reach Out</p>
      <h1>Contact Us</h1>
    </div>
  </section>

  <section class="cu-main">

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

    <div class="cu-form-card">
      <p class="form-card-eyebrow">Send a message</p>

      <form action="${pageContext.request.contextPath}/ContactServlet" method="post">
        <div class="form-row">
          <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" placeholder="Your name" required />
          </div>
          <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="you@example.com" required />
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

   <jsp:include page="/WEB-INF/fragments/footer.jsp"/>

</body>
</html>