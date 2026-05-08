package skola;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import com.model.Notes;
import com.service.NotesService;

@WebServlet("/NotesSevlet")
public class NotesSevlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private NotesService notesService = new NotesService();

    public NotesSevlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Notes> notesList = notesService.getNotesByStudentId(1);
            request.setAttribute("notesList", notesList);
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Could not load notes.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/notes.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String title   = request.getParameter("noteTitle");
                String content = request.getParameter("noteContent");
                notesService.addNote(1, title, content);

            } else if ("delete".equals(action)) {
                int noteId = Integer.parseInt(request.getParameter("noteId"));
                notesService.deleteNote(noteId, 1);
            }

        } catch (Exception e) {
            request.setAttribute("errorMsg", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/notes.jsp")
                   .forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/NotesSevlet");
    }
}