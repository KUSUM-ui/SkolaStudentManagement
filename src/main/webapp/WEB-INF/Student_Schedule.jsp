<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Schedule</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/_sidebar_student.jsp">
      <jsp:param name="activePage" value="schedule"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Schedule</h2>
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

      <!-- Section label -->
      <div class="sk-stusch-section-label">Section - Schedule</div>

      <!-- Schedule Table -->
      <div class="sk-stusch-table-wrap">
        <table class="sk-stusch-table">
          <thead>
            <tr>
              <th class="sk-stusch-th sk-stusch-th-day">Day</th>
              <th class="sk-stusch-th">Start - Time</th>
              <th class="sk-stusch-th">End - Time</th>
              <th class="sk-stusch-th">Module</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty scheduleList}">
                <c:forEach var="sch" items="${scheduleList}">
                  <tr class="sk-stusch-tr">
                    <td class="sk-stusch-td sk-stusch-td-day">${sch.day}</td>
                    <td class="sk-stusch-td">${sch.startTime}</td>
                    <td class="sk-stusch-td">${sch.endTime}</td>
                    <td class="sk-stusch-td sk-stusch-td-module">${sch.moduleName}</td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <tr class="sk-stusch-tr">
                  <td class="sk-stusch-td sk-stusch-td-day">Sunday</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td sk-stusch-td-module">Module1</td>
                </tr>
                <tr class="sk-stusch-tr">
                  <td class="sk-stusch-td sk-stusch-td-day">Sunday</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td sk-stusch-td-module">Module2</td>
                </tr>
                <tr class="sk-stusch-tr">
                  <td class="sk-stusch-td sk-stusch-td-day">Sunday</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td sk-stusch-td-module">Module 3</td>
                </tr>
                <tr class="sk-stusch-tr">
                  <td class="sk-stusch-td sk-stusch-td-day">Sunday</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td sk-stusch-td-module">Module 4</td>
                </tr>
                <tr class="sk-stusch-tr">
                  <td class="sk-stusch-td sk-stusch-td-day">Monday</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td">00:00</td>
                  <td class="sk-stusch-td sk-stusch-td-module">Module 4</td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

    </main>
  </div>

  <jsp:include page="/WEB-INF/_footer.jsp" />

</div>

</body>
</html>