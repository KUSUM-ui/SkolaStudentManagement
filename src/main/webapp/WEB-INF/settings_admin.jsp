<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Settings</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css">
</head>

<body class="sk-page">
<div class="sk-app">

    <jsp:include page="/WEB-INF/_sidebar_admin.jsp">
        <jsp:param name="activePage" value="settings"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-settings-header">
            <h2>Profile Settings</h2>
            <i class="ri-user-3-line"></i>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="sk-alert sk-alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="sk-alert sk-alert-error">${errorMessage}</div>
        </c:if>

        <div class="sk-settings-card">

            <%-- ══════════════════════════
                 FORM 1 — Profile
                 ══════════════════════════ --%>
            <form class="sk-settings-form"
                  action="${pageContext.request.contextPath}/SettingsAdminServlet"
                  method="post">

                <input type="hidden" name="action" value="updateProfile">

                <p class="sk-settings-section-title">Personal Information</p>

                <div class="sk-settings-grid">

                    <div>
                        <label for="firstName">First Name</label>
                        <input type="text" id="firstName" name="firstName"
                               value="${admin.firstName}" required>
                    </div>

                    <div>
                        <label for="lastName">Last Name</label>
                        <input type="text" id="lastName" name="lastName"
                               value="${admin.lastName}" required>
                    </div>

                    <div>
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email"
                               value="${admin.email}" required>
                    </div>

                </div>

                <div class="sk-settings-actions">
                    <button type="button" class="sk-btn-outline"
                            onclick="window.location.href='${pageContext.request.contextPath}/SettingsAdminServlet'">
                        Cancel
                    </button>
                    <button type="submit" class="sk-btn">Save</button>
                </div>

            </form>

            <%-- ══════════════════════════
                 FORM 2 — Change Password
                 ══════════════════════════ --%>
            <form class="sk-settings-form"
                  action="${pageContext.request.contextPath}/SettingsAdminServlet"
                  method="post">

                <input type="hidden" name="action" value="changePassword">

                <h3>Change Password</h3>

                <div class="sk-settings-password">

                    <div>
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword"
                               placeholder="Enter current password" required>
                    </div>

                    <div>
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword"
                               placeholder="Min 6 characters" required>
                    </div>

                    <div>
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword"
                               placeholder="Confirm new password" required>
                    </div>

                </div>

                <div class="sk-settings-actions">
                    <button type="button" class="sk-btn-outline"
                            onclick="this.closest('form').reset()">
                        Cancel
                    </button>
                    <button type="submit" class="sk-btn">Update Password</button>
                </div>

            </form>

            <%-- Log out --%>
            <div class="sk-settings-logout">
                <a href="${pageContext.request.contextPath}/LogoutServlet" class="sk-btn">
                    Log Out <i class="ri-logout-box-r-line"></i>
                </a>
            </div>

        </div>

    </main>
</div>

<jsp:include page="/WEB-INF/_footer.jsp"/>

<script>
    document.querySelectorAll('.sk-alert').forEach(function (el) {
        if (!el.textContent.trim()) el.style.display = 'none';
    });
</script>

</body>
</html>
