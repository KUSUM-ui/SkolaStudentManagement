<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Inkspire &mdash; Club Detail | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page sk-admin">

    <div class="sk-app">

       <jsp:include page="_sidebar_student.jsp">
            <jsp:param name="activePage" value="clubs"/>
        </jsp:include>

        <main class="sk-main sk-cd-main">

            <!-- Topbar -->
            <div class="sk-topbar">
                <h2>Welcome, Kusum</h2>
                <div class="sk-search">
                    <i class="material-icons">search</i>
                    <span>Search</span>
                </div>
            </div>

            <!-- Hero Banner -->
            <div class="sk-cd-hero">
                <img src="<%= request.getContextPath() %>/images/inkspiremain.png" class="hero-image" alt="Inkspire Hero" />
                <div class="sk-cd-hero-overlay">
                    <h1 class="sk-cd-hero-title">Inkspire</h1>
                    <a href="<%= request.getContextPath() %>/clubRegister.jsp" class="sk-cd-register-btn">Register Now</a>
                </div>
            </div>

            <!-- About Section -->
            <section class="sk-cd-about-section">
                <div class="sk-cd-about-text">
                    <h2 class="sk-cd-section-title">About the club</h2>
                    <p>
                        Inkspire is a student-run creative club dedicated to the art of visual
                        storytelling. We bring together curious minds who love to explore the
                        world through a camera lens &mdash; from shooting their first short film to
                        mastering the craft of video editing.
                    </p>
                    <p>
                        Founded by students, for students, Inkspire was born out of a shared
                        passion for cinema and creativity. We believe that everyone has a story
                        worth telling &mdash; and we&rsquo;re here to help you tell it with confidence, skill,
                        and style.
                    </p>
                    <p>
                        Whether you&rsquo;re picking up a camera for the very first time or already have
                        experience in production, our club is a welcoming space where beginners
                        and enthusiasts learn side by side. No prior experience is needed &mdash; just
                        curiosity and a love for storytelling.
                    </p>
                </div>
                <div class="sk-cd-about-img">
                    <img src="<%= request.getContextPath() %>/images/inkspire2nd.png" alt="Inkspire Club" />
                </div>
            </section>

            <!-- What We Do + Club Details side by side -->
            <div class="sk-cd-bottom-row">

                <section class="sk-cd-what-section">
                    <h2 class="sk-cd-section-center-title">What we do</h2>
                    <div class="sk-cd-what-grid">
                        <div class="sk-cd-what-card">
                            <span class="sk-cd-what-title">Videography</span>
                            <p class="sk-cd-what-desc">Hands-on shooting sessions and camera techniques</p>
                        </div>
                        <div class="sk-cd-what-card">
                            <span class="sk-cd-what-title">Editing</span>
                            <p class="sk-cd-what-desc">Learn industry tools like Premiere Pro &amp; DaVinci Resolve</p>
                        </div>
                        <div class="sk-cd-what-card">
                            <span class="sk-cd-what-title">Story telling</span>
                            <p class="sk-cd-what-desc">Scriptwriting, storyboarding &amp; narrative structure</p>
                        </div>
                        <div class="sk-cd-what-card">
                            <span class="sk-cd-what-title">Competitions</span>
                            <p class="sk-cd-what-desc">Participate in short film &amp; photography contests</p>
                        </div>
                    </div>
                </section>

                <section class="sk-cd-details-section">
                    <h2 class="sk-cd-section-center-title">Club details</h2>
                    <div class="sk-cd-details-table">
                        <div class="sk-cd-details-row">
                            <span class="sk-cd-details-label">Meets</span>
                            <span class="sk-cd-details-value">Every Saturday 10 AM</span>
                        </div>
                        <div class="sk-cd-details-row">
                            <span class="sk-cd-details-label">Open to</span>
                            <span class="sk-cd-details-value">All skill levels</span>
                        </div>
                        <div class="sk-cd-details-row">
                            <span class="sk-cd-details-label">Equipment</span>
                            <span class="sk-cd-details-value">Provided by the club</span>
                        </div>
                        <div class="sk-cd-details-row">
                            <span class="sk-cd-details-label">Membership</span>
                            <span class="sk-cd-details-value">Free to join</span>
                        </div>
                    </div>
                </section>

            </div>

            <!-- Quote -->
            <section class="sk-cd-quote-section">
                <p class="sk-cd-quote">
                    &ldquo;To empower every student to see the world through a
                    creative lens and share their unique story with the world.&rdquo;
                </p>
            </section>

        </main>
    </div>

    <%@ include file="_footer.jsp" %>

</body>
</html>