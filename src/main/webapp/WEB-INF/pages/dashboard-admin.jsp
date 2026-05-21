<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Skola - Admin Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css" />
</head>

<body class="sk-page sk-admin">
<div class="sk-app">

  <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
    <jsp:param name="activePage" value="dashboard"/>
  </jsp:include>

  <main class="sk-main">

    <div class="sk-topbar">
      <h2>Welcome, <c:out value="${not empty adminName ? adminName : 'Admin'}"/>.</h2>
      <div class="sk-avatar">

        <c:choose>
          <c:when test="${not empty sessionScope.adminAvatar}">
            <img src="${pageContext.request.contextPath}/${sessionScope.adminAvatar}" alt="Admin"/>
          </c:when>
          <c:otherwise>
            <div class="sk-avatar-placeholder" style="width: 40px; height: 40px; background: var(--red-pale); color: var(--red); 
            display: flex; align-items: center; justify-content: center; border-radius: 50%;">
              <i class="ri-user-line" style="font-size: 20px;"></i>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <c:if test="${not empty successMessage}">
      <div class="sk-alert sk-alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <div class="sk-alert sk-alert-error">${errorMessage}</div>
    </c:if>

    <div class="dash-stats">

      <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-graduation-cap-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty totalStudents ? totalStudents : 0}</div>
          <div class="dash-stat-label">Total Students</div>
        </div>
      </div>

      <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-time-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty pendingCount ? pendingCount : 0}</div>
          <div class="dash-stat-label">Pending Approvals</div>
        </div>
      </div>

      <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-book-open-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty totalClasses ? totalClasses : 0}</div>
          <div class="dash-stat-label">Classes</div>
        </div>
      </div>

      <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-megaphone-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty totalAnnouncements ? totalAnnouncements : 0}</div>
          <div class="dash-stat-label">Announcements</div>
        </div>
      </div>

      <div class="dash-stat">
        <div class="dash-stat-icon"><i class="ri-briefcase-line"></i></div>
        <div>
          <div class="dash-stat-count">${not empty totalFaculties ? totalFaculties : 0}</div>
          <div class="dash-stat-label">Faculties</div>
        </div>
      </div>

    </div>

    <div class="sk-row">

      <div class="sk-card sk-announce-box">

        <div class="sk-announce-header">
          <span>Post new announcement</span>
          <a href="${pageContext.request.contextPath}/admin/announcements"
             class="sk-btn" style="font-size:12px; padding:5px 12px;">
            View all
          </a>
        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/admin/announcements"
              enctype="multipart/form-data">

            <input type="hidden" name="sourcePage" value="dashboard"/>
            <input type="hidden" name="action" value="add"/>

            <input type="text" name="title" placeholder="Title" required />

            <div class="sk-announce-genre">
              <label>Genre</label>
              <select name="genre" required>
                <option value="" disabled selected>Select genre</option>
                <option value="academics">Academics</option>
                <option value="non-academics">Non-Academics</option>
              </select>
            </div>

            <textarea name="content" placeholder="Write here..." required></textarea>

            <div class="sk-announce-footer">

              <label class="sk-icon-btn" title="Upload image">
                <i class="ri-image-add-line"></i>
                <input type="file" name="imageFile" accept="image/*" hidden />
              </label>

              <label class="sk-icon-btn" title="Upload attachment">
                <i class="ri-attachment-line"></i>
                <input type="file"
                       name="attachmentFile"
                       accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt"
                       hidden />
              </label>

              <button class="sk-btn" type="submit" style="margin-left:auto;">
                Post
              </button>

            </div>
        </form>
      </div>

      <div class="sk-card sk-action-card">
        <span>Manage Classes</span>
        <a href="${pageContext.request.contextPath}/admin/classes">
          <i class="ri-book-open-line"></i>
        </a>
      </div>

      <div class="sk-card sk-action-card">
        <span>Manage Schedule</span>
        <a href="${pageContext.request.contextPath}/admin/schedule">
          <i class="ri-calendar-check-line"></i>
        </a>
      </div>

      <div class="sk-card sk-action-card">
        <span>View Students</span>
        <a href="${pageContext.request.contextPath}/admin/students">
          <i class="ri-file-search-line"></i>
        </a>
      </div>

    </div>

    <div class="sk-mid-row">

      <div class="sk-mid-left">
        <div class="sk-club-section">
          <h3>Student Registration Requests</h3>

          <div class="sk-club-table">
            <c:choose>
              <c:when test="${not empty pendingStudents}">
                <c:forEach var="s" items="${pendingStudents}">
                  <div class="sk-club-row">
                    <span>
                      ${s.firstName} ${s.lastName}
                      <span style="font-size:11px; color:var(--muted); display:block;">${s.email}</span>
                    </span>
                    <div class="sk-club-actions">
                      <form action="${pageContext.request.contextPath}/admin/students/approvals/approve"
                            method="post">
                        <input type="hidden" name="registrationId" value="${s.studentId}"/>
                        <button type="submit" class="sk-btn" style="font-size:12px; padding:5px 12px;">
                          Approve
                        </button>
                      </form>
                    </div>
                  </div>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <div class="sk-club-row">
                  <span style="color:var(--muted); font-size:13px;">No new registration requests</span>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

          <div class="sk-view-all-link">
            <a href="${pageContext.request.contextPath}/admin/students/approvals">View all →</a>
          </div>

        </div>
      </div>

      <div class="sk-mid-right">

        <div class="sk-recent-label">Recent Announcements</div>

        <div class="sk-recent-box">
          <c:choose>
            <c:when test="${not empty recentAnnouncements}">
              <c:forEach var="a" items="${recentAnnouncements}">
                <a class="dash-ann-item"
                   href="${pageContext.request.contextPath}/admin/announcements">
                  <div class="dash-ann-row">
                    <div style="flex:1; min-width:0;">
                      <div class="dash-ann-title">${a.title}</div>
                      <div class="dash-ann-preview">${a.content}</div>
                    </div>
                    <span class="dash-badge dash-badge-${a.genre}">${a.genre}</span>
                  </div>
                  <div class="dash-ann-date">${not empty a.publishedAt ? a.publishedAt : ''}</div>
                </a>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <div style="font-size:13px; color:var(--muted); padding:16px 0;">
                No recent announcements
              </div>
            </c:otherwise>
          </c:choose>

          <a class="dash-view-all"
             href="${pageContext.request.contextPath}/admin/announcements">
            View all →
          </a></div></div></div> </main>
</div>
<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>

</body>
</html>