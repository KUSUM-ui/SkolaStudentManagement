<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Student Requests</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
      <jsp:param name="activePage" value="clubs"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Student requests</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-sreq-list">

        <c:forEach var="req" items="${studentRequests}">
          <div class="sk-sreq-card">

            <div class="sk-sreq-avatar">
              <c:choose>
                <c:when test="${not empty req.photoUrl}">
                  <img src="${req.photoUrl}" alt="${req.fullName}"/>
                </c:when>
                <c:otherwise>
                  <i class="ri-image-line"></i>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="sk-sreq-info">
              <h3 class="sk-sreq-name">${req.fullName}</h3>
              <p class="sk-sreq-course">${req.course}</p>
              <div class="sk-sreq-details">
                <div class="sk-sreq-col">
                  <p><span>Club:</span> ${req.clubName}</p>
                  <p><span>Phone number:</span> ${req.phone}</p>
                </div>
                <div class="sk-sreq-col">
                  <p><span>Email:</span> ${req.email}</p>
                  <p><span>Date:</span> ${req.requestDate}</p>
                </div>
              </div>
            </div>

            <div class="sk-sreq-action">
              <form method="post" action="${pageContext.request.contextPath}/admin/clubs/approve">
                <input type="hidden" name="requestId" value="${req.id}"/>
                <button type="submit" class="sk-btn sk-sreq-approve-btn">Approve</button>
              </form>
            </div>

          </div>
        </c:forEach>

        <c:if test="${empty studentRequests}">
          <p class="sk-sreq-empty">No pending student requests.</p>
        </c:if>

      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>