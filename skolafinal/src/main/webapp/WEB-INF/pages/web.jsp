<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Web Development — Club Detail | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page sk-admin">

    <div class="sk-app">

        <jsp:include page="_sidebar_student.jsp">
            <jsp:param name="activePage" value="clubs"/>
        </jsp:include>

        <main class="sk-main sk-club-main">

            <div class="sk-topbar">
                <h2>Welcome, Kusum</h2>
                <div class="sk-search">
                    <i class="ri-search-line"></i>
                    <span>Search</span>
                </div>
            </div>

            <!-- Hero Banner -->
            <div class="sk-club-hero">
                <img src="${pageContext.request.contextPath}/images/web main.png"
                     alt="Web development club"
                     class="sk-club-hero-img">
                <div class="sk-club-hero-overlay">
                    <h1 class="sk-club-hero-title">Web development</h1>
                    <a href="<%= request.getContextPath() %>/clubRegister.jsp"
                       class="sk-club-register-link">Register Now</a>
                </div>
            </div>

            <!-- About Section -->
            <section class="sk-club-about">
                <div class="sk-club-about-text">
                    <h2 class="sk-club-section-title">About the club</h2>
                    <p>
                        The Web Development Club is a student-driven community dedicated to
                        learning, building, and innovating in the field of web technologies. Our
                        club brings together beginners and experienced developers who share a
                        common interest in creating modern, responsive, and user-friendly
                        websites and web applications.
                    </p>
                    <p>
                        We aim to create a collaborative environment where members can
                        explore both front-end and back-end development, understand real-world
                        development practices, and work on meaningful projects. Whether someone
                        is just starting with HTML and CSS or already working with advanced
                        frameworks, the club provides opportunities for everyone to grow and improve.
                    </p>
                </div>
                <div class="sk-club-about-img">
                    <img src="${pageContext.request.contextPath}/images/web2nd.png"
                         alt="Web development club illustration">
                </div>
            </section>

            <!-- What We Do + Upcoming Events -->
            <div class="sk-club-bottom-row">

                <section class="sk-club-what">
                    <h2 class="sk-club-section-center-title">What we do</h2>
                    <div class="sk-club-what-grid">
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">Webb design</span>
                            <p class="sk-club-what-desc">Learn how to design modern, responsive websites using HTML, CSS, and UI/UX principles</p>
                        </div>
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">Front development</span>
                            <p class="sk-club-what-desc">Build interactive user interfaces using JavaScript and frameworks like React</p>
                        </div>
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">Backend Development</span>
                            <p class="sk-club-what-desc">Learn server-side coding, databases, and APIs</p>
                        </div>
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">Project and Hackathons</span>
                            <p class="sk-club-what-desc">Build real projects and join coding competitions</p>
                        </div>
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">Project and Hackathons</span>
                            <p class="sk-club-what-desc">Build real projects and join coding competitions</p>
                        </div>
                        <div class="sk-club-what-card">
                            <span class="sk-club-what-title">UI/UX workshops</span>
                            <p class="sk-club-what-desc">Design user-first interfaces using Figma and design principles</p>
                        </div>
                    </div>
                </section>

                <section class="sk-club-events">
                    <h2 class="sk-club-section-center-title">Upcoming events</h2>
                    <div class="sk-club-events-list">
                        <div class="sk-club-event-item">
                            <span class="sk-club-event-name">Weekly coding session</span>
                            <p class="sk-club-event-desc">Every Friday &nbsp;3–5 PM &nbsp;CSI Lab, Block B</p>
                        </div>
                        <div class="sk-club-event-item">
                            <span class="sk-club-event-name">Frontend hackathon</span>
                            <p class="sk-club-event-desc">24-hr build challenge · Register by May 17</p>
                        </div>
                        <div class="sk-club-event-item">
                            <span class="sk-club-event-name">Project showcase day</span>
                            <p class="sk-club-event-desc">Members demo their semester projects · Open to all</p>
                        </div>
                    </div>
                </section>

            </div>

        </main>
    </div>

    <%@ include file="_footer.jsp" %>

</body>
</html>