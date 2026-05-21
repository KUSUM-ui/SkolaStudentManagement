<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA - View Note</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/notes.css"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
    <div class="sk-app">

         <jsp:include page="/WEB-INF/fragments/_sidebar_student.jsp">
            <jsp:param name="activePage" value="notes"/>
        </jsp:include>

        <main class="sk-main"style="background: #FFF5F5;">

            <div class="sk-topbar">
                <a href="${pageContext.request.contextPath}/student/notes" style="text-decoration:none; display:flex; 
                align-items:center; gap:8px; color:#333; font-weight:600;">
                    <i class="ri-arrow-left-line"></i> Back to Notes
                </a>
            </div>

            <div class="sk-note-view-card" style="background:#fff; padding:30px; border-radius:16px; margin-top:20px; 
            box-shadow:0 2px 10px rgba(0,0,0,0.05);">

                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:15px;">
                    <h2 style="margin:0; font-size: 22px; color: #111827;">
                        <c:out value="${note.noteTitle}"/>
                    </h2>

                    <a href="${pageContext.request.contextPath}/student/notes/view?action=delete&id=${note.noteId}"
                       onclick="return confirm('Are you sure you want to permanently delete this note?');"
                       style="text-decoration:none; color:#d11a2a; font-weight:600; display: flex; align-items: center; gap: 4px;">
                        <i class="ri-delete-bin-line"></i> Delete
                    </a>
                </div>

                <p style="color:#6b7280; font-size: 13px; margin-bottom:25px; display: flex; align-items: center; gap: 4px;">
                    <i class="ri-time-line"></i>
                    <fmt:formatDate value="${note.noteCreatedAt}" pattern="dd MMM yyyy, hh:mm a"/>
                </p>

                <div style="line-height:1.8; font-size:15px; white-space:pre-wrap; color: #374151; background: #f9fafb; padding: 20px;
                 border-radius: 8px; border: 1px solid #f3f4f6;">
                    <c:out value="${note.noteContent}"/>
                </div>

            </div>

        </main>
    </div>

  <jsp:include page="/WEB-INF/fragments/_footer_student.jsp" />
</div>

</body>
</html>