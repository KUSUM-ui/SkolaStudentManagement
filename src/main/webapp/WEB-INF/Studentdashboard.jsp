<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/std.css" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page sk-student">

    <div class="sk-app">

        <jsp:include page="/WEB-INF/_sidebar_student.jsp">
            <jsp:param name="activePage" value="dashboard"/>
        </jsp:include>

        <main class="sk-main">

            <!-- Topbar -->
                 <div class="sk-topbar">
        <h2>Welcome, ${sessionScope.studentName}</h2>
        <div class="sk-stusch-topbar-right">
          <div class="sk-stusch-search-wrap">
            <i class="ri-search-line"></i>
            <input type="text" class="sk-stusch-search" placeholder="Search" name="search"/>
          </div>
          <div class="sk-avatar">
            <img src="${pageContext.request.contextPath}/img/student-avatar.png"
                 alt="Student"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
            <i class="ri-user-line" style="display:none;"></i>
          </div>
        </div>
      </div>

            <!-- Row 1: Schedule + Profile -->
            <div class="sk-row">
                <div class="sk-card sk-card-schedule">
                    <p class="sk-card-title">Today's schedule</p>
                    <div class="sk-view-all">View all</div>
                </div>

                <div class="sk-card sk-card-profile">
                    <i class="ri-graduation-cap-line"></i>
                    <span class="sk-profile-sub">Computing</span>
                    <span class="sk-profile-class">${student.gradeLevel}</span>
                    <span class="sk-profile-sem">Semester 4</span>
                    <span class="sk-profile-name">${student.firstName} ${student.lastName}</span>
                </div>
            </div>

            <!-- Announcement -->
            <div class="sk-card sk-card-announce">
                <h3>Announcement</h3>
                <c:choose>
                    <c:when test="${not empty announcements}">
                        <c:forEach var="ann" items="${announcements}">
                            <p class="sk-dash-ann-item">${ann.message}</p>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="sk-dash-ann-empty"></p>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- My Notes -->
            <div class="sk-notes-section">
                <h3>My Notes</h3>
                <div class="sk-notes-row">
                    <div class="sk-card sk-notes-area">
                        <c:if test="${not empty notes}">
                            <c:forEach var="note" items="${notes}" end="2">
                                <div class="sk-dash-note-item">
                                    <span class="sk-dash-note-title">${note.title}</span>
                                    <span class="sk-dash-note-preview">${note.content}</span>
                                </div>
                            </c:forEach>
                        </c:if>
                        <div class="sk-view-all">View all</div>
                    </div>
                    <div class="sk-new-note">
                        <span class="sk-pins">📌</span>
                        <p>Create<br/>new note</p>
                        <a href="${pageContext.request.contextPath}/notes.jsp" class="sk-btn">Create</a>
                    </div>
                </div>
            </div>

        </main>
    </div>

    <jsp:include page="/WEB-INF/_footer.jsp" />

</body>
</html>