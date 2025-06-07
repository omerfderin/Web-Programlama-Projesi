<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Yeni Kitap Ekle - KitapKöşem</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/books">
                <i class="fas fa-book-open me-2"></i>KitapKöşem
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">
                            <i class="fas fa-books me-1"></i>Kitaplar
                        </a>
                    </li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/addBook">
                                <i class="fas fa-plus me-1"></i>Yeni Kitap Ekle
                            </a>
                        </li>
                    </c:if>
                </ul>
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <span class="navbar-text me-3">
                                <i class="fas fa-user me-1"></i>${sessionScope.user.username}
                            </span>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">
                                <i class="fas fa-sign-out-alt me-1"></i>Çıkış
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">
                                <i class="fas fa-sign-in-alt me-1"></i>Giriş
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-light">
                                <i class="fas fa-user-plus me-1"></i>Kayıt
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="auth-card">
                    <div class="card-header">
                        <h3><i class="fas fa-plus-circle me-2"></i>Yeni Kitap Ekle</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/addBook" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="title" class="form-label">
                                    <i class="fas fa-book me-2"></i>Kitap Adı
                                </label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="mb-3">
                                <label for="author" class="form-label">
                                    <i class="fas fa-user-edit me-2"></i>Yazar
                                </label>
                                <input type="text" class="form-control" id="author" name="author" required>
                            </div>
                            <div class="mb-3">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left me-2"></i>Açıklama
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="coverImage" class="form-label">
                                    <i class="fas fa-image me-2"></i>Kitap Kapağı
                                </label>
                                <input type="file" class="form-control" id="coverImage" name="coverImage" accept="image/*">
                                <small class="form-text text-muted">Maksimum dosya boyutu: 2MB. İzin verilen formatlar: JPG, PNG, GIF</small>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i>Kitap Ekle
                                </button>
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>İptal
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>