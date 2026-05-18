<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Reservations – Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css">
</head>

<body class="sk-page">
<div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
        <jsp:param name="activePage" value="classes"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
            <h2>Class Reservations</h2>
        </div>

        <c:if test="${not empty success}">
            <div class="sk-alert sk-alert-success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="sk-alert sk-alert-error">${error}</div>
        </c:if>

        <div class="sk-card">
            <table class="sk-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Class</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Comment</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty reservations}">
                            <tr>
                                <td colspan="7" class="sk-empty">
                                    No reservations found.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="r" items="${reservations}">
                                <tr>

                                    <td>${r.firstName}</td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty r.className}">${r.className}</c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>

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
                                            <c:when test="${r.status eq 'Approved'}">
                                                <span class="sk-status sk-status-approved">Approved</span>
                                            </c:when>
                                            <c:when test="${r.status eq 'Disapproved'}">
                                                <span class="sk-status sk-status-disapproved">Disapproved</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="sk-status sk-status-pending">Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status eq 'Approved' or r.status eq 'Disapproved'}">
                                                <span style="font-size:13px; color:var(--muted);">Done</span>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/admin/classes"
                                                      method="post" class="sk-action-form">
                                                    <input type="hidden" name="reservationId" value="${r.reservationId}">
                                                    <input type="hidden" name="action" value="approve">
                                                    <button type="submit" class="sk-btn sk-btn-success">Approve</button>
                                                </form>

                                                <form action="${pageContext.request.contextPath}/admin/classes"
                                                      method="post" class="sk-action-form">
                                                    <input type="hidden" name="reservationId" value="${r.reservationId}">
                                                    <input type="hidden" name="action" value="reject">
                                                    <button type="submit" class="sk-btn sk-btn-danger">Disapprove</button>
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

<jsp:include page="_footer.jsp"/>
</body>
</html>