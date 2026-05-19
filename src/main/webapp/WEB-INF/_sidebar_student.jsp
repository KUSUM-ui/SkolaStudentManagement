<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%--
  Student Sidebar Fragment
  ────────────────────────
  Include this fragment on every student page:

      <jsp:include page="/WEB-INF/_sidebar_student.jsp">
          <jsp:param name="activePage" value="dashboard"/>
      </jsp:include>

  Valid activePage values:
      dashboard | notes | class | schedule | settings
--%>

<aside class="sk-sidebar">

    <!-- LOGO -->
    <div class="nav-logo">
        <img src="${pageContext.request.contextPath}/resources/images/logo.png"
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    </div>

    <nav class="sk-nav">

        <a href="${pageContext.request.contextPath}/student/Dashboard"
           class="${param.activePage == 'dashboard' ? 'active' : ''}">
            <i class="ri-layout-grid-line"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/student/notes"
           class="${param.activePage == 'notes' ? 'active' : ''}">
            <i class="ri-sticky-note-line"></i> Notes
        </a>

        <a href="${pageContext.request.contextPath}/student/ClassReservation"
           class="${param.activePage == 'class' ? 'active' : ''}">
            <i class="ri-book-open-line"></i> Class
        </a>

        <a href="${pageContext.request.contextPath}/student/schedule"
           class="${param.activePage == 'schedule' ? 'active' : ''}">
            <i class="ri-calendar-line"></i> Schedule
        </a>

        <a href="${pageContext.request.contextPath}/student/Settings"
           class="${param.activePage == 'settings' ? 'active' : ''}">
            <i class="ri-settings-3-line"></i> Settings
        </a>

    </nav>

</aside>
