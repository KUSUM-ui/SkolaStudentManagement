<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA – About Us</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">

  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/aboutus.css" />
</head>

<body>

<jsp:include page="/WEB-INF/header.jsp">
    <jsp:param name="activePage" value="about"/>
</jsp:include>

<!-- HERO SECTION -->
<section class="au-hero">

  <div class="au-hero-text">
    <h2>About us</h2>
    <p>
      Skola is a smart student management platform designed to simplify academic life.
      It helps students manage schedules, notes, and activities in one place.
    </p>
  </div>

  <div class="au-hero-image">
    <img src="<%=request.getContextPath()%>/resources/images/abtus.png"
         alt="Students studying" />
  </div>

</section>

<!-- STATS -->
<section class="au-stats">

  <div class="au-stat-item">
    <span class="au-stat-number">${institutionCount}</span>
    <span class="au-stat-label">Institutions</span>
  </div>

  <div class="au-stat-item">
    <span class="au-stat-number">${activeStudents}</span>
    <span class="au-stat-label">Active students</span>
  </div>

  <div class="au-stat-item">
    <span class="au-stat-number">${efficiencyRate}</span>
    <span class="au-stat-label">Efficiency rate</span>
  </div>

  <div class="au-stat-item">
    <span class="au-stat-number">${userRating}</span>
    <span class="au-stat-label">User rating</span>
  </div>

</section>

<!-- WHAT SKOLA DOES -->
<section class="au-what">
  <h2>What Skola does</h2>
  <p>
    Skola helps students manage academic activities, notes, schedules, and club participation
    in a centralized system.
  </p>
</section>

<!-- TEAM SECTION (FIXED - NO SCRIPTLET ISSUES) -->
<section class="au-team">

  <h2>Meet the Team</h2>

  <div class="au-team-grid">

    <c:choose>
      <c:when test="${not empty teamNames}">

        <c:forEach var="i" begin="0" end="${teamNames.size()-1}">

          <div class="au-team-card">

            <div class="au-team-photo">
              <img src="${pageContext.request.contextPath}/resources/images/${teamPhotos[i]}"
                   alt="${teamNames[i]}" />
            </div>

            <button class="au-team-name">
              ${teamNames[i]}
            </button>

          </div>

        </c:forEach>

      </c:when>

      <c:otherwise>

        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 1</button>
        </div>

        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 2</button>
        </div>

        <div class="au-team-card">
          <div class="au-team-photo"></div>
          <button class="au-team-name">Member 3</button>
        </div>

      </c:otherwise>

    </c:choose>

  </div>

</section>

<!-- FOOTER -->
<jsp:include page="/WEB-INF/footer.jsp"/>

</body>
</html>