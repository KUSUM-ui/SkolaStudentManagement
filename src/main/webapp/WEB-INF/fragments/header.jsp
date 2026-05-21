<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="home-nav">

    <!-- BRAND -->
    <a href="${pageContext.request.contextPath}/home"
       class="home-nav-brand__">

        <img
            src="${pageContext.request.contextPath}/images/logo.png"
            alt="Skola"
            class="home-nav-logo"
        />

        <span>SKOLA</span>

    </a>

    <!-- NAVIGATION LINKS -->
    <ul class="home-nav-links">

        <li>
            <a href="${pageContext.request.contextPath}/home"
               class="${param.activePage eq 'home' ? 'active' : ''}">

                Home

            </a>
        </li>

        <li>

    <a href="${pageContext.request.contextPath}/about" class="${param.activePage eq 'about' ? 'active' : ''}">About</a>
        </li>

        <li>
    <a href="${pageContext.request.contextPath}/contact" class="${param.activePage eq 'contact' ? 'active' : ''}" >Contact</a>
        </li>

    </ul>

    <!-- ACTION BUTTONS -->
    <div class="home-nav-actions">

        <a href="${pageContext.request.contextPath}/home/registerstudent"
           class="home-nav-btn-outline">

            Register

        </a>

        <a href="${pageContext.request.contextPath}/login"
           class="home-nav-btn">

            Login

        </a>

    </div>

</nav>
