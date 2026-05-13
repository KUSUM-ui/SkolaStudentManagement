<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>student - notes</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css">
</head>
<body>

<div class="sk-page sk-student">

  <div class="sk-app">

    <!-- SIDEBAR -->
    <%@ include file="sidebar.jsp" %>

    <!-- MAIN -->
    <main class="sk-main">

      <!-- TOPBAR -->
      <div class="sk-topbar">
        <h2>Welcome, </h2>
        <div class="sk-search">
          <i class="ri-search-line"></i>
          <span>Search</span>
        </div>
      </div>

      <!-- PINNED NOTES ROW -->
      <div class="sk-notes-pinned-row">
        <div class="sk-note-pin-card">Title</div>
        <div class="sk-note-pin-card">Title</div>
        <div class="sk-note-pin-card">Title</div>
        <div class="sk-note-pin-card">Title</div>
      </div>

      <!-- CREATE NEW BUTTON -->
      <div class="sk-notes-create-row">
        <button class="sk-notes-create-btn" onclick="location.href='createnotes.jsp'">+ &nbsp; Create new</button>
      </div>

      <!-- ALL NOTES LIST -->
      <div class="sk-notes-list-section">
        <p class="sk-notes-list-label">All notes</p>

        <div class="sk-notes-list">
          <div class="sk-note-item">
            <span class="sk-note-title">Title</span>
            <span class="sk-note-date">11 May, 2026</span>
          </div>
          <hr class="sk-note-divider"/>
          <div class="sk-note-item">
            <span class="sk-note-title">Title</span>
            <span class="sk-note-date">11 May, 2026</span>
          </div>
          <hr class="sk-note-divider"/>
        </div>
      </div>

    </main>

  </div><!-- end sk-app -->

  <!-- FOOTER -->
  <%@ include file="footer.jsp" %>

</div><!-- end sk-page -->

</body>
</html>
    