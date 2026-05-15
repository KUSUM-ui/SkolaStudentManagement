<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%
    String activeAdmin = request.getParameter("activePage");
    if (activeAdmin == null) {
        activeAdmin = "";
    }
%>

<aside class="sk-sidebar">

    <!-- LOGO -->
    <div class="nav-logo">
        <img src="<%=request.getContextPath()%>/images/logo.png" 
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    </div>

    <!-- NAVIGATION -->
    <nav class="sk-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="<%= "dashboard".equals(activeAdmin) ? "active" : "" %>">
            <i class="ri-layout-grid-line"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/admin/students"
           class="<%= "students".equals(activeAdmin) ? "active" : "" %>">
            <i class="ri-group-line"></i> Students
        </a>


        <a href="${pageContext.request.contextPath}/admin/reports"
           class="<%= "reports".equals(activeAdmin) ? "active" : "" %>">
            <i class="ri-bar-chart-line"></i> Reports
        </a>

        <a href="${pageContext.request.contextPath}/admin/announcements"
           class="<%= "announcements".equals(activeAdmin) ? "active" : "" %>">
            <i class="ri-megaphone-line"></i> Announcements
        </a>

        <a href="${pageContext.request.contextPath}/admin/settings"
           class="<%= "settings".equals(activeAdmin) ? "active" : "" %>">
            <i class="ri-settings-3-line"></i> Settings
        </a>
    </nav>

</aside>