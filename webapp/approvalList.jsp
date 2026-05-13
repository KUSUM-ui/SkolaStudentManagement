<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Student Registration Approval</title>
  <link rel="stylesheet" type="text/css" href="skola.css">
  <link rel="stylesheet" type="text/css" href="studentRegistration.css">
</head>
<body>

<div class="sk-page">
  <div class="sk-app">

    <%@ include file="sidebar.jsp" %>

    <main class="sk-main">

      <!-- Topbar -->
      <div class="sk-topbar">
        <h2>Welcome, ${adminName}</h2>
        <div class="sk-search"><i class="ri-search-line"></i> Search</div>
        <div class="sk-avatar"><i class="ri-user-line"></i></div>
      </div>

      <!-- Section label -->
      <p class="sreg-label">Student registration</p>

      <!-- Registration card -->
      <div class="sreg-card">

        <div class="sreg-row">
          <span class="sreg-name">Aarav Sharma</span>
          <div class="sreg-actions">
            <button type="button" class="sk-btn">Approve</button>
            <a href="${pageContext.request.contextPath}/admin/students/detail" class="sk-btn-outline">View details</a>
          </div>
        </div>
        <hr class="sreg-divider"/>

        <div class="sreg-row">
          <span class="sreg-name">Anil Thapa</span>
          <div class="sreg-actions">
            <button type="button" class="sk-btn">Approve</button>
            <a href="${pageContext.request.contextPath}/admin/students/detail" class="sk-btn-outline">View details</a>
          </div>
        </div>
        <hr class="sreg-divider"/>

        <div class="sreg-row">
          <span class="sreg-name">Rohan Karki</span>
          <div class="sreg-actions">
            <button type="button" class="sk-btn">Approve</button>
            <a href="${pageContext.request.contextPath}/admin/students/detail" class="sk-btn-outline">View details</a>
          </div>
        </div>
        <hr class="sreg-divider"/>

        <div class="sreg-row">
          <span class="sreg-name">Priya Adhikari</span>
          <div class="sreg-actions">
            <button type="button" class="sk-btn">Approve</button>
            <a href="${pageContext.request.contextPath}/admin/students/detail" class="sk-btn-outline">View details</a>
          </div>
        </div>
        <hr class="sreg-divider"/>

        <div class="sreg-row">
          <span class="sreg-name">Bikash Rai</span>
          <div class="sreg-actions">
            <button type="button" class="sk-btn">Approve</button>
            <a href="${pageContext.request.contextPath}/admin/students/detail" class="sk-btn-outline">View details</a>
          </div>
        </div>

      </div>

    </main>
  </div>

  <%@ include file="footer.jsp" %>
</div>

</body>
</html>
