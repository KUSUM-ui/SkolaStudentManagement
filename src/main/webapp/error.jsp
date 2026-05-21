<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Error – Skola</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/error.css"/>
</head>
<body>

    <jsp:include page="/WEB-INF/fragments/header.jsp"/>

    <section class="error-page">
        <div class="error-box">

            <c:set var="statusCode" value="${requestScope['jakarta.servlet.error.status_code']}"/>
            <c:if test="${empty statusCode}">
                <c:set var="statusCode" value="${requestScope['javax.servlet.error.status_code']}"/>
            </c:if>
            <c:if test="${empty statusCode}">
                <c:set var="statusCode" value="500"/>
            </c:if>

            <p class="error-code">${statusCode}</p>

            <c:choose>
                <c:when test="${statusCode == 404}">
                    <h1 class="error-heading">Page Not Found</h1>
                    <p class="error-desc">The page you're looking for doesn't exist or may have been moved.</p>
                </c:when>
                <c:when test="${statusCode == 403}">
                    <h1 class="error-heading">Access Forbidden</h1>
                    <p class="error-desc">You don't have permission to view this page.</p>
                </c:when>
                <c:otherwise>
                    <h1 class="error-heading">Something Went Wrong</h1>
                    <p class="error-desc">An unexpected server error occurred. Please try again in a moment.</p>
                </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/home" class="home-btn-primary">Back to Home</a>

        </div>
    </section>

    <jsp:include page="/WEB-INF/fragments/footer.jsp"/>

</body>
</html>
