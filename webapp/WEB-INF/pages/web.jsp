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

        <main class="sk-main sk-webdev-main">

            <div class="sk-topbar">
                <h2>Welcome, Kusum</h2>
                <div class="sk-search">
                    <i class="ri-search-line"></i>
                    <span>Search</span>
                </div>
            </div>

            <!-- Hero Banner -->
            <div class="sk-webdev-hero">
                <img src="${pageContext.request.contextPath}/images/web main.png"
                     alt="Web development club"
                     class="sk-webdev-hero-img">
                <div class="sk-webdev-hero-overlay">
                    <h1 class="sk-webdev-hero-title">Web development</h1>
                    <a href="${pageContext.request.contextPath}/clubRegister.jsp"
                       class="sk-webdev-register-btn">Register Now</a>
                </div>
            </div>

            <!-- About Section -->
            <div class="sk-webdev-about-card">
                <section class="sk-webdev-about">
                    <div class="sk-webdev-about-text">
                        <h2 class="sk-webdev-section-title">About the club</h2>
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
                            development practices, and work on meaningful projects.
                        </p>
                    </div>
                    <div class="sk-webdev-about-img">
                        <img src="${pageContext.request.contextPath}/images/web2nd.png"
                             alt="Web development club illustration">
                    </div>
                </section>
            </div>

            <!-- What We Do + Upcoming Events -->
            <div class="sk-webdev-bottom-row">

                <section class="sk-webdev-what">
                    <h2 class="sk-webdev-center-title">What we do</h2>
                    <div class="sk-webdev-what-grid">
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">Web design</span>
                            <p class="sk-webdev-what-desc">Learn how to design modern, responsive websites using HTML, CSS, and UI/UX principles</p>
                        </div>
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">Front-end development</span>
                            <p class="sk-webdev-what-desc">Build interactive user interfaces using JavaScript and frameworks like React</p>
                        </div>
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">Backend Development</span>
                            <p class="sk-webdev-what-desc">Learn server-side coding, databases, and APIs</p>
                        </div>
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">Project and Hackathons</span>
                            <p class="sk-webdev-what-desc">Build real projects and join coding competitions</p>
                        </div>
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">Open source</span>
                            <p class="sk-webdev-what-desc">Contribute to real-world open source repositories and build your portfolio</p>
                        </div>
                        <div class="sk-webdev-what-card">
                            <span class="sk-webdev-what-title">UI/UX workshops</span>
                            <p class="sk-webdev-what-desc">Design user-first interfaces using Figma and design principles</p>
                        </div>
                    </div>
                </section>

                <section class="sk-webdev-events">
                    <h2 class="sk-webdev-center-title">Upcoming events</h2>
                    <div class="sk-webdev-events-box">
                        <div class="sk-webdev-event-item">
                            <span class="sk-webdev-event-name">Weekly coding session</span>
                            <p class="sk-webdev-event-desc">Every Friday &nbsp;3–5 PM &nbsp;·&nbsp; CS Lab, Block B</p>
                        </div>
                        <div class="sk-webdev-event-item">
                            <span class="sk-webdev-event-name">Frontend hackathon</span>
                            <p class="sk-webdev-event-desc">24-hr build challenge &nbsp;·&nbsp; Register by May 17</p>
                        </div>
                        <div class="sk-webdev-event-item">
                            <span class="sk-webdev-event-name">Project showcase day</span>
                            <p class="sk-webdev-event-desc">Members demo their semester projects &nbsp;·&nbsp; Open to all</p>
                        </div>
                    </div>
                </section>

            </div>

        </main>
    </div>

    <%@ include file="_footer.jsp" %>

</body>
</html>