package controller;

import model.Book;
import model.BookDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class BookListServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String search = request.getParameter("search");
        List<Book> books;
        
        if (search != null && !search.trim().isEmpty()) {
            books = BookDAO.searchBooks(search);
        } else {
            books = BookDAO.getAllBooks();
        }
        
        request.setAttribute("books", books);
        request.getRequestDispatcher("/jsp/books.jsp").forward(request, response);
    }
} 