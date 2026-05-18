<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - View Students</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-student">
  <div class="sk-app">

    <!-- SIDEBAR -->
        <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <!-- MAIN -->
    <main class="sk-main">

      <!-- TOPBAR -->
      <div class="sk-topbar">
		    <div class="sk-on-back-row">
		        <a href="${pageContext.request.contextPath}/student/notes" class="sk-on-back">
		            <i class="ri-arrow-left-s-line"></i> My Notes
		        </a>
		    </div>
		    <a href="${pageContext.request.contextPath}/studentProfileServlet" style="text-decoration:none; color:inherit; margin-left:auto;">
		        <div class="sk-avatar"><i class="ri-user-line"></i></div>
		    </a>
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
   <jsp:include page="footer.jsp" />

</div>
</body>
</html>