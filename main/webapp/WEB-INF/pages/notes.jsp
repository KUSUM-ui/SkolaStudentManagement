<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Notes</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
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
       <h2>Welcome, Student</h2>
        <div class="sk-notes-topbar-right">
          <div class="sk-search">
            <i class="ri-search-line"></i>
            <span>Search</span>
          </div>
          <div class="sk-avatar">
            <img src="${pageContext.request.contextPath}/img/student-avatar.png"
                 alt="Student"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
            <i class="ri-user-line" style="display:none;"></i>
          </div>
        </div>
      </div>

      <c:if test="${not empty errorMsg}">
        <p class="sk-notes-error">${errorMsg}</p>
      </c:if>

      <div class="sk-notes-layout">

        <div class="sk-card sk-notes-list-card">
          <p class="sk-notes-list-title">My Notes</p>
          <c:choose>
            <c:when test="${not empty notesList}">
              <ol class="sk-notes-ol">
                <c:forEach var="note" items="${notesList}">
                  <li class="sk-notes-item">
                    <div class="sk-notes-item-info">
                      <span class="sk-notes-item-title">
                        <c:choose>
                          <c:when test="${not empty note.noteTitle}">${note.noteTitle}</c:when>
                          <c:otherwise>Untitled</c:otherwise>
                        </c:choose>
                      </span>
                      <span class="sk-notes-item-preview">${note.noteContent}</span>
                    </div>
                    <form method="post"
                          action="${pageContext.request.contextPath}/NotesSevlet"
                          class="sk-notes-delete-form">
                      <input type="hidden" name="action" value="delete"/>
                      <input type="hidden" name="noteId" value="${note.noteId}"/>
                      <button type="submit" class="sk-notes-delete-btn" title="Delete note">
                        <i class="ri-delete-bin-6-line"></i>
                      </button>
                    </form>
                  </li>
                </c:forEach>
              </ol>
            </c:when>
            <c:otherwise>
              <p class="sk-notes-empty">No notes yet. Create your first one below.</p>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="sk-card sk-notes-form-card">
          <form method="post"
                action="${pageContext.request.contextPath}/NotesSevlet"
                class="sk-notes-form">
            <input type="hidden" name="action" value="add"/>
            <input
              type="text"
              name="noteTitle"
              class="sk-notes-title-input"
              placeholder="Note title (optional)"/>
            <textarea
              name="noteContent"
              class="sk-notes-textarea"
              placeholder="Create new note..."></textarea>
            <div class="sk-notes-form-footer">
              <button type="submit" class="sk-btn sk-notes-add-btn">Add note</button>
            </div>
          </form>
        </div>

      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp"/>
</div>

</body>
</html>