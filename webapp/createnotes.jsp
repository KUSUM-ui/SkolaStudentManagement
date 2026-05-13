<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>student - Createnotes</title>
  <link rel="stylesheet" type="text/css" href="skola.css">
</head>
<body>

<div class="sk-page sk-student">

  <div class="sk-app">

    <%@ include file="sidebar.jsp" %>

    <main class="sk-main">

      <div class="sk-topbar">
        <div class="sk-on-back-row">
          <a href="notes.jsp" class="sk-on-back">
            <i class="ri-arrow-left-s-line"></i> Create note
          </a>
        </div>
        <div class="sk-search">
          <i class="ri-search-line"></i>
          <span>Search</span>
        </div>
      </div>

      <form action="${pageContext.request.contextPath}/student/notes/save"
            method="post" class="sk-cn-form">

        <input type="text" name="title" placeholder="Title" class="sk-cn-title"/>

        <textarea name="body" placeholder="Create new note" class="sk-cn-body"></textarea>

        <div class="sk-cn-btn-row">
          <button type="submit" class="sk-btn" style="padding:9px 28px;">Save</button>
          <button type="button" class="sk-cn-exit"
                  onclick="location.href='notes.jsp'">Exit</button>
        </div>

      </form>

    </main>

  </div>

  <%@ include file="footer.jsp" %>

</div>

</body>
</html>
    