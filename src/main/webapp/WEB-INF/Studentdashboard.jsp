<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard | Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
</head>
<body>

<div class="sk-page sk-student">
    <div class="sk-app">

        <%-- ── Sidebar ── --%>
        <jsp:include page="/WEB-INF/_sidebar_student.jsp">
            <jsp:param name="activePage" value="dashboard"/>
        </jsp:include>

        <%-- ── Main ── --%>
        <main class="sk-main">

            <%-- Topbar --%>
            <div class="sk-topbar">
                <h2>Welcome, ${student.fullName}</h2>
                <a href="${pageContext.request.contextPath}/StudentSettingsServlet" class="sk-avatar">
                    <i class="ri-user-line"></i>
                </a>
            </div>

            <%-- Row 1: Schedule + Profile --%>
            <div class="sk-row">

                <%-- Today's Schedule Card --%>
                <div class="sk-card sk-card-schedule">
                    <div class="sk-card-schedule-header">
                        <p class="sk-today-label">
                            Today's schedule
                            <c:if test="${not empty todayDay}">
                                &nbsp;— <strong>${todayDay}</strong>
                            </c:if>
                        </p>
                        <a href="${pageContext.request.contextPath}/StudentScheduleServlet" class="sk-view-all">View all</a>
                    </div>

                    <c:choose>
                        <c:when test="${empty todaySchedule}">
                            <p class="sk-schedule-empty">No classes scheduled for ${todayDay}.</p>
                        </c:when>
                        <c:otherwise>
                            <table class="sk-schedule-table">
                                <thead>
                                    <tr>
                                        <th>Start</th>
                                        <th>End</th>
                                        <th>Module</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="s" items="${todaySchedule}">
                                        <tr>
                                            <td>${s.startTime}</td>
                                            <td>${s.endTime}</td>
                                            <td>${s.moduleName}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>

                <%-- Profile Card --%>
                <div class="sk-card sk-card-profile">
                    <i class="ri-graduation-cap-line"></i>
                    <span class="sk-profile-sub">Computing</span>
                    <span class="sk-profile-class">Semester ${student.semester}</span>
                    <span class="sk-profile-sem">Semester ${student.semester}</span>
                    <span class="sk-profile-name">${student.fullName}</span>
                </div>

            </div>
            <%-- End Row 1 --%>

<div class="sk-card-announce">

    <div class="sk-announcement-header">
        <h3>Announcement</h3>
    </div>

    <c:choose>

        <c:when test="${empty announcements}">
            <div class="sk-empty-state">
                No announcements yet.
            </div>
        </c:when>

        <c:otherwise>
            <div class="sk-announcement-container">
                <c:forEach var="a" items="${announcements}">

                    <div class="sk-announcement-card">

                        <%-- Top row: title + genre badge --%>
                        <div class="sk-ann-top-row">
                            <h4 class="sk-announcement-title">${a.title}</h4>
                            <c:if test="${not empty a.genre}">
                                <span class="sk-ann-badge sk-ann-badge-${a.genre}">
                                    ${a.genre}
                                </span>
                            </c:if>
                        </div>

                        <%-- Content text --%>
                        <p class="sk-announcement-content">${a.content}</p>

                        <%-- Image if exists --%>
                        <c:if test="${not empty a.imagePath}">
                            <img
                                src="${pageContext.request.contextPath}/uploads/announcements/${a.imagePath}"
                                alt="Announcement Image"
                                class="sk-ann-image"
                            />
                        </c:if>

                        <%-- Attachment if exists --%>
                        <c:if test="${not empty a.attachmentPath}">
                            
                                href="${pageContext.request.contextPath}/uploads/announcements/${a.attachmentPath}"
                                class="sk-ann-attachment"
                                target="_blank"
                            >
                                <i class="ri-attachment-2"></i> View Attachment
                            </a>
                        </c:if>

                    </div>

                </c:forEach>
            </div>
        </c:otherwise>

    </c:choose>

</div>

            <%-- My Notes Section --%>
            <div class="sk-notes-section">
                <h3>My Notes</h3>
                <div class="sk-notes-row">

                    <%-- Notes list --%>
                    <div class="sk-notes-area">
                        <c:if test="${not empty notes}">
                            <c:forEach var="n" items="${notes}">
                                <p>${n.title}</p>
                            </c:forEach>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/StudentNotesServlet" class="sk-view-all">View all</a>
                    </div>

                    <%-- Create note --%>
                    <div class="sk-new-note">
                        <span class="sk-pins"></span>
                        <p>Create new note</p>
                        <a href="${pageContext.request.contextPath}/StudentNotesServlet" class="sk-btn">Create</a>
                    </div>

                </div>
            </div>
           

        </main>
        <%-- End Main --%>

    </div>
</div>
 <jsp:include page="/WEB-INF/_footer.jsp"/>
</body>
</html>