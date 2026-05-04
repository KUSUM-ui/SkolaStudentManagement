<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    footer.jsp
    Reusable footer fragment for SKOLA
    Include in any page: <%@ include file="footer.jsp" %>
--%>
<%
    String contextPath = request.getContextPath();
    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
%>
<footer class="site-footer" role="contentinfo">

    <div class="footer-top">

        <!-- Brand column -->
        <div class="footer-brand">
            <a href="<%= contextPath %>/index.jsp" class="logo" aria-label="SKOLA Home">
                <span class="logo-text">SKOLA</span>
            </a>
            <p class="footer-tagline">
                The Academic Curator for institutions that value excellence, aesthetics,
                and efficiency in every digital touchpoint.
            </p>
        </div>

        <!-- Nav column -->
        <nav class="footer-nav" aria-label="Footer navigation">
            <h4>Navigation</h4>
            <ul>
                <li><a href="<%= contextPath %>/index.jsp">Home</a></li>
                <li><a href="<%= contextPath %>/about.jsp">About Us</a></li>
                <li><a href="<%= contextPath %>/contact.jsp">Contact Us</a></li>
            </ul>
        </nav>

        <!-- Contact column -->
        <div class="footer-contact">
            <h4>Contact</h4>
            <ul>
                <li>
                    <!-- Email icon -->
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                         stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <rect x="2" y="4" width="20" height="16" rx="2"/>
                        <path d="M2 7l10 7 10-7"/>
                    </svg>
                    <a href="mailto:skola@edu.np">skola@edu.np</a>
                </li>
                <li>
                    <!-- Phone icon -->
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                         stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07
                                 A19.5 19.5 0 013.07 9.81a19.79 19.79 0 01-3.07-8.67A2 2 0
                                 012.18 1h3a2 2 0 012 1.72c.13 1 .39 1.99.74 2.94a2 2 0
                                 01-.45 2.11L6.91 8.86a16 16 0 006.23 6.23l1.09-1.09a2 2 0
                                 012.11-.45 12.84 12.84 0 002.94.74A2 2 0 0122 16.92z"/>
                    </svg>
                    <span>977+ 9741877269</span>
                </li>
                <li>
                    <!-- Location icon -->
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                         stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                        <path d="M21 10c0 7-9 13-9 13S3 17 3 10a9 9 0 0118 0z"/>
                        <circle cx="12" cy="10" r="3"/>
                    </svg>
                    <span>Suryabinayak, BKT</span>
                </li>
            </ul>
        </div>

    </div><!-- /.footer-top -->

    <div class="footer-bottom">
        <span>&copy; <%= currentYear %> SKOLA. All rights reserved.</span>
        <div class="footer-bottom-links">
            <a href="<%= contextPath %>/privacy.jsp">Privacy Policy</a>
            <a href="<%= contextPath %>/terms.jsp">Terms of Service</a>
            <a href="<%= contextPath %>/cookies.jsp">Cookies Settings</a>
        </div>
    </div>

</footer>
