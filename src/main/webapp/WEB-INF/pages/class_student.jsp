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
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/class.css"/>
</head>
<body class="sk-page sk-student">

<div class="sk-app">

  
    <jsp:include page="/WEB-INF/fragments/_sidebar_student.jsp">
        <jsp:param name="activePage" value="classes"/>
    </jsp:include>


    <main class="sk-main" style="background: #FFF5F5;">

        <div class="sk-topbar">
            <h2>Class Reservation</h2>
           
            <a href="${pageContext.request.contextPath}/student/settings" class="sk-avatar">
                <c:choose>
                    <c:when test="${not empty student.image}">
                        <img src="${pageContext.request.contextPath}/${student.image}" alt="${student.firstName}" />
                    </c:when>
                    <c:otherwise>
                        <i class="ri-user-3-line"></i>
                    </c:otherwise>
                </c:choose>
            </a>
        </div>

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

     
        <div class="sk-card">
            <p class="sk-section-title">
                <i class="ri-calendar-check-line"></i> New Reservation
            </p>

            <form action="${pageContext.request.contextPath}/student/classes" method="post" class="sk-reservation-form">

               
                <div class="sk-form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" value="${student.firstName}" />
                </div>

              
                <div class="sk-form-group">
                    <label for="classId">Class</label>
                    <div class="sk-select-wrap">
                        <select id="classId" name="classId" class="sk-class-select">
                            <option value="" disabled selected>Select a class</option>
                            <c:forEach var="c" items="${classes}">
                                <option value="${c.classId}">${c.className}</option>
                            </c:forEach>
                        </select>
                        <i class="ri-arrow-down-s-line"></i>
                    </div>
                </div>

         
                <div class="sk-form-row">
                    <div class="sk-form-group">
                        <label for="date">Date</label>
                        <input type="date" id="date" name="date" />
                    </div>

                    <div class="sk-form-group">
                        <label>Time</label>
                        <div class="sk-time-row">
                            <input type="time" id="timeFrom" name="timeFrom" />
                            <span>to</span>
                            <input type="time" id="timeTo" name="timeTo" />
                        </div>
                    </div>
                </div>

               
                <div class="sk-form-group">
                    <label for="comment">Comment</label>
                    <textarea id="comment" name="comment" rows="4"></textarea>
                </div>

                <div class="sk-form-actions">
                    <button type="submit">
                        <i class="ri-send-plane-line"></i> Add to Reservation List
                    </button>
                </div>

            </form>
        </div>
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
                                                <span class="sk-status-pill approved">Approved</span>
                                            </c:when>
                                            <c:when test="${r.status == 'Disapproved' || r.status == 'Rejected'}">
                                                <span class="sk-status-pill disapproved">Disapproved</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="sk-status-pill pending">Pending</span>
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

<jsp:include page="/WEB-INF/fragments/_footer_student.jsp"/>

</body>
</html>