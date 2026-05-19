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

            <%-- ── Topbar ── --%>
            <div class="sk-topbar">
                <h2>Welcome, ${student.fullName}</h2>

                <%-- Profile avatar: shows image if student has one, else icon --%>
                <a href="${pageContext.request.contextPath}/student/Settings" class="sk-avatar">
                    <c:choose>
                        <c:when test="${not empty student.image}">
                            <%-- student.image → SettingsStudentModel.getImage() → DB column: image --%>
                            <img src="${pageContext.request.contextPath}/uploads/profiles/${student.image}"
                                 alt="Profile Photo" />
                        </c:when>
                        <c:otherwise>
                            <i class="ri-user-line"></i>
                        </c:otherwise>
                    </c:choose>
                </a>
            </div>

            <%-- ── Row 1: Schedule + Profile card ── --%>
            <div class="sk-row">

                <%-- Today's Schedule --%>
                <div class="sk-card sk-card-schedule">
                    <div class="sk-card-schedule-header">
                        <p class="sk-today-label">
                            Today's schedule
                            <c:if test="${not empty todayDay}">
                                &nbsp;— <strong>${todayDay}</strong>
                            </c:if>
                        </p>
                        <a href="${pageContext.request.contextPath}/student/schedule"
                           class="sk-view-all">View all</a>
                    </div>

                    <c:choose>
                        <c:when test="${empty todaySchedule}">
                            <p class="sk-schedule-empty">No classes scheduled for ${todayDay}.</p>
                        </c:when>
                        <c:otherwise>
                            <table class="sk-schedule-table">
                                <thead>
                                    <tr>
                                        <th>START</th>
                                        <th>END</th>
                                        <th>MODULE</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- s.startTime  → ScheduleModel.getStartTime()  → DB: start_time --%>
                                    <%-- s.endTime    → ScheduleModel.getEndTime()    → DB: end_time   --%>
                                    <%-- s.moduleName → ScheduleModel.getModuleName() → DB: module_name (JOIN) --%>
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
                <%-- student.semester   → SettingsStudentModel.getSemester()  → DB: semester (via SettingsStudentModel) --%>
                <%-- student.fullName   → SettingsStudentModel.getFullName()  → firstName + lastName --%>
                <div class="sk-card sk-card-profile">
                    <i class="ri-graduation-cap-line"></i>
                    <span class="sk-profile-sub">Computing</span>
                    <span class="sk-profile-class">${student.semester}</span>
                    <span class="sk-profile-sem">Semester ${student.semester}</span>
                    <span class="sk-profile-name">${student.fullName}</span>
                </div>

            </div>
            <%-- End Row 1 --%>

            <%-- ── Announcements ── --%>
            <div class="sk-card-announce">
                <div class="sk-announcement-header">
                    <h3>Announcement</h3>
                </div>

                <c:choose>
                    <c:when test="${empty announcements}">
                        <div class="sk-empty-state">No announcements yet.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="sk-announcement-container">
                            <%-- a.title          → AnnouncementModel.getTitle()          → DB: title          --%>
                            <%-- a.content        → AnnouncementModel.getContent()        → DB: content        --%>
                            <%-- a.genre          → AnnouncementModel.getGenre()          → DB: genre          --%>
                            <%-- a.imagePath      → AnnouncementModel.getImagePath()      → DB: image_path     --%>
                            <%-- a.attachmentPath → AnnouncementModel.getAttachmentPath() → DB: attachment_path --%>
                            <c:forEach var="a" items="${announcements}">
                                <div class="sk-announcement-card">

                                    <div class="sk-ann-top-row">
                                        <h4 class="sk-announcement-title">${a.title}</h4>
                                        <c:if test="${not empty a.genre}">
                                            <span class="sk-ann-badge sk-ann-badge-${a.genre}">
                                                ${a.genre}
                                            </span>
                                        </c:if>
                                    </div>

                                    <p class="sk-announcement-content">${a.content}</p>

                                    <c:if test="${not empty a.imagePath}">
                                        <img src="${pageContext.request.contextPath}/uploads/announcements/${a.imagePath}"
                                             alt="Announcement Image"
                                             class="sk-ann-image" />
                                    </c:if>

                                    <c:if test="${not empty a.attachmentPath}">
                                        <a href="${pageContext.request.contextPath}/uploads/announcements/${a.attachmentPath}"
                                           class="sk-ann-attachment"
                                           target="_blank">
                                            <i class="ri-attachment-2"></i> View Attachment
                                        </a>
                                    </c:if>

                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- ── My Notes ── --%>
            <div class="sk-notes-section">
                <h3>My Notes</h3>
                <div class="sk-notes-row">

                    <div class="sk-notes-area">
                        <%-- n.noteTitle → Notes.getNoteTitle() → DB: note_title --%>
                        <c:choose>
                            <c:when test="${empty notes}">
                                <p class="sk-schedule-empty">No notes yet.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="n" items="${notes}">
                                    <p>${n.noteTitle}</p>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/student/notes"
                           class="sk-view-all">View all</a>
                    </div>

                    <div class="sk-new-note">
                        <i class="ri-sticky-note-add-line"></i>
                        <p>Create new note</p>
                        <a href="${pageContext.request.contextPath}/student/notes/create"
                           class="sk-btn">Create</a>
                    </div>

                </div>
            </div>

        </main>
        <%-- End Main --%>

    </div>
    <%-- Footer inside .sk-page so CSS selectors apply --%>
    <jsp:include page="/WEB-INF/_footer.jsp"/>
</div>

</body>
</html>
