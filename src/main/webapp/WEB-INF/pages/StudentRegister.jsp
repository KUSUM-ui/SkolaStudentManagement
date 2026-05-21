<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA — Student Registration</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>

<body>

    <jsp:include page="/WEB-INF/fragments/header.jsp">
        <jsp:param name="activePage" value="register"/>
    </jsp:include>

    <main class="reg-page">

        <div class="reg-container">

            <c:choose>
                <c:when test="${not empty successMessage || param.success eq 'true'}">
                    <div class="reg-form" style="text-align: center; padding: 60px 44px;">
                        
                        <c:choose>
                            <c:when test="${not empty registeredPhoto}">
                                <div style="width: 110px; height: 110px; margin: 0 auto 24px; position: relative;">
                                    <img src="${pageContext.request.contextPath}/${registeredPhoto}" alt="Profile Preview" 
                                    style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%; border: 3px solid var(--border);" />
                                    <div style="position: absolute; bottom: 0; right: 0; width: 32px; height: 32px; background: #2e7d32; 
                                    color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; 
                                    font-size: 16px; border: 2px solid #fff;">
                                        <i class="ri-checkbox-circle-fill"></i>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div style="width: 80px; height: 80px; background: var(--red-pale); color: var(--red); border-radius: 50%; display: flex; align-items:
                                 center; justify-content: center; margin: 0 auto 24px; font-size: 40px;">
                                    <i class="ri-checkbox-circle-line"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <h1 style="font-size: 28px; font-weight: 700; color: var(--text); margin-bottom: 16px;">
                            <c:choose>
                                <c:when test="${not empty registeredName}">
                                    Registration Sent, ${registeredName}!
                                </c:when>
                                <c:otherwise>
                                    Registration Request Sent!
                                </c:otherwise>
                            </c:choose>
                        </h1>
                        
                        <p style="font-size: 15px; color: var(--muted); line-height: 1.6; max-width: 540px; margin: 0 auto 32px;">
                            Your registration request has been successfully submitted. You will only be able to log in once your account has 
                            been approved by an administrator. Please contact your administrator for further inquiries.
                        </p>
                        <div style="display: flex; align-items: center; justify-content: center; gap: 16px; flex-wrap: wrap;">
                            <a href="${pageContext.request.contextPath}/home" class="reg-load-btn" style="text-decoration: none; display: inline-flex;">
                                <i class="ri-home-4-line"></i> Back to Homepage
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="reg-btn-primary" style="text-decoration: none; display: inline-flex;">
                                <i class="ri-arrow-left-line"></i> Return to Login
                            </a>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="reg-heading">
                        <p class="home-eyebrow">Student Portal</p>
                        <h1>Create your account</h1>
                        <p class="reg-subtext">
                            Fill in your details below. Your registration will be reviewed
                            by an administrator before you can log in.
                        </p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="reg-alert reg-alert-error">
                            <i class="ri-error-warning-line"></i> ${error}
                        </div>
                    </c:if>

                    <form class="reg-form"
                          action="${pageContext.request.contextPath}/home/registerstudent"
                          method="post"
                          enctype="multipart/form-data">

                        <div class="reg-section-label">Personal Information</div>

                        <div class="reg-grid">

                            <div class="reg-field">
                                <label for="first_name">First Name <span class="reg-req">*</span></label>
                                <input type="text" id="first_name" name="first_name"
                                       value="${param.first_name}"
                                       placeholder="e.g. Jane"
                                       autocomplete="off"/>
                            </div>

                            <div class="reg-field">
                                <label for="last_name">Last Name <span class="reg-req">*</span></label>
                                <input type="text" id="last_name" name="last_name"
                                       value="${param.last_name}"
                                       placeholder="e.g. Smith"
                                       autocomplete="off"/>
                            </div>

                            <div class="reg-field">
                                <label for="email">Email Address <span class="reg-req">*</span></label>
                                <input type="email" id="email" name="email"
                                       value="${param.email}"
                                       placeholder="student@email.com"
                                       autocomplete="off"/>
                            </div>

                            <div class="reg-field">
                                <label for="password">Password <span class="reg-req">*</span></label>
                                <input type="password" id="password" name="password"
                                       placeholder="Min. 8 characters"/>
                            </div>

                            <div class="reg-field">
                                <label for="number">Phone Number</label>
                                <input type="text" id="number" name="number"
                                       value="${param.number}"
                                       placeholder="+977 98XXXXXXXX"
                                       autocomplete="off"/>
                            </div>

                            <div class="reg-field">
                                <label for="dob">Date of Birth</label>
                                <input type="date" id="dob" name="dob"
                                       value="${param.dob}"/>
                            </div>

                            <div class="reg-field">
                                <label for="gender">Gender</label>
                                <select id="gender" name="gender" class="reg-select">
                                    <option value="" disabled
                                         <c:if test="${empty param.gender}">selected</c:if>>
                                         Select gender
                                    </option>
                                    <option value="Male"
                                         <c:if test="${param.gender eq 'Male'}">selected</c:if>>Male</option>
                                    <option value="Female"
                                         <c:if test="${param.gender eq 'Female'}">selected</c:if>>Female</option>
                                    <option value="Other"
                                         <c:if test="${param.gender eq 'Other'}">selected</c:if>>Other</option>
                                </select>
                            </div>

                            <div class="reg-field reg-field-photo">
                                <label for="image">Profile Photo</label>
                                <label for="image" class="reg-upload-btn">
                                    <i class="ri-upload-2-line"></i>
                                    Choose Photo
                                </label>
                                <input type="file" id="image" name="image"
                                       accept="image/jpeg,image/png,image/webp,image/gif"
                                       class="reg-file-input"/>
                                <span class="reg-upload-hint">JPEG / PNG / WEBP — max 5 MB</span>
                            </div>

                        </div>

                        <div class="reg-section-label" style="margin-top:32px;">Academic Information</div>

                        <div class="reg-grid">

                            <div class="reg-field">
                                <label for="program">Program / Faculty <span class="reg-req">*</span></label>
                                <select id="program" name="program" class="reg-select">
                                    <option value="" disabled
                                         <c:if test="${empty param.program}">selected</c:if>>
                                         Select program
                                    </option>
                                    <c:choose>
                                        <c:when test="${not empty faculties}">
                                            <c:forEach var="f" items="${faculties}">
                                                <option value="${f.facultyId}"
                                                     <c:if test="${param.program eq f.facultyId}">selected</c:if>>
                                                     ${f.facultyName}
                                                </option>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="" disabled>No programs found</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                                <span class="reg-field-hint">
                                    Select a program, then click "Load Sections" below.
                                </span>
                            </div>

                            <div class="reg-field">
                                <label for="sectionId">Section <span class="reg-req">*</span></label>
                                <c:choose>
                                    <c:when test="${not empty sections}">
                                        <select id="sectionId" name="sectionId" class="reg-select">
                                            <option value="" disabled
                                                 <c:if test="${empty param.sectionId}">selected</c:if>>
                                                 Select section
                                            </option>
                                            <c:forEach var="sec" items="${sections}">
                                                <option value="${sec.sectionId}"
                                                     <c:if test="${param.sectionId eq sec.sectionId}">selected</c:if>>
                                                     ${sec.sectionName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </c:when>
                                    <c:otherwise>
                                        <select id="sectionId" name="sectionId" class="reg-select">
                                            <option value="" disabled selected>
                                                Select a program first
                                            </option>
                                        </select>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="reg-field">
                                <label for="gradeLevel">Semester / Year <span class="reg-req">*</span></label>
                                <select id="gradeLevel" name="gradeLevel" class="reg-select">
                                    <option value="" disabled
                                         <c:if test="${empty param.gradeLevel}">selected</c:if>>
                                         Select semester
                                    </option>
                                    <option value="1"  <c:if test="${param.gradeLevel eq '1'}">selected</c:if>>Semester 1</option>
                                    <option value="2"  <c:if test="${param.gradeLevel eq '2'}">selected</c:if>>Semester 2</option>
                                    <option value="3"  <c:if test="${param.gradeLevel eq '3'}">selected</c:if>>Semester 3</option>
                                    <option value="4"  <c:if test="${param.gradeLevel eq '4'}">selected</c:if>>Semester 4</option>
                                    <option value="5"  <c:if test="${param.gradeLevel eq '5'}">selected</c:if>>Semester 5</option>
                                    <option value="6"  <c:if test="${param.gradeLevel eq '6'}">selected</c:if>>Semester 6</option>
                                </select>
                            </div>

                        </div>

                        <div class="reg-load-sections">
                            <button type="submit" name="_action" value="loadSections" class="reg-load-btn">
                                <i class="ri-refresh-line"></i>
                                Load Sections for Selected Program
                            </button>
                            <span class="reg-field-hint">
                                Click after choosing your program to populate your Section options without clearing fields.
                            </span>
                        </div>

                        <div class="reg-actions">
                            <button type="submit" class="reg-btn-primary">
                                <i class="ri-user-add-line"></i>
                                Submit Registration
                            </button>
                            <a href="${pageContext.request.contextPath}/login"
                               class="reg-link-login">
                                Already have an account? <strong>Log in</strong>
                            </a>
                        </div>

                    </form>
                </c:otherwise>
            </c:choose>

        </div>

    </main>

    <jsp:include page="/WEB-INF/fragments/footer.jsp"/>

</body>
</html>

<style>
.reg-page {
    flex: 1;
    background: #fafafa;
    padding: 60px 24px 80px;
}
.reg-container {
    max-width: 780px;
    margin: 0 auto;
}
.reg-heading {
    text-align: center;
    margin-bottom: 40px;
}
.reg-heading h1 {
    font-size: 32px;
    font-weight: 700;
    color: var(--text);
    margin: 8px 0 12px;
}
.reg-subtext {
    font-size: 14px;
    color: var(--muted);
    max-width: 500px;
    margin: 0 auto;
    line-height: 1.6;
}
.reg-alert {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 20px;
    border-radius: 10px;
    font-size: 13.5px;
    margin-bottom: 28px;
}
.reg-alert-error {
    background: #fdecea;
    color: #b00020;
    border: 1px solid #f5c6cb;
}
.reg-form {
    background: #fff;
    border: 1px solid var(--border);
    border-radius: 16px;
    padding: 40px 44px 44px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.06);
}
.reg-section-label {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: var(--red);
    margin-bottom: 20px;
    padding-bottom: 8px;
    border-bottom: 1px solid var(--border);
}
.reg-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px 28px;
}
.reg-field {
    display: flex;
    flex-direction: column;
    gap: 6px;
}
.reg-field label {
    font-size: 12.5px;
    font-weight: 600;
    color: var(--text);
}
.reg-req {
    color: var(--red);
}
.reg-field input {
    padding: 11px 16px;
    border: 1px solid var(--border);
    border-radius: 8px;
    background: #fafafa;
    font-size: 13.5px;
    color: var(--text);
    outline: none;
    font-family: inherit;
    transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
}
.reg-field input:focus {
    border-color: var(--red);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(155,35,53,0.10);
}
.reg-select {
    padding: 11px 16px;
    border: 1px solid var(--border);
    border-radius: 8px;
    background: #fafafa;
    font-size: 13.5px;
    color: var(--text);
    font-family: inherit;
    outline: none;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
}
.reg-select:focus {
    border-color: var(--red);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(155,35,53,0.10);
}
.reg-field-hint {
    font-size: 11.5px;
    color: var(--muted);
    line-height: 1.5;
}
.reg-field-photo {
    grid-column: 1;
}
.reg-file-input {
    display: none;
}
.reg-upload-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 10px 18px;
    background: var(--red-pale);
    color: var(--red);
    border: 1.5px solid var(--red-light);
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    width: fit-content;
    transition: background 0.15s;
}
.reg-upload-btn:hover { background: var(--red-light); }
.reg-upload-hint {
    font-size: 11px;
    color: var(--muted);
}
.reg-load-sections {
    margin-top: 16px;
}
.reg-load-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 9px 20px;
    background: #fff;
    color: var(--text);
    border: 1px solid var(--border);
    border-radius: 8px;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    font-family: inherit;
    transition: border-color 0.15s, background 0.15s;
}
.reg-load-btn:hover {
    border-color: var(--red);
    color: var(--red);
    background: var(--red-pale);
}
.reg-actions {
    display: flex;
    align-items: center;
    gap: 24px;
    margin-top: 36px;
    flex-wrap: wrap;
}
.reg-btn-primary {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 14px 44px;
    background: var(--red);
    color: #fff;
    border: none;
    border-radius: 30px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    font-family: inherit;
    transition: background 0.2s;
}
.reg-btn-primary:hover { background: var(--red-hover); }
.reg-link-login {
    font-size: 13.5px;
    color: var(--muted);
    text-decoration: none;
}
.reg-link-login strong { color: var(--red); }
.reg-link-login:hover strong { text-decoration: underline; }

@media (max-width: 600px) {
    .reg-form { padding: 28px 20px 32px; }
    .reg-grid { grid-template-columns: 1fr; }
    .reg-field-photo { grid-column: 1; }
    .reg-actions { flex-direction: column; align-items: flex-start; gap: 14px; }
    .reg-heading h1 { font-size: 26px; }
}
</style>