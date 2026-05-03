<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Money Maze — Club Detail | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
        <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page sk-admin">

    <div class="sk-app">

        <jsp:include page="_sidebar_student.jsp">
            <jsp:param name="activePage" value="clubs"/>
        </jsp:include>

        <main class="sk-main sk-mm-main">

            <div class="sk-topbar">
                <h2>Welcome, Kusum</h2>
                <div class="sk-search">
                    <i class="material-icons">search</i>
                    <span>Search</span>
                </div>
            </div>

            <!-- Hero Banner -->
            <div class="sk-mm-hero">
                <img src="<%= request.getContextPath() %>/images/moneymazemain.png" class="sk-mm-hero-image" alt="MoneyMaze Hero" />
                <div class="sk-mm-hero-overlay">
                    <h1 class="sk-mm-hero-title">Money Maze</h1>
                    <a href="<%= request.getContextPath() %>/clubRegister.jsp" class="sk-mm-register-btn">Register Now</a>
                </div>
            </div>

            <!-- About Section -->
            <section class="sk-mm-about-section">
                <div class="sk-mm-about-text">
                    <h2 class="sk-mm-section-title">About the club</h2>
                    <p>
                        Money Maze is a student-run finance club dedicated to helping young
                        people take control of their financial lives. We were created out of a
                        simple but powerful belief — that financial literacy shouldn't be a
                        privilege; it should be a skill every student has access to.
                    </p>
                    <p>
                        From understanding your first paycheck to exploring the stock market,
                        from building an emergency fund to planning long-term wealth — we
                        cover it all in a friendly, judgment-free environment where every question
                        is welcome and every member grows together.
                    </p>
                </div>
                <div class="sk-mm-about-img">
                    <img src="<%= request.getContextPath() %>/images/moneymaze2nd.png" alt="Money Maze Club" />
                </div>
            </section>

            <!-- Quote -->
            <section class="sk-mm-quote-section">
                <p class="sk-mm-quote">
                    "Financial freedom starts with financial knowledge — and
                    that's exactly what we're here to build, one session at a time."
                </p>
            </section>

            <!-- What We Do + Who We Are For -->
            <section class="sk-mm-bottom-row">

                <div class="sk-mm-what-section">
                    <h2 class="sk-mm-center-title">What we do</h2>
                    <div class="sk-mm-what-grid">
                        <div class="sk-mm-what-card">
                            <span class="sk-mm-what-title">Budgeting</span>
                            <p class="sk-mm-what-desc">Track income, control spending, build savings habits</p>
                        </div>
                        <div class="sk-mm-what-card">
                            <span class="sk-mm-what-title">Investing</span>
                            <p class="sk-mm-what-desc">Stocks, mutual funds, SIPs, and compound growth</p>
                        </div>
                        <div class="sk-mm-what-card">
                            <span class="sk-mm-what-title">Finance Planning</span>
                            <p class="sk-mm-what-desc">Goals, emergency funds, and long-term wealth</p>
                        </div>
                        <div class="sk-mm-what-card">
                            <span class="sk-mm-what-title">Real-world skills</span>
                            <p class="sk-mm-what-desc">Taxes, credit, loans, and smart spending</p>
                        </div>
                    </div>
                </div>

                <div class="sk-mm-who-section">
                    <h2 class="sk-mm-center-title">Who we are for</h2>
                    <ul class="sk-mm-who-list">
                        <li>Students who have never managed money before and want to learn the basics</li>
                        <li>Those curious about investing, the stock market or building passive income</li>
                        <li>Anyone who wants to feel confident and in control of their financial future</li>
                    </ul>
                    <div class="sk-mm-who-deco">
                        <img src="<%= request.getContextPath() %>/images/moneymaze3rd.png" alt="" />
                    </div>
                </div>

            </section>

        </main>
    </div>

    <%@ include file="_footer.jsp" %>

</body>
</html>