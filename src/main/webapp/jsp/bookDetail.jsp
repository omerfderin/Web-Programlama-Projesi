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

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="book-cover mb-3">
                                    <c:if test="${not empty book.coverImage}">
                                        <img src="${pageContext.request.contextPath}${book.coverImage}" 
                                             class="img-fluid rounded" alt="${book.title}">
                                    </c:if>
                                    <c:if test="${empty book.coverImage}">
                                        <img src="${pageContext.request.contextPath}/images/default-cover.jpg" 
                                             class="img-fluid rounded" alt="Varsayılan Kapak">
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <h2 class="card-title">${book.title}</h2>
                                <h6 class="card-subtitle mb-3 text-muted">${book.author}</h6>
                                <div class="rating mb-3">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fas fa-star ${i <= book.averageRating ? '' : 'text-muted'}"></i>
                                    </c:forEach>
                                    <span class="ms-2">(${String.format("%.1f", book.averageRating)})</span>
                                </div>
                                <p class="card-text">${book.description}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-light">
                        <h4 class="mb-0">Yorumlar</h4>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty sessionScope.user}">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                Yorum yapabilmek için lütfen <a href="${pageContext.request.contextPath}/login" class="alert-link">giriş yapın</a> veya <a href="${pageContext.request.contextPath}/register" class="alert-link">kayıt olun</a>.
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.user != null && !hasReviewed}">
                            <form action="${pageContext.request.contextPath}/addReview" method="post" class="mb-4">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <div class="mb-3">
                                    <label class="form-label">Puanınız</label>
                                    <div class="rating-input" id="ratingInputContainer">
                                        <c:forEach begin="1" end="5" var="i">
                                            <input type="radio" name="rating" value="${i}" id="rating${i}" required>
                                            <label for="rating${i}" data-rating="${i}"><i class="fas fa-star"></i></label>
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
                            <div class="review">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div>
                                        <strong>${review.username}</strong>
                                        <div class="rating">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fas fa-star ${i <= review.rating ? '' : 'text-muted'}"></i>
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
                                <i class="fas fa-info-circle me-2"></i>
                                Henüz yorum yapılmamış.
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ratingInputContainer = document.getElementById('ratingInputContainer');
            if (!ratingInputContainer) return;

            const stars = ratingInputContainer.querySelectorAll('label i');
            const radioButtons = ratingInputContainer.querySelectorAll('input[type="radio"]');

            function highlightStars(rating) {
                stars.forEach((star, index) => {
                    if (index < rating) {
                        star.classList.add('fas');
                        star.classList.remove('far');
                        star.style.color = '#f39c12';
                    } else {
                        star.classList.add('far');
                        star.classList.remove('fas');
                        star.style.color = '#ddd';
                    }
                });
            }
            radioButtons.forEach(radio => {
                if (radio.checked) {
                    highlightStars(parseInt(radio.value));
                }
            });
            ratingInputContainer.addEventListener('mouseover', function(event) {
                let targetLabel = event.target.closest('label');
                if (targetLabel) {
                    const rating = parseInt(targetLabel.getAttribute('for').replace('rating', ''));
                    highlightStars(rating);
                }
            });
            ratingInputContainer.addEventListener('mouseout', function() {
                let checkedRating = 0;
                radioButtons.forEach(radio => {
                    if (radio.checked) {
                        checkedRating = parseInt(radio.value);
                    }
                });
                highlightStars(checkedRating);
            });
            radioButtons.forEach(radio => {
                radio.addEventListener('change', function() {
                    highlightStars(parseInt(this.value));
                });
            });
        });
    </script>
</body>
</html>