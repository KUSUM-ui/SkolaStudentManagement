<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Skola - Announcements</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skola.css" />
</head>

<%
  // Replace with DB fetch
  String[] announcements = {
    "Announcement 1", "Announcement 1", "Announcement 1",
    "Announcement 1", "Announcement 1", "Announcement 1",
    "Announcement 1", "Announcement 1"
  };
%>

<body class="sk-page sk-announce-page">
<div class="sk-app">

	  <!-- ── SIDEBAR ── -->
	<jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
	    <jsp:param name="activePage" value="announcements"/>
	</jsp:include>

  <!-- ── MAIN ── -->
  <main class="sk-main">

    <!-- Topbar -->
    <div class="sk-topbar">
      <h2>Announcements</h2>
      <div class="sk-avatar"><i class="ri-user-line"></i></div>
    </div>

    <!-- Post announcement -->
    <div class="sk-announce-form-box">
      <span>Post new announcement</span>
      <textarea placeholder="Write here..."></textarea>
      <div class="sk-announce-form-footer">
        <i class="ri-image-add-line"></i>
        <i class="ri-attachment-line"></i>
        <button class="sk-btn" style="margin-left:auto;">Post</button>
      </div>
    </div>

    <!-- Recent announcements list -->
    <div class="sk-announce-list-label">Recent announcements</div>
    <div class="sk-announce-list">
      <%
        for (String ann : announcements) {
      %>
      <div class="sk-announce-item"><%= ann %></div>
      <% } %>
    </div>

  </main>
</div>

<!-- ── FOOTER ── -->
<jsp:include page="/WEB-INF/fragments/_footer.jsp"/>

</body>
</html>
