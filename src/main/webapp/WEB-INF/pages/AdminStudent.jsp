
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Students</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <c:if test="${not empty sessionScope.successMessage}">
          <div class="sk-alert sk-alert-success">
              <i class="ri-checkbox-circle-line"></i> ${sessionScope.successMessage}
              
          </div>
          <c:remove var="successMessage" scope="session" />
        </c:if>
        <div>
          <h2>Students</h2>
          <a href="${pageContext.request.contextPath}/admin/dashboard" class="sk-edit-back-link">
            <i class="ri-arrow-left-s-line"></i> Back to Dashboard
          </a>
        </div>
        <div class="sk-avatar">
          <c:choose>
            <c:when test="${not empty sessionScope.adminAvatar}">
              <img src="${pageContext.request.contextPath}/${sessionScope.adminAvatar}" alt="Admin"/>
            </c:when>
            <c:otherwise>
              <div class="sk-avatar-placeholder" style="width: 40px; height: 40px; background: var(--red-pale); color: var(--red); display: flex; 
              align-items: center; justify-content: center; border-radius: 50%;">
                <i class="ri-user-line" style="font-size: 20px;"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <div class="sk-adstu-hero">

       <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-graduation-cap-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty totalStudents ? totalStudents : 0}</div>
          <div class="dash-stat-label">Total Students</div>
        </div>
      </div>

        <div class="sk-adstu-info-strip">
          <h3>Student Management</h3>
          <p>View and manage student records, schedules, and account details. Use the actions below to navigate to a specific area.</p>
        </div>

      </div>

      <p class="sk-adstu-section-label">Pending Actions</p>
      <a class="sk-adstu-approval-banner"
         href="${pageContext.request.contextPath}/admin/students/approvals"
         >
        <div class="sk-adstu-approval-left">
          <div class="sk-adstu-approval-dot"></div>
          <div class="sk-adstu-approval-text">
            <strong>Student Registration Approvals</strong>
            <span>Review and approve pending student registration requests</span>
          </div>
        </div>
        <c:if test="${not empty pendingCount and pendingCount > 0}">
          <div class="sk-adstu-approval-badge">${pendingCount} pending</div>
        </c:if>
        <i class="ri-arrow-right-s-line sk-adstu-approval-arrow"></i>
      </a>

      <p class="sk-adstu-section-label">Quick Actions</p>
      <div class="sk-adstu-actions-grid">

        <a class="sk-adstu-action-card"
           href="${pageContext.request.contextPath}/admin/students/view">
          <div class="sk-adstu-action-icon-wrap">
            <i class="ri-file-list-3-line"></i>
          </div>
          <div>
            <p class="sk-adstu-action-title">View Student Details</p>
            <p class="sk-adstu-action-desc">Browse and search all registered student profiles</p>
          </div>
        </a>

        <a class="sk-adstu-action-card"
           href="${pageContext.request.contextPath}/admin/schedule">
          <div class="sk-adstu-action-icon-wrap">
            <i class="ri-calendar-schedule-line"></i>
          </div>
          <div>
            <p class="sk-adstu-action-title">Manage Schedule</p>
            <p class="sk-adstu-action-desc">Assign and update class schedules for students</p>
          </div>
        </a>

        <a class="sk-adstu-action-card sk-adstu-action-card--highlight"
           href="${pageContext.request.contextPath}/admin/students/register">
          <div class="sk-adstu-action-icon-wrap">
            <i class="ri-user-add-line"></i>
          </div>
          <div>
            <p class="sk-adstu-action-title">Add New Registration</p>
            <p class="sk-adstu-action-desc">Manually register a new student into the system</p>
          </div>
        </a>

      </div>

    </main>
  </div>
<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>
</div>

</body>
</html>
