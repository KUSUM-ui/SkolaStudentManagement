<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Notes</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notes.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_student.jsp">
      <jsp:param name="activePage" value="notes"/>
    </jsp:include>

    <main class="sk-main" style="background: #FFF5F5;">


      <div class="sk-topbar" style="display: flex; justify-content: space-between; align-items: center;">
        <h2 style="margin: 0;">Welcome, ${not empty sessionScope.studentName ? sessionScope.studentName : 'Student'}</h2>
        
        <div style="display: flex; align-items: center; gap: 20px;">
   
          <form action="${pageContext.request.contextPath}/student/notes" method="get" class="sk-search" style="position: relative; display: flex; align-items: center; max-width: 240px; width: 100%;">
            <i class="ri-search-line" style="position: absolute; left: 14px; color: #a39797; font-size: 16px; pointer-events: none; z-index: 2;"></i>
            <input type="text" 
                   name="q" 
                   value="${searchKeyword}" 
                   placeholder="Search notes..." 
                   style="width: 100%; padding: 10px 14px 10px 40px; background-color: #ffffff; border: 1px solid #e5e5ea; border-radius: 8px; 
                   font-size: 14px; color: #333333; outline: none; box-sizing: border-box; -webkit-appearance: none; -moz-appearance: none; appearance: none;" />
            <button type="submit" style="display: none;">Search</button>
          </form>

          <a href="${pageContext.request.contextPath}/student/settings" class="sk-avatar">
              <c:choose>
                  <c:when test="${not empty student.image}">
                      <img src="${pageContext.request.contextPath}/${student.image}" alt="Profile" />
                  </c:when>
                  <c:otherwise>
                      <i class="ri-user-3-line"></i>
                  </c:otherwise>
              </c:choose>
          </a>
        </div>
      </div>

      <c:if test="${not empty noteSuccess}">
        <p class="sk-msg-success" style="color: #15803d; background: #f0fdf4; padding: 10px; border-radius: 6px; margin-bottom: 15px;">${noteSuccess}</p>
      </c:if>

      <c:if test="${not empty noteError}">
        <p class="sk-msg-error" style="color: #b91c1c; background: #fef2f2; padding: 10px; border-radius: 6px; margin-bottom: 15px;">${noteError}</p>
      </c:if>

      <c:if test="${not empty notesList}">
        <div class="sk-notes-pinned-row" style="display: flex; gap: 12px; margin-bottom: 20px; flex-wrap: wrap;">
          <c:forEach var="note" items="${notesList}" end="3">
            <a href="${pageContext.request.contextPath}/student/notes/view?id=${note.noteId}"
               class="sk-note-pin-card" style="text-decoration:none; color:inherit; background:#f5dde0; padding: 15px; border-radius: 12px;
                border: 1px solid #e5e7eb; min-width: 140px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
               <i class="ri-sticky-note-line" style="color: #f59e0b; margin-right: 4px;"></i>
               ${note.noteTitle}
            </a>
          </c:forEach>
        </div>
      </c:if>

      <div class="sk-notes-create-row">
        <a href="${pageContext.request.contextPath}/student/notes/create" class="sk-notes-create-btn" style="text-decoration: none; font-weight: 600;">
          + &nbsp; Create new
        </a>
      </div>

      <div class="sk-notes-list-section">
        <p class="sk-notes-list-label">All notes</p>

        <div class="sk-notes-list">
          <c:choose>
            <c:when test="${empty notesList}">
              <p class="sk-notes-empty">No notes available.</p>
            </c:when>
            <c:otherwise>
              <c:forEach var="note" items="${notesList}">
                <a href="${pageContext.request.contextPath}/student/notes/view?id=${note.noteId}" class="sk-note-item" style="text-decoration: none; color: inherit; display: flex; justify-content: space-between; align-items: center; padding: 12px 6px;">
                  <span class="sk-note-title" style="font-weight: 500;">${note.noteTitle}</span>
                  
                  <span class="sk-note-date" style="color: #888; font-size: 13px;">
                    <fmt:formatDate value="${note.noteCreatedAt}" pattern="dd MMM, yyyy"/>
                  </span>
                </a>
                <hr class="sk-note-divider" style="border: 0; border-top: 1px solid #f3f4f6; margin: 0;"/>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>

      </div>

    </main>
  </div>

  <jsp:include page="/WEB-INF/fragments/_footer_student.jsp" />
</div>

</body>
</html>