<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SKOLA — Academic Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"> 
     <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css" />
</head>
<body>

    <!-- ── NAVIGATION ── -->
    <nav>
        <a href="HomeServlet" class="nav-brand">
          <div class="nav-logo">
      <img src="<%=request.getContextPath()%>/resources/images/logo.png" alt="SKOLA" class="logo-img" />
      
    </div>
            <span class="nav-wordmark">Skola</span>
        </a>

        <ul class="nav-links">
            <li><a href="HomeServlet" class="active">Home</a></li>
            <li><a href="AboutusServlet">About Us</a></li>
            <li><a href="ContactUsServlet">Contact Us</a></li>
        </ul>

        <div class="nav-right">
            <a href="login.jsp" class="btn-nav-login">Login</a>
        </div>
    </nav>

    <!-- ── HERO ── -->
    <section class="hero">
        <div class="hero-left">

            <div class="hero-eyebrow animate-in delay-1">
                <div class="hero-eyebrow-line"></div>
                <span class="hero-eyebrow-text">Academic Management</span>
            </div>

            <h1 class="hero-title animate-in delay-2">
                SKOLA<br>
                <span class="hero-title-italic">Learning.</span>
            </h1>

            <p class="hero-subtitle animate-in delay-3">
                Where institutions meet intelligence.
            </p>

            <p class="hero-description animate-in delay-4">
                SKOLA is a professional digital ecosystem designed for curated student management.
                Streamline your institution's workflows with precision and elegance.
            </p>

            <div class="hero-cta-group animate-in delay-5">
                <a href="admin-login.jsp" class="btn-primary">
                    Admin Portal &nbsp;<i class="fa-solid fa-arrow-right"></i>
                </a>
                <a href="student-login.jsp" class="btn-secondary">
                    Student Portal
                </a>
            </div>
        </div>

        <div class="hero-right">
            <img
                src="/resources/images/brit.png"
                alt="SKOLA Campus"
                class="hero-image-fill"
                onerror="this.style.display='none'"
            >
            <div class="hero-image-overlay"></div>
            <span class="hero-year-tag">Est. 2024 &nbsp;&middot;&nbsp; Digital Excellence</span>
            <div class="hero-badge">
                <p class="hero-badge-label">&#10022; Academic Excellence</p>
                <p class="hero-badge-title">Built for Modern Institutions</p>
                <p class="hero-badge-sub">Smart. Efficient. Elegant.</p>
            </div>
        </div>
    </section>

    <!-- ── MARQUEE BAND ── -->
    <div class="marquee-band">
        <div class="marquee-track">
            <div class="marquee-item"><span>Student Records</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Grade Management</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Attendance Tracking</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Faculty Dashboard</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Reports &amp; Analytics</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Course Scheduling</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Examinations</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Parent Portal</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Student Records</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Grade Management</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Attendance Tracking</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Faculty Dashboard</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Reports &amp; Analytics</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Course Scheduling</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Examinations</span><div class="marquee-dot"></div></div>
            <div class="marquee-item"><span>Parent Portal</span><div class="marquee-dot"></div></div>
        </div>
    </div>

    <!-- ── STATS BAND ── -->
    <section class="stats-band">
        <div class="stats-inner">
            <div class="stat-item">
                <div class="stat-number">10<span>K+</span></div>
                <div class="stat-label">Students Managed</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">500<span>+</span></div>
                <div class="stat-label">Faculty Members</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">99<span>%</span></div>
                <div class="stat-label">Uptime Guaranteed</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">24<span>/7</span></div>
                <div class="stat-label">System Availability</div>
            </div>
        </div>
    </section>

    <!-- ── FEATURES ── -->
    <section class="features" id="features">
        <div class="section-header">
            <div class="section-number">01</div>
            <div class="section-title-block">
                <p class="section-eyebrow">What we offer</p>
                <h2 class="section-title">Everything your institution <em>needs.</em></h2>
            </div>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-num">01</div>
                <div class="feature-icon"><i class="fa-solid fa-users"></i></div>
                <h3 class="feature-title">Student Management</h3>
                <p class="feature-desc">Complete student lifecycle management — from enrollment to graduation. Maintain rich profiles, track progress, and generate reports in seconds.</p>
            </div>

            <div class="feature-card">
                <div class="feature-num">02</div>
                <div class="feature-icon"><i class="fa-solid fa-file-lines"></i></div>
                <h3 class="feature-title">Grade &amp; Results</h3>
                <p class="feature-desc">Effortlessly manage grades, examinations, and academic records. Publish results instantly and generate transcripts with a single click.</p>
            </div>

            <div class="feature-card">
                <div class="feature-num">03</div>
                <div class="feature-icon"><i class="fa-solid fa-calendar-check"></i></div>
                <h3 class="feature-title">Attendance System</h3>
                <p class="feature-desc">Real-time attendance tracking with automated notifications. Visual dashboards give instant insight into patterns and irregularities.</p>
            </div>

            <div class="feature-card">
                <div class="feature-num">04</div>
                <div class="feature-icon"><i class="fa-solid fa-chart-line"></i></div>
                <h3 class="feature-title">Analytics &amp; Reports</h3>
                <p class="feature-desc">Institutional intelligence at your fingertips. Rich analytics help leadership make data-driven decisions with confidence.</p>
            </div>

            <div class="feature-card">
                <div class="feature-num">05</div>
                <div class="feature-icon"><i class="fa-solid fa-bullhorn"></i></div>
                <h3 class="feature-title">Communication Hub</h3>
                <p class="feature-desc">Keep all stakeholders connected — announcements, notices, and direct messaging between faculty, students, and parents.</p>
            </div>

            <div class="feature-card">
                <div class="feature-num">06</div>
                <div class="feature-icon"><i class="fa-solid fa-layer-group"></i></div>
                <h3 class="feature-title">Multi-Portal Access</h3>
                <p class="feature-desc">Tailored interfaces for administrators, faculty, and students. Each role sees exactly what they need — nothing more, nothing less.</p>
            </div>
        </div>
    </section>

    <!-- ── PORTAL ENTRY ── -->
    <section class="portals">
        <div class="portals-inner">
            <p class="portals-label">Access Portals</p>
            <h2 class="portals-heading">Where do you <em>belong?</em></h2>

            <div class="portals-grid">

                <a href="admin-login.jsp" class="portal-card admin">
                    <div class="portal-shape"></div>
                    <p class="portal-card-tag">Administrator Access</p>
                    <h3 class="portal-card-title">Admin<br>Dashboard</h3>
                    <p class="portal-card-desc">Full institutional control. Manage students, faculty, courses, and generate comprehensive reports from a unified command center.</p>
                    <div class="portal-card-arrow">
                        Enter Admin Portal &nbsp;<i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

                <a href="student-login.jsp" class="portal-card student">
                    <div class="portal-shape"></div>
                    <p class="portal-card-tag">Student Access</p>
                    <h3 class="portal-card-title">Student<br>Portal</h3>
                    <p class="portal-card-desc">Your academic journey, visualized. View grades, attendance records, course schedules, and important notices all in one place.</p>
                    <div class="portal-card-arrow">
                        Enter Student Portal &nbsp;<i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>

            </div>
        </div>
    </section>

    <!-- ── FOOTER (matches aboutus.jsp) ── -->
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
                <a href="HomeServlet">Home</a>
                <a href="AboutusServlet">About Us</a>
                <a href="ContactUsServlet">Contact Us</a>
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

    <script>
        document.querySelectorAll('a[href^="#"]').forEach(a => {
            a.addEventListener('click', e => {
                e.preventDefault();
                document.querySelector(a.getAttribute('href'))?.scrollIntoView({ behavior: 'smooth' });
            });
        });
    </script>

</body>
</html>
