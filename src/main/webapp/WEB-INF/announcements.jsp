<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="com.SkolaStudentManagement.Model.AnnouncementModel" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Skola - Announcements</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/skola.css?v=2" />
</head>

<body class="sk-page sk-announce-page">
<div class="sk-app">

  <!-- SIDEBAR -->
  <jsp:include page="/WEB-INF/_sidebar_admin.jsp">
    <jsp:param name="activePage" value="announcements"/>
  </jsp:include>

  <!-- MAIN -->
  <main class="sk-main">

    <!-- Topbar -->
    <div class="sk-topbar">
      <h2>Announcements</h2>
      <div class="sk-avatar"><i class="ri-user-line"></i></div>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty successMessage}">
      <div class="sk-alert sk-alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <div class="sk-alert sk-alert-error">${errorMessage}</div>
    </c:if>

    <!-- Post form — multipart for file uploads -->
    <form action="${pageContext.request.contextPath}/AnnouncementServlet"
          method="post" enctype="multipart/form-data">

      <div class="sk-announce-form-box">
        <span>Post new announcement</span>

        <!-- Title -->
        <input type="text" name="title" class="sk-announce-title-input"
               placeholder="Title" required />

        <!-- Genre dropdown -->
        <div class="sk-announce-genre">
          <label for="genre">Genre</label>
          <select id="genre" name="genre" class="sk-genre-select" required>
            <option value="" disabled selected>Select genre</option>
            <option value="academics">Academics</option>
            <option value="non-academics">Non-Academics</option>
          </select>
        </div>

        <textarea name="content" placeholder="Write here..." required></textarea>

        <!-- Hidden file inputs -->
        <input type="file" id="imageUpload"      name="imageFile"
               accept="image/*"                  style="display:none" />
        <input type="file" id="attachmentUpload" name="attachmentFile"
               accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt"
               style="display:none" />

        <!-- Preview areas -->
        <div id="imagePreview"      class="sk-upload-preview" style="display:none"></div>
        <div id="attachmentPreview" class="sk-upload-preview" style="display:none"></div>

        <div class="sk-announce-form-footer">

          <!-- Image button -->
          <label for="imageUpload" class="sk-icon-btn" title="Attach image">
            <i class="ri-image-add-line"></i>
          </label>

          <!-- File/attachment button -->
          <label for="attachmentUpload" class="sk-icon-btn" title="Attach file">
            <i class="ri-attachment-line"></i>
          </label>

          <button type="submit" class="sk-btn" style="margin-left:auto;">Post</button>
        </div>
      </div>
    </form>

    <!-- Filter bar -->
    <div class="sk-announce-list-label">
      Recent announcements
      <div class="sk-announce-filter">
        <button type="button" class="sk-filter-btn active"
                onclick="filterAnnouncements('all', this)">All</button>
        <button type="button" class="sk-filter-btn"
                onclick="filterAnnouncements('academics', this)">Academics</button>
        <button type="button" class="sk-filter-btn"
                onclick="filterAnnouncements('non-academics', this)">Non-Academics</button>
      </div>
    </div>

    <!-- Announcements list from DB -->
    <div class="sk-announce-list">
      <c:choose>
        <c:when test="${not empty announcements}">
          <c:forEach var="ann" items="${announcements}">
            <div class="sk-announce-item" data-genre="${ann.genre}">
              <div class="sk-announce-item-header">
                <strong>${ann.title}</strong>
                <span class="sk-announce-badge sk-badge-${ann.genre}">${ann.genre}</span>
              </div>
              <p>${ann.content}</p>
              <c:if test="${not empty ann.imagePath}">
                <img src="${pageContext.request.contextPath}/${ann.imagePath}"
                     class="sk-announce-img" alt="announcement image"/>
              </c:if>
              <c:if test="${not empty ann.attachmentPath}">
                <a href="${pageContext.request.contextPath}/${ann.attachmentPath}"
                   class="sk-announce-attachment" target="_blank">
                  <i class="ri-file-line"></i> Download attachment
                </a>
              </c:if>
              <small>${ann.publishedAt}</small>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <p class="sk-empty-msg">No announcements yet.</p>
        </c:otherwise>
      </c:choose>
    </div>

  </main>
</div>

<!-- FOOTER -->
<jsp:include page="/WEB-INF/_footer.jsp"/>

<script>
  function filterAnnouncements(genre, btn) {
    document.querySelectorAll('.sk-filter-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.querySelectorAll('.sk-announce-item').forEach(item => {
      item.style.display = (genre === 'all' || item.dataset.genre === genre) ? '' : 'none';
    });
  }

  // Image preview
  document.getElementById('imageUpload').addEventListener('change', function () {
    const preview = document.getElementById('imagePreview');
    const file = this.files[0];
    if (file) {
      const url = URL.createObjectURL(file);
      preview.innerHTML = '<img src="' + url + '" style="max-height:120px;border-radius:6px;margin-top:8px;"/>'
                        + '<span class="sk-upload-name">' + file.name + '</span>';
      preview.style.display = 'flex';
    }
  });

  // Attachment preview
  document.getElementById('attachmentUpload').addEventListener('change', function () {
    const preview = document.getElementById('attachmentPreview');
    const file = this.files[0];
    if (file) {
      preview.innerHTML = '<i class="ri-file-line"></i> <span class="sk-upload-name">' + file.name + '</span>';
      preview.style.display = 'flex';
    }
  });
</script>
</body>
</html>
