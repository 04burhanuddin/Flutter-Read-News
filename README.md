# Getting Started

**Read News App** adalah aplikasi berita berbasis Flutter yang menggunakan arsitektur **Clean Architecture** dengan manajemen state menggunakan **BLoC**.

- **Flutter Version**: `Flutter 3.24.5 • channel stable`
- **Tools**: Dart `3.5.4` • DevTools `2.37.3`

---

## Setup API

### 1. Membuat API Key
Aplikasi ini menggunakan data dari [News API](https://newsapi.org/). Silakan ikuti langkah berikut untuk mendapatkan API Key Anda:
- Kunjungi [News API](https://newsapi.org/).
- Daftar/login untuk mendapatkan API Key.
- Salin API Key yang telah Anda buat.

### 2. Menambahkan API Key ke Aplikasi
Untuk mengintegrasikan API Key Anda:
- Buka file `lib/data/repositories/news_repository_impl.dart`.
- Masukkan API Key Anda pada variabel `_apiKey`:

  ```dart
  class NewsRepositoryImpl implements NewsRepository {
    // Tambahkan API Key Anda di sini
    static const _apiKey = "YOUR_API_KEY_HERE";
    static const _baseUrl = "https://newsapi.org/v2/everything";

    ...
  }

### 2. Menjalankan Project
- Clone repository:

  ```git
  git clone https://github.com/04burhanuddin/Flutter-Read-News.git
  cd Flutter-Read-News
  ```

- Install dependencies `flutter pub get`
- Jalankan Aplikasi dengn perintah `flutter run`
