package skola;
import com.model.Notes;
import com.service.NotesService;
import com.utils.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

@WebServlet("/student/notes")
public class NotesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NotesService notesService = new NotesService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;
        if (userEmail == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        try {
            int studentId = fetchStudentIdFromEmail(userEmail);
            if (studentId == -1) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            session.setAttribute("student_id", studentId);

            String search = request.getParameter("search");
            List<Notes> notesList;

            if (search != null && !search.trim().isEmpty()) {
                notesList = notesService.searchNotesByTitle(studentId, search);
            } else {
                notesList = notesService.getNotesByStudentId(studentId);
            }

            request.setAttribute("notesList", notesList);
            request.getRequestDispatcher("/WEB-INF/pages/notes.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    private int fetchStudentIdFromEmail(String email) {
        String sql = "SELECT student_id FROM Student WHERE email = ?";
        try (Connection con = DBConfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, email);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("student_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}