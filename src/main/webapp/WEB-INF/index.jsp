<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA — Academic Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"/>
</head>
<body>

<jsp:include page="/WEB-INF/header.jsp">
    <jsp:param name="activePage" value="home"/>
</jsp:include>

    <!-- HERO -->
    <section class="home-hero">
        <div class="home-hero-inner">
            <p class="home-eyebrow">Academic Management System</p>
            <h1 class="home-title">Welcome to <span>SKOLA</span></h1>
            <p class="home-subtitle">
                A professional digital ecosystem designed for curated student management.
                Streamline your institution's workflows with precision and elegance.
            </p>
            <div class="home-hero-btns">
                <a href="<%=request.getContextPath()%>/login" class="home-btn-primary">
                    <i class="ri-shield-user-line"></i> Admin Portal
                </a>
                <a href="<%=request.getContextPath()%>/login" class="home-btn-secondary">
                    <i class="ri-user-line"></i> Student Portal
                </a>
            </div>
        </div>
        <div class="home-hero-image">
            <img src="<%=request.getContextPath()%>/resources/images/brit.png"
                 alt="Campus"
                 onerror="this.style.display='none'"/>
        </div>
    </section>

    <!-- STATS -->
    <section class="home-stats">
        <div class="home-stat">
            <span class="home-stat-num">10K<span>+</span></span>
            <span class="home-stat-label">Students Managed</span>
        </div>
        <div class="home-stat">
            <span class="home-stat-num">500<span>+</span></span>
            <span class="home-stat-label">Faculty Members</span>
        </div>
        <div class="home-stat">
            <span class="home-stat-num">99<span>%</span></span>
            <span class="home-stat-label">Uptime Guaranteed</span>
        </div>
        <div class="home-stat">
            <span class="home-stat-num">24<span>/7</span></span>
            <span class="home-stat-label">System Availability</span>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="home-features">
        <div class="home-section-header">
            <p class="home-eyebrow">What we offer</p>
            <h2>Everything your institution needs</h2>
        </div>
        <div class="home-features-grid">
    <div class="home-feature-card">
        <div class="home-feature-icon"><i class="ri-group-line"></i></div>
        <h3>Student Management</h3>
        <p>Complete student lifecycle management — from enrollment to graduation. Maintain rich profiles and track progress.</p>
    </div>
    <div class="home-feature-card">
        <div class="home-feature-icon"><i class="ri-bar-chart-line"></i></div>
        <h3>Reports</h3>
        <p>Comprehensive academic reports giving institutions clear insight into student performance and progress.</p>
    </div>
    <div class="home-feature-card">
        <div class="home-feature-icon"><i class="ri-calendar-line"></i></div>
        <h3>Class Booking</h3>
        <p>Students can easily reserve classroom slots and manage bookings with admin approval workflows.</p>
    </div>
    <div class="home-feature-card">
        <div class="home-feature-icon"><i class="ri-sticky-note-line"></i></div>
        <h3>Notes</h3>
        <p>Create, organize, and access personal academic notes anytime — all stored in one convenient place.</p>
    </div>
    <div class="home-feature-card">
        <div class="home-feature-icon"><i class="ri-calendar-schedule-line"></i></div>
        <h3>Manage Schedule</h3>
        <p>View your section's full weekly schedule with module timings, organized clearly by day and time.</p>
    </div>
</div>
        </div>
    </section>

    <!-- PORTALS -->
    <section class="home-portals">
        <div class="home-section-header">
            <p class="home-eyebrow" style="color:rgba(255,255,255,0.6);">Access Portals</p>
            <h2 style="color:#fff;">Where do you belong?</h2>
        </div>
        <div class="home-portals-grid">
            <a href="<%=request.getContextPath()%>/login" class="home-portal-card">
                <div class="home-portal-icon"><i class="ri-shield-user-line"></i></div>
                <p class="home-portal-tag">Administrator Access</p>
                <h3>Admin Dashboard</h3>
                <p class="home-portal-desc">Full institutional control. Manage students, faculty, courses, and generate comprehensive reports.</p>
                <span class="home-portal-link">Enter Admin Portal <i class="ri-arrow-right-line"></i></span>
            </a>
            <a href="<%=request.getContextPath()%>/login" class="home-portal-card">
                <div class="home-portal-icon"><i class="ri-user-line"></i></div>
                <p class="home-portal-tag">Student Access</p>
                <h3>Student Dashboard</h3>
                <p class="home-portal-desc">Your academic journey, visualized. View Schedules, create notes, book classes and be updated with announcements.</p>
                <span class="home-portal-link">Enter Student Portal <i class="ri-arrow-right-line"></i></span>
            </a>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="home-footer">
        <div class="home-footer-top">
            <div class="home-footer-brand">
                <span class="home-footer-logo">SKOLA</span>
                <p>The Academic Curator for institutions that value excellence, aesthetics, and efficiency in every digital touchpoint.</p>
            </div>
            <div class="home-footer-links">
                <a href="HomeServlet">Home</a>
                <a href="AboutusServlet">About Us</a>
                <a href="ContactUsServlet">Contact Us</a>
            </div>
            <div class="home-footer-contact">
                <p class="home-footer-contact-title">Contact</p>
                <p><i class="ri-mail-line"></i> skola@edu.np</p>
                <p><i class="ri-phone-line"></i> 977+ 9741877269</p>
                <p><i class="ri-map-pin-line"></i> Suryabinayak, BKT</p>
            </div>
        </div>
        <div class="home-footer-bottom">
            <span>&copy; 2024 SKOLA. All rights reserved.</span>
            <div>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Cookies Settings</a>
            </div>
        </div>
    </footer>

</body>
</html>
