<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Student Sidebar Fragment
  ────────────────────────
  Include this fragment on every student page:

      <jsp:include page="/WEB-INF/fragments/_sidebar_student.jsp">
          <jsp:param name="activePage" value="dashboard"/>
      </jsp:include>

  Valid activePage values:
      dashboard | teachers | notes | clubs | schedule | settings
--%>

<%
    String activeStudent = request.getParameter("activePage");
    if (activeStudent == null) activeStudent = "";
%>

<aside class="sk-sidebar">

    <!-- LOGO -->
    <div class="nav-logo">
        <img src="<%=request.getContextPath()%>/images/logo.png" 
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    </div>

    <nav class="sk-nav">

        <a href="${pageContext.request.contextPath}/student/dashboard"
           class="<%= "dashboard".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-layout-grid-line"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/student/teachers"
           class="<%= "teachers".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-user-line"></i> Teachers
        </a>

        <a href="${pageContext.request.contextPath}/student/notes"
           class="<%= "notes".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-sticky-note-line"></i> Notes
        </a>

        <a href="${pageContext.request.contextPath}/student/clubs"
           class="<%= "clubs".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-team-line"></i> Clubs
        </a>

        <a href="${pageContext.request.contextPath}/student/schedule"
           class="<%= "schedule".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-calendar-line"></i> Schedule
        </a>

        <a href="${pageContext.request.contextPath}/student/settings"
           class="<%= "settings".equals(activeStudent) ? "active" : "" %>">
            <i class="ri-settings-3-line"></i> Settings
        </a>

    </nav>

</aside>