
https://github.com/user-attachments/assets/824821e8-1a04-4374-b8df-dc3e100cc3fb
# Shartflix - Flutter Case Study

## 📱 Proje Hakkında

Shartflix, modern Flutter teknolojileri kullanılarak geliştirilmiş bir uygulamadı. Bu proje, NodeLabs case study'si olarak hazırlanmış olup, güncel Flutter best practice'lerini ve enterprise-level mimari yaklaşımlarını göstermektedir.

## 🎯 Özellikler

### 🔐 Kimlik Doğrulama Sistemi
- **Kullanıcı Girişi**: Email/şifre ile güvenli giriş
- **Kullanıcı Kaydı**: Yeni hesap oluşturma
- **Profil Fotoğrafı Yükleme**: Kullanıcı profil fotoğrafı yönetimi
- **Güvenli Token Yönetimi**: Flutter Secure Storage ile token saklama

### 🎬 Film Yönetimi
- **Film Listesi**: Sayfalama ile film listesi görüntüleme
- **Favori Filmler**: Kullanıcı favori filmlerini ekleme/çıkarma
- **Film Detayları**: Detaylı film bilgileri görüntüleme

### 🌍 Çok Dilli Destek
- **Türkçe ve İngilizce** dil desteği
- **Dinamik dil değiştirme** özelliği
- **Otomatik dil algılama**

### 📊 Analytics ve Monitoring
- **Firebase Analytics**: Kullanıcı davranışlarını takip etme
- **Firebase Crashlytics**: Hata raporlama ve monitoring
- **Custom Event Tracking**: Özel olay takibi

## 🏗️ Mimari Yapı

### Clean Architecture
Proje, Clean Architecture prensiplerine uygun olarak geliştirilmiştir:

```
lib/
├── core/                    # Çekirdek bileşenler
│   ├── error/              # Hata yönetimi
│   ├── init/               # Uygulama başlatma
│   ├── resources/          # Kaynaklar
│   ├── shared/             # Paylaşılan servisler
│   └── util/               # Yardımcı fonksiyonlar
├── config/                 # Konfigürasyon
│   ├── navigation/         # Navigasyon servisleri
│   └── theme/              # Tema ayarları
├── features/               # Özellik modülleri
│   ├── auth/              # Kimlik doğrulama
│   ├── main/              # Ana uygulama
│   └── splash/            # Splash ekranı
└── service_locator.dart    # Dependency injection
```

### State Management
- **BLoC Pattern**: Flutter BLoC ile state yönetimi
- **Event-Driven Architecture**: Event-based state management
- **Separation of Concerns**: UI, Business Logic ve Data katmanları ayrımı

## 🔧 Teknolojiler ve Kütüphaneler

### Core Dependencies
- **Flutter**: 3.8.0+
- **Dart**: 3.8.0+
- **BLoC**: ^9.0.0 - State management
- **Dio**: ^5.8.0+1 - HTTP client
- **Retrofit**: ^4.6.0 - API client generation
- **Get It**: ^8.0.3 - Dependency injection

### Authentication & Security
- **Flutter Secure Storage**: ^9.2.4 - Güvenli veri saklama
- **Image Picker**: ^1.1.2 - Fotoğraf seçimi

### UI/UX
- **Easy Localization**: ^3.0.8 - Çok dilli destek
- **Flutter SVG**: ^2.0.10+1 - SVG desteği
- **Lottie**: ^3.3.1 - Animasyonlar

### Analytics & Monitoring
- **Firebase Analytics**: ^11.6.0 - Kullanıcı analitikleri
- **Firebase Crashlytics**: ^4.3.10 - Hata raporlama
- **Firebase Core**: ^3.15.2 - Firebase temel servisleri

### Development Tools
- **Build Runner**: ^2.5.4 - Code generation
- **JSON Serializable**: ^6.9.5 - JSON serialization
- **Retrofit Generator**: ^10.0.0 - API client generation
- **Flutter Lints**: ^6.0.0 - Code quality



## 📱 Ekran Görüntüleri

<!-- Buraya uygulama ekran görüntüleri eklenecek -->
### Uygulama iconu
![App Icon]![Screenshot_20250727-113325_One UI Home](https://github.com/user-attachments/assets/b4158692-9684-41c8-92e0-c19fadc2ee73)

### Splash Ekranı
![Splash Screen]Uploading Screen_Recording_20250727-113758_One UI Home~2.mp4…



### Giriş Ekranı
![Login Screen]![Screenshot_20250727-113441](https://github.com/user-attachments/assets/5d49ec03-8467-4126-9580-74a4bf8dfe57)

### Fotoğraf Yükleme Ekranı
![Photo upload Screen]![Screenshot_20250727-112733](https://github.com/user-attachments/assets/eab9e3f1-c124-4bc2-b870-f8ad75bd05cf)


### Ana Sayfa
![Home Screen]![Screenshot_20250727-112733](https://github.com/user-attachments/assets/09336570-4b30-4ad2-98e3-7c8a7480177f)


### Profil Sayfası
![Profile Screen]![Screenshot_20250727-112343](https://github.com/user-attachments/assets/77930f97-9824-4944-9ad7-6e16b196d48e)
### Sınırlı Teklif
![Limited Offer]![Screenshot_20250727-113207](https://github.com/user-attachments/assets/da8c52f4-6a26-41f6-8557-5ab4425c38e4)



## 🎬 Animasyonlar
### Splash Animasyonu
![Splash Animation]![6a19ca2e-4a66-44b1-a395-3fd85d480556](https://github.com/user-attachments/assets/a7e797bd-e787-4db0-8a8f-86b2d86b2c7d)






## 🔌 API Entegrasyonları

### Base URL
```
https://caseapi.servicelabs.tech/
```

### Endpoints

#### Authentication
- `POST /user/login` - Kullanıcı girişi
- `POST /user/register` - Kullanıcı kaydı
- `GET /user/profile` - Kullanıcı profili
- `POST /user/upload_photo` - Profil fotoğrafı yükleme

#### Movies
- `GET /movie/list` - Film listesi (sayfalama ile)
- `POST /movie/favorite/{movieId}` - Favori ekleme/çıkarma
- `GET /movie/favorites` - Favori filmler listesi

## 🔐 Güvenlik

### Token Yönetimi
- JWT token'ları Flutter Secure Storage'da saklanır
- Otomatik token yenileme
- Güvenli token temizleme

### Hata Yönetimi
- Merkezi hata yakalama sistemi
- Kullanıcı dostu hata mesajları
- Crashlytics ile hata raporlama

## 📊 Analytics Events

### Kullanıcı Etkileşimleri
- `login_button_pressed` - Giriş butonu tıklama
- `signup_button_pressed` - Kayıt butonu tıklama
- `add_to_favorites` - Favori ekleme
- `movie_view` - Film görüntüleme
- `page_view` - Sayfa görüntüleme

### Custom Events
- `movies_loaded` - Film listesi yüklendi
- `photo_uploaded` - Fotoğraf yüklendi

## 🌍 Çok Dilli Destek

### Desteklenen Diller
- **Türkçe (tr)** - Varsayılan dil
- **İngilizce (en)** - İkincil dil

### Dil Dosyaları
- `assets/translations/tr.json` - Türkçe çeviriler
- `assets/translations/en.json` - İngilizce çeviriler




## 📄 Lisans

Bu proje case study amaçlı geliştirilmiştir.



