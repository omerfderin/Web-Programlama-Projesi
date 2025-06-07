package controller;

import model.Review;
import model.ReviewDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addReview")
public class AddReviewServlet extends HttpServlet {
    
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
        
        String bookIdStr = request.getParameter("bookId");
        String comment = request.getParameter("comment");
        String ratingStr = request.getParameter("rating");
        
        if (bookIdStr == null || ratingStr == null) {
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        try {
            int bookId = Integer.parseInt(bookIdStr);
            int rating = Integer.parseInt(ratingStr);
            
            if (rating < 1 || rating > 5) {
                request.setAttribute("error", "Puan 1-5 arasında olmalıdır!");
                response.sendRedirect(request.getContextPath() + "/book/" + bookId);
                return;
            }
            
            model.User user = (model.User) session.getAttribute("user");
            
            if (ReviewDAO.hasUserReviewed(bookId, user.getId())) {
                request.setAttribute("error", "Bu kitap için zaten yorum yapmışsınız!");
                response.sendRedirect(request.getContextPath() + "/book/" + bookId);
                return;
            }
            
            Review review = new Review(bookId, user.getId(), comment, rating);
            
            if (ReviewDAO.addReview(review)) {
                response.sendRedirect(request.getContextPath() + "/book/" + bookId);
            } else {
                request.setAttribute("error", "Yorum eklenirken bir hata oluştu!");
                response.sendRedirect(request.getContextPath() + "/book/" + bookId);
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/books");
        }
    }
} 