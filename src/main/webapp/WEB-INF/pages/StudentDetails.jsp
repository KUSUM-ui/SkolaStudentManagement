<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - View Students</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<c:set var="q" value="${fn:toLowerCase(param.q)}"/>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Students</h2>
      </div>

      <a class="sk-stdlist-back" href="${pageContext.request.contextPath}/admin/students">
        <i class="ri-arrow-left-s-line"></i> Back to Students
      </a>

      <c:if test="${not empty errorMessage}">
        <div class="sk-error-banner">
          <i class="ri-error-warning-line"></i> ${errorMessage}
        </div>
      </c:if>

      <form method="get" action="${pageContext.request.contextPath}/admin/students/view">
        <div class="sk-stdlist-search-wrap">
          <i class="ri-search-line"></i>
          <input class="sk-stdlist-search" type="text" name="q" value="${param.q}" placeholder="Search by name, email, or phone..." />
          <c:if test="${not empty selectedCourse}"><input type="hidden" name="course" value="${selectedCourse}"/></c:if>
          <c:if test="${not empty selectedSection}"><input type="hidden" name="section" value="${selectedSection}"/></c:if>
          <c:if test="${not empty selectedSemester}"><input type="hidden" name="semester" value="${selectedSemester}"/></c:if>
        </div>
      </form>

      <form method="get" action="${pageContext.request.contextPath}/admin/students/view">
        <c:if test="${not empty param.q}"><input type="hidden" name="q" value="${param.q}"/></c:if>

        <div class="sk-filter-panel-row">
          <div class="sk-filter-group">
            <label for="courseFilter">Faculty / Course</label>
            <select id="courseFilter" name="course">
              <option value="">All Faculties</option>
              <c:forEach var="f" items="${faculties}">
                <option value="${f.facultyId}" <c:if test="${selectedCourse eq f.facultyId}">selected</c:if>>${f.facultyName}</option>
              </c:forEach>
            </select>
          </div>

          <div class="sk-filter-group">
            <label for="sectionFilter">Section</label>
            <select id="sectionFilter" name="section">
              <option value="">All Sections</option>
              <c:forEach var="sec" items="${sections}">
                <option value="${sec.sectionId}" <c:if test="${selectedSection eq sec.sectionId}">selected</c:if>>${sec.sectionName}</option>
              </c:forEach>
            </select>
          </div>

          <div class="sk-filter-group">
            <label for="semesterFilter">Semester</label>
            <select id="semesterFilter" name="semester">
              <option value="">All Semesters</option>
              <option value="1" <c:if test="${selectedSemester eq '1'}">selected</c:if>>Semester 1</option>
              <option value="2" <c:if test="${selectedSemester eq '2'}">selected</c:if>>Semester 2</option>
              <option value="3" <c:if test="${selectedSemester eq '3'}">selected</c:if>>Semester 3</option>
              <option value="4" <c:if test="${selectedSemester eq '4'}">selected</c:if>>Semester 4</option>
              <option value="5" <c:if test="${selectedSemester eq '5'}">selected</c:if>>Semester 5</option>
              <option value="6" <c:if test="${selectedSemester eq '6'}">selected</c:if>>Semester 6</option>
            </select>
          </div>

          <div class="sk-filter-actions">
            <button type="submit" class="sk-filter-submit-btn">
              <i class="ri-filter-3-line"></i> Filter
            </button>
            <a href="${pageContext.request.contextPath}/admin/students/view" class="sk-btn-outline" style="font-size:13px; padding:6px 14px;">Clear</a>
          </div>
        </div>
      </form>

      <c:if test="${not empty students}">
        <p class="sk-stdlist-count">
          Showing <strong>${fn:length(students)}</strong> student(s)
        </p>
      </c:if>

      <div class="sk-stdlist-card">
        <c:choose>
          <c:when test="${not empty students}">
            <c:forEach var="s" items="${students}">
              <c:set var="searchText" value="${fn:toLowerCase(s.firstName)} ${fn:toLowerCase(s.lastName)} ${fn:toLowerCase(s.email)} ${fn:toLowerCase(s.number)}"/>

              <c:if test="${empty q or fn:contains(searchText, q)}">
                <div class="sk-stdlist-row">

                  <div class="sk-stdlist-avatar">
                    <c:choose>
                      <c:when test="${not empty s.image}">
                        <img src="${pageContext.request.contextPath}/${s.image}" alt="Photo"/>
                      </c:when>
                      <c:when test="${not empty s.firstName}">
                        ${fn:substring(s.firstName,0,1)}${not empty s.lastName ? fn:substring(s.lastName,0,1) : ''}
                      </c:when>
                      <c:otherwise>
                        <i class="ri-user-line"></i>
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <div class="sk-stdlist-info">
                    <div class="sk-stdlist-name">
                      ${s.firstName} ${s.lastName}
                    </div>
                    <div class="sk-stdlist-meta">
                      <c:if test="${not empty s.email}">
                        <span class="sk-stdlist-meta-item"><i class="ri-mail-line"></i>${s.email}</span>
                      </c:if>
                      <c:if test="${not empty s.number}">
                        <span class="sk-stdlist-meta-item"><i class="ri-phone-line"></i>${s.number}</span>
                      </c:if>
                    </div>
                  </div>

                  <c:if test="${not empty s.facultyId}">
                    <span class="sk-stdlist-badge">
                      ID: ${s.facultyId} <c:if test="${not empty s.sectionId}">- ${s.sectionId}</c:if>
                    </span>
                  </c:if>

                  <a href="${pageContext.request.contextPath}/admin/students/edit?id=${s.studentId}" class="sk-stdlist-edit-btn">
                    <i class="ri-edit-line"></i> Edit
                  </a>
                </div>
              </c:if>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="sk-stdlist-empty">
              <i class="ri-group-line"></i>
              No students registered yet.
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </main>
  </div>
</div>

</body>
</html>