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
### Giriş Ekranı
![Login Screen]

### Ana Sayfa
![Home Screen]

### Film Detayları
![Movie Details]

### Profil Sayfası
![Profile Screen]

## 🎬 Animasyonlar

<!-- Buraya uygulama animasyonları eklenecek -->
### Splash Animasyonu
![Splash Animation](animations/splash_animation.gif)





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



