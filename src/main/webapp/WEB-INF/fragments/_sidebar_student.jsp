<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<aside class="sk-sidebar">
 <!-- LOGO -->
    <div class="sk-logo">
		<img src="${pageContext.request.contextPath}/images/logo.png"
             alt="SKOLA" class="logo-img" />
        <span class="logo-text">SKOLA</span>
    

    <a href="${pageContext.request.contextPath}/student/dashboard" class="sk-logo"></a>
    </div>
        
 
    

    <nav class="sk-nav">

        <a href="${pageContext.request.contextPath}/student/dashboard"
           class="${param.activePage == 'dashboard' ? 'active' : ''}">
            <i class="ri-layout-grid-line"></i>
            <span>Dashboard</span>
        </a>

        <a href="${pageContext.request.contextPath}/student/notes"
           class="${param.activePage == 'notes' ? 'active' : ''}">
            <i class="ri-sticky-note-line"></i>
            <span>Notes</span>
        </a>
        
    <a href="${pageContext.request.contextPath}/student/classes"
       class="${param.activePage == 'classes' ? 'active' : ''}">
      <i class="ri-book-open-line"></i> Classes
    </a>

        <a href="${pageContext.request.contextPath}/student/schedule"
           class="${param.activePage == 'schedule' ? 'active' : ''}">
            <i class="ri-calendar-line"></i>
            <span>Schedule</span>
        </a>

        <a href="${pageContext.request.contextPath}/student/settings"
           class="${param.activePage == 'settings' ? 'active' : ''}">
            <i class="ri-settings-3-line"></i>
            <span>Settings</span>
        </a>

    </nav>

</aside>