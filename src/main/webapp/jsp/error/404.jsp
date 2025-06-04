<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Sayfa Bulunamadı</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <h1 class="display-1">404</h1>
                <h2 class="mb-4">Sayfa Bulunamadı</h2>
                <p class="lead mb-4">Aradığınız sayfa bulunamadı veya taşınmış olabilir.</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Ana Sayfaya Dön</a>
            </div>
        </div>
    </div>
</body>
</html> 