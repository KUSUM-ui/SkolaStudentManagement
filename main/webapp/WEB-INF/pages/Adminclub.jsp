<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Clubs</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
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
        <h2>Clubs</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/images/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-clubs-edit-row">
        <a href="${pageContext.request.contextPath}/admin/clubs/edit-profile"
           class="sk-clubs-edit-link">
          Edit club profile
          <i class="ri-arrow-right-s-line"></i>
        </a>
      </div>

      <div class="sk-row sk-clubs-stat-row">

        <div class="sk-card sk-clubs-bg-card">
          <img class="sk-clubs-card-bg-img"
               src="${pageContext.request.contextPath}/images/inkspiremain.png"
               alt=""/>
          <i class="ri-graduation-cap-line"></i>
          <span class="sk-clubs-stat-name">Inkspire</span>
          <span class="sk-clubs-stat-count">${inkspireCount}</span>
          <span class="sk-clubs-stat-desc">0</span>
        </div>

        <div class="sk-card sk-clubs-bg-card">
          <img class="sk-clubs-card-bg-img"
               src="${pageContext.request.contextPath}/images/web main.png"
               alt=""/>
          <i class="ri-graduation-cap-line"></i>
          <span class="sk-clubs-stat-name">Web<br>Development</span>
          <span class="sk-clubs-stat-count">${webDevCount}</span>
          <span class="sk-clubs-stat-desc">0</span>
        </div>

        <div class="sk-card sk-clubs-bg-card">
          <img class="sk-clubs-card-bg-img"
               src="${pageContext.request.contextPath}/images/sparkedmain.png"
               alt=""/>
          <i class="ri-graduation-cap-line"></i>
          <span class="sk-clubs-stat-name">Sparked</span>
          <span class="sk-clubs-stat-count">${sparkedCount}</span>
          <span class="sk-clubs-stat-desc">0</span>
        </div>

        <div class="sk-card sk-clubs-bg-card">
          <img class="sk-clubs-card-bg-img"
               src="${pageContext.request.contextPath}/images/moneymazemain.png"
               alt=""/>
          <i class="ri-graduation-cap-line"></i>
          <span class="sk-clubs-stat-name">Money<br>Maze</span>
          <span class="sk-clubs-stat-count">${moneyMazeCount}</span>
          <span class="sk-clubs-stat-desc">0</span>
        </div>

      </div>

      <div class="sk-admin sk-club-section">
        <h3>New club registrations</h3>
        <div class="sk-club-table">

          <c:forEach var="reg" items="${newRegistrations}">
            <div class="sk-club-row">
              <span>${reg.studentName}</span>
              <div class="sk-club-actions">
                <form method="post"
                      action="${pageContext.request.contextPath}/admin/clubs/approve"
                      style="display:inline;">
                  <input type="hidden" name="registrationId" value="${reg.registrationId}"/>
                  <input type="hidden" name="studentId"      value="${reg.studentId}"/>
                  <input type="hidden" name="clubId"         value="${reg.clubId}"/>
                  <button type="submit" class="sk-btn">Approve</button>
                </form>
                <a href="${pageContext.request.contextPath}/admin/clubs/request/${reg.registrationId}"
                   class="sk-btn-outline">View details</a>
              </div>
            </div>
          </c:forEach>

          <c:if test="${empty newRegistrations}">
            <div class="sk-club-row">
              <span style="color: var(--muted); font-size: 13px;">No pending registrations.</span>
            </div>
          </c:if>

        </div>
        <div class="sk-view-all-link">
          <a href="${pageContext.request.contextPath}/admin/clubs/requests"
             style="color: var(--muted); text-decoration: none; font-size: 12px;">View all</a>
        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>