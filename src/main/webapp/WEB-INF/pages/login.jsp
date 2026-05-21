<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login – Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/skola.css" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet" />
</head>
<body>

<div class="sk-login-page">

    <div class="sk-login-left">

        <div class="sk-login-center-brand">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="Skola Logo" class="sk-login-logo-img" />
            <span class="sk-login-logo-text">KOLA</span>
        </div>

        <div class="sk-login-bottom-brand">
            <h2 class="sk-login-welcome">Welcome back</h2>
            <p class="sk-login-tagline">Login to continue.</p>
        </div>

        <div class="sk-login-blob sk-login-blob-1"></div>
        <div class="sk-login-blob sk-login-blob-2"></div>
        <div class="sk-login-blob sk-login-blob-3"></div>
    </div>

    <div class="sk-login-right">
        <div class="sk-login-form-wrap">

            <div style="margin-bottom: 24px;">
                <a href="${pageContext.request.contextPath}/home" style="display: inline-flex; align-items: center;
                 gap: 6px; color: var(--muted); text-decoration: none; font-size: 13.5px;">
                    <i class="ri-arrow-left-line"></i> Back to Homepage
                </a>
            </div>

            <h1 class="sk-login-title">Login</h1>
            <p class="sk-login-sub">Enter your credentials to continue.</p>

            <form action="${pageContext.request.contextPath}/login" method="post">

                <div class="sk-login-tabs">
                    <input type="radio" name="role" id="tab-admin" value="admin"  ${empty param.role || param.role == 'admin' ? 'checked' : ''}  />
                    <label for="tab-admin">Admin</label>
                    <input type="radio" name="role" id="tab-student" value="student"  ${empty param.role || param.role == 'student' ? 'checked' : ''} />
                    <label for="tab-student">Student</label>
                </div>

                <c:if test="${not empty error}">
                    <div class="sk-login-error">
                        ${error}
                    </div>
                </c:if>

                <div class="sk-login-field">
                    <label for="email">Email</label>
                    <div class="sk-login-input-wrap">
                        <i class="ri-mail-line sk-login-input-icon"></i>
                        <input type="text" id="email" name="email" value="${param.email}" placeholder="Enter your email" />
                    </div>
                </div>

                <div class="sk-login-field">
                    <label for="password">Password</label>
                    <div class="sk-login-input-wrap">
                        <i class="ri-lock-line sk-login-input-icon"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" />
                    </div>
                </div>

                <button type="submit" class="sk-login-btn">Login</button>
            </form> </div> </div>
</div>
</body>
</html>