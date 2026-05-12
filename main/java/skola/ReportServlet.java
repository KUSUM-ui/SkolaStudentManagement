package skola;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ReportServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String view = request.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "students";
        }

        // Handle PDF export click — just redirect back for now
        String export = request.getParameter("export");
        if ("pdf".equals(export)) {
            response.sendRedirect(request.getContextPath() + "/ReportServlet?view=" + view);
            return;
        }

        request.setAttribute("view", view);

        request.getRequestDispatcher("/WEB-INF/pages/Report.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    
}
}