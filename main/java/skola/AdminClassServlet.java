package skola;

import com.model.Classreservationmodel;
import com.service.ClassReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/classes")
public class AdminClassServlet extends HttpServlet {

    private final ClassReservationService service = new ClassReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Transfer flash messages from session into request scope, then clear
        HttpSession session = request.getSession(false);
        if (session != null) {
            String success = (String) session.getAttribute("success");
            String error   = (String) session.getAttribute("error");
            if (success != null) {
                request.setAttribute("success", success);
                session.removeAttribute("success");
            }
            if (error != null) {
                request.setAttribute("error", error);
                session.removeAttribute("error");
            }
        }

        List<Classreservationmodel> reservations = service.getAllReservations();
        request.setAttribute("reservations", reservations);

        request.getRequestDispatcher("/WEB-INF/pages/admin_class.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationIdStr = request.getParameter("reservationId");
        String action           = request.getParameter("action");
        HttpSession session     = request.getSession();

        try {
            int reservationId = Integer.parseInt(reservationIdStr);

            String status;
            switch (action.toLowerCase()) {
                case "approve":
                    status = "Approved";
                    break;
                case "reject":
                    status = "Disapproved";
                    break;
                default:
                    status = "Pending";
            }

            boolean updated = service.updateStatus(reservationId, status);

            if (updated) {
                session.setAttribute("success", "Reservation " + status + " successfully.");
            } else {
                session.setAttribute("error", "Update failed. Please try again.");
            }

        } catch (Exception e) {
            session.setAttribute("error", "Invalid request.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/classes");
    }
}