<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${book.title} - KitapKöşem</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">Kitaplar</a>
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
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h2 class="card-title">${book.title}</h2>
                        <h6 class="card-subtitle mb-3 text-muted">${book.author}</h6>
                        <div class="rating mb-3">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= book.averageRating ? 'text-warning' : 'text-muted'}"></i>
                            </c:forEach>
                            <span class="ms-2">(${String.format("%.1f", book.averageRating)})</span>
                        </div>
                        <p class="card-text">${book.description}</p>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header">
                        <h4>Yorumlar</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${sessionScope.user != null && !hasReviewed}">
                            <form action="${pageContext.request.contextPath}/addReview" method="post" class="mb-4">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <div class="mb-3">
                                    <label class="form-label">Puanınız</label>
                                    <div class="rating-input">
                                        <c:forEach begin="1" end="5" var="i">
                                            <input type="radio" name="rating" value="${i}" id="rating${i}" required>
                                            <label for="rating${i}"><i class="fas fa-star"></i></label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="comment" class="form-label">Yorumunuz</label>
                                    <textarea class="form-control" id="comment" name="comment" rows="3" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Yorum Yap</button>
                            </form>
                        </c:if>

                        <c:forEach items="${reviews}" var="review">
                            <div class="review mb-3 pb-3 border-bottom">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div>
                                        <strong>${review.username}</strong>
                                        <div class="rating">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                            </c:forEach>
                                        </div>
                                    </div>
                                    <small class="text-muted">
                                        ${review.createdAt}
                                    </small>
                                </div>
                                <p class="mb-0">${review.comment}</p>
                            </div>
                        </c:forEach>

                        <c:if test="${empty reviews}">
                            <div class="alert alert-info">
                                Henüz yorum yapılmamış.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 