package controller;

import model.User;
import model.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        // Validasyon
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "Tüm alanları doldurunuz!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Kullanıcı adı ve email kontrolü
        if (UserDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Bu kullanıcı adı zaten kullanılıyor!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        if (UserDAO.isEmailExists(email)) {
            request.setAttribute("error", "Bu email adresi zaten kullanılıyor!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }
        
        // Yeni kullanıcı oluştur
        User user = new User(username, password, email);
        
        if (UserDAO.register(user)) {
            request.setAttribute("success", "Kayıt başarılı! Giriş yapabilirsiniz.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Kayıt sırasında bir hata oluştu!");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }
} 