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
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/books">KitapKöşem</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/books">Kitaplar</a>
                    </li>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/addBook">Yeni Kitap Ekle</a>
                        </li>
                    </c:if>
                </ul>
                <div class="d-flex">
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <span class="navbar-text me-3">
                                Hoş geldin, ${sessionScope.user.username}
                            </span>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Çıkış Yap</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2">Giriş Yap</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-light">Kayıt Ol</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col">
                <form action="${pageContext.request.contextPath}/books" method="get" class="d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Kitap adı veya yazar ara...">
                    <button type="submit" class="btn btn-primary">Ara</button>
                </form>
            </div>
        </div>

        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach items="${books}" var="book">
                <div class="col">
                    <div class="card h-100">
                        <div class="card-body">
                            <h5 class="card-title">${book.title}</h5>
                            <h6 class="card-subtitle mb-2 text-muted">${book.author}</h6>
                            <p class="card-text">${book.description}</p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star ${i <= book.averageRating ? 'text-warning' : 'text-muted'}"></i>
                                    </c:forEach>
                                    <span class="ms-2">(${String.format("%.1f", book.averageRating)})</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/book/${book.id}" class="btn btn-primary">Detaylar</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty books}">
            <div class="alert alert-info mt-4">
                Henüz kitap eklenmemiş.
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 