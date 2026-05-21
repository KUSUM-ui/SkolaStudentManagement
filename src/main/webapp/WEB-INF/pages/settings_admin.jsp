<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA – Admin Settings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>

<body class="sk-page sk-admin">
<div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
        <jsp:param name="activePage" value="settings"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
            <div>
                <h2>Settings</h2>
            </div>           
        </div> 
        <c:if test="${not empty successMessage}">
            <div class="sk-alert sk-alert-success">
                <i class="ri-checkbox-circle-line"></i> ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="sk-alert sk-alert-error">
                <i class="ri-error-warning-line"></i> ${errorMessage}
            </div>
        </c:if>
        <div class="sk-edit-wrapper">
            <div class="sk-edit-card">

                <div class="sk-edit-card-header">

                    <div class="sk-edit-card-title">
                        <p class="sk-edit-card-label">
                            ${admin.firstName} ${admin.lastName}
                        </p>
                        <p class="sk-edit-card-sub">Administrator Account</p>
                    </div>
                </div>

                <div class="sk-edit-divider"></div>
                <p class="sk-edit-section-label">Personal Information</p>

                <form action="${pageContext.request.contextPath}/admin/settings"
                      method="post"
                      class="sk-edit-form">

                    <input type="hidden" name="action" value="updateProfile"/>

                    <div class="sk-edit-row">
                        <div class="sk-edit-field-half">
                            <label for="firstName">First name</label>
                            <input type="text" id="firstName" name="firstName"
                                   value="${admin.firstName}"
                                   placeholder="First name"
                                   autocomplete="off"/>
                        </div>
                        <div class="sk-edit-field-half">
                            <label for="lastName">Last name</label>
                            <input type="text" id="lastName" name="lastName"
                                   value="${admin.lastName}"
                                   placeholder="Last name"
                                   autocomplete="off"/>
                        </div>
                    </div>

                    <div class="sk-edit-field-full">
                        <label for="email">Email address</label>
                        <input type="text" id="email" name="email"
                               value="${admin.email}"
                               placeholder="admin@email.com"
                               autocomplete="off"/>
                    </div>

                    <div class="sk-edit-actions">
                        <button type="submit" class="sk-btn">
                           Save Changes
                        </button>
                    </div>

                </form>

         
                <div class="sk-edit-divider"></div>
                <p class="sk-edit-section-label">Change Password</p>

                <form action="${pageContext.request.contextPath}/admin/settings"
                      method="post"
                      class="sk-edit-form">

                    <input type="hidden" name="action" value="changePassword"/>

                    <div class="sk-edit-field-full">
                        <label for="currentPassword">Current password</label>
                        <input type="password" id="currentPassword" name="currentPassword"
                               placeholder="Enter current password"/>
                    </div>

                    <div class="sk-edit-row">
                        <div class="sk-edit-field-half">
                            <label for="newPassword">New password</label>
                            <input type="password" id="newPassword" name="newPassword"
                                   placeholder="Min. 8 characters"/>
                        </div>
                        <div class="sk-edit-field-half">
                            <label for="confirmPassword">Confirm new password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                   placeholder="Repeat new password"/>
                        </div>
                    </div>

                    <div class="sk-edit-actions">
                        <button type="submit" class="sk-btn">
                            </i> Update Password
                        </button>
                    </div>

                </form>

  
                <div class="sk-edit-divider"></div>

                <div class="sk-edit-actions" style="justify-content:flex-end;">
                    <a href="${pageContext.request.contextPath}/logout" class="sk-btn-outline"
                       style="font-size:13px; padding:8px 18px; display:inline-flex; align-items:center; gap:6px;">
                        Log Out
                    </a>
                </div>

            </div>
        </div>

    </main>
</div>

<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>

</body>
</html>
