<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Sparked — Club Detail | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
      <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page sk-admin">

    <div class="sk-app">

        <jsp:include page="_sidebar_student.jsp">
            <jsp:param name="activePage" value="clubs"/>
        </jsp:include>
  
        <main class="sk-main sk-sparked-main">

            <div class="sk-topbar">
                <h2>Welcome, Kusum</h2>
                <div class="sk-search">
                    <i class="material-icons">search</i>
                    <span>Search</span>
                </div>
            </div>

            <!-- Hero Banner -->
            <div class="sk-sparked-hero">
                <img src="<%= request.getContextPath() %>/images/sparkedmain.png" class="sk-sparked-hero-image" alt="Sparked Hero" />
                <div class="sk-sparked-hero-overlay">
                    <h1 class="sk-sparked-hero-title">Sparked</h1>
                    <a href="<%= request.getContextPath() %>/clubRegister.jsp" class="sk-sparked-register-btn">Register Now</a>
                </div>
            </div>

            <!-- What is Sparked + Why We Exist + image -->
            <section class="sk-sparked-about-section">
                <div class="sk-sparked-about-left">
                    <div class="sk-sparked-about-block">
                        <h2 class="sk-sparked-section-title">What is sparked</h2>
                        <p>Sparked is a community-driven public speaking and communication club dedicated to helping individuals find their voice, build confidence, and express ideas with clarity and conviction. Whether you're stepping up to a podium for the first time or refining years of experience, Sparked is your stage.</p>
                    </div>
                    <div class="sk-sparked-about-block">
                        <h2 class="sk-sparked-section-title">Why we exist?</h2>
                        <p>Our mission is to cultivate fearless communicators — people who can speak authentically, lead conversations, and inspire others. We provide a safe, supportive environment to practice, grow, and transform how the world hears you.</p>
                    </div>
                </div>
                <div class="sk-sparked-about-img">
                    <img src="<%= request.getContextPath() %>/images/sparked2nd.png" alt="Sparked speaker" />
                </div>
            </section>

            <!-- What We Do + What Sparked Teaches You -->
            <section class="sk-sparked-middle-section">

                <div class="sk-sparked-what-col">
                    <h2 class="sk-sparked-col-title">What we do</h2>
                    <div class="sk-sparked-what-grid">
                        <div class="sk-sparked-what-card">
                            <span class="sk-sparked-what-title">Weekly speeches</span>
                            <p class="sk-sparked-what-desc">Practice impromptu and prepared speeches in a supportive setting every week.</p>
                        </div>
                        <div class="sk-sparked-what-card">
                            <span class="sk-sparked-what-title">Debate sessions</span>
                            <p class="sk-sparked-what-desc">Sharpen your argumentation and critical thinking through structured debates.</p>
                        </div>
                        <div class="sk-sparked-what-card">
                            <span class="sk-sparked-what-title">Workshop series</span>
                            <p class="sk-sparked-what-desc">Hands-on workshops on storytelling, body language, voice modulation, and more.</p>
                        </div>
                        <div class="sk-sparked-what-card">
                            <span class="sk-sparked-what-title">Reading circles</span>
                            <p class="sk-sparked-what-desc">Participate in short film &amp; photography contests.</p>
                        </div>
                    </div>
                </div>

                <div class="sk-sparked-teaches-col">
                    <h2 class="sk-sparked-col-title">What sparked teaches you</h2>
                    <div class="sk-sparked-teaches-list">
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Confidence</span>
                            <p class="sk-sparked-teach-desc">Speak without fear in front of any crowd.</p>
                        </div>
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Body language</span>
                            <p class="sk-sparked-teach-desc">Use posture and gestures to amplify your words.</p>
                        </div>
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Voice control</span>
                            <p class="sk-sparked-teach-desc">Master pace, pitch, and pause for impact.</p>
                        </div>
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Critical thinking</span>
                            <p class="sk-sparked-teach-desc">Build arguments and respond on your feet.</p>
                        </div>
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Leadership</span>
                            <p class="sk-sparked-teach-desc">Inspire and guide others through your words.</p>
                        </div>
                        <div class="sk-sparked-teach-item">
                            <span class="sk-sparked-teach-label">Networking</span>
                            <p class="sk-sparked-teach-desc">Connect with students, alumni, and professionals.</p>
                        </div>
                    </div>
                </div>

            </section>

            <!-- Quote -->
            <section class="sk-sparked-quote-section">
                <p class="sk-sparked-quote">"To build a generation of fearless communicators who speak with confidence, lead with clarity, and inspire the world around them."</p>
            </section>

            <!-- Social + Silhouette -->
            <section class="sk-sparked-social-section">
                <div class="sk-sparked-social-text">
                    <p>Follow our journey, get event updates, and connect with our community across platforms.</p>
                    <p class="sk-sparked-social-link">Facebook — Sparked Club</p>
                    <p class="sk-sparked-social-link">Instagram — @sparked_club</p>
                </div>
                <div class="sk-sparked-social-img">
                    <img src="<%= request.getContextPath() %>/images/sparked3rd.png" alt="Sparked audience silhouette" />
                </div>
            </section>

        </main>
    </div>

    <%@ include file="_footer.jsp" %>

</body>
</html>