package controller;

import model.Book;
import model.BookDAO;
import java.io.IOException;
import java.io.File;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/addBook")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 2,   // 2 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AddBookServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        
        if (title == null || title.trim().isEmpty() ||
            author == null || author.trim().isEmpty()) {
            
            request.setAttribute("error", "Kitap adı ve yazar alanları zorunludur!");
            request.getRequestDispatcher("/jsp/newBook.jsp").forward(request, response);
            return;
        }
        
        String coverImagePath = null;
        try {
            Part filePart = request.getPart("coverImage");
            if (filePart != null && filePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/uploads/book_covers");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    boolean created = uploadDir.mkdirs();
                    if (!created) {
                        throw new ServletException("Yükleme dizini oluşturulamadı!");
                    }
                }
                
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String ext = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();

                if (!ext.matches("\\.(jpg|jpeg|png|gif)$")) {
                    throw new ServletException("Sadece JPG, JPEG, PNG ve GIF dosyaları yüklenebilir!");
                }
                
                String fileName = System.currentTimeMillis() + ext;
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                coverImagePath = "/uploads/book_covers/" + fileName;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Görsel yüklenirken bir hata oluştu: " + e.getMessage());
            request.getRequestDispatcher("/jsp/newBook.jsp").forward(request, response);
            return;
        }
        
        model.User user = (model.User) session.getAttribute("user");
        Book book = new Book(title, author, description, user.getId());
        book.setCoverImage(coverImagePath);
        
        if (BookDAO.addBook(book)) {
            response.sendRedirect(request.getContextPath() + "/books");
        } else {
            request.setAttribute("error", "Kitap eklenirken bir hata oluştu!");
            request.getRequestDispatcher("/jsp/newBook.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/jsp/newBook.jsp").forward(request, response);
    }
}