<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login – Skola</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css" />
</head>
<body>

<div class="navbar">
    <span class="logo">Skola</span>
</div>

<div class="sk-page login">

    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="page-center">
            <div class="card">

                <div class="tabs">
                    <input type="radio" name="role" id="tab-admin" value="admin" checked />
                    <label for="tab-admin">Admin</label>

                    <input type="radio" name="role" id="tab-student" value="student" />
                    <label for="tab-student">Student</label>
                </div>

                <h1>Login</h1>
                <p class="subtitle">Enter your credentials to continue.</p>

               
                <c:if test="${not empty error}">
                    <p style="color: #ff4d4f; background: #ffecec; padding: 8px; border-radius: 5px; margin-bottom: 10px;">
                        ${error}
                    </p>
                </c:if>

                <div class="field">
                    <label for="email">Email*</label>
                    <input type="text" id="email" name="email" value="${param.email}" />
                </div>

                <div class="field">
                    <label for="password">Password*</label>
                    <input type="password" id="password" name="password" />
                </div>

                <button type="submit" class="btn-login">Login</button>

                <a href="${pageContext.request.contextPath}/forgotpassword" class="forgot">
                    Forgot Password?
                </a>

            </div>
        </div>

    </form>

</div>

</body>
</html>