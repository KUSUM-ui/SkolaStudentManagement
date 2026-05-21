<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Create Notes</title>
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

      <div class="sk-topbar">
        <div class="sk-on-back-row">
          <a href="${pageContext.request.contextPath}/student/notes" class="sk-on-back" style="text-decoration: none; font-weight: 600; color: inherit;">
            <i class="ri-arrow-left-s-line"></i> Back to Notes
          </a>
        </div>

        <div class="sk-avatar">
          <c:choose>
            <c:when test="${not empty sessionScope.studentAvatar}">
              <img src="${pageContext.request.contextPath}/${sessionScope.studentAvatar}" alt="Student Avatar" class="sk-avatar-img" />
            </c:when>
            <c:otherwise>
              <div class="sk-avatar-placeholder">
                <i class="ri-user-3-line"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <c:if test="${not empty noteSuccess}">
        <p class="sk-msg-success" style="color: #15803d; background: #f0fdf4; padding: 10px; border-radius: 6px; margin-bottom: 15px;">${noteSuccess}</p>
      </c:if>

      <c:if test="${not empty noteError}">
        <p class="sk-msg-error" style="color: #b91c1c; background: #fef2f2; padding: 10px; border-radius: 6px; margin-bottom: 15px;">${noteError}</p>
      </c:if>

      <form action="${pageContext.request.contextPath}/student/notes/create" method="post" class="sk-cn-form">
        <input type="text" name="title" placeholder="Title" class="sk-cn-title" required
               value="${not empty param.title ? param.title : ''}" style="width: 100; padding: 10px; font-size: 18px; font-weight: 600; border: 1px solid #e5e7eb; border-radius: 8px; margin-bottom: 15px; outline: none;"/>

        <textarea name="body" placeholder="Create new note..." class="sk-cn-body" required style="width: 100; min-height: 200px; padding: 12px; border: 1px solid #e5e7eb; border-radius: 8px; font-size: 15px; resize: vertical; outline: none; font-family: inherit;"></textarea>

        <div class="sk-cn-btn-row" style="margin-top: 15px; display: flex; gap: 10px;">
          <button type="submit" class="sk-btn" style="background: #2563eb; color: #fff; padding: 8px 16px; border: none; border-radius: 6px; cursor: pointer; font-weight: 500;">Save Note</button>
          <button type="button" class="sk-cn-exit" onclick="location.href='${pageContext.request.contextPath}/student/notes'" style="background: #e5e7eb; color: #374151; padding: 8px 16px; border: none; border-radius: 6px; cursor: pointer; font-weight: 500;">Cancel</button>
        </div>
      </form>

    </main>
  </div>

  <jsp:include page="/WEB-INF/fragments/_footer_student.jsp" />
</div>

</body>
</html>