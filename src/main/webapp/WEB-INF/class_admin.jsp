<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Reservations – Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
</head>

<body class="sk-page">
<div class="sk-app">
    <jsp:include page="/WEB-INF/_sidebar_admin.jsp">
        <jsp:param name="activePage" value="class"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-header-row">
            <h2>Class Reservations</h2>
        </div>

        <%-- ── Feedback ── --%>
        <c:if test="${not empty success}">
            <div class="sk-alert sk-alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="sk-alert sk-alert-error">${error}</div>
        </c:if>

        <%-- ════════════════════════════════════════
             RESERVATIONS TABLE
             ════════════════════════════════════════ --%>
        <div class="sk-card">
            <table class="sk-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Comment</th>
                        <th>Approval</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty reservations}">
                            <tr>
                                <td colspan="5" class="sk-empty">No reservations found.</td>
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
                                            <c:when test="${empty r.comment}">-</c:when>
                                            <c:otherwise>${r.comment}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status eq 'Approved' or r.status eq 'Disapproved'}">
                                                <span class="sk-status sk-status-${r.status.toLowerCase()}">${r.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/AdminClassServlet"
                                                      method="post" class="sk-action-form">
                                                    <input type="hidden" name="reservationId" value="${r.reservationId}">
                                                    <input type="hidden" name="action" value="Approved">
                                                    <button type="submit" class="sk-btn">Approve</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/AdminClassServlet"
                                                      method="post" class="sk-action-form">
                                                    <input type="hidden" name="reservationId" value="${r.reservationId}">
                                                    <input type="hidden" name="action" value="Disapproved">
                                                    <button type="submit" class="sk-btn-outline">Disapprove</button>
                                                </form>
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

<jsp:include page="/WEB-INF/_footer.jsp"/>
</body>
</html>
