<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<aside class="sk-sidebar">

    <!-- LOGO -->
    <div class="nav-logo">
        <img src="${pageContext.request.contextPath}/images/logo.png"
             alt="SKOLA"
             class="logo-img" />

        <span class="logo-text">SKOLA</span>
    </div>

    <!-- NAVIGATION -->
    <nav class="sk-nav">

        <a href="${pageContext.request.contextPath}/student/dashboard"
           class="${param.activePage == 'dashboard' ? 'active' : ''}">
            <i class="ri-layout-grid-line"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/student/notes"
           class="${param.activePage == 'notes' ? 'active' : ''}">
            <i class="ri-sticky-note-line"></i>
            Notes
        </a>

        <a href="${pageContext.request.contextPath}/student/schedule"
           class="${param.activePage == 'schedule' ? 'active' : ''}">
            <i class="ri-calendar-line"></i>
            Schedule
        </a>

        <a href="${pageContext.request.contextPath}/student/settings"
           class="${param.activePage == 'settings' ? 'active' : ''}">
            <i class="ri-settings-3-line"></i>
            Settings
        </a>

    </nav>

</aside>