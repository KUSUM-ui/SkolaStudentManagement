<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0"/>

    <title>SKOLA - View Note</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/skola.css"/>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/notes.css"/>

    <link rel="stylesheet"
          href="https://fonts.googleapis.com/icon?family=Material+Icons"/>

    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
          rel="stylesheet"/>
</head>

<body>

<div class="sk-page sk-student">

    <div class="sk-app">

        <!-- SIDEBAR -->
        <jsp:include page="/WEB-INF/_sidebar_student.jsp">
            <jsp:param name="activePage" value="notes"/>
        </jsp:include>

        <!-- MAIN -->
        <main class="sk-main">

            <!-- TOPBAR -->
            <div class="sk-topbar">

                <a href="${pageContext.request.contextPath}/student/notes"
                   style="text-decoration:none;
                          display:flex;
                          align-items:center;
                          gap:8px;
                          color:#333;
                          font-weight:600;">

                    <i class="ri-arrow-left-line"></i>
                    My Notes

                </a>

            </div>

            <!-- NOTE CARD -->
            <div class="sk-note-view-card"
                 style="background:#fff;
                        padding:30px;
                        border-radius:16px;
                        margin-top:20px;
                        box-shadow:0 2px 10px rgba(0,0,0,0.05);">

                <!-- HEADER -->
                <div style="display:flex;
                            justify-content:space-between;
                            align-items:center;
                            margin-bottom:15px;">

                    <h2 style="margin:0;">
                        <c:out value="${note.noteTitle}"/>
                    </h2>

                    <!-- DELETE BUTTON -->
                    <a href="${pageContext.request.contextPath}/student/notes/view?action=delete&id=${note.noteId}"
                       style="text-decoration:none;
                              color:#d11a2a;
                              font-weight:600;">

                        <i class="ri-delete-bin-line"></i>
                        Delete

                    </a>

                </div>

                <!-- DATE -->
                <p style="color:#888;
                          margin-bottom:25px;">

                    <fmt:formatDate
                            value="${note.noteCreatedAt}"
                            pattern="dd MMM yyyy, hh:mm a"/>

                </p>

                <!-- CONTENT -->
                <div style="line-height:1.8;
                            font-size:15px;
                            white-space:pre-wrap;">

                    <c:out value="${note.noteContent}"/>

                </div>

            </div>

        </main>

    </div>

    <!-- FOOTER -->
    <jsp:include page="/WEB-INF/_footer.jsp"/>

</div>

</body>
</html>