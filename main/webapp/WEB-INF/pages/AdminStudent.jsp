<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

      <!-- TOPBAR -->
      <div class="sk-topbar">
        <h2>Student</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <!-- ROW 1: Stat card + View student details + Manage Schedule -->
      <div class="sk-adstu-row1">

        <div class="sk-adstu-stat-card">
          <i class="ri-graduation-cap-line sk-adstu-stat-icon"></i>
          <div class="sk-adstu-stat-label">TOTAL STUDENTS</div>
          <div class="sk-adstu-stat-count">
            <c:choose>
              <c:when test="${not empty totalStudents}">${totalStudents}</c:when>
              <c:otherwise>1142</c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="sk-adstu-action-card"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/view'">
          <span class="sk-adstu-action-label">View student details</span>
          <div class="sk-adstu-action-img">
            <img src="${pageContext.request.contextPath}/images/list.png" alt="List">
          </div>
        </div>

        <div class="sk-adstu-action-card"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/schedule'">
          <span class="sk-adstu-action-label">Manage Schedule</span>
          <div class="sk-adstu-action-img">
            <img src="${pageContext.request.contextPath}/images/calender.png" alt="Schedule">
          </div>
        </div>

      </div>

      <!-- ROW 2: Student registration table + Add new Registrations -->
      <div class="sk-adstu-row2">

        <div class="sk-adstu-reg-card">
          <div class="sk-adstu-reg-header">
            <span class="sk-adstu-reg-title">Student registration</span>
            <a href="${pageContext.request.contextPath}/admin/students/register" class="sk-adstu-view-all">View all</a>
          </div>
          <div class="sk-adstu-reg-list">
            <c:choose>
              <c:when test="${not empty pendingStudents}">
                <c:forEach var="student" items="${pendingStudents}">
                  <div class="sk-adstu-reg-row">
                    <span class="sk-adstu-reg-name">${student.name}</span>
                    <div class="sk-adstu-reg-actions">
                      <button class="sk-adstu-approve-btn"
                        onclick="location.href='${pageContext.request.contextPath}/admin/students/approve?id=${student.id}'">
                        Approve
                      </button>
                      <button class="sk-adstu-viewdet-btn"
                        onclick="location.href='${pageContext.request.contextPath}/admin/students/view?id=${student.id}'">
                        View details
                      </button>
                    </div>
                  </div>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <c:forEach begin="1" end="4">
                  <div class="sk-adstu-reg-row">
                    <span class="sk-adstu-reg-name">Name</span>
                    <div class="sk-adstu-reg-actions">
                      <button class="sk-adstu-approve-btn">Approve</button>
                      <button class="sk-adstu-viewdet-btn">View details</button>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <div class="sk-adstu-addnew-card"
             onclick="location.href='${pageContext.request.contextPath}/admin/students/register'">
          <div class="sk-adstu-add-inner">
            <span class="sk-adstu-add-plus">+</span>
            <span class="sk-adstu-add-label">Add new<br/>Registrations</span>
          </div>
        </div>

      </div>

      <!-- ROW 3: Manage student details -->
      <p class="sk-adstu-manage-label">Manage student details</p>

      <div class="sk-adstu-account-card">
        <div class="sk-adstu-account-actions">
          <button class="sk-adstu-mgmt-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/students/change-details'">
            Change Details
          </button>
          <button class="sk-adstu-mgmt-btn"
            onclick="location.href='${pageContext.request.contextPath}/admin/students/remove'">
            Remove Student
          </button>
        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>