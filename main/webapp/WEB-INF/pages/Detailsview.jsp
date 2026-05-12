<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Student Details</title>
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
        <div>
          <h2>Student</h2>
          <a href="${pageContext.request.contextPath}/admin/students"
             class="sk-stuview-back">
            <i class="ri-arrow-left-line"></i> Back
          </a>
        </div>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-stuview-wrapper">

        <!-- Avatar -->
        <div class="sk-stuview-avatar">
          <c:choose>
            <c:when test="${not empty student.photoUrl}">
              <img src="${pageContext.request.contextPath}${student.photoUrl}" alt="Student Photo"/>
            </c:when>
            <c:otherwise>
              <i class="ri-user-3-line"></i>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Fields -->
        <div class="sk-stuview-fields">

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Student ID</span>
            <span class="sk-stuview-value <c:if test='${empty student.studentId}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.studentId}">${student.studentId}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Full name</span>
            <span class="sk-stuview-value <c:if test='${empty student.firstName and empty student.lastName}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.firstName or not empty student.lastName}">
                  ${student.firstName} ${student.lastName}
                </c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Email</span>
            <span class="sk-stuview-value <c:if test='${empty student.email}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.email}">${student.email}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Password</span>
            <span class="sk-stuview-value <c:if test='${empty student.password}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.password}">••••••••</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Faculty / Program</span>
            <span class="sk-stuview-value <c:if test='${empty student.facultyId}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.facultyName}">${student.facultyName}</c:when>
                <c:when test="${not empty student.facultyId}">${student.facultyId}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Class</span>
            <span class="sk-stuview-value <c:if test='${empty student.gradeLevel}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.gradeLevel}">${student.gradeLevel}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Year</span>
            <span class="sk-stuview-value <c:if test='${empty student.dob}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.dob}">${student.dob}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Address</span>
            <span class="sk-stuview-value <c:if test='${empty student.address}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.address}">${student.address}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Phone number</span>
            <span class="sk-stuview-value <c:if test='${empty student.phone and empty student.phoneNumber}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.phone}">${student.phone}</c:when>
                <c:when test="${not empty student.phoneNumber}">${student.phoneNumber}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

          <div class="sk-stuview-field">
            <span class="sk-stuview-label">Gender</span>
            <span class="sk-stuview-value <c:if test='${empty student.gender}'>placeholder</c:if>">
              <c:choose>
                <c:when test="${not empty student.gender}">${student.gender}</c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </span>
          </div>

        </div>

        <!-- Edit button -->
        <div class="sk-stuview-edit-row">
          <a href="${pageContext.request.contextPath}/admin/students/edit?id=${student.studentId}"
             class="sk-stuview-edit-btn">Edit</a>
        </div>

      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>