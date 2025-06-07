package controller;

import model.Book;
import model.Review;
import model.BookDAO;
import model.ReviewDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/book/*")
public class BookDetailServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
    	
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(pathInfo.substring(1));
            Book book = BookDAO.getBookById(bookId);
            
            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/books");
                return;
            }
            
            List<Review> reviews = ReviewDAO.getReviewsByBookId(bookId);
            
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                model.User user = (model.User) session.getAttribute("user");
                boolean hasReviewed = ReviewDAO.hasUserReviewed(bookId, user.getId());
                request.setAttribute("hasReviewed", hasReviewed);
            }
            
            request.setAttribute("book", book);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/jsp/bookDetail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/books");
        }
    }
} 