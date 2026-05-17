<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Notes</title>
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
        <h2>Welcome, ${sessionScope.first_name}</h2>
        <form action="${pageContext.request.contextPath}/student/notes" method="get" class="sk-search">
          <i class="ri-search-line"></i>
          <input type="text" name="search" placeholder="Search notes..."
                 value="${param.search}"
                 style="border:none; outline:none; background:transparent; width:100%; font-size:13px; font-family:inherit;"/>
        </form>
      </div>

      <c:if test="${not empty noteSuccess}">
        <p class="sk-msg-success">${noteSuccess}</p>
        <c:remove var="noteSuccess" scope="session"/>
      </c:if>

      <c:if test="${not empty noteError}">
        <p class="sk-msg-error">${noteError}</p>
        <c:remove var="noteError" scope="session"/>
      </c:if>

      <!-- PINNED NOTES ROW -->
      <c:if test="${not empty notesList}">
        <div class="sk-notes-pinned-row">
          <c:forEach var="note" items="${notesList}" end="3">
            <a href="${pageContext.request.contextPath}/student/notes/view?id=${note.noteId}" class="sk-note-pin-card">
              <c:out value="${note.noteTitle}"/>
            </a>
          </c:forEach>
        </div>
      </c:if>

      <!-- CREATE NEW BUTTON -->
      <div class="sk-notes-create-row">
        <a href="${pageContext.request.contextPath}/student/notes/create" class="sk-notes-create-btn">
          + &nbsp; Create new
        </a>
      </div>

      <!-- ALL NOTES LIST -->
      <div class="sk-notes-list-section">
        <p class="sk-notes-list-label">All notes</p>

        <div class="sk-notes-list">
          <c:choose>
            <c:when test="${empty notesList}">
              <c:choose>
                <c:when test="${not empty param.search}">
                  <p class="sk-notes-empty">No notes found for "<c:out value="${param.search}"/>".</p>
                </c:when>
                <c:otherwise>
                  <p class="sk-notes-empty">No notes available.</p>
                </c:otherwise>
              </c:choose>
            </c:when>
            <c:otherwise>
              <c:forEach var="note" items="${notesList}">
                <a href="${pageContext.request.contextPath}/student/notes/view?id=${note.noteId}" class="sk-note-item">
                  <span class="sk-note-title"><c:out value="${note.noteTitle}"/></span>
                  <span class="sk-note-date">
                    <fmt:formatDate value="${note.noteCreatedAt}" pattern="dd MMM, yyyy"/>
                  </span>
                </a>
                <hr class="sk-note-divider"/>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>

      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>