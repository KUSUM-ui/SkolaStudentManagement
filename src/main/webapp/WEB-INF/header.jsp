<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- 
    header.jsp
    Reusable header fragment for SKOLA
    Include in any page: <%@ include file="header.jsp" %>
--%>
<%
    // Derive root path so links work regardless of how deep the page is
    String contextPath = request.getContextPath();
%>
<header class="site-header">

    <!-- Logo -->
    <a href="<%= contextPath %>/index.jsp" class="logo" aria-label="SKOLA Home">
        <!-- Swan SVG icon (inline so no external image needed) -->
        <svg width="38" height="38" viewBox="0 0 38 38" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <ellipse cx="19" cy="26" rx="12" ry="7" fill="#C0392B" opacity="0.15"/>
            <path d="M10 28 C10 20, 16 10, 24 8 C28 7, 30 10, 28 14 C26 18, 20 20, 18 26"
                  stroke="#C0392B" stroke-width="2.5" fill="none" stroke-linecap="round"/>
            <ellipse cx="26" cy="10" rx="3" ry="4" fill="#C0392B" transform="rotate(-20 26 10)"/>
            <circle cx="28" cy="8" r="1.2" fill="#111"/>
        </svg>
        <span class="logo-text">SKOLA</span>
    </a>

    <!-- Navigation -->
    <nav class="site-nav" id="siteNav" role="navigation" aria-label="Main navigation">
        <a href="<%= contextPath %>/index.jsp">Home</a>
        <a href="<%= contextPath %>/about.jsp">About Us</a>
        <a href="<%= contextPath %>/contact.jsp">Contact Us</a>
        <a href="<%= contextPath %>/login.jsp" class="btn-login">Login</a>
    </nav>

    <!-- Hamburger (mobile) -->
    <button class="hamburger" id="hamburgerBtn" aria-label="Toggle navigation" aria-expanded="false">
        <span></span>
        <span></span>
        <span></span>
    </button>

</header>

<script>
    (function () {
        var btn = document.getElementById('hamburgerBtn');
        var nav = document.getElementById('siteNav');
        if (btn && nav) {
            btn.addEventListener('click', function () {
                var open = nav.classList.toggle('open');
                btn.setAttribute('aria-expanded', open);
            });
        }
    })();
</script>
