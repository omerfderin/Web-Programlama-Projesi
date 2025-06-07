# Kitap Köşem

Online Kitap İnceleme ve Puanlama Sistemi

## Teknik Gereksinimler

- Java JDK 8 veya üzeri
- Apache Tomcat 9.0
- MySQL 8.0
- Maven 3.6 veya üzeri
- Eclipse IDE (önerilen)

## Kurulum

1. Projeyi klonlayın ya da doğrudan paylaşılan klasörü IDE içerisinde açınız:
```bash
git clone https://github.com/kullaniciadi/KitapKosem.git
```

2. MySQL veritabanını oluşturun:
```sql
CREATE DATABASE kitapkosem;
USE kitapkosem;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    description TEXT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    comment TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
); 

ALTER TABLE books
ADD COLUMN cover_image VARCHAR(255) DEFAULT NULL;

ALTER DATABASE kitapkosem CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
ALTER TABLE books CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
ALTER TABLE users CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
ALTER TABLE reviews CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
```

3. Projeyi Eclipse'te açın:
   - File -> Import -> Existing Maven Projects
   - Proje klasörünü seçin
   - Finish'e tıklayın

4. DBUtil.java sınıfındaki veritabanı bilgilerini değiştirin

5. Projeyi çalıştırın:
   - Projeye sağ tıklayın
   - Run As -> Run on Server
   - Apache Tomcat 9.0'ı seçin
   - Finish'e tıklayın

## Proje Yapısı

```
src/
├── main/
│   ├── java/
│   │   ├── controller/    # Servlet sınıfları       
│   │   ├── model/        # Veri modelleri
│   │   └── util/         # Veritabanı sınıfı
│   └── webapp/
│       ├── css/          # Style dosyaları      
│       ├── jsp/          # JSP sayfaları
│       ├── WEB-INF/     
│       │    ├── lib/
│       │    │   ├──jstl-1.2.jar                # Kullanılan bazı kütüphane etiketleri için gerekli jar
│       │    │   ├──mysql-connector-j-9.0.0.jar # MySQL bağlantısı için gerekli jar
│       │    │   ├──servlet-api.jar             # Servlet için gerekli jar
│       │    │ 
│       │    ├──web.xml
│       │
│       ├──index.jsp
```
