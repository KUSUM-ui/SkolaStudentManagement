<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="home-nav">
    <a href="${pageContext.request.contextPath}/HomeServlet" class="home-nav-brand">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png"
             alt="Skola" class="home-nav-logo"
             onerror="this.style.display='none'"/>
        <span>SKOLA</span>
    </a>

    <ul class="home-nav-links">
        <li><a href="${pageContext.request.contextPath}/HomeServlet"
               class="${param.activePage == 'home' ? 'active' : ''}">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/AboutusServlet"
               class="${param.activePage == 'about' ? 'active' : ''}">About Us</a></li>
        <li><a href="${pageContext.request.contextPath}/ContactUsServlet"
               class="${param.activePage == 'contact' ? 'active' : ''}">Contact Us</a></li>
    </ul>

    <div class="home-nav-actions">
        <a href="${pageContext.request.contextPath}/register" class="home-nav-btn-outline">Register</a>
        <a href="${pageContext.request.contextPath}/login"    class="home-nav-btn">Login</a>
    </div>
</nav>
