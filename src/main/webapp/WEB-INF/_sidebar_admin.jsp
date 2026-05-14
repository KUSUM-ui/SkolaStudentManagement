<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>


<aside class="sk-sidebar">

    <!-- LOGO -->
    <div class="nav-logo">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png"
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    </div>

    <!-- NAVIGATION -->
    <nav class="sk-nav">

        <a href="${pageContext.request.contextPath}/AdminDashboardServlet"
           class="${param.activePage == 'dashboard' ? 'active' : ''}">
            <i class="ri-layout-grid-line"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/students"
           class="${param.activePage == 'students' ? 'active' : ''}">
            <i class="ri-group-line"></i> Students
        </a>

        <a href="${pageContext.request.contextPath}/AdminClassServlet"
           class="${param.activePage == 'class' ? 'active' : ''}">
            <i class="ri-book-open-line"></i> Class
        </a>

        <a href="${pageContext.request.contextPath}/admin/reports"
           class="${param.activePage == 'reports' ? 'active' : ''}">
            <i class="ri-bar-chart-line"></i> Reports
        </a>

        <a href="${pageContext.request.contextPath}/AnnouncementServlet"
           class="${param.activePage == 'announcements' ? 'active' : ''}">
            <i class="ri-megaphone-line"></i> Announcements
        </a>

        <a href="${pageContext.request.contextPath}/SettingsAdminServlet"
           class="${param.activePage == 'settings' ? 'active' : ''}">
            <i class="ri-settings-3-line"></i> Settings
        </a>

    </nav>

</aside>
