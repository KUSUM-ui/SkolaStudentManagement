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

      <div class="sk-adstu-top-row">
        <div class="sk-adstu-filters">
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
      </div>

      <div class="sk-view-wrapper">
        <div class="sk-view-card">

          <div class="sk-view-list">
            <c:choose>
              <c:when test="${not empty students}">
                <c:forEach var="s" items="${students}">
                  <div class="sk-view-row">
                    <div class="sk-view-row-avatar">
                      <c:choose>
                        <c:when test="${not empty s.photoUrl}">
                          <img src="${pageContext.request.contextPath}${s.photoUrl}" alt="${s.name}"/>
                        </c:when>
                        <c:otherwise>
                          <i class="ri-user-3-line"></i>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="sk-view-row-info">
                      <span class="sk-view-row-name">${s.name}</span>
                      <span class="sk-view-row-meta">${s.studentId} &bull; ${s.course} &bull; ${s.classSection}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/students/edit?id=${s.studentId}"
                       class="sk-btn sk-view-row-btn">View</a>
                  </div>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <div class="sk-view-empty">
                  <p>No students found</p>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>