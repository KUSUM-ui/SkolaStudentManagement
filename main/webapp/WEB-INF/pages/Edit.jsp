<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Edit Student</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Skola.css"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="_sidebar_admin.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <div>
          <h2>Student</h2>
          <a href="${pageContext.request.contextPath}/admin/students/change-details"
             class="sk-edit-back-link">
            <i class="ri-arrow-left-s-line"></i> Edit details
          </a>
        </div>
        <div class="sk-avatar">
          <img src="${pageContext.request.contextPath}/img/admin-avatar.png"
               alt="Admin"
               onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
          <i class="ri-user-line" style="display:none;"></i>
        </div>
      </div>

      <div class="sk-edit-wrapper">
        <div class="sk-edit-card">

          <div class="sk-edit-card-header">

            <label for="photoUpload" class="sk-edit-avatar-circle sk-edit-avatar-upload">
              <img id="avatarPreview"
                   src="${not empty student.photoUrl ? pageContext.request.contextPath.concat(student.photoUrl) : ''}"
                   alt="Student photo"
                   class="sk-edit-avatar-img ${empty student.photoUrl ? 'sk-edit-avatar-img--hidden' : ''}"/>
              <span class="sk-edit-avatar-placeholder ${not empty student.photoUrl ? 'sk-edit-avatar-img--hidden' : ''}">
                <i class="ri-user-3-line"></i>
                <span class="sk-edit-avatar-hint">Upload</span>
              </span>
              <span class="sk-edit-avatar-overlay">
                <i class="ri-camera-line"></i>
              </span>
            </label>
            <input type="file" id="photoUpload" name="photo"
                   accept="image/*" class="sk-edit-photo-input"
                   onchange="
                     var f=this.files[0];
                     if(f){
                       var r=new FileReader();
                       r.onload=function(e){
                         var img=document.getElementById('avatarPreview');
                         var ph=document.querySelector('.sk-edit-avatar-placeholder');
                         img.src=e.target.result;
                         img.classList.remove('sk-edit-avatar-img--hidden');
                         if(ph) ph.classList.add('sk-edit-avatar-img--hidden');
                       };
                       r.readAsDataURL(f);
                     }
                   "/>

            <div class="sk-edit-card-title">
              <p class="sk-edit-card-label">EDITING STUDENT</p>
              <p class="sk-edit-card-sub">Fill in the fields below and click Save to apply changes</p>
            </div>
          </div>

          <div class="sk-edit-divider"></div>

          <form action="${pageContext.request.contextPath}/admin/students/change-details"
                method="post" enctype="multipart/form-data"
                class="sk-edit-form">

            <div class="sk-edit-section-label">Personal Information</div>

            <div class="sk-edit-field-full">
              <label for="name">Name</label>
              <input type="text" id="name" name="name"
                     value="${student.name}" placeholder="Full name" />
            </div>

            <div class="sk-edit-field-full">
              <label for="studentId">Student ID</label>
              <input type="text" id="studentId" name="studentId"
                     value="${student.studentId}"
                     readonly class="sk-edit-input-readonly" />
            </div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="email">Email address</label>
                <input type="email" id="email" name="email"
                       value="${student.email}" placeholder="email@example.com" />
              </div>
              <div class="sk-edit-field-half">
                <label for="phone">Phone number</label>
                <input type="text" id="phone" name="phone"
                       value="${student.phone}" placeholder="+977 98XXXXXXXX" />
              </div>
            </div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="dob">Date of birth</label>
                <input type="text" id="dob" name="dob"
                       value="${student.dateOfBirth}" placeholder="DD / MM / YYYY" />
              </div>
              <div class="sk-edit-field-half">
                <label for="address">Address</label>
                <input type="text" id="address" name="address"
                       value="${student.address}" placeholder="City, District" />
              </div>
            </div>

            <div class="sk-edit-divider"></div>
            <div class="sk-edit-section-label">Academic Information</div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="course">Course</label>
                <input type="text" id="course" name="course"
                       value="${student.course}" placeholder="e.g. BOC" />
              </div>
              <div class="sk-edit-field-half">
                <label for="classVal">Class</label>
                <input type="text" id="classVal" name="classVal"
                       value="${student.classSection}" placeholder="e.g. Section A" />
              </div>
            </div>

            <div class="sk-edit-divider"></div>
            <div class="sk-edit-section-label">Change Password</div>

            <div class="sk-edit-row">
              <div class="sk-edit-field-half">
                <label for="oldPassword">Old password</label>
                <input type="password" id="oldPassword" name="oldPassword"
                       placeholder="Current password" />
              </div>
              <div class="sk-edit-field-half">
                <label for="newPassword">New password</label>
                <input type="password" id="newPassword" name="newPassword"
                       placeholder="New password" />
              </div>
            </div>

            <div class="sk-edit-actions">
              <button type="submit" class="sk-btn sk-adstu-btn">Save</button>
              <button type="button" class="sk-btn-outline sk-adstu-btn sk-edit-remove-btn"
                onclick="location.href='${pageContext.request.contextPath}/admin/students/remove'">
                Remove student
              </button>
            </div>

          </form>
        </div>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />
</div>

</body>
</html>