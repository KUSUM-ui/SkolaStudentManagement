<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Students</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
     <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

<jsp:include page="_sidebar_admin.jsp">
  <jsp:param name="activePage" value="students"/>
</jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Student</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-adstu-top-row">
        <div class="sk-card sk-adstu-stat-card">
          <i class="ri-graduation-cap-line sk-adstu-stat-icon"></i>
          <div class="sk-stat-label">Total Students</div>
          <div class="sk-stat-count">1142</div>
        </div>

        <div class="sk-adstu-filters">
          <div class="sk-adstu-select-wrap">
            <select class="sk-adstu-select" name="course">
              <option value="">All Courses</option>
              <option value="BCA">BCA</option>
              <option value="BBA">BBA</option>
              <option value="BIT">BIT</option>
            </select>
            <i class="ri-arrow-down-s-line sk-adstu-arrow"></i>
          </div>
          <div class="sk-adstu-select-wrap">
            <select class="sk-adstu-select" name="section">
              <option value="">All Sections</option>
              <option value="A">Section A</option>
              <option value="B">Section B</option>
              <option value="C">Section C</option>
            </select>
            <i class="ri-arrow-down-s-line sk-adstu-arrow"></i>
          </div>
        </div>
      </div>

      <div class="sk-row sk-adstu-action-row">

        <div class="sk-card sk-adstu-action-card"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/view'">
          <span>View student details</span>
          <div class="sk-adstu-action-img">
            <img src="${pageContext.request.contextPath}/img/icon-view-students.png"
                 alt="View students"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
           <img src="${pageContext.request.contextPath}/images/list.png" alt="List">
          </div>
        </div>

        <div class="sk-card sk-adstu-action-card"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/schedule'">
          <span>Manage Schedule</span>
          <div class="sk-adstu-action-img">
            <img src="${pageContext.request.contextPath}/img/icon-schedule.png"
                 alt="Manage schedule"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
        <img src="${pageContext.request.contextPath}/images/calender.png" alt="studentschedule">
          </div>
        </div>

        <div class="sk-card sk-adstu-action-card sk-adstu-action-outline"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/register'">
          <div class="sk-adstu-add-reg">
            <span class="sk-adstu-add-plus">+</span>
            <span class="sk-adstu-add-label">Add new<br/>Registrations</span>
          </div>
        </div>

      </div>

      <p class="sk-adstu-manage-label">Manage student details</p>

      <div class="sk-card sk-adstu-account-card">
        <p class="sk-adstu-account-title">Account Actions</p>
        <div class="sk-adstu-account-actions">
          <button class="sk-btn sk-adstu-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/students/reset-password'">
            Reset Password
          </button>
          <button class="sk-btn sk-adstu-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/students/change-details'">
            Change Details
          </button>
          <button class="sk-btn sk-adstu-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/students/remove'">
            Remove Student
          </button>
        </div>
      </div>

    </main>
  </div>

  <%@ include file="_footer.jsp" %>

</div>

</body>
</html>