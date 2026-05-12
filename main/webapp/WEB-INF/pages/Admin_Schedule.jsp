<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>SKOLA - Manage Schedule</title>
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
        <h2>Manage Schedule</h2>
        <div class="sk-stusch-topbar-right">
          <div class="sk-stusch-search-wrap">
            <i class="ri-search-line"></i>
            <input type="text" class="sk-stusch-search" placeholder="Search" name="search"/>
          </div>
          <div class="sk-avatar">
            <img src="${pageContext.request.contextPath}/img/student-avatar.png"
                 alt="Student"
                 onerror="this.style.display='none';this.nextElementSibling.style.display='block'"/>
            <i class="ri-user-line" style="display:none;"></i>
          </div>
        </div>
      </div>

      <!-- Filter Row -->
      <div class="sk-sch-filter-row">
        <div class="sk-sch-select-wrap">
          <select class="sk-sch-select" name="faculty">
            <option value="">Faculty</option>
          </select>
          <i class="ri-arrow-down-s-line sk-sch-arrow"></i>
        </div>
        <div class="sk-sch-select-wrap">
          <select class="sk-sch-select" name="semester">
            <option value="">Semester</option>
          </select>
          <i class="ri-arrow-down-s-line sk-sch-arrow"></i>
        </div>
        <div class="sk-sch-select-wrap">
          <select class="sk-sch-select" name="section">
            <option value="">Section</option>
          </select>
          <i class="ri-arrow-down-s-line sk-sch-arrow"></i>
        </div>
      </div>

      <!-- Schedule Table -->
      <div class="sk-sch-table-wrap">
        <table class="sk-sch-table">
          <thead>
            <tr>
              <th class="sk-sch-th sk-sch-th-day">Day</th>
              <th class="sk-sch-th">Start - Time</th>
              <th class="sk-sch-th">End - Time</th>
              <th class="sk-sch-th sk-sch-th-module">Module</th>
            </tr>
          </thead>
          <tbody>

            <!-- Sunday - Module 1 -->
            <tr class="sk-sch-tr">
              <td class="sk-sch-td sk-sch-td-day">Sunday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun1_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun1_end">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 1</td>
            </tr>

            <!-- Sunday - Module 2 -->
            <tr class="sk-sch-tr">
              <td class="sk-sch-td sk-sch-td-day">Sunday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun2_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun2_end">
                   <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 2</td>
            </tr>

            <!-- Sunday - Module 3 -->
            <tr class="sk-sch-tr">
              <td class="sk-sch-td sk-sch-td-day">Sunday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun3_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun3_end">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 3</td>
            </tr>

            <!-- Sunday - Module 4 -->
            <tr class="sk-sch-tr">
              <td class="sk-sch-td sk-sch-td-day">Sunday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun4_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="sun4_end">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 4</td>
            </tr>

            <!-- Monday - Module 1 -->
            <tr class="sk-sch-tr sk-sch-tr-day-start">
              <td class="sk-sch-td sk-sch-td-day">Monday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="mon1_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="mon1_end">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 1</td>
            </tr>

            <!-- Monday - Module 2 -->
            <tr class="sk-sch-tr">
              <td class="sk-sch-td sk-sch-td-day">Monday</td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="mon2_start">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td">
                <div class="sk-sch-time-wrap">
                  <select class="sk-sch-time-select" name="mon2_end">
                    <option value="00:00">00:00</option>
                    <option value="06:00">06:00 AM</option>
                    <option value="06:30">06:30 AM</option>
                    <option value="07:00">07:00 AM</option>
                    <option value="07:30">07:30 AM</option>
                    <option value="08:00">08:00 AM</option>
                    <option value="08:30">08:30 AM</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="09:30">09:30 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="10:30">10:30 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="11:30">11:30 AM</option>
                    <option value="12:00">12:00 PM</option>
                    <option value="12:30">12:30 PM</option>
                    <option value="01:00">01:00 PM</option>
                    <option value="01:30">01:30 PM</option>
                    <option value="02:00">02:00 PM</option>
                    <option value="02:30">02:30 PM</option>
                    <option value="03:00">03:00 PM</option>
                    <option value="03:30">03:30 PM</option>
                    <option value="04:00">04:00 PM</option>
                    <option value="04:30">04:30 PM</option>
                    <option value="05:00">05:00 PM</option>
                    <option value="05:30">05:30 PM</option>
                    <option value="06:00">06:00 PM</option>
                  </select>
                  <i class="ri-arrow-down-s-line sk-sch-time-arrow"></i>
                </div>
              </td>
              <td class="sk-sch-td sk-sch-td-module-name">Module 2</td>
            </tr>

          </tbody>
        </table>
      </div>

      <!-- Save Button -->
      <div class="sk-sch-save-row">
        <button class="sk-btn sk-sch-save-btn" type="button">Save</button>
      </div>

    </main>
  </div>

  <jsp:include page="_footer.jsp" />

</div>

</body>
</html>