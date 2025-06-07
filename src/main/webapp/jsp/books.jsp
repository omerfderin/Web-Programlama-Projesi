<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kitaplar - KitapKöşem</title>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/books">
                            <i class="fas fa-books me-1"></i>Kitaplar
                        </a>
                    </li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/addBook">
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
        <div class="row mb-4">
            <div class="col-md-6 mx-auto">
                <form action="${pageContext.request.contextPath}/books" method="get" class="d-flex">
                    <input type="text" name="search" class="form-control" placeholder="Kitap adı veya yazar ara...">
                    <button type="submit" class="btn btn-primary ms-2">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${books}" var="book">
                <div class="col">
                    <div class="card h-100">
                        <div class="book-cover">
                            <c:if test="${not empty book.coverImage}">
                                <img src="${pageContext.request.contextPath}${book.coverImage}" 
                                     class="card-img-top" alt="${book.title}">
                            </c:if>
                            <c:if test="${empty book.coverImage}">
                                <img src="${pageContext.request.contextPath}/images/default-cover.jpg" 
                                     class="card-img-top" alt="Varsayılan Kapak">
                            </c:if>
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${book.title}</h5>
                            <h6 class="card-subtitle mb-2">${book.author}</h6>
                            <p class="card-text">${book.description}</p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <div class="rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star ${i <= book.averageRating ? '' : 'text-muted'}"></i>
                                    </c:forEach>
                                    <span class="ms-2">(${String.format("%.1f", book.averageRating)})</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/book/${book.id}" class="btn btn-primary">
                                    <i class="fas fa-info-circle me-1"></i>Detaylar
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty books}">
            <div class="alert alert-info mt-4 text-center">
                <i class="fas fa-info-circle me-2"></i>Henüz kitap eklenmemiş.
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>