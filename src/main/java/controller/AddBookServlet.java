package controller;

import model.Book;
import model.BookDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
            request.getRequestDispatcher("/jsp/yeniKitap.jsp").forward(request, response);
            return;
        }
        
        model.User user = (model.User) session.getAttribute("user");
        Book book = new Book(title, author, description, user.getId());
        
        if (BookDAO.addBook(book)) {
            response.sendRedirect(request.getContextPath() + "/books");
        } else {
            request.setAttribute("error", "Kitap eklenirken bir hata oluştu!");
            request.getRequestDispatcher("/jsp/yeniKitap.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        request.getRequestDispatcher("/jsp/yeniKitap.jsp").forward(request, response);
    }
} 