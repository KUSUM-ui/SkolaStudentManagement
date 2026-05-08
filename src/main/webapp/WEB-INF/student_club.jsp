<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clubs – Skola</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
</head>

<body class="sk-page sk-student">
<div class="sk-app">

    <jsp:include page="/WEB-INF/_sidebar_student.jsp">
        <jsp:param name="activePage" value="clubs"/>
    </jsp:include>

    <main class="sk-main">

        <!-- Topbar -->
        <div class="sk-topbar">
            <h2>Welcome, ${sessionScope.firstName}</h2>
            <div class="sk-search">
                <i class="ri-search-line"></i>
                <span>Search</span>
            </div>
        </div>

        <!-- Error message -->
        <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="sk-msg-error">${errorMsg}</div>
        <% } %>

        <!-- Heading -->
        <h2 class="sk-clubs-heading">Explore clubs</h2>

        <%
            List<Map<String, String>> clubs =
                (List<Map<String, String>>) request.getAttribute("clubs");
        %>

        <% if (clubs == null || clubs.isEmpty()) { %>
            <p class="sk-msg-empty">No clubs available yet. Check back soon!</p>
        <% } else { %>
            <div class="sk-clubs-grid">
                <% for (Map<String, String> club : clubs) { %>
                    <div class="sk-club-card">
                        <div class="sk-club-card-name"><%= club.get("name") %></div>

                        <% if (club.get("imageUrl") != null && !club.get("imageUrl").isEmpty()) { %>
                            <img class="sk-club-card-img"
                                 src="<%= club.get("imageUrl") %>"
                                 alt="<%= club.get("name") %>"/>
                        <% } else { %>
                            <div class="sk-club-card-img-placeholder">
                                <i class="ri-team-line"></i>
                            </div>
                        <% } %>

                        <p class="sk-club-card-desc"><%= club.get("description") %></p>
                    </div>
                <% } %>
            </div>
        <% } %>

        <!-- Register Now banner -->
        <div class="sk-register-banner">
            <div class="sk-register-banner-icon">
                <i class="ri-megaphone-line"></i>
            </div>
            <div class="sk-register-banner-text">
                <h2>Register Now</h2>
                <a href="${pageContext.request.contextPath}/student/club-register"
                   class="sk-btn">
                    Register
                </a>
            </div>
        </div>

    </main>
</div>

<jsp:include page="/WEB-INF/_footer.jsp"/>
</body>
</html>