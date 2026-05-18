<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Settings – Skola</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/settings.css">
</head>

<body class="sk-page">
<div class="sk-app">

    <jsp:include page="/WEB-INF/_sidebar_student.jsp">
        <jsp:param name="activePage" value="settings"/>
    </jsp:include>

    <main class="sk-main">

        <!-- ── Topbar — matches other pages ── -->
        <div class="sk-topbar">
            <h2>Profile Settings</h2>
            <div class="sk-avatar">
                <c:choose>
                    <c:when test="${not empty student.image}">
                        <img src="${pageContext.request.contextPath}/${student.image}"
                             alt="${student.firstName}">
                    </c:when>
                    <c:otherwise>
                        <i class="ri-user-3-line"></i>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="sk-settings-wrap">
            <div class="sk-settings-card">

                <!-- ── Feedback banners ── -->
                <c:if test="${not empty success}">
                    <div class="sk-alert sk-alert-success">
                        <i class="ri-checkbox-circle-line"></i> ${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="sk-alert sk-alert-error">
                        <i class="ri-error-warning-line"></i> ${error}
                    </div>
                </c:if>


                <!-- ════════════════════════════════
                     SECTION 1 · PROFILE PICTURE
                     ════════════════════════════════ -->
                <div class="sk-settings-section">

                    <div class="sk-profile-row">

                        <!-- Avatar -->
                        <div class="sk-avatar-wrap">
                            <c:choose>
                                <c:when test="${not empty student.image}">
                                    <%--
                                        student.image  →  "uploads/profile_images/student_172000.jpg"
                                        Full URL       →  /SkolaStudentManagement/uploads/profile_images/student_172000.jpg
                                        ImageUtil.upload() already returns the relative path; we just prefix contextPath.
                                    --%>
                                    <img class="sk-avatar-img"
                                         src="${pageContext.request.contextPath}/${student.image}"
                                         alt="Profile photo of ${student.firstName} ${student.lastName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="sk-avatar-placeholder">
                                        <i class="ri-user-3-line"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- green dot = "online" feel -->
                            <span class="sk-avatar-badge"></span>
                        </div>

                        <!-- Name + email -->
                        <div class="sk-profile-meta">
                            <h3 class="sk-profile-name">${student.firstName} ${student.lastName}</h3>
                            <span class="sk-profile-email">
                                <i class="ri-mail-line"></i> ${student.email}
                            </span>
                            <span class="sk-profile-grade">
                                <i class="ri-graduation-cap-line"></i>
                                ${student.gradeLevel}
                                <c:if test="${not empty student.sectionId}"> · Section ${student.sectionId}</c:if>
                            </span>
                        </div>

                        <!-- Upload / Remove controls -->
                        <div class="sk-avatar-actions">
                            <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                                  method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="updateImage">

                                <!-- Hidden file input; label acts as styled button -->
                                <input type="file" id="avatarFile" name="image"
                                       accept="image/jpeg,image/png,image/gif,image/webp"
                                       onchange="previewAvatar(this)">

                                <div class="sk-avatar-btn-row">
                                    <label for="avatarFile" class="sk-btn sk-btn-icon">
                                        <i class="ri-image-add-line"></i> Choose Photo
                                    </label>
                                    <button type="submit" class="sk-btn">
                                        <i class="ri-upload-cloud-2-line"></i> Upload
                                    </button>
                                </div>

                              
                            </form>

                            <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                                  method="post">
                                <input type="hidden" name="action" value="removeImage">
                                <button type="submit" class="sk-btn-remove">
                                    <i class="ri-delete-bin-6-line"></i> Remove Photo
                                </button>
                            </form>
                        </div>

                    </div><!-- /sk-profile-row -->
                </div><!-- /section 1 -->


                <!-- ════════════════════════════════
                     SECTION 2 · PERSONAL INFO  (read-only)
                     ════════════════════════════════ -->
                <div class="sk-settings-section">
                    <div class="sk-section-label">
                        <i class="ri-id-card-line"></i>
                        <h3>Personal Information</h3>
                        <span class="sk-section-badge">Read-only</span>
                    </div>

                    <div class="sk-info-grid">
                        <div class="sk-info-field">
                            <label>First Name</label>
                            <div class="sk-info-value">${student.firstName}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Last Name</label>
                            <div class="sk-info-value">${student.lastName}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Email Address</label>
                            <div class="sk-info-value">${student.email}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Date of Birth</label>
                            <div class="sk-info-value">${student.dob}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Gender</label>
                            <div class="sk-info-value">${student.gender}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Grade Level</label>
                            <div class="sk-info-value">${student.gradeLevel}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Section</label>
                            <div class="sk-info-value">${student.sectionId}</div>
                        </div>
                        <div class="sk-info-field">
                            <label>Faculty ID</label>
                            <div class="sk-info-value">${student.facultyId}</div>
                        </div>
                    </div>
                </div><!-- /section 2 -->


                <!-- ════════════════════════════════
                     SECTION 3 · CONTACT NUMBER  (editable)
                     ════════════════════════════════ -->
                <div class="sk-settings-section">
                    <h3>Contact Number</h3>

                    <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                          method="post" class="sk-settings-form">
                        <input type="hidden" name="action" value="updatePhone">

                        <div class="sk-settings-grid">
                            <div>
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phone"
                                       placeholder="+977" value="${student.phone}">
                            </div>
                        </div>

                        <div class="sk-settings-actions">
                            <button type="reset"  class="sk-btn-outline">Cancel</button>
                            <button type="submit" class="sk-btn">Save</button>
                        </div>
                    </form>
                </div><!-- /section 3 -->


                <!-- ════════════════════════════════
                     SECTION 4 · CHANGE PASSWORD  (editable)
                     ════════════════════════════════ -->
                <div class="sk-settings-section">
                    <h3>Change Password</h3>

                    <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                          method="post" class="sk-settings-form">
                        <input type="hidden" name="action" value="updatePassword">

                        <div class="sk-settings-password">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword"
                                   name="currentPassword"
                                   placeholder="Enter current password">

                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword"
                                   name="newPassword"
                                   placeholder="Enter new password">

                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword"
                                   name="confirmPassword"
                                   placeholder="Confirm new password">
                        </div>

                        <div class="sk-settings-actions">
                            <button type="reset"  class="sk-btn-outline">Cancel</button>
                            <button type="submit" class="sk-btn">Update Password</button>
                        </div>
                    </form>
                </div><!-- /section 4 -->


                <!-- ════════════════════════════════
                     LOGOUT
                     ════════════════════════════════ -->
                <div class="sk-settings-logout">
                    <a href="${pageContext.request.contextPath}/LogoutServlet"
                       class="sk-btn-ghost sk-btn-danger sk-logout-btn"
                       onclick="return confirm('Are you sure you want to log out?')">
                        <i class="ri-logout-box-r-line"></i> Log Out
                    </a>
                </div>

            </div><!-- /sk-settings-card -->
        </div><!-- /sk-settings-wrap -->
    </main>
</div><!-- /sk-app -->

<jsp:include page="/WEB-INF/_footer.jsp"/>

<script>
/* ── Live avatar preview before upload ── */
function previewAvatar(input) {
    if (!input.files || !input.files[0]) return;
    const reader = new FileReader();
    reader.onload = function(e) {
        /* Replace placeholder icon OR existing <img> with a live preview */
        const wrap = document.querySelector('.sk-avatar-wrap');
        let img = wrap.querySelector('.sk-avatar-img');
        const placeholder = wrap.querySelector('.sk-avatar-placeholder');

        if (!img) {
            img = document.createElement('img');
            img.className = 'sk-avatar-img';
            img.alt = 'Preview';
            if (placeholder) placeholder.replaceWith(img);
            else wrap.insertBefore(img, wrap.firstChild);
        }
        img.src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
}

/* ── Auto-dismiss alerts after 4 s ── */
document.querySelectorAll('.sk-alert').forEach(function(el) {
    setTimeout(function() {
        el.style.transition = 'opacity 0.5s, max-height 0.5s';
        el.style.opacity    = '0';
        el.style.maxHeight  = '0';
        el.style.padding    = '0';
        el.style.margin     = '0';
    }, 4000);
});
</script>
</body>
</html>
