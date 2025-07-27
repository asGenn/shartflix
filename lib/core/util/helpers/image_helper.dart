class ImageHelper {
  /// HTTP URL'lerini HTTPS'e çevirir
  static String? convertToHttps(String? url) {
    if (url == null || url.isEmpty) return url;

    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }

    return url;
  }

  /// Resim URL'si boş veya null kontrolü yapar
  static bool isValidImageUrl(String? url) {
    return url != null && url.isNotEmpty && url.trim().isNotEmpty;
  }
}
