<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<aside class="sk-sidebar">

 <!-- LOGO -->
    <div class="sk-logo">
		<img src="${pageContext.request.contextPath}/images/logo.png"
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    </div>

  <!-- Navigation -->
  <nav class="sk-nav">

    <a href="${pageContext.request.contextPath}/admin/dashboard"
       class="${param.activePage == 'dashboard' ? 'active' : ''}">
      <i class="ri-layout-grid-line"></i> Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/admin/students"
       class="${param.activePage == 'students' ? 'active' : ''}">
      <i class="ri-group-line"></i> Students
    </a>

    <a href="${pageContext.request.contextPath}/admin/classes"
       class="${param.activePage == 'classes' ? 'active' : ''}">
      <i class="ri-book-open-line"></i> Classes
    </a>

    <a href="${pageContext.request.contextPath}/admin/report"
       class="${param.activePage == 'reports' ? 'active' : ''}">
      <i class="ri-bar-chart-line"></i> Reports
    </a>

    <a href="${pageContext.request.contextPath}/admin/announcements"
       class="${param.activePage == 'announcements' ? 'active' : ''}">
      <i class="ri-megaphone-line"></i> Announcements
    </a>

    <a href="${pageContext.request.contextPath}/admin/schedule"
       class="${param.activePage == 'Schedules' ? 'active' : ''} ">
      <i class="ri-calendar-line"></i> Schedule
    </a>

    <a href="${pageContext.request.contextPath}/admin/settings"
       class="${param.activePage == 'settings' ? 'active' : ''}">
      <i class="ri-settings-3-line"></i> Settings
    </a>

  </nav>

</aside>