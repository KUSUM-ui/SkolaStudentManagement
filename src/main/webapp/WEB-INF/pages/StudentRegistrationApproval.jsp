<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Registration Approvals</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
</head>

<body>

<c:set var="tab" value="${param.tab != null ? param.tab : 'pending'}"/>

<div class="sk-page sk-admin">
  <div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
      <jsp:param name="activePage" value="students"/>
    </jsp:include>

    <main class="sk-main">

      <div class="sk-topbar">
        <h2>Registration Approvals</h2>
      </div>
      <a class="sk-appr-back"
         href="${pageContext.request.contextPath}/admin/students">
        <i class="ri-arrow-left-s-line"></i> Back to Students
      </a>

      <!-- STATS -->
      <div class="sk-appr-stats">

        <div class="sk-appr-stat sk-appr-stat--pending">
          <div class="sk-appr-stat-icon"><i class="ri-time-line"></i></div>
          <div>
            <div class="sk-appr-stat-num">${empty pendingCount ? 0 : pendingCount}</div>
            <div class="sk-appr-stat-lbl">Pending</div>
          </div>
        </div>

        <div class="sk-appr-stat sk-appr-stat--approved">
          <div class="sk-appr-stat-icon"><i class="ri-check-line"></i></div>
          <div>
            <div class="sk-appr-stat-num">${empty approvedCount ? 0 : approvedCount}</div>
            <div class="sk-appr-stat-lbl">Approved</div>
          </div>
        </div>

        <div class="sk-appr-stat sk-appr-stat--rejected">
          <div class="sk-appr-stat-icon"><i class="ri-close-line"></i></div>
          <div>
            <div class="sk-appr-stat-num">${empty rejectedCount ? 0 : rejectedCount}</div>
            <div class="sk-appr-stat-lbl">Rejected</div>
          </div>
        </div>

      </div>

      <!-- TABS  -->
      <div class="sk-appr-tabs">

        <a class="sk-appr-tab ${tab == 'pending' ? 'active' : ''}"
           href="?tab=pending">Pending</a>

        <a class="sk-appr-tab ${tab == 'approved' ? 'active' : ''}"
           href="?tab=approved">Approved</a>

        <a class="sk-appr-tab ${tab == 'rejected' ? 'active' : ''}"
           href="?tab=rejected">Rejected</a>

      </div>

      <!-- PENDING -->
      <c:if test="${tab == 'pending'}">
        <c:choose>
          <c:when test="${not empty pendingRegistrations}">
            <c:forEach var="r" items="${pendingRegistrations}">

              <div class="sk-appr-card">

                <div class="sk-appr-avatar">
                  ${not empty r.firstName ? fn:substring(r.firstName,0,1) : '?'}
                </div>

                <div class="sk-appr-info">
                  <div class="sk-appr-name">
                    ${r.firstName} ${r.lastName}
                  </div>

                  <div class="sk-appr-meta">
                    <c:if test="${not empty r.email}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-mail-line"></i>${r.email}
                      </span>
                    </c:if>

                    <c:if test="${not empty r.facultyName}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-book-open-line"></i>${r.facultyName}
                      </span>
                    </c:if>

                    <c:if test="${not empty r.number}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-phone-line"></i>${r.number}
                      </span>
                    </c:if>
                  </div>
                </div>

                <span class="sk-appr-status sk-appr-status--pending">Pending</span>

                <div class="sk-appr-actions">
                  <form action="${pageContext.request.contextPath}/admin/students/approvals/approve" method="post">
                    <input type="hidden" name="registrationId" value="${r.registrationId}"/>
                    <button class="sk-appr-btn sk-appr-btn--approve" type="submit">
                      <i class="ri-check-line"></i> Approve
                    </button>
                  </form>

                  <form action="${pageContext.request.contextPath}/admin/students/approvals/reject" method="post">
                    <input type="hidden" name="registrationId" value="${r.registrationId}"/>
                    <button class="sk-appr-btn sk-appr-btn--reject" type="submit">
                      <i class="ri-close-line"></i> Reject
                    </button>
                  </form>
                </div>

              </div>

            </c:forEach>
          </c:when>

          <c:otherwise>
            <div class="sk-appr-empty">
              <i class="ri-checkbox-circle-line"></i>
              <p>No pending registrations.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </c:if>

      <!-- APPROVED  -->
      <c:if test="${tab == 'approved'}">
        <c:choose>
          <c:when test="${not empty approvedRegistrations}">
            <c:forEach var="r" items="${approvedRegistrations}">

              <div class="sk-appr-card">

                <div class="sk-appr-avatar">
                  ${not empty r.firstName ? fn:substring(r.firstName,0,1) : '?'}
                </div>

                <div class="sk-appr-info">
                  <div class="sk-appr-name">${r.firstName} ${r.lastName}</div>

                  <div class="sk-appr-meta">
                    <c:if test="${not empty r.email}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-mail-line"></i>${r.email}
                      </span>
                    </c:if>

                    <c:if test="${not empty r.facultyName}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-book-open-line"></i>${r.facultyName}
                      </span>
                    </c:if>
                  </div>
                </div>

                <span class="sk-appr-status sk-appr-status--approved">Approved</span>

              </div>

            </c:forEach>
          </c:when>

          <c:otherwise>
            <div class="sk-appr-empty">
              <i class="ri-user-check-line"></i>
              <p>No approved registrations.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </c:if>

      <!-- REJECTED -->
      <c:if test="${tab == 'rejected'}">
        <c:choose>
          <c:when test="${not empty rejectedRegistrations}">
            <c:forEach var="r" items="${rejectedRegistrations}">

              <div class="sk-appr-card">

                <div class="sk-appr-avatar">
                  ${not empty r.firstName ? fn:substring(r.firstName,0,1) : '?'}
                </div>

                <div class="sk-appr-info">
                  <div class="sk-appr-name">${r.firstName} ${r.lastName}</div>

                  <div class="sk-appr-meta">
                    <c:if test="${not empty r.email}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-mail-line"></i>${r.email}
                      </span>
                    </c:if>

                    <c:if test="${not empty r.facultyName}">
                      <span class="sk-appr-meta-item">
                        <i class="ri-book-open-line"></i>${r.facultyName}
                      </span>
                    </c:if>
                  </div>
                </div>

                <span class="sk-appr-status sk-appr-status--rejected">Rejected</span>

              </div>

            </c:forEach>
          </c:when>

          <c:otherwise>
            <div class="sk-appr-empty">
              <i class="ri-user-forbid-line"></i>
              <p>No rejected registrations.</p>
            </div>
          </c:otherwise>
        </c:choose>
      </c:if>

    </main>
  </div>
</div>

</body>
</html>