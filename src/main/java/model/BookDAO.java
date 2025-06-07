package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

public class BookDAO {
    
    public static List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, COALESCE(AVG(r.rating), 0) as avg_rating " +
                    "FROM books b LEFT JOIN reviews r ON b.id = r.book_id " +
                    "GROUP BY b.id ORDER BY b.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setDescription(rs.getString("description"));
                book.setUserId(rs.getInt("user_id"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                book.setAverageRating(rs.getDouble("avg_rating"));
                book.setCoverImage(rs.getString("cover_image"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public static List<Book> searchBooks(String query) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, COALESCE(AVG(r.rating), 0) as avg_rating " +
                    "FROM books b LEFT JOIN reviews r ON b.id = r.book_id " +
                    "WHERE b.title LIKE ? OR b.author LIKE ? " +
                    "GROUP BY b.id ORDER BY b.created_at DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + query + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setUserId(rs.getInt("user_id"));
                    book.setCreatedAt(rs.getTimestamp("created_at"));
                    book.setAverageRating(rs.getDouble("avg_rating"));
                    book.setCoverImage(rs.getString("cover_image"));
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public static Book getBookById(int id) {
        String sql = "SELECT b.*, COALESCE(AVG(r.rating), 0) as avg_rating " +
                    "FROM books b LEFT JOIN reviews r ON b.id = r.book_id " +
                    "WHERE b.id = ? GROUP BY b.id";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setDescription(rs.getString("description"));
                    book.setUserId(rs.getInt("user_id"));
                    book.setCreatedAt(rs.getTimestamp("created_at"));
                    book.setAverageRating(rs.getDouble("avg_rating"));
                    book.setCoverImage(rs.getString("cover_image"));
                    return book;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, author, description, user_id, cover_image) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getDescription());
            ps.setInt(4, book.getUserId());
            ps.setString(5, book.getCoverImage());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean deleteBook(int bookId, int userId) {
        String sql = "DELETE FROM books WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bookId);
            stmt.setInt(2, userId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean deleteComment(int commentId, int userId) {
        String sql = "DELETE FROM comments WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, commentId);
            stmt.setInt(2, userId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}