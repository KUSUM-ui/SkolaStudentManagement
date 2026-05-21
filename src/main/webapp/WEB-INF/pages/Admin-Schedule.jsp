<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.userEmail}">
    <c:redirect url="/login"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>SKOLA - Manage Schedule</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/skola.css"/>

    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
          rel="stylesheet"/>
</head>

<body>

<div class="sk-page sk-admin">

    <div class="sk-app">

        <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
            <jsp:param name="activePage" value="Schedules"/>
        </jsp:include>

        <main class="sk-main">

            <!-- TOPBAR -->
            <div class="sk-topbar">
                <h2>Manage Schedule</h2>
               <div class="sk-avatar" ><i class="ri-user-line"></i></div>
               </div>

            <!-- SUCCESS -->
            <c:if test="${not empty success}">
                <div class="sk-success-message">
                    ${success}
                </div>
            </c:if>

            <!-- ERROR -->
            <c:if test="${not empty error}">
                <div class="sk-success-message"
                     style="background:#fdecea;
                            color:#c62828;
                            border-color:#f5c6cb;">
                             ${error}</div>
            </c:if>

            <!-- FILTER SECTION            -->
     
            <form method="get" action="${pageContext.request.contextPath}/admin/schedule">
				<div class="sk-sch-filter-row">

                    <!-- FACULTY -->
                    <div class="sk-sch-select-wrap">
						 <select class="sk-sch-select" name="faculty">
							<option value="">Select Faculty</option>

                            <c:forEach var="f" items="${faculties}">
                                <option value="${f.facultyId}"
                                    <c:if test="${f.facultyId == selectedFaculty}">
                                        selected
                                    </c:if>>${f.facultyName}
                                    </option>
                                     </c:forEach>
                                     </select>
						<i class="ri-arrow-down-s-line sk-sch-arrow"></i>
						 </div>

                    <!-- SEMESTER — only shown once a faculty has been selected -->
                    <c:if test="${not empty selectedFaculty}">

                        <div class="sk-sch-select-wrap">

                            <select class="sk-sch-select"
                                    name="semester">

                                <option value="">Select Semester</option>

                                <c:forEach var="sem" items="${semesterList}">

                                    <option value="${sem}"
                                        <c:if test="${sem == selectedSemester}">
                                            selected
                                        </c:if>>

                                        Semester ${sem}

                                    </option>

                                </c:forEach>

                            </select>

                            <i class="ri-arrow-down-s-line sk-sch-arrow"></i>

                        </div>

                    </c:if>

                    <!-- SECTION — only shown once a semester has been selected -->
                    <c:if test="${not empty sections}">

                        <div class="sk-sch-select-wrap">

                            <select class="sk-sch-select"
                                    name="section">

                                <option value="">Select Section</option>

                                <c:forEach var="s" items="${sections}">

                                    <option value="${s.sectionId}"
                                        <c:if test="${s.sectionId == selectedSection}">
                                            selected
                                        </c:if>>

                                        ${s.sectionName}

                                    </option>

                                </c:forEach>

                            </select>

                            <i class="ri-arrow-down-s-line sk-sch-arrow"></i>

                        </div>

                    </c:if>

                    <!-- APPLY s -->
                    <button type="submit" class="sk-sch-apply-btn">
                        <i class="ri-filter-line"></i> Apply
                    </button>

                </div>

            </form>

  
            <!-- SCHEDULE TABLE -->
  

            <c:if test="${not empty selectedSection}">

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/schedule">

                    <input type="hidden"
                           name="section_id"
                           value="${selectedSection}"/>

                    <input type="hidden"
                           name="faculty_id"
                           value="${selectedFaculty}"/>

                    <input type="hidden"
                           name="semester"
                           value="${selectedSemester}"/>

                    <div class="sk-sch-table-wrap">

                        <table class="sk-sch-table">

                            <thead>

                                <tr>

                                    <th class="sk-sch-th sk-sch-th-day">
                                        Day
                                    </th>

                                    <th class="sk-sch-th sk-sch-th-module">
                                        Module
                                    </th>

                                    <th class="sk-sch-th">
                                        Start Time
                                    </th>

                                    <th class="sk-sch-th">
                                        End Time
                                    </th>

                                </tr>

                            </thead>

                            <tbody>

                                <c:forEach var="day" items="${days}">

                                    <c:forEach var="slot" items="${slots}">

                                        <c:set var="key"
                                               value="${day}_${slot}"/>

                                        <c:set var="existing"
                                               value="${scheduleMap[key]}"/>

                                        <tr class="sk-sch-tr">

                                            <!-- DAY -->
                                            <td class="sk-sch-td sk-sch-td-day">

                                                ${day}

                                                <span style="font-size:11px;
                                                             color:#aaa;
                                                             display:block;">

                                                    slot ${slot + 1}

                                                </span>

                                            </td>

                                            <!-- MODULE -->
                                            <td class="sk-sch-td">

                                                <div class="sk-sch-time-wrap">

                                                    <select class="sk-sch-time-select"
                                                            name="module_${day}_${slot}"
                                                            style="min-width:200px;">

                                                        <option value="">
                                                            -- none --
                                                        </option>

                                                        <c:forEach var="m"
                                                                   items="${modules}">

                                                            <option value="${m.moduleId}"

                                                                <c:if test="${not empty existing
                                                                    and existing.moduleId == m.moduleId}">
                                                                    selected
                                                                </c:if>>

                                                                ${m.moduleName}

                                                            </option>

                                                        </c:forEach>

                                                    </select>

                                                    <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>

                                                </div>

                                            </td>

                                            <!-- START TIME -->
                                            <td class="sk-sch-td">

                                                <div class="sk-sch-time-wrap">

                                                    <select class="sk-sch-time-select"
                                                            name="start_${day}_${slot}">

                                                        <option value="">
                                                            --
                                                        </option>

                                                        <c:forEach var="t"
                                                                   items="${timeList}">

                                                            <option value="${t}"

                                                                <c:if test="${not empty existing
                                                                    and existing.startTime == t}">
                                                                    selected
                                                                </c:if>>

                                                                ${t}

                                                            </option>

                                                        </c:forEach>

                                                    </select>

                                                    <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>

                                                </div>

                                            </td>

                                            <!-- END TIME -->
                                            <td class="sk-sch-td">

                                                <div class="sk-sch-time-wrap">

                                                    <select class="sk-sch-time-select"
                                                            name="end_${day}_${slot}">

                                                        <option value="">
                                                            --
                                                        </option>

                                                        <c:forEach var="t"
                                                                   items="${timeList}">

                                                            <option value="${t}"

                                                                <c:if test="${not empty existing
                                                                    and existing.endTime == t}">
                                                                    selected
                                                                </c:if>>

                                                                ${t}

                                                            </option>

                                                        </c:forEach>

                                                    </select>

                                                    <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>

                                                </div>

                                            </td>

                                        </tr>

                                    </c:forEach>

                                </c:forEach>

                            </tbody>

                        </table>

                    </div>

                    <div class="sk-sch-save-row">

                        <button class="sk-btn sk-sch-save-btn"
                                type="submit">

                            Save Schedule

                        </button>

                    </div>

                </form>

            </c:if>

        </main>

    </div>

<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>

</div>

</body>
</html>
