<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Class Reservation</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css">
</head>

<body class="sk-page">
<div class="sk-app">
    <jsp:include page="_sidebar_student.jsp">
        <jsp:param name="activePage" value="class"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
            <h2>Class Reservation</h2>
            <div class="sk-clsres-search-wrap">
                <i class="ri-search-line"></i>
                <input type="text" class="sk-clsres-search" placeholder="Search">
            </div>
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
        <div class="sk-clsres-form-card">
            <form action="${pageContext.request.contextPath}/ClassReservationServlet"
                  method="post">

                <div class="sk-clsres-field">
                    <label class="sk-clsres-label" for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName"
                           class="sk-clsres-input">
                </div>

                <div class="sk-clsres-field">
                    <label class="sk-clsres-label" for="classId">Class</label>
                    <select id="classId" name="classId" class="sk-clsres-input">
                        <option value="">-- Select a Class --</option>
                        <c:forEach var="cls" items="${classes}">
                            <option value="${cls.classId}">${cls.className}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="sk-clsres-row">
                    <div class="sk-clsres-field sk-clsres-field-date">
                        <label class="sk-clsres-label" for="date">Date</label>
                        <input type="date" id="date" name="date"
                               class="sk-clsres-input">
                    </div>

                    <div class="sk-clsres-field sk-clsres-field-time">
                        <label class="sk-clsres-label">Time</label>
                        <div class="sk-clsres-time-row">
                            <input type="time" id="timeFrom" name="timeFrom"
                                   class="sk-clsres-input sk-clsres-time-input">
                            <span class="sk-clsres-to">to</span>
                            <input type="time" id="timeTo" name="timeTo"
                                   class="sk-clsres-input sk-clsres-time-input">
                        </div>
                    </div>
                </div>

                <div class="sk-clsres-field">
                    <label class="sk-clsres-label" for="comment">Comment</label>
                    <textarea id="comment" name="comment"
                              class="sk-clsres-textarea"></textarea>
                </div>

                <div class="sk-clsres-submit-row">
                    <button type="submit" class="sk-clsres-submit-btn">
                        Add to Reservation list
                    </button>
                </div>

            </form>
        </div>

        <%-- ════════════════════════════════════════
             STATUS TABLE
             ════════════════════════════════════════ --%>
        <div class="sk-clsres-status-wrap">
            <div class="sk-clsres-status-title">Status</div>

            <div class="sk-clsres-status-table-wrap">
                <table class="sk-clsres-status-table">
                    <thead>
                        <tr>
                            <th class="sk-clsres-status-th">Name</th>
                            <th class="sk-clsres-status-th">Class</th>
                            <th class="sk-clsres-status-th">Date</th>
                            <th class="sk-clsres-status-th">Time</th>
                            <th class="sk-clsres-status-th">Comment</th>
                            <th class="sk-clsres-status-th">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty reservations}">
                                <tr>
                                    <td colspan="6" class="sk-clsres-status-td sk-clsres-status-empty">
                                        No reservations yet.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="r" items="${reservations}">
                                    <tr class="sk-clsres-status-tr">
                                        <td class="sk-clsres-status-td">${r.firstName}</td>
                                        <td class="sk-clsres-status-td">
                                            <c:choose>
                                                <c:when test="${not empty r.className}">${r.className}</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="sk-clsres-status-td">${r.date}</td>
                                        <td class="sk-clsres-status-td">${r.timeRange}</td>
                                        <td class="sk-clsres-status-td">
                                            <c:choose>
                                                <c:when test="${empty r.comment}">-</c:when>
                                                <c:otherwise>${r.comment}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="sk-clsres-status-td">
                                            <c:choose>
                                                <c:when test="${empty r.status}">
                                                    <span class="sk-status sk-status-pending">Pending</span>
                                                </c:when>
                                                <c:when test="${r.status eq 'Approved'}">
                                                    <span class="sk-status sk-status-approved">Approved</span>
                                                </c:when>
                                                <c:when test="${r.status eq 'Disapproved'}">
                                                    <span class="sk-status sk-status-disapproved">Disapproved</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="sk-status sk-status-pending">${r.status}</span>
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
        </div>

    </main>
</div>

<jsp:include page="_footer.jsp"/>
</body>
</html>