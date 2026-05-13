<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>student - opennotes</title>
  <link rel="stylesheet" type="text/css" href="skola.css">
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
        <div class="sk-on-back-row">
          <a href="${pageContext.request.contextPath}/student/notes" class="sk-on-back">
            <i class="ri-arrow-left-s-line"></i> My Notes
          </a>
        </div>
        <div class="sk-search">
          <i class="ri-search-line"></i>
          <span>Search</span>
        </div>
      </div>

      <!-- NOTE EDITOR -->
      <div class="sk-on-editor">
        <div class="sk-on-header">
          <span class="sk-on-title">Title</span>
          <a href="${pageContext.request.contextPath}/student/notes/delete?id=${note.id}" class="sk-on-delete">
            <i class="ri-delete-bin-line"></i> Delete
          </a>
        </div>
        <textarea class="sk-on-textarea">Content</textarea>
      </div>

    </main>
  </div>

  <!-- FOOTER -->
  <%@ include file="footer.jsp" %>

</div>
</body>
</html>