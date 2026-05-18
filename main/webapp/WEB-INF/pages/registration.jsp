<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA - Student Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>

<body class="sk-page sk-admin">
<div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
        <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
            <div>
                <h2>Student Registration</h2>
                <a href="${pageContext.request.contextPath}/admin/students"
                   class="sk-edit-back-link">
                    <i class="ri-arrow-left-s-line"></i> Back to Students
                </a>
            </div>
            <div class="sk-avatar"><i class="ri-user-line"></i></div>
        </div>

        <c:if test="${not empty error}">
            <div class="sk-alert sk-alert-error">
                <i class="ri-error-warning-line"></i> ${error}
            </div>
        </c:if>

        <div class="sk-reg-wrapper">
            <div class="sk-reg-card">

                <div class="sk-edit-card-header">
                    <div class="sk-edit-avatar-circle">
                        <div class="sk-edit-avatar-placeholder">
                            <i class="ri-user-line"></i>
                            <span class="sk-edit-avatar-hint">Photo</span>
                        </div>
                    </div>
                    <div class="sk-edit-card-title">
                        <p class="sk-edit-card-label">New Student</p>
                        <p class="sk-edit-card-sub">Fill in the fields below and click Register to add the student</p>
                    </div>
                </div>

                <form id="regForm"
                      action="${pageContext.request.contextPath}/admin/students/register"
                      method="post"
                      enctype="multipart/form-data">

                    <%-- ── PERSONAL INFORMATION ── --%>
                    <div class="sk-edit-divider"></div>
                    <p class="sk-edit-section-label">Personal Information</p>

                    <div class="sk-edit-form">

                        <div class="sk-edit-row">
                            <div class="sk-edit-field-half">
                                <label for="first_name">First name</label>
                                <input type="text" id="first_name" name="first_name"
                                       placeholder="e.g. Jane"
                                       autocomplete="off"/>
                            </div>
                            <div class="sk-edit-field-half">
                                <label for="last_name">Last name</label>
                                <input type="text" id="last_name" name="last_name"
                                       placeholder="e.g. Smith"
                                       autocomplete="off"/>
                            </div>
                        </div>

                        <div class="sk-edit-row">
                            <div class="sk-edit-field-half">
                                <label for="email">Email address</label>
                                <input type="email" id="email" name="email"
                                       placeholder="student@email.com"
                                       autocomplete="off"/>
                            </div>
                            <div class="sk-edit-field-half">
                                <label for="number">Phone number</label>
                                <input type="text" id="number" name="number"
                                       placeholder="+977 98XXXXXXXX"
                                       autocomplete="off"/>
                            </div>
                        </div>

                        <div class="sk-edit-row">
                            <div class="sk-edit-field-half">
                                <label for="dob">Date of birth</label>
                                <input type="date" id="dob" name="dob"/>
                            </div>
                            <div class="sk-edit-field-half">
                                <label for="gender">Gender</label>
                                <select id="gender" name="gender" class="sk-reg-select">
                                    <option value="" disabled selected>Select gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                        </div>

                        <div class="sk-edit-field-full">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password"
                                   placeholder="Min. 8 characters"/>
                        </div>

                    </div>

                    <%-- ── ACADEMIC INFORMATION ── --%>
                    <div class="sk-edit-divider"></div>
                    <p class="sk-edit-section-label">Academic Information</p>

                    <div class="sk-edit-form">

                        <div class="sk-edit-row">
                            <div class="sk-edit-field-half">
                                <label for="program">Program / Faculty</label>
                                <select id="program" name="program" class="sk-reg-select">
                                    <option value="" disabled selected>Select program</option>
                                    <c:choose>
                                        <c:when test="${not empty faculties}">
                                            <c:forEach var="f" items="${faculties}">
                                                <option value="${f.facultyId}">${f.facultyName}</option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">General</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>

                    </div>

                    <%-- ── UPLOAD PHOTO ── --%>
                    <div class="sk-edit-divider"></div>
                    <p class="sk-edit-section-label">Upload Photo</p>

                    <div class="sk-edit-form">
                        <div class="sk-edit-field-full">
                            <label for="image" class="sk-ecp-change-cover-label sk-reg-upload-label">
                                <i class="ri-upload-2-line"></i> Choose Photo
                            </label>
                            <input type="file" id="image" name="image"
                                   accept="image/*" class="sk-ecp-file-input"/>
                        </div>
                    </div>

                    <%-- ── ACTIONS ── --%>
                    <div class="sk-edit-divider"></div>

                    <div class="sk-edit-actions">
                        <button type="submit" class="sk-btn">Register Student</button>
                    </div>

                </form>
            </div>
        </div>

    </main>
</div>

<jsp:include page="_footer.jsp"/>
</body>
</html>