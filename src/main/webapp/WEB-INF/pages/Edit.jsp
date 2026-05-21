<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Edit Student</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <div>
          <h2>Student</h2>
          <a href="${pageContext.request.contextPath}/admin/students/view" class="sk-edit-back-link">
            <i class="ri-arrow-left-s-line"></i> Back to students
          </a>
        </div>
        <div class="sk-avatar">
          <c:choose>
            <c:when test="${not empty sessionScope.adminAvatar}">
              <img src="${pageContext.request.contextPath}/${sessionScope.adminAvatar}" alt="Admin"/>
            </c:when>
            <c:otherwise>
              <div class="sk-avatar-placeholder" style="width: 40px; height: 40px; background: var(--red-pale);
              color: var(--red); display: flex; align-items: center; justify-content: center; border-radius: 50%;">
                <i class="ri-user-line" style="font-size: 20px;"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <c:if test="${not empty successMessage}">
        <div class="sk-edit-alert sk-edit-alert--success">
          <i class="ri-check-circle-line"></i> ${successMessage}
        </div>
      </c:if>
      <c:if test="${not empty errorMessage}">
        <div class="sk-edit-alert sk-edit-alert--error">
          <i class="ri-error-warning-line"></i> ${errorMessage}
        </div>
      </c:if>

      <div class="sk-edit-wrapper">
        <div class="sk-edit-card">

          <div class="sk-edit-card-header">
            <div class="sk-edit-avatar-circle">
              <c:choose>
                <c:when test="${not empty student.image}">
                  <img id="avatarPreview" src="${pageContext.request.contextPath}/${student.image}" alt="Student photo" style="width:100%; height:100%; object-fit:cover; object-position:center; border-radius:50%;"/>
                </c:when>
                <c:otherwise>
                  <span class="sk-edit-avatar-placeholder">
                    <i class="ri-user-3-line"></i>
                    <span class="sk-edit-avatar-hint">No Photo</span>
                  </span>
                </c:otherwise>
              </c:choose>
            </div>

            <div class="sk-edit-card-title">
              <p class="sk-edit-card-label">Editing Student</p>
              <p class="sk-edit-card-sub">Fill in the fields below and click Save to apply changes</p>
            </div>
          </div>

          <div class="sk-edit-divider"></div>

          <%-- id added to main form so Save button outside can reference it --%>
          <form id="editStudentForm"
                action="${pageContext.request.contextPath}/admin/students/edit"
                method="post"
                enctype="multipart/form-data"
                class="sk-edit-form">

            <input type="hidden" name="studentId" value="${student.studentId}"/>
            <input type="hidden" name="action"    value="save"/>

            <div class="sk-edit-section-label">Personal Information</div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="firstName">First name</label>
                <input type="text" id="firstName" name="firstName" value="${student.firstName}" placeholder="First name"/>
              </div>
              <div class="sk-edit-field-half">
                <label for="lastName">Last name</label>
                <input type="text" id="lastName" name="lastName" value="${student.lastName}" placeholder="Last name"/>
              </div>
            </div>

            <div class="sk-edit-field-full">
              <label for="studentIdDisplay">Student ID</label>
              <input type="text" id="studentIdDisplay" value="${student.studentId}" readonly class="sk-edit-input-readonly"/>
            </div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="email">Email address</label>
                <input type="email" id="email" name="email" value="${student.email}" placeholder="email@example.com"/>
              </div>
              <div class="sk-edit-field-half">
                <label for="phone">Phone number</label>
                <input type="text" id="phone" name="phone" value="${student.number}" placeholder="+977 98XXXXXXXX" maxlength="14"/>
              </div>
            </div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="dob">Date of birth</label>
                <input type="date" id="dob" name="dob" value="${student.dob}"/>
              </div>
              <div class="sk-edit-field-half">
                <label for="gender">Gender</label>
                <select id="gender" name="gender">
                  <option value="" ${empty student.gender ? 'selected' : ''}>Select gender</option>
                  <option value="Male"   ${student.gender == 'Male'   ? 'selected' : ''}>Male</option>
                  <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                  <option value="Other"  ${student.gender == 'Other'  ? 'selected' : ''}>Other</option>
                  <option value="Prefer not to say" ${student.gender == 'Prefer not to say' ? 'selected' : ''}>Prefer not to say</option>
                </select>
              </div>
            </div>

            <div class="sk-edit-divider"></div>

            <div class="sk-edit-section-label">Academic Information</div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="gradeLevel">Semester</label>
                <select id="gradeLevel" name="gradeLevel">
                  <option value="">Select semester</option>
                  <option value="Semester 1" ${student.gradeLevel == 'Semester 1' ? 'selected' : ''}>Semester 1</option>
                  <option value="Semester 2" ${student.gradeLevel == 'Semester 2' ? 'selected' : ''}>Semester 2</option>
                  <option value="Semester 3" ${student.gradeLevel == 'Semester 3' ? 'selected' : ''}>Semester 3</option>
                  <option value="Semester 4" ${student.gradeLevel == 'Semester 4' ? 'selected' : ''}>Semester 4</option>
                  <option value="Semester 5" ${student.gradeLevel == 'Semester 5' ? 'selected' : ''}>Semester 5</option>
                  <option value="Semester 6" ${student.gradeLevel == 'Semester 6' ? 'selected' : ''}>Semester 6</option>
                </select>
              </div>
              <div class="sk-edit-field-half">
                <label for="sectionId">Section</label>
                <input type="text" id="sectionId" name="sectionId" value="${student.sectionId}" placeholder="e.g. A"/>
              </div>
            </div>

            <div class="sk-edit-divider"></div>

            <div class="sk-edit-section-label">Upload Photo</div>

            <div class="sk-edit-field-full">
              <label for="photoUpload" class="sk-ecp-change-cover-label sk-reg-upload-label">
                <i class="ri-upload-2-line"></i> Choose Photo
              </label>
              <input type="file" id="photoUpload" name="image" accept="image/jpeg,image/png,image/webp,image/gif" class="sk-edit-photo-input"/>
              <span class="sk-edit-photo-hint">JPEG / PNG / WEBP — max 5 MB. Leave blank to keep current photo.</span>
            </div>

            <div class="sk-edit-divider"></div>

            <div class="sk-edit-section-label">Change Password</div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="oldPassword">Old password</label>
                <input type="password" id="oldPassword" name="oldPassword" placeholder="Current password"/>
              </div>
              <div class="sk-edit-field-half">
                <label for="newPassword">New password</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Leave blank to keep current"/>
              </div>
            </div>

          </form><%-- SAVE FORM ENDS HERE --%>

          <%-- Actions: Remove has its own form, Save references editStudentForm by id --%>
          <div class="sk-edit-actions">

            <form action="${pageContext.request.contextPath}/admin/students/edit"
                  method="post"
                  style="display:inline;">
              <input type="hidden" name="studentId" value="${student.studentId}"/>
              <input type="hidden" name="action"    value="remove"/>
              <button type="submit"
                      class="sk-btn-outline sk-adstu-btn sk-edit-remove-btn"
                      onclick="return confirm('Are you sure you want to remove this student?');">
                Remove student
              </button>
            </form>

            <button type="submit"
                    form="editStudentForm"
                    class="sk-btn sk-adstu-btn">
              Save changes
            </button>

          </div>

        </div>
      </div>

    </main>
  </div>

<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>
</div>

</body>
</html>