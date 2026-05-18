<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Reservation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
</head>

<body class="sk-page">
<div class="sk-app">
    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="class"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
    		<h2>Class Reservation</h2>
    		<a href="${pageContext.request.contextPath}/studentProfileServlet" style="text-decoration:none; color:inherit; margin-left:auto;">
        	<div class="sk-avatar"><i class="ri-user-line"></i></div>
    		</a>
		</div>
        <%-- ── Feedback ── --%>
        <c:if test="${not empty success}">
            <div class="sk-alert sk-alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="sk-alert sk-alert-error">${error}</div>
        </c:if>

        <%-- ════════════════════════════════════════
             RESERVATION FORM
             ════════════════════════════════════════ --%>
        <div class="sk-card">
            <form action="${pageContext.request.contextPath}/ClassReservationServlet"
                  method="post" class="sk-reservation-form">

                <div>
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName"
                           value="${student.firstName}" required>
                </div>

                <div class="sk-form-row">
                    <div>
                        <label for="date">Date</label>
                        <input type="date" id="date" name="date" required>
                    </div>

                    <div>
                        <label>Time</label>
                        <div class="sk-time-row">
                            <input type="time" id="timeFrom" name="timeFrom" required>
                            <span>to</span>
                            <input type="time" id="timeTo" name="timeTo" required>
                        </div>
                    </div>
                </div>

                <div>
                    <label for="comment">Comment</label>
                    <textarea id="comment" name="comment" rows="5"></textarea>
                </div>

                <div class="sk-form-actions">
                    <button type="submit" class="sk-btn">Add to Reservation list</button>
                </div>

            </form>
        </div>

        <%-- ════════════════════════════════════════
             STATUS TABLE
             ════════════════════════════════════════ --%>
        <div class="sk-card">
            <h3>Status</h3>

            <table class="sk-table">
                <thead>
                    <tr>
                        <th>Name</th>
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
                <td colspan="5" class="sk-empty">
                    No reservations yet.
                </td>
            </tr>
        </c:when>

        <c:otherwise>
            <c:forEach var="r" items="${reservations}">
                <tr>

                    <td>${r.firstName}</td>

                    <td>${r.date}</td>

                    <td>${r.timeRange}</td>

                    <td>
                        <c:choose>
                            <c:when test="${empty r.comment}">
                                -
                            </c:when>
                            <c:otherwise>
                                ${r.comment}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>

                            <c:when test="${empty r.status}">
                                <span class="sk-status">
                                    Pending
                                </span>
                            </c:when>

                            <c:otherwise>
                                <span class="sk-status">
                                    ${r.status}
                                </span>
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

<jsp:include page="footer.jsp"/>
</body>
</html>
