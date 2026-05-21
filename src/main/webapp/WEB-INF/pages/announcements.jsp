<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Skola - Announcements</title>
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/skola.css"/>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/announcement.css"/>
</head>

<body class="sk-page sk-announce-page">
<div class="sk-app">

    <jsp:include page="/WEB-INF/fragments/_sidebar_admin.jsp">
        <jsp:param name="activePage" value="announcements"/>
    </jsp:include>

    <main class="sk-main">

        <div class="sk-topbar">
            <h2>Announcements</h2>
            <div class="sk-avatar">
            <i class="ri-user-line"></i>
            </div>
        </div>

        <!-- Flash messages (session-cleared by servlet) -->
        <c:if test="${not empty successMessage}">
            <div class="sk-alert sk-alert-success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="sk-alert sk-alert-error">${errorMessage}</div>
        </c:if>

        <!-- Edit form or create form -->
        <c:choose>
            <c:when test="${not empty editAnn}">

                <div class="sk-announce-form-box" style="border-color: #9b2335;">
                    <span>Edit announcement</span>

                    <form action="${pageContext.request.contextPath}/admin/announcements"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden" name="_method" value="saveEdit"/>
                        <input type="hidden" name="id"      value="${editAnn.announcementId}"/>

                        <input type="text"
                               name="title"
                               class="sk-announce-title-input"
                               value="${editAnn.title}"
                               />

                        <div class="sk-announce-genre">
                            <label for="editGenre">Genre</label>
                            <select id="editGenre" name="genre" class="sk-genre-select" >
                                <option value="academics"
                                        ${editAnn.genre == 'academics' ? 'selected' : ''}>Academics</option>
                                <option value="non-academics"
                                        ${editAnn.genre == 'non-academics' ? 'selected' : ''}>Non-Academics</option>
                            </select>
                        </div>

                        <textarea name="content" >${editAnn.content}</textarea>

                        <c:if test="${not empty editAnn.imagePath}">
                            <div style="margin-top:10px;">
                                <p style="font-size:12px; color:#7a7a7a; margin-bottom:6px;">Current image:</p>
                                <img src="${pageContext.request.contextPath}/${editAnn.imagePath}"
                                     style="height:80px; border-radius:8px; object-fit:cover;"/>
                            </div>
                        </c:if>

                        <div class="sk-announce-form-footer">
                            <label for="editImageUpload" class="sk-icon-btn" title="Replace Image">
                                <i class="ri-image-add-line"></i>
                            </label>
                            <input type="file" id="editImageUpload" name="imageFile" accept="image/*"/>

                            <label for="editAttachUpload" class="sk-icon-btn" title="Replace Attachment">
                                <i class="ri-attachment-line"></i>
                            </label>
                            <input type="file" id="editAttachUpload" name="attachmentFile"
                                   accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt"/>

                            <a href="${pageContext.request.contextPath}/admin/announcements"
                               class="sk-btn-outline"
                               style="margin-left:auto; padding:10px 20px;">Cancel</a>

                            <button type="submit" class="sk-btn" style="padding:10px 20px;">
                                Save Changes
                            </button>
                        </div>

                    </form>
                </div>

            </c:when>
            <c:otherwise>

                <!-- Post new announcement -->
                <form action="${pageContext.request.contextPath}/admin/announcements"
                      method="post"
                      enctype="multipart/form-data">

                    <input type="hidden" name="sourcePage" value="announcements"/>

                    <div class="sk-announce-form-box">
                        <span>Post new announcement</span>

                        <input type="text"
                               name="title"
                               class="sk-announce-title-input"
                               placeholder="Title"
                               />

                        <div class="sk-announce-genre">
                            <label for="genre">Genre</label>
                            <select id="genre" name="genre" class="sk-genre-select">
                                <option value="" disabled selected>Select genre</option>
                                <option value="academics">Academics</option>
                                <option value="non-academics">Non-Academics</option>
                            </select>
                        </div>

                        <textarea name="content" placeholder="Write here..." ></textarea>

                        <div class="sk-announce-form-footer">
                            <label for="imageUpload" class="sk-icon-btn" title="Upload Image">
                                <i class="ri-image-add-line"></i>
                            </label>
                            <input type="file" id="imageUpload" name="imageFile" accept="image/*"/>

                            <label for="attachmentUpload" class="sk-icon-btn" title="Upload Attachment">
                                <i class="ri-attachment-line"></i>
                            </label>
                            <input type="file" id="attachmentUpload" name="attachmentFile"
                                   accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.txt"/>

                            <button type="submit" class="sk-btn" style="margin-left:auto;">Post</button>
                        </div>
                    </div>

                </form>

            </c:otherwise>
        </c:choose>

        <!-- Filter tabs -->
        <div class="sk-announce-list-label">
            Recent announcements

            <div class="sk-announce-filter">
                <a href="${pageContext.request.contextPath}/admin/announcements?filter=all"
                   class="sk-filter-btn ${activeFilter == 'all' ? 'active' : ''}">All</a>

                <a href="${pageContext.request.contextPath}/admin/announcements?filter=academics"
                   class="sk-filter-btn ${activeFilter == 'academics' ? 'active' : ''}">Academics</a>

                <a href="${pageContext.request.contextPath}/admin/announcements?filter=non-academics"
                   class="sk-filter-btn ${activeFilter == 'non-academics' ? 'active' : ''}">Non-Academics</a>
            </div>
        </div>

        <!-- Announcement list -->
        <div class="sk-announce-list">
            <c:choose>
                <c:when test="${not empty announcements}">
                    <c:forEach var="ann" items="${announcements}">
                        <div class="sk-announce-item">

                            <div class="sk-announce-item-header">
                                <strong>${ann.title}</strong>
                                <span class="sk-announce-badge sk-badge-${ann.genre}">${ann.genre}</span>
                            </div>

                            <p>${ann.content}</p>

                            <%-- Image is scoped to .sk-announce-page so it never bleeds --%>
                            <c:if test="${not empty ann.imagePath}">
                                <img src="${pageContext.request.contextPath}/${ann.imagePath}"
                                     class="sk-announce-img"
                                     alt="Announcement Image"/>
                            </c:if>

                            <c:if test="${not empty ann.attachmentPath}">
                                <a href="${pageContext.request.contextPath}/${ann.attachmentPath}"
                                   class="sk-announce-attachment"
                                   target="_blank">
                                    <i class="ri-file-line"></i> Download attachment
                                </a>
                            </c:if>

                            <div class="sk-announce-item-footer">
                                <small>${ann.publishedAt}</small>

                                <div class="sk-announce-actions">

                                    <!-- Edit -->
                                    <form action="${pageContext.request.contextPath}/admin/announcements"
                                          method="post"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="_method" value="edit"/>
                                        <input type="hidden" name="id"      value="${ann.announcementId}"/>
                                        <button type="submit" class="sk-announce-edit-btn">
                                            <i class="ri-edit-line"></i> Edit
                                        </button>
                                    </form>

                                    <!-- Delete  -->
                                    <form action="${pageContext.request.contextPath}/admin/announcements"
                                          method="post">
                                        <input type="hidden" name="_method" value="delete"/>
                                        <input type="hidden" name="id"      value="${ann.announcementId}"/>
                                        <button type="submit" class="sk-announce-delete-btn">
                                            <i class="ri-delete-bin-line"></i> Delete
                                        </button>
                                    </form>

                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="sk-empty-msg">No announcements yet.</p>
                </c:otherwise>
            </c:choose>
        </div>

    </main>
</div>

<jsp:include page="/WEB-INF/fragments/_footer_admin.jsp"/>
</body>
</html>
