<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile Settings</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/skola.css">
</head>

<body class="sk-page">

<div class="sk-app">
	<jsp:include page="/WEB-INF/fragments/_sidebar_student.jsp">
	    <jsp:param name="activePage" value="settings"/>
	</jsp:include>


<main class="sk-main">

    <div class="sk-settings-wrap">

        <div class="sk-settings-card">

            <div class="sk-settings-header">
                <h2>Profile</h2>
                <i class="ri-user-3-line"></i>
            </div>

            <div class="sk-profile-section">
                <div class="sk-profile-pic">
                    <i class="ri-image-line"></i>
                </div>

                <div class="sk-profile-actions">
                    <button class="sk-btn">Update New</button>
                    <button class="sk-btn-outline">Remove</button>
                </div>
            </div>

            <form class="sk-settings-form">

                <div class="sk-settings-grid">

                    <div>
                        <label>First Name</label>
                        <input type="text">
                    </div>

                    <div>
                        <label>Last Name</label>
                        <input type="text">
                    </div>

                    <div>
                        <label>Email address</label>
                        <input type="email" placeholder="email@example.com">
                    </div>

                    <div>
                        <label>Contact Number</label>
                        <input type="text" placeholder="+977">
                    </div>

                    <div>
                        <label>Gender</label>
                        <select>
                            <option>Choose</option>
                            <option>Male</option>
                            <option>Female</option>
                        </select>
                    </div>

                    <div>
                        <label>Address</label>
                        <input type="text">
                    </div>

                </div>

                <div class="sk-settings-password">
                    <label>Password</label>
                    <input type="password" placeholder="Current password">
                    <input type="password" placeholder="New password">
                </div>

                <div class="sk-settings-actions">
                    <button type="button" class="sk-btn-outline">Cancel</button>
                    <button type="submit" class="sk-btn">Save</button>
                </div>

            </form>

            <div class="sk-settings-logout">
                <button class="sk-btn">
                    Log Out <i class="ri-logout-box-r-line"></i>
                </button>
            </div>

        </div>

    </div>

</main>
</div>

<jsp:include page="/WEB-INF/fragments/_footer.jsp"/>

</body>
</html>