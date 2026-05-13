<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Skola - Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css" />
</head>

<%
  String adminName     = "Admin";
  String[] clubApplicants = {"Name", "Name", "Name", "Name", "Name", "Name"};
%>

<body class="sk-page sk-admin">
<div class="sk-app">

  <!-- ── SIDEBAR ── -->
  <jsp:include page="/WEB-INF/_sidebar_admin.jsp">
    <jsp:param name="activePage" value="dashboard"/>
  </jsp:include>

  <!-- ── MAIN ── -->
  <main class="sk-main">

    <!-- Topbar -->
    <div class="sk-topbar">
      <h2>Welcome, <%= adminName %>.</h2>
      <div class="sk-avatar"><i class="ri-user-line"></i></div>
    </div>

    <!-- Announcement + Faculty stat -->
    <div class="sk-row">
      <div class="sk-card sk-announce-box">
        <div class="sk-announce-header">
          <span>Post new announcement</span>
          <a href="${pageContext.request.contextPath}/admin/announcements" class="sk-btn">View all</a>
        </div>
        <textarea placeholder="Write here......"></textarea>
        <div class="sk-announce-footer">
          <i class="ri-image-add-line"></i>
          <button class="sk-btn-outline">Post</button>
        </div>
      </div>

      <div class="sk-card sk-stat-card">
        <i class="ri-graduation-cap-line"></i>
        <span class="sk-stat-label">Faculty Members</span>
        <span class="sk-stat-count">1142</span>
        <span class="sk-stat-desc">Active distinguished educators across 12 academic departments.</span>
      </div>
    </div>

    <!-- Action cards + Recent activities -->
    <div class="sk-mid-row">
      <div class="sk-mid-left">

        <div class="sk-row">
          <div class="sk-card sk-action-card">
            <span>Manage Schedule</span>
            <i class="ri-calendar-check-line"></i>
          </div>
          <div class="sk-card sk-action-card">
            <span>View student details</span>
            <i class="ri-file-search-line"></i>
          </div>
        </div>

        <!-- Club registrations -->
        <div class="sk-club-section">
          <h3>New club registrations</h3>
          <div class="sk-club-table">
            <%
              for (String name : clubApplicants) {
            %>
            <div class="sk-club-row">
              <span><%= name %></span>
              <div class="sk-club-actions">
                <button class="sk-btn">Approve</button>
                <button class="sk-btn-outline">View details</button>
              </div>
            </div>
            <% } %>
          </div>
          <div class="sk-view-all-link">View all</div>
        </div>

      </div>

      <div class="sk-mid-right">
        <div class="sk-recent-label">Recent activities</div>
        <div class="sk-recent-box"></div>
      </div>
    </div>

  </main>
</div>

<!-- ── FOOTER ── -->
<jsp:include page="/WEB-INF/_footer.jsp"/>

</body>
</html>
