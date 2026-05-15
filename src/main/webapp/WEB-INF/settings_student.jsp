<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Settings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
</head>

<body class="sk-page">
<div class="sk-app">
    <jsp:include page="/WEB-INF/_sidebar_student.jsp">
        <jsp:param name="activePage" value="settings"/>
    </jsp:include>

    <main class="sk-main">
        <div class="sk-settings-wrap">
            <div class="sk-settings-card">

                <div class="sk-settings-header">
                    <h2>Profile Settings</h2>
                    <i class="ri-user-3-line"></i>
                </div>

                <%-- ── Feedback messages ── --%>
                <c:if test="${not empty success}">
                    <div class="sk-alert sk-alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="sk-alert sk-alert-error">${error}</div>
                </c:if>


                <%-- ════════════════════════════════════════
                     SECTION 1 · PROFILE PICTURE
                     ════════════════════════════════════════ --%>
                <div class="sk-settings-section">
                    <div class="sk-profile-section">

                        <%-- Circle container — inline style guarantees sizing --%>
                        <div style="width:120px; height:120px; border-radius:50%; overflow:hidden; background:#dcdcdc; flex-shrink:0; display:flex; align-items:center; justify-content:center;">
                            <c:choose>
                                <c:when test="${not empty student.image}">
                                    <img src="${pageContext.request.contextPath}/${student.image}"
                                         alt="Profile"
                                         style="width:120px; height:120px; object-fit:cover; border-radius:50%; display:block;">
                                </c:when>
                                <c:otherwise>
                                    <i class="ri-user-3-line" style="font-size:48px; color:#aaa;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="sk-profile-info">
                            <h3>${student.firstName} ${student.lastName}</h3>
                            <span>${student.email}</span>
                        </div>

                        <div class="sk-profile-actions">
                            <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                                  method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="updateImage">
                                <div class="sk-profile-actions-row">
                                    <label for="image" class="sk-btn">
                                        <i class="ri-upload-2-line"></i> Choose
                                    </label>
                                    <input type="file" id="image" name="image"
                                           accept="image/jpeg,image/png,image/gif,image/webp"
                                           style="display:none;">
                                    <button type="submit" class="sk-btn">Upload</button>
                                </div>
                            </form>

                            <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                                  method="post">
                                <input type="hidden" name="action" value="removeImage">
                                <button type="submit" class="sk-btn-outline">Remove</button>
                            </form>
                        </div>

                    </div>
                </div>


                <%-- ════════════════════════════════════════
                     SECTION 2 · PERSONAL INFO  (read-only)
                     ════════════════════════════════════════ --%>
                <div class="sk-settings-section">
                    <h3>Personal Information</h3>

                    <div class="sk-settings-grid">
                        <div>
                            <label>First Name</label>
                            <input type="text" value="${student.firstName}" disabled>
                        </div>
                        <div>
                            <label>Last Name</label>
                            <input type="text" value="${student.lastName}" disabled>
                        </div>
                        <div>
                            <label>Email Address</label>
                            <input type="email" value="${student.email}" disabled>
                        </div>
                        <div>
                            <label>Date of Birth</label>
                            <input type="text" value="${student.dob}" disabled>
                        </div>
                        <div>
                            <label>Gender</label>
                            <input type="text" value="${student.gender}" disabled>
                        </div>
                        <div>
                            <label>Grade Level</label>
                            <input type="text" value="${student.gradeLevel}" disabled>
                        </div>
                        <div>
                            <label>Section</label>
                            <input type="text" value="${student.sectionId}" disabled>
                        </div>
                        <div>
                            <label>Faculty ID</label>
                            <input type="text" value="${student.facultyId}" disabled>
                        </div>
                    </div>
                </div>


                <%-- ════════════════════════════════════════
                     SECTION 3 · PHONE  (editable)
                     ════════════════════════════════════════ --%>
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
                            <button type="reset" class="sk-btn-outline">Cancel</button>
                            <button type="submit" class="sk-btn">Save</button>
                        </div>
                    </form>
                </div>


                <%-- ════════════════════════════════════════
                     SECTION 4 · PASSWORD  (editable)
                     ════════════════════════════════════════ --%>
                <div class="sk-settings-section">
                    <h3>Change Password</h3>

                    <form action="${pageContext.request.contextPath}/SettingsStudentServlet"
                          method="post" class="sk-settings-form">
                        <input type="hidden" name="action" value="updatePassword">

                        <div class="sk-settings-password">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword"
                                   name="currentPassword" placeholder="Enter current password">

                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword"
                                   name="newPassword" placeholder="Enter new password">

                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword"
                                   name="confirmPassword" placeholder="Confirm new password">
                        </div>

                        <div class="sk-settings-actions">
                            <button type="reset" class="sk-btn-outline">Cancel</button>
                            <button type="submit" class="sk-btn">Update Password</button>
                        </div>
                    </form>
                </div>


                <%-- ════════════════════════════════════════
                     LOGOUT
                     ════════════════════════════════════════ --%>
                <div class="sk-settings-logout">
                    <a href="${pageContext.request.contextPath}/LogoutServlet">
                        <button class="sk-btn">
                            Log Out <i class="ri-logout-box-r-line"></i>
                        </button>
                    </a>
                </div>

            </div>
        </div>
    </main>
</div>

<jsp:include page="/WEB-INF/_footer.jsp"/>
</body>
</html>
