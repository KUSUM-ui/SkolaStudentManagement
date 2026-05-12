<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Edit Club Profile</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
      <jsp:param name="activePage" value="clubs"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Clubs</h2>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/images/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-ecp-layout">

        <!-- LEFT COLUMN -->
        <div class="sk-ecp-left">

          <div class="sk-ecp-back-row">
            <a href="${pageContext.request.contextPath}/admin/clubs"
               class="sk-ecp-back-link">
              <i class="ri-arrow-left-s-line"></i> Back
            </a>
          </div>

          <form method="post"
                action="${pageContext.request.contextPath}/admin/clubs/update"
                enctype="multipart/form-data">

            <input type="hidden" name="clubId" value="${club.clubId}"/>

            <div class="sk-ecp-field">
              <label for="clubIdDisplay">Club ID</label>
              <input type="text"
                     id="clubIdDisplay"
                     value="${club.clubId}"
                     readonly
                     class="sk-ecp-input sk-ecp-input-readonly"/>
            </div>

            <div class="sk-ecp-field">
              <label for="clubName">Club Name</label>
              <input type="text"
                     id="clubName"
                     name="clubName"
                     value="${club.clubName}"
                     class="sk-ecp-input"/>
            </div>

            <div class="sk-ecp-field">
              <label for="clubDescription">About the club</label>
              <textarea id="clubDescription"
                        name="clubDescription"
                        class="sk-ecp-textarea">${club.clubDescription}</textarea>
            </div>

            <!-- What do we do -->
            <div class="sk-ecp-whatwedo">
              <h3 class="sk-ecp-whatwedo-title">What do we do</h3>
              <div class="sk-ecp-whatwedo-list">
                <c:forEach var="activity" items="${club.activities}">
                  <div class="sk-ecp-whatwedo-item">
                    <div class="sk-ecp-whatwedo-text">
                      <span class="sk-ecp-whatwedo-name">${activity.title}</span>
                      <span class="sk-ecp-whatwedo-desc">${activity.description}</span>
                    </div>
                    <button type="submit"
                            name="deleteActivityId"
                            value="${activity.activityId}"
                            class="sk-ecp-delete-btn"
                            formaction="${pageContext.request.contextPath}/admin/clubs/activity/delete">
                      <i class="ri-delete-bin-line"></i>
                    </button>
                  </div>
                </c:forEach>
                <c:if test="${empty club.activities}">
                  <p style="font-size:13px; color:var(--muted);">No activities added yet.</p>
                </c:if>
              </div>
            </div>

            <div class="sk-ecp-field">
              <label for="maxMembers">Max members</label>
              <input type="number"
                     id="maxMembers"
                     name="maxMembers"
                     value="${club.maxMembers}"
                     class="sk-ecp-input"/>
            </div>

            <div class="sk-ecp-submit-row">
              <button type="submit"
                      class="sk-btn sk-ecp-update-btn">Update</button>
            </div>

          </form>
        </div>

        <!-- DIVIDER -->
        <div class="sk-ecp-divider"></div>

        <!-- RIGHT COLUMN -->
        <div class="sk-ecp-right">

          <!-- Club selector tabs — plain links, no JS -->
          <div class="sk-ecp-club-tabs">
            <c:forEach var="cl" items="${allClubs}">
              <a href="${pageContext.request.contextPath}/admin/clubs/edit-profile?clubId=${cl.clubId}"
                 class="sk-ecp-club-tab ${cl.clubId == club.clubId ? 'sk-ecp-club-tab-active' : ''}">
                ${cl.clubName}
              </a>
            </c:forEach>
          </div>

          <!-- Cover photo -->
          <div class="sk-ecp-cover-wrap">
            <c:choose>
              <c:when test="${not empty club.coverImage}">
                <img class="sk-ecp-cover-img"
                     src="${pageContext.request.contextPath}/images/inkspiremain.png"
                     alt="${club.clubName}"/>
              </c:when>
              <c:otherwise>
                <div class="sk-ecp-cover-placeholder">
                  <i class="ri-image-line"></i>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Change cover photo -->
          <form method="post"
                action="${pageContext.request.contextPath}/admin/clubs/cover"
                enctype="multipart/form-data"
                class="sk-ecp-cover-form">
            <input type="hidden" name="clubId" value="${club.clubId}"/>
            <label for="coverPhoto" class="sk-ecp-change-cover-label">
              Change cover photo
              <input type="file"
                     id="coverPhoto"
                     name="coverPhoto"
                     accept="image/*"
                     class="sk-ecp-file-input"/>
            </label>
            <button type="submit" class="sk-ecp-change-cover-btn">Upload</button>
          </form>

          <!-- Total member from max_members -->
          <div class="sk-ecp-total-member">
            <span class="sk-ecp-total-label">Total member</span>
            <div class="sk-ecp-total-box">${club.maxMembers}</div>
          </div>

        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>