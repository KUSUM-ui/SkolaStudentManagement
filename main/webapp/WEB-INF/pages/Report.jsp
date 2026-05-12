<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Report</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
      <jsp:param name="activePage" value="reports"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Report</h2>
        <div class="sk-topbar-right">
          <a href="${pageContext.request.contextPath}/ReportServlet?export=pdf"
             class="sk-rpt-export-btn">
            Export PDF <i class="ri-download-2-line"></i>
          </a>
          <div class="sk-avatar">
            <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
                 alt="Admin"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
            <i class="ri-user-line" style="display:none;"></i>
          </div>
        </div>
      </div>

      <p class="sk-rpt-section-label">Students</p>

      <div class="sk-rpt-top-row">

        <div class="sk-card sk-rpt-stat-card">
          <p class="sk-rpt-stat-label">
            <c:choose>
              <c:when test="${view eq 'module'}">TOTAL MODULE</c:when>
              <c:otherwise>TOTAL STUDENTS</c:otherwise>
            </c:choose>
          </p>
          <p class="sk-rpt-stat-count">
            <c:choose>
              <c:when test="${view eq 'module'}">
                <c:choose>
                  <c:when test="${not empty totalModules}">${totalModules}</c:when>
                  <c:otherwise>&mdash;</c:otherwise>
                </c:choose>
              </c:when>
              <c:otherwise>
                <c:choose>
                  <c:when test="${not empty totalStudents}">${totalStudents}</c:when>
                  <c:otherwise>&mdash;</c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>
          </p>
        </div>

        <div class="sk-rpt-toggle-group">
          <a href="${pageContext.request.contextPath}/ReportServlet?view=module"
             class="sk-rpt-toggle-btn ${view eq 'module' ? 'sk-rpt-toggle-active' : ''}">
            <i class="ri-book-open-line"></i> Module
          </a>
          <a href="${pageContext.request.contextPath}/ReportServlet?view=students"
             class="sk-rpt-toggle-btn ${view ne 'module' ? 'sk-rpt-toggle-active' : ''}">
            <i class="ri-user-line"></i> Students
          </a>
        </div>

      </div>

      <%-- MODULE VIEW --%>
      <c:if test="${view eq 'module'}">

        <form method="get" action="${pageContext.request.contextPath}/ReportServlet"
              class="sk-rpt-filter-row">
          <input type="hidden" name="view" value="module"/>
          <div class="sk-adstu-select-wrap">
            <select class="sk-adstu-select" name="facultyId" onchange="this.form.submit()">
              <option value="">Faculty</option>
              <c:forEach var="fac" items="${faculties}">
                <option value="${fac.facultyId}"
                  ${param.facultyId eq fac.facultyId ? 'selected' : ''}>
                  ${fac.facultyName}
                </option>
              </c:forEach>
            </select>
            <i class="ri-arrow-down-s-line sk-adstu-arrow"></i>
          </div>
        </form>

        <div class="sk-rpt-table-wrap">
          <table class="sk-rpt-table">
            <thead>
              <tr>
                <th>Module ID</th>
                <th>Module Name</th>
                <th>Description</th>
                <th>Credit</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty modules}">
                  <c:forEach var="m" items="${modules}">
                    <tr>
                      <td>${m.moduleId}</td>
                      <td>${m.moduleName}</td>
                      <td>${m.moduleDescription}</td>
                      <td>${m.moduleCredits}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <c:forEach begin="1" end="8">
                    <tr>
                      <td></td><td></td><td></td><td></td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>

        <p class="sk-rpt-total">
          Total modules:
          <c:if test="${not empty totalModules}">
            <span>${totalModules}</span>
          </c:if>
        </p>

      </c:if>

      <%-- STUDENTS VIEW --%>
      <c:if test="${view ne 'module'}">

        <form method="get" action="${pageContext.request.contextPath}/ReportServlet"
              class="sk-rpt-filter-row">
          <input type="hidden" name="view" value="students"/>
          <div class="sk-adstu-select-wrap">
            <select class="sk-adstu-select" name="sectionId" onchange="this.form.submit()">
              <option value="">Section</option>
              <c:forEach var="sec" items="${sections}">
                <option value="${sec.sectionId}"
                  ${param.sectionId eq sec.sectionId ? 'selected' : ''}>
                  ${sec.sectionId}
                </option>
              </c:forEach>
            </select>
            <i class="ri-arrow-down-s-line sk-adstu-arrow"></i>
          </div>
        </form>

        <div class="sk-rpt-table-wrap">
          <table class="sk-rpt-table">
            <thead>
              <tr>
                <th>Student ID</th>
                <th>Student Name</th>
                <th>Course</th>
                <th>Grade Level</th>
                <th>Section</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty students}">
                  <c:forEach var="stu" items="${students}">
                    <tr>
                      <td>${stu.studentId}</td>
                      <td>${stu.firstName} ${stu.lastName}</td>
                      <td>${stu.facultyName}</td>
                      <td>${stu.gradeLevel}</td>
                      <td>${stu.sectionId}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <c:forEach begin="1" end="8">
                    <tr>
                      <td></td><td></td><td></td><td></td><td></td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>

        <p class="sk-rpt-total">
          Total students:
          <c:if test="${not empty totalStudents}">
            <span>${totalStudents}</span>
          </c:if>
        </p>

      </c:if>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>