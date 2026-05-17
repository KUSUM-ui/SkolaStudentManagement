<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css" />
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
                <h2>Welcome, ${student.firstName}</h2>
                <div class="sk-stusch-topbar-right">
                    <div class="sk-stusch-search-wrap">
                        <i class="ri-search-line"></i>
                        <input type="text" class="sk-stusch-search" placeholder="Search"/>
                    </div>
                    <div class="sk-avatar">
                        <i class="ri-user-line"></i>
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
                    <span class="sk-profile-sub">COMPUTING</span>
                    <span class="sk-profile-class">${student.gradeLevel}</span>
                    <span class="sk-profile-sem">Semester 4</span>
                    <span class="sk-profile-name">${student.firstName} ${student.lastName}</span>
                </div>
            </div>

            <!-- Announcement card -->
            <div class="sk-card sk-card-announce sk-dash-announce-card">
                <h3>Announcement</h3>
                <hr class="sk-dash-divider"/>
                <c:choose>
                    <c:when test="${not empty announcements}">
                        <div class="sk-dash-ann-list">
                            <c:forEach var="ann" items="${announcements}">
                                <div class="sk-dash-ann-item">
                                    <div class="sk-dash-ann-header">
                                        <strong class="sk-dash-ann-title">${ann.title}</strong>
                                        <span class="sk-announce-badge sk-badge-${ann.genre}">${ann.genre}</span>
                                    </div>
                                    <p class="sk-dash-ann-content">${ann.content}</p>
                                    <c:if test="${not empty ann.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${ann.imagePath}"
                                             alt="announcement image"
                                             class="sk-dash-ann-img"/>
                                    </c:if>
                                    <small class="sk-dash-ann-date">
                                        <fmt:parseDate value="${ann.publishedAt}"
                                                       pattern="yyyy-MM-dd'T'HH:mm:ss"
                                                       var="parsedDate" type="both"/>
                                        <fmt:formatDate value="${parsedDate}"
                                                        pattern="dd MMM yyyy, hh:mm a"/>
                                    </small>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="sk-dash-ann-empty">No announcements yet.</p>
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
                        <a href="${pageContext.request.contextPath}/NotesServlet" class="sk-btn">Create</a>
                    </div>
                </div>
            </div>

        </main>
    </div>

    <jsp:include page="/WEB-INF/_footer.jsp" />

</body>
</html>
