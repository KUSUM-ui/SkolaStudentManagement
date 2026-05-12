<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Class Reservation</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
  <div class="sk-app">

    <jsp:include page="_sidebar_student.jsp">
      <jsp:param name="activePage" value="class"/>
    </jsp:include>

    <main class="sk-main">

      <!-- Topbar -->
      <div class="sk-topbar">
        <h2>Class Reservation</h2>
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

      <!-- Reservation Form Card -->
      <div class="sk-clsres-form-card">
        <form method="post" action="${pageContext.request.contextPath}/classReservation">

          <!-- First Name -->
          <div class="sk-clsres-field">
            <label class="sk-clsres-label" for="firstName">First Name</label>
            <input class="sk-clsres-input" type="text" id="firstName" name="firstName" value="${param.firstName}"/>
          </div>

          <!-- Date + Time row -->
          <div class="sk-clsres-row">
            <div class="sk-clsres-field sk-clsres-field-date">
              <label class="sk-clsres-label" for="resDate">Date</label>
              <input class="sk-clsres-input" type="date" id="resDate" name="resDate" value="${param.resDate}"/>
            </div>
            <div class="sk-clsres-field sk-clsres-field-time">
              <label class="sk-clsres-label">Time</label>
              <div class="sk-clsres-time-row">
                <input class="sk-clsres-input sk-clsres-time-input" type="time" id="timeFrom" name="timeFrom" value="${param.timeFrom}"/>
                <span class="sk-clsres-to">to</span>
                <input class="sk-clsres-input sk-clsres-time-input" type="time" id="timeTo" name="timeTo" value="${param.timeTo}"/>
              </div>
            </div>
          </div>

          <!-- Comment -->
          <div class="sk-clsres-field">
            <label class="sk-clsres-label" for="comment">Comment</label>
            <textarea class="sk-clsres-textarea" id="comment" name="comment" rows="5"><c:out value="${param.comment}"/></textarea>
          </div>

          <!-- Submit -->
          <div class="sk-clsres-submit-row">
            <button class="sk-clsres-submit-btn" type="submit">Add to Reservation list</button>
          </div>

        </form>
      </div>

      <!-- Status Section -->
      <div class="sk-clsres-status-wrap">
        <div class="sk-clsres-status-title">Status</div>
        <div class="sk-clsres-status-table-wrap">
          <table class="sk-clsres-status-table">
            <thead>
              <tr>
                <th class="sk-clsres-status-th">Name</th>
                <th class="sk-clsres-status-th">Date</th>
                <th class="sk-clsres-status-th">Time</th>
                <th class="sk-clsres-status-th">Comment</th>
                <th class="sk-clsres-status-th">Status</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${not empty reservationList}">
                  <c:forEach var="res" items="${reservationList}">
                    <tr class="sk-clsres-status-tr">
                      <td class="sk-clsres-status-td">${res.firstName}</td>
                      <td class="sk-clsres-status-td">${res.resDate}</td>
                      <td class="sk-clsres-status-td">${res.timeFrom} - ${res.timeTo}</td>
                      <td class="sk-clsres-status-td">${res.comment}</td>
                      <td class="sk-clsres-status-td">${res.status}</td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td class="sk-clsres-status-td sk-clsres-status-empty" colspan="5"></td>
                  </tr>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>
        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>