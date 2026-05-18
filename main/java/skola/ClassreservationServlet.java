package skola;

import com.model.Classreservationmodel;
import com.service.ClassReservationService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/ClassReservationServlet")
public class ClassReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ClassReservationService service = new ClassReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (int) session.getAttribute("student_id");

        request.setAttribute("classes", service.getAllClasses());
        request.setAttribute("reservations", service.getReservationsByStudent(studentId));

        request.getRequestDispatcher("/WEB-INF/pages/class_student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("student_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int studentId = (int) session.getAttribute("student_id");

        String firstName  = request.getParameter("firstName");
        String classIdStr = request.getParameter("classId");
        String dateStr    = request.getParameter("date");
        String timeFrom   = request.getParameter("timeFrom");
        String timeTo     = request.getParameter("timeTo");
        String comment    = request.getParameter("comment");

        if (firstName == null || firstName.trim().isEmpty() ||
            classIdStr == null || classIdStr.trim().isEmpty() ||
            dateStr    == null || dateStr.trim().isEmpty()    ||
            timeFrom   == null || timeFrom.trim().isEmpty()   ||
            timeTo     == null || timeTo.trim().isEmpty()) {

            request.setAttribute("error", "First name, class, date, and time are required.");
            doGet(request, response);
            return;
        }

        try {
            Classreservationmodel r = new Classreservationmodel();
            r.setStudentId(studentId);
            r.setClassId(Integer.parseInt(classIdStr));
            r.setFirstName(firstName.trim());
            r.setDate(Date.valueOf(dateStr));
            r.setTimeFrom(Time.valueOf(timeFrom + ":00"));
            r.setTimeTo(Time.valueOf(timeTo + ":00"));
            r.setComment(comment != null ? comment.trim() : "");

            if (service.addReservation(r)) {
                request.setAttribute("success", "Reservation submitted successfully. Waiting for admin approval.");
            } else {
                request.setAttribute("error", "Failed to submit reservation. Please try again.");
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date, time, or class selection.");
        }

        doGet(request, response);
    }
}