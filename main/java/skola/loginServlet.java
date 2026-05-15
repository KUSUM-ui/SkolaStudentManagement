package skola;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import com.service.LoginService;
import com.utils.SessionUtil;
import com.utils.CookieUtil;

@WebServlet("/login")
public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private LoginService service = new LoginService();

    // ===================== GET =====================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
               .forward(request, response);
    }

    // ===================== POST =====================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // ===================== VALIDATION =====================
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            boolean isValid = service.login(email.trim(), password.trim(), role.trim());

            if (isValid) {

                // ===================== SESSION =====================
                SessionUtil.invalidateSession(request);
                SessionUtil.setAttribute(request, "userEmail", email.trim());
                SessionUtil.setAttribute(request, "userRole", role.trim().toLowerCase());

                // ===================== COOKIE =====================
                CookieUtil.addCookie(response, "role", role.trim(), 60 * 60);

                // ===================== ROLE-BASED REDIRECT =====================
                String userRole = role.trim().toLowerCase();

                switch (userRole) {
                    case "admin":
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                        break;

                    case "student":
                        response.sendRedirect(request.getContextPath() + "/student/dashboard");
                        break;

                    default:
                        request.setAttribute("error", "Invalid role.");
                        request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                               .forward(request, response);
                        break;
                }

            } else {
                request.setAttribute("error", "Invalid email, password, or role.");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                       .forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp")
                   .forward(request, response);
        }
    }
}
