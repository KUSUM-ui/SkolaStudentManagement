<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - View Students</title>
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

      <div class="sk-adstu-view-filters">
        <div class="sk-adstu-select-wrap">
          <select class="sk-adstu-select" name="course">
            <option value="">All Courses</option>
            <option value="BOC">Bachelor's Of Computing</option>
            <option value="BON">Bachelor's Of Networking</option>
            <option value="BOA">Bachelor's Of AI</option>
            <option value="BOF">Bachelor's Of Accounting and Finance</option>
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

      <div class="sk-adstu-view-card">

        <c:choose>

          <c:when test="${not empty students}">
            <c:forEach var="s" items="${students}">
              <div class="sk-adstu-view-row">

                <div class="sk-adstu-view-info">

                  <span class="sk-adstu-view-name">
                    <c:choose>
                      <c:when test="${not empty s.firstName and not empty s.lastName}">
                        ${s.firstName} ${s.lastName}
                      </c:when>
                      <c:when test="${not empty s.firstName}">
                        ${s.firstName}
                      </c:when>
                      <c:otherwise>
                        <span class="sk-adstu-placeholder">&mdash;</span>
                      </c:otherwise>
                    </c:choose>
                  </span>

                  <div class="sk-adstu-view-meta">

                    <span class="sk-adstu-meta-item">
                      <i class="ri-mail-line"></i>
                      <c:choose>
                        <c:when test="${not empty s.email}">${s.email}</c:when>
                        <c:otherwise><span class="sk-adstu-placeholder">No email</span></c:otherwise>
                      </c:choose>
                    </span>

                    <span class="sk-adstu-meta-item">
                      <i class="ri-phone-line"></i>
                      <c:choose>
                        <c:when test="${not empty s.phone}">${s.phone}</c:when>
                        <c:otherwise><span class="sk-adstu-placeholder">&mdash;</span></c:otherwise>
                      </c:choose>
                    </span>

                    <span class="sk-adstu-meta-item">
                      <i class="ri-book-open-line"></i>
                      <c:choose>
                        <c:when test="${not empty s.gradeLevel}">${s.gradeLevel}</c:when>
                        <c:otherwise><span class="sk-adstu-placeholder">No grade</span></c:otherwise>
                      </c:choose>
                    </span>

                    <span class="sk-adstu-meta-item">
                      <i class="ri-calendar-line"></i>
                      <c:choose>
                        <c:when test="${not empty s.dob}">${s.dob}</c:when>
                        <c:otherwise><span class="sk-adstu-placeholder">&mdash;</span></c:otherwise>
                      </c:choose>
                    </span>

                    <span class="sk-adstu-meta-item">
                      <i class="ri-user-line"></i>
                      <c:choose>
                        <c:when test="${not empty s.gender}">${s.gender}</c:when>
                        <c:otherwise><span class="sk-adstu-placeholder">&mdash;</span></c:otherwise>
                      </c:choose>
                    </span>

                  </div>
                </div>

                <a href="${pageContext.request.contextPath}/admin/students/edit?id=${s.studentId}"
                   class="sk-adstu-edit-btn">
                  Edit details
                </a>

              </div>
            </c:forEach>
          </c:when>

          <c:otherwise>
            <div class="sk-adstu-view-empty">
              <p>No students registered yet.</p>
            </div>
          </c:otherwise>

        </c:choose>

      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />

</div>

</body>
</html>