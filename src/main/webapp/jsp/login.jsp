<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giriş Yap - KitapKöşem</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-5">
                <div class="card auth-card">
                    <div class="card-header">
                        <h3><i class="fas fa-sign-in-alt me-2"></i>Giriş Yap</h3>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle me-2"></i>
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user me-1"></i>Kullanıcı Adı
                                </label>
                                <input type="text" class="form-control" id="username" name="username" required>
                            </div>
                            <div class="mb-4">
                                <label for="password" class="form-label">
                                    <i class="fas fa-lock me-1"></i>Şifre
                                </label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="d-grid mb-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-sign-in-alt me-2"></i>Giriş Yap
                                </button>
                            </div>
                        </form>
                        
                        <div class="text-center">
                            <p class="mb-0">Hesabınız yok mu? 
                                <a href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus me-1"></i>Kayıt Ol
                                </a>
                            </p>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-1"></i>Ana Sayfaya Dön
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>