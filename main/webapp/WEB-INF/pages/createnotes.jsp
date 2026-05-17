<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Create Notes</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notes.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
  <div class="sk-app">

    <jsp:include page="_sidebar_student.jsp">
      <jsp:param name="activePage" value="notes"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <div class="sk-on-back-row">
          <a href="${pageContext.request.contextPath}/student/notes" class="sk-on-back">
            <i class="ri-arrow-left-s-line"></i> Create note
          </a>
        </div>
        <div class="sk-search">
          <i class="ri-search-line"></i>
          <span>Search</span>
        </div>
      </div>

      <c:if test="${not empty noteSuccess}">
        <p class="sk-msg-success">${noteSuccess}</p>
        <c:remove var="noteSuccess" scope="session"/>
      </c:if>

      <c:if test="${not empty noteError}">
        <p class="sk-msg-error">${noteError}</p>
        <c:remove var="noteError" scope="session"/>
      </c:if>

      <form action="${pageContext.request.contextPath}/student/notes/create"
            method="post" class="sk-cn-form">

        <input type="text" name="title" placeholder="Title" class="sk-cn-title"
               value="${not empty param.title ? param.title : ''}"/>

        <textarea name="body" placeholder="Create new note" class="sk-cn-body"></textarea>

        <div class="sk-cn-btn-row">
          <button type="submit" class="sk-btn" style="padding:9px 28px;">Save</button>
          <button type="button" class="sk-cn-exit"
                  onclick="location.href='${pageContext.request.contextPath}/student/notes'">Exit</button>
        </div>

      </form>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>