<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Class Reservation | Skola</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>

</head>
<body>

<div class="sk-page sk-student">
    <div class="sk-app">

        <%-- ── Sidebar ── --%>
        <jsp:include page="/WEB-INF/_sidebar_student.jsp">
            <jsp:param name="activePage" value="class"/>
        </jsp:include>

        <%-- ── Main ── --%>
        <main class="sk-main">

            <%-- ── Topbar ── --%>
            <div class="sk-topbar">
                <h2>Class Reservation</h2>
                <%-- Profile avatar --%>
                <a href="${pageContext.request.contextPath}/StudentSettingsServlet" class="sk-avatar">
                    <c:choose>
                        <c:when test="${not empty student.image}">
                            <%-- student.image → SettingsStudentModel.getImage() → DB: Student.image --%>
                            <img src="${pageContext.request.contextPath}/uploads/profiles/${student.image}"
                                 alt="Profile" />
                        </c:when>
                        <c:otherwise>
                            <i class="ri-user-line"></i>
                        </c:otherwise>
                    </c:choose>
                </a>
            </div>

            <%-- ── Feedback alerts ── --%>
            <c:if test="${not empty success}">
                <div class="sk-alert sk-alert-success">
                    <i class="ri-checkbox-circle-line"></i> ${success}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="sk-alert sk-alert-error">
                    <i class="ri-error-warning-line"></i> ${error}
                </div>
            </c:if>

            <%-- ── Reservation Form ── --%>
            <div class="sk-card">
                <p class="sk-section-title">
                    <i class="ri-calendar-check-line"></i> New Reservation
                </p>

                <form action="${pageContext.request.contextPath}/student/ClassReservation"
                      method="post"
                      class="sk-reservation-form">

                    <%-- First Name --%>
                    <div>
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName"
                               value="${student.firstName}" required />
                    </div>

                    <%-- Class dropdown --%>
                    <%-- classes → ClassModel list → class.class_id, class.class_name --%>
                    <div>
                        <label for="classId">Class</label>
                        <div class="sk-select-wrap">
                            <select id="classId" name="classId" class="sk-class-select" required>
                                <option value="" disabled selected>Select a class</option>
                                <c:forEach var="c" items="${classes}">
                                    <option value="${c.classId}">${c.className}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <%-- Date + Time row --%>
                    <div class="sk-form-row">
                        <div>
                            <label for="date">Date</label>
                            <input type="date" id="date" name="date" required />
                        </div>

                        <div>
                            <label>Time</label>
                            <div class="sk-time-row">
                                <input type="time" id="timeFrom" name="timeFrom" required />
                                <span>to</span>
                                <input type="time" id="timeTo" name="timeTo" required />
                            </div>
                        </div>
                    </div>

                    <%-- Comment --%>
                    <div>
                        <label for="comment">Comment</label>
                        <textarea id="comment" name="comment" rows="4"></textarea>
                    </div>

                    <div class="sk-form-actions">
                        <button type="submit" class="sk-btn">
                            <i class="ri-send-plane-line"></i> Add to Reservation List
                        </button>
                    </div>

                </form>
            </div>

            <%-- ── Status Table ── --%>
            <div class="sk-card">
                <p class="sk-section-title">
                    <i class="ri-list-check-3"></i> My Reservations
                </p>

                <table class="sk-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Class</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Comment</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty reservations}">
                                <tr>
                                    <td colspan="6" class="sk-empty">No reservations yet.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <%-- r.firstName  → Classreservationmodel.getFirstName()  → DB: first_name  --%>
                                <%-- r.className  → Classreservationmodel.getClassName()  → JOIN: class_name --%>
                                <%-- r.date       → Classreservationmodel.getDate()       → DB: date        --%>
                                <%-- r.timeRange  → Classreservationmodel.getTimeRange()  → DB: time_from, time_to --%>
                                <%-- r.comment    → Classreservationmodel.getComment()    → DB: comment     --%>
                                <%-- r.status     → Classreservationmodel.getStatus()     → DB: status      --%>
                                <c:forEach var="r" items="${reservations}">
                                    <tr>
                                        <td>${r.firstName}</td>
                                        <td>${r.className}</td>
                                        <td>${r.date}</td>
                                        <td>${r.timeRange}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${empty r.comment}">-</c:when>
                                                <c:otherwise>${r.comment}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${r.status == 'Approved'}">
                                                    <span class="sk-status sk-status-approved">Approved</span>
                                                </c:when>
                                                <c:when test="${r.status == 'Disapproved'}">
                                                    <span class="sk-status sk-status-disapproved">Disapproved</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="sk-status sk-status-pending">Pending</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </main>
    </div>

    <%-- Footer inside .sk-page so CSS selectors apply --%>
    <jsp:include page="/WEB-INF/_footer.jsp"/>
</div>

</body>
</html>
