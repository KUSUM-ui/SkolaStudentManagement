<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Student Registration</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/Skola.css"/>
     <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>
<body class="sk-page">

  <div class="sk-app">

        <jsp:include page="_sidebar_admin.jsp">
       <jsp:param name="activePage" value="students"/>
      </jsp:include>

    <div class="sk-main">

      <div class="sk-reg-wrapper">
        <h2 class="sk-reg-page-title">Student Registration</h2>

        <div class="sk-reg-card">
          <form id="regForm" action="${pageContext.request.contextPath}/registerStudent" method="post">
            <div class="sk-reg-grid">

              <div class="sk-reg-field">
                <label for="firstName">First name</label>
                <input type="text" id="firstName" name="firstName" autocomplete="off"/>
              </div>

              <div class="sk-reg-field">
                <label for="lastName">Last name</label>
                <input type="text" id="lastName" name="lastName" autocomplete="off"/>
              </div>

              <div class="sk-reg-field">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" autocomplete="off"/>
              </div>

              <div class="sk-reg-field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"/>
              </div>

              <div class="sk-reg-field">
                <label for="phone">Phone number</label>
                <input type="text" id="phone" name="phone" autocomplete="off"/>
              </div>

              <div class="sk-reg-field">
                <label for="course">Course</label>
                <input type="text" id="course" name="course" autocomplete="off"/>
              </div>

              <div class="sk-reg-field sk-reg-field--full">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" autocomplete="off"/>
              </div>

            </div>
          </form>
        </div>

        <div class="sk-reg-submit-row">
          <button type="submit" form="regForm" class="sk-reg-btn">Register now</button>
        </div>

      </div>

    </div>
  </div>

  <%@ include file="_footer.jsp" %>

</body>
</html>