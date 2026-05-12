<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Class Reservations</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
      <jsp:param name="activePage" value="class"/>
    </jsp:include>

    <main class="sk-main">

      <!-- Topbar -->
      <div class="sk-topbar">
        <h2>Profile</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <!-- Reservations Table -->
      <div class="sk-acr-table-wrap">
        <table class="sk-acr-table">
          <thead>
            <tr>
              <th class="sk-acr-th">Name</th>
              <th class="sk-acr-th">Date</th>
              <th class="sk-acr-th">Time</th>
              <th class="sk-acr-th">Comment</th>
              <th class="sk-acr-th">Approval</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty reservationList}">
                <c:forEach var="res" items="${reservationList}">
                  <tr class="sk-acr-tr">
                    <td class="sk-acr-td">${res.firstName}</td>
                    <td class="sk-acr-td">${res.resDate}</td>
                    <td class="sk-acr-td">${res.timeFrom} - ${res.timeTo}</td>
                    <td class="sk-acr-td">${not empty res.comment ? res.comment : '-'}</td>
                    <td class="sk-acr-td sk-acr-td-actions">
                      <div class="sk-acr-btn-group">
                        <form method="post" action="${pageContext.request.contextPath}/classReservation/approve">
                          <input type="hidden" name="reservationId" value="${res.id}"/>
                          <button class="sk-acr-approve-btn" type="submit">Approve</button>
                        </form>
                        <form method="post" action="${pageContext.request.contextPath}/classReservation/disapprove">
                          <input type="hidden" name="reservationId" value="${res.id}"/>
                          <button class="sk-acr-disapprove-btn" type="submit">Disapprove</button>
                        </form>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <!-- Placeholder rows matching design -->
                <tr class="sk-acr-tr">
                  <td class="sk-acr-td">Shine amgain</td>
                  <td class="sk-acr-td">15 May. 2026</td>
                  <td class="sk-acr-td">11:00am-2:00pm</td>
                  <td class="sk-acr-td">-</td>
                  <td class="sk-acr-td sk-acr-td-actions">
                    <div class="sk-acr-btn-group">
                      <button class="sk-acr-approve-btn" type="button">Approve</button>
                      <button class="sk-acr-disapprove-btn" type="button">Disapprove</button>
                    </div>
                  </td>
                </tr>
                <tr class="sk-acr-tr">
                  <td class="sk-acr-td">Shine amgain</td>
                  <td class="sk-acr-td">15 May. 2026</td>
                  <td class="sk-acr-td">11:00am-2:00pm</td>
                  <td class="sk-acr-td">-</td>
                  <td class="sk-acr-td sk-acr-td-actions">
                    <div class="sk-acr-btn-group">
                      <button class="sk-acr-approve-btn" type="button">Approve</button>
                      <button class="sk-acr-disapprove-btn" type="button">Disapprove</button>
                    </div>
                  </td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>