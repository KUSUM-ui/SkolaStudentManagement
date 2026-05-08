<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Skola - Student Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css" />
</head>

<%
  String studentName = "Kusum";
  String department  = "COMPUTING";
  String classCode   = "C4";
  String semester    = "Semester 4";
  String fullName    = "Kusum Kiju";
%>

<body class="sk-page sk-student">
<div class="sk-app">

  <!-- ── SIDEBAR ── -->
  <aside class="sk-sidebar">
    <a href="#" class="sk-logo">
      <i class="ri-graduation-cap-fill" style="font-size:28px; color:#9b2335;"></i>
      <span>SKOLA</span>
    </a>
    <nav class="sk-nav">
      <a href="#" class="active"><i class="ri-layout-grid-line"></i> Dashboard</a>
      <a href="#"><i class="ri-user-line"></i> Teachers</a>
      <a href="#"><i class="ri-sticky-note-line"></i> Notes</a>
      <a href="#"><i class="ri-team-line"></i> Clubs</a>
      <a href="#"><i class="ri-calendar-line"></i> Schedule</a>
      <a href="#"><i class="ri-settings-3-line"></i> Settings</a>
    </nav>
  </aside>

  <!-- ── MAIN ── -->
  <main class="sk-main">

    <!-- Topbar -->
    <div class="sk-topbar">
      <h2>Welcome, <%= studentName %></h2>
      <div class="sk-search">
        <i class="ri-search-line"></i>
        <span>Search</span>
      </div>
    </div>

    <!-- Schedule + Profile -->
    <div class="sk-row">
      <div class="sk-card sk-card-schedule">
        <div class="sk-card-title">Today's schedule</div>
        <div class="sk-view-all">View all</div>
      </div>
      <div class="sk-card sk-card-profile">
        <i class="ri-graduation-cap-line"></i>
        <span class="sk-profile-sub"><%= department %></span>
        <span class="sk-profile-class"><%= classCode %></span>
        <span class="sk-profile-sem"><%= semester %></span>
        <span class="sk-profile-name"><%= fullName %></span>
      </div>
    </div>

    <!-- Announcement -->
    <div class="sk-card-announce">
      <h3>Announcement</h3>
    </div>

    <!-- Club Registration + My Clubs -->
    <div class="sk-row">
      <div class="sk-card sk-card-clubs">
        <h3>Club Registration</h3>
        <div class="sk-club-icon"><i class="ri-file-list-3-line"></i></div>
        <div class="sk-club-btn-row">
          <a href="#" class="sk-btn-outline" style="font-size:12px; padding:5px 12px;">View all clubs</a>
          <a href="#" class="sk-btn">Register Now</a>
        </div>
      </div>
      <div class="sk-card sk-card-clubs">
        <h3>My clubs</h3>
      </div>
    </div>

    <!-- My Notes -->
    <div class="sk-notes-section">
      <h3>My Notes</h3>
      <div class="sk-notes-row">
        <div class="sk-notes-area">
          <span class="sk-view-all">View all</span>
        </div>
        <div class="sk-new-note">
          <div class="sk-pins">📌</div>
          <p>Create<br/>new note</p>
          <a href="#" class="sk-btn">Create</a>
        </div>
      </div>
    </div>

  </main>
</div>

<!-- ── FOOTER ── -->
<footer class="sk-footer">
  <div class="sk-footer-top">
    <div class="sk-footer-brand">
      <div class="sk-footer-logo">SKOLA</div>
      <p>The Academic Curator for institutions<br/>
         that value excellence, aesthetics, and<br/>
         efficiency in every digital touchpoint.</p>
    </div>
    <div class="sk-footer-col">
      <a href="#">Home</a>
      <a href="#">About Us</a>
      <a href="#">Contact Us</a>
    </div>
    <div class="sk-footer-col sk-footer-contact">
      <h4>Contact</h4>
      <p><i class="ri-mail-line"></i> skola@edu.np</p>
      <p><i class="ri-phone-line"></i> 977+ 9741877269</p>
      <p><i class="ri-map-pin-line"></i> Suryabinayak, BKT</p>
    </div>
  </div>
  <div class="sk-footer-bottom">
    <span>© 2024 Relume. All rights reserved.</span>
    <div>
      <a href="#">Privacy Policy</a>
      <a href="#">Terms of Service</a>
      <a href="#">Cookies Settings</a>
    </div>
  </div>
</footer>

</body>
</html>
