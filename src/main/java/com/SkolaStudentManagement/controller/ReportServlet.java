package com.SkolaStudentManagement.controller;

import com.SkolaStudentManagement.model.Faculty;
import com.SkolaStudentManagement.model.Module;
import com.SkolaStudentManagement.model.Section;
import com.SkolaStudentManagement.model.StudentModel;
import com.SkolaStudentManagement.service.ReportService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/report")
public class ReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String view = req.getParameter("view");
        if (view == null || view.isEmpty()) {
            view = "students";
        }

        int facultyId = 0;
        String facultyIdParam = req.getParameter("facultyId");
        if (facultyIdParam != null && !facultyIdParam.isEmpty()) {
            try { 
                facultyId = Integer.parseInt(facultyIdParam); 
            } catch (NumberFormatException ignored) {}
        }

        String sectionId = req.getParameter("sectionId");
        if (sectionId != null && sectionId.isEmpty()) {
            sectionId = null; // Clean empty forms strings to avoid SQL lookup errors
        }

        // ── PDF Export Branch ─────────────────────────────────────────────
        if ("pdf".equals(req.getParameter("export"))) {
            exportPdf(req, resp, view, facultyId, sectionId);
            return;
        }

        // ── Standard UI Render Setup ──────────────────────────────────────
        List<Faculty> faculties = reportService.getAllFaculties();
        req.setAttribute("faculties", faculties);
        req.setAttribute("view", view);
        req.setAttribute("selectedFacultyId", facultyId);
        req.setAttribute("selectedSectionId", sectionId != null ? sectionId : "");

        if ("module".equals(view)) {
            if (facultyId > 0) {
                Map<Integer, List<Module>> modulesBySemester = reportService.getModulesByFaculty(facultyId);
                int totalModules = reportService.countModulesByFaculty(facultyId);
                
                List<Module> modules = modulesBySemester.values().stream()
                        .flatMap(List::stream)
                        .collect(java.util.stream.Collectors.toList());
                
                req.setAttribute("modules", modules);
                req.setAttribute("totalModules", totalModules);
            } else {
                req.setAttribute("totalModules", 0);
            }
        } else {
            // Students View context branch
            if (facultyId > 0) {
                // Always seed available sub-sections to view on form update
                List<Section> sections = reportService.getSectionsByFaculty(facultyId);
                req.setAttribute("sections", sections);

                List<StudentModel> students = reportService.getStudents(facultyId, sectionId);
                int totalStudents = reportService.countStudents(facultyId, sectionId);

                req.setAttribute("students", students);
                req.setAttribute("totalStudents", totalStudents);
            } else {
                // If no faculty is selected, show an empty list instead of a crash context
                req.setAttribute("sections", new ArrayList<Section>());
                req.setAttribute("students", new ArrayList<StudentModel>());
                req.setAttribute("totalStudents", 0);
            }
        }

        req.getRequestDispatcher("/WEB-INF/pages/Report.jsp").forward(req, resp);
    }

    // ── PDF Export Generation Logic ───────────────────────────────────────
    private void exportPdf(HttpServletRequest req, HttpServletResponse resp,
                           String view, int facultyId, String sectionId)
            throws IOException {

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=\"report.pdf\"");

        try {
            Document doc = new Document(PageSize.A4, 36, 36, 54, 36);
            PdfWriter.getInstance(doc, resp.getOutputStream());
            doc.open();

            Font titleFont  = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, new BaseColor(30, 30, 30));
            Font headerFont = new Font(Font.FontFamily.HELVETICA, 9,  Font.BOLD, BaseColor.WHITE);
            Font cellFont   = new Font(Font.FontFamily.HELVETICA, 9,  Font.NORMAL, new BaseColor(50, 50, 50));
            Font subFont    = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, new BaseColor(100, 100, 100));

            BaseColor headerBg = new BaseColor(155, 35, 53);   // Updated to match SKOLA brand crimson red
            BaseColor rowAlt   = new BaseColor(251, 242, 243);  // Soft pink alternate tracking tint

            if ("module".equals(view)) {
                doc.add(new Paragraph("Module Report", titleFont));
                doc.add(new Paragraph(" "));

                if (facultyId > 0) {
                    Map<Integer, List<Module>> bySemester = reportService.getModulesByFaculty(facultyId);

                    for (Map.Entry<Integer, List<Module>> entry : bySemester.entrySet()) {
                        Paragraph semLabel = new Paragraph("Semester " + entry.getKey(), subFont);
                        semLabel.setSpacingBefore(10);
                        doc.add(semLabel);

                        PdfPTable table = new PdfPTable(4);
                        table.setWidthPercentage(100);
                        table.setWidths(new float[]{1.2f, 2.5f, 4f, 1f});
                        table.setSpacingBefore(4);

                        addHeaderCell(table, "Module ID",   headerFont, headerBg);
                        addHeaderCell(table, "Module Name", headerFont, headerBg);
                        addHeaderCell(table, "Description", headerFont, headerBg);
                        addHeaderCell(table, "Credits",     headerFont, headerBg);

                        boolean alt = false;
                        for (Module m : entry.getValue()) {
                            BaseColor bg = alt ? rowAlt : BaseColor.WHITE;
                            addCell(table, String.valueOf(m.getModuleId()),   cellFont, bg);
                            addCell(table, m.getModuleName(),                 cellFont, bg);
                            addCell(table, m.getModule_description() != null ? m.getModule_description() : "", cellFont, bg);
                            addCell(table, String.valueOf(m.getModule_credits()), cellFont, bg);
                            alt = !alt;
                        }
                        doc.add(table);
                    }

                    int total = reportService.countModulesByFaculty(facultyId);
                    Paragraph totLine = new Paragraph("Total modules: " + total, subFont);
                    totLine.setSpacingBefore(8);
                    doc.add(totLine);

                } else {
                    doc.add(new Paragraph("Please select a faculty to export modules.", subFont));
                }

            } else {
                doc.add(new Paragraph("Student Report", titleFont));
                doc.add(new Paragraph(" "));

                if (facultyId > 0) {
                    List<StudentModel> students = reportService.getStudents(facultyId, sectionId);

                    PdfPTable table = new PdfPTable(5);
                    table.setWidthPercentage(100);
                    table.setWidths(new float[]{1.2f, 2.5f, 2.5f, 1.5f, 1.5f});
                    table.setSpacingBefore(4);

                    addHeaderCell(table, "Student ID",   headerFont, headerBg);
                    addHeaderCell(table, "Student Name", headerFont, headerBg);
                    addHeaderCell(table, "Course",       headerFont, headerBg);
                    addHeaderCell(table, "Semester",     headerFont, headerBg);
                    addHeaderCell(table, "Section",      headerFont, headerBg);

                    boolean alt = false;
                    for (StudentModel s : students) {
                        BaseColor bg = alt ? rowAlt : BaseColor.WHITE;
                        addCell(table, String.valueOf(s.getStudentId()),       cellFont, bg);
                        addCell(table, s.getFirstName() + " " + s.getLastName(), cellFont, bg);
                        addCell(table, s.getFacultyName() != null ? s.getFacultyName() : "", cellFont, bg);
                        addCell(table, gradeLevelToSemester(s.getGradeLevel()), cellFont, bg);
                        addCell(table, s.getSectionId() != null ? s.getSectionId() : "", cellFont, bg);
                        alt = !alt;
                    }
                    doc.add(table);

                    int total = reportService.countStudents(facultyId, sectionId);
                    Paragraph totLine = new Paragraph("Total students: " + total, subFont);
                    totLine.setSpacingBefore(8);
                    doc.add(totLine);

                } else {
                    doc.add(new Paragraph("Please select a faculty to export students.", subFont));
                }
            }

            doc.close();

        } catch (DocumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to generate PDF: " + e.getMessage());
        }
    }

    private void addHeaderCell(PdfPTable table, String text, Font font, BaseColor bg) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setBackgroundColor(bg);
        cell.setPadding(6);
        cell.setBorder(Rectangle.NO_BORDER);
        table.addCell(cell);
    }

    private void addCell(PdfPTable table, String text, Font font, BaseColor bg) {
        PdfPCell cell = new PdfPCell(new Phrase(text != null ? text : "", font));
        cell.setBackgroundColor(bg);
        cell.setPadding(5);
        cell.setBorderColor(new BaseColor(220, 220, 230));
        cell.setBorderWidth(0.5f);
        table.addCell(cell);
    }

    private String gradeLevelToSemester(String gradeLevel) {
        if (gradeLevel == null) return "";
        switch (gradeLevel.trim()) {
            case "1": return "Semester 1";
            case "2": return "Semester 2";
            case "3": return "Semester 3";
            case "4": return "Semester 4";
            case "5": return "Semester 5";
            case "6": return "Semester 6";
            default:  return gradeLevel;
        }
    }
}