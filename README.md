# Kitap Köşem

Online Kitap İnceleme ve Puanlama Sistemi

## Teknik Gereksinimler

- Java JDK 8 veya üzeri
- Apache Tomcat 9.0
- MySQL 8.0
- Maven 3.6 veya üzeri
- Eclipse IDE (önerilen)

## Kurulum

1. Projeyi klonlayın:
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

## 1. Model Katmanı

### Model Katmanı (Java Beans)

Book: Kitap bilgilerini tutan sınıf
User: Kullanıcı bilgilerini tutan sınıf
Review: Kitap yorumlarını tutan sınıf

### DAO (Data Access Object) Sınıfları

BookDAO: Kitap verilerinin veritabanı işlemleri
UserDAO: Kullanıcı verilerinin veritabanı işlemleri
ReviewDAO: Yorum verilerinin veritabanı işlemleri

## 2. View Katmanı

View katmanı, kullanıcı arayüzünü oluşturan JSP sayfalarını içeriyor

### JSP Sayfaları

books.jsp: Kitap listesi sayfası
bookDetail.jsp: Kitap detayları sayfası
newBook.jsp: Kitap ekleme sayfası
login.jsp: Giriş formu
register.jsp: Kayıt formu
404.jsp: 404 hatasında gösterilecek sayfa
500.jsp: 500 hatasında gösterilecek sayfa

## 3. Controller Katmanı

Controller katmanı, kullanıcı isteklerini işleyen Servlet sınıflarını içeriyor

### Servlet Sınıfları

AddBookServlet: Kitapların eklenmesinden sorumlu servlet
AddReviewServlet: Kitaplara yorumların eklenmesinden sorumlu servlet
BookDetailServlet: Kitap bilgilerinin görüntülenmesinden sorumlu servlet
BookListServlet: Kitapların ana sayfada görüntülenmesinden sorumlu servlet
LoginServlet: Kullanıcının girişinden sorumlu servlet
LogoutServlet: Kullanıcının çıkış yapmasından sorumlu servlet
RegisterServlet: Kullanıcının kaydından sorumlu servlet

## MVC Akışı Örneği

Kullanıcı bir kitap eklemek istediğinde

View (newBook.jsp) üzerinden form doldurulur
Controller (AddBookServlet) form verilerini alır
Model (Book ve BookDAO) verileri işler ve kaydeder
Controller kullanıcıyı kitap listesine yönlendirir
View (books.jsp) güncel listeyi gösterir

# Kullanıcı Senaryoları

## 1. Kullanıcı Kaydı ve Girişi

### 1.1 Yeni Kullanıcı Kaydı

1. Kullanıcı "Kayıt Ol" butonuna tıklar
2. Kayıt formu açılır
3. Kullanıcı gerekli bilgileri ekler:
   - Kullanıcı adı
   - E-posta
   - Şifre
4. Kullanıcı "Kayıt Ol" butonuna tıklar
5. Kullanıcı bilgileri veritabanına kaydedilir
6. Kayıt başarılı olursa kullanıcı ana sayfaya yönlendirilir

### 1.2 Kullanıcı Girişi

1. Kullanıcı "Giriş Yap" butonuna tıklar
2. Giriş formu açılır
3. Kullanıcı kullanıcı adı ve şifresini girer
4. Kullanıcı "Giriş Yap" butonuna tıklar
5. Sistem bilgileri kontrol eder
6. Giriş başarılı olursa kullanıcı ana sayfaya yönlendirilir

### 1.3 Kullanıcı Çıkışı

1. Kullanıcı "Çıkış" butonuna tıklar
2. Kullanıcı çıkış yapmış olur ve ana sayfaya yönlendirilir

## 2. Kitap İşlemleri

### 2.1 Kitap Ekleme

1. Kullanıcı "Yeni Kitap Ekle" butonuna tıklar
2. Kitap ekleme formu açılır
3. Kullanıcı kitap bilgilerini ekler:
   - Kitap adı
   - Yazar
   - Açıklama
   - Kitap görseli
4. Kullanıcı "Kitap Ekle" butonuna tıklar
5. Kitap veritabanına kaydedilir
6. Kullanıcı kitap detay sayfasına yönlendirilir

### 2.2 Kitap Arama

1. Kullanıcı ana sayfada bulunan arama çubuğun bulmak istediği kitabın ismini ya da yazarın ismini yazar
2. Kullanıcıya girdiği bilgilere uygun olan kitaplar gösterilir

## 3. Yorum İşlemleri

### 3.1 Yorum Yapma

1. Kullanıcı kitap detay sayfasına gider
2. Yorum formunu görür
3. Kullanıcı vereceği puanı seçer
4. Yorum metnini girer
5. "Yorum Yap" butonuna tıklar
6. Yorum veritabanına kaydedilir
7. Yorum listesinde yeni yorum görüntülenir

## 4. Kitap Görüntüleme

### 4.1 Kitap Listesi Görüntüleme

1. Kullanıcı ana sayfaya gider
2. Kitapların listesini görür
3. Her kitap için:
   - Kapak resmi
   - Kitap adı
   - Yazar
   - Ortalama puan
   bilgilerini görür

### 4.2 Kitap Detayı Görüntüleme

1. Kullanıcı kitap listesinde "Detaylar" butonuna tıklar
2. Kitap detay sayfası açılır
3. Kullanıcı şu bilgileri görür:
   - Kitap görseli
   - Ortalama puan
   - Kitap adı
   - Yazar
   - Açıklama
   - Yorumlar
