import 'package:flutter/material.dart';

import '../../domain/entities/movie_entity.dart';

class SwipeableMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback onFavoriteToggle;

  const SwipeableMovieCard({
    super.key,
    required this.movie,
    required this.onFavoriteToggle,
  });

  bool _isValidUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  String _convertToHttps(String url) {
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }

  Map<String, String> _getHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      'Referer': 'https://www.imdb.com/',
    };
  }

  Widget _buildNetworkImage(String url) {
    final httpsUrl = _convertToHttps(url);

    return Image.network(
      httpsUrl,
      fit: BoxFit.cover,
      headers: _getHeaders(),
      errorBuilder: (context, error, stackTrace) {
        print('Image error for ${movie.title}: $error');
        print('Failed URL: $httpsUrl');
        return _buildFallbackImage();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[900],
          child: const Center(
            child: CircularProgressIndicator(color: Colors.red),
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    // Önce poster URL'ini kontrol et
    if (_isValidUrl(movie.poster)) {
      return _buildNetworkImage(movie.poster);
    }

    // Images listesinden alternatif resim dene
    for (String imageUrl in movie.images) {
      if (_isValidUrl(imageUrl)) {
        return _buildNetworkImage(imageUrl);
      }
    }

    // Hiçbir geçerli URL yoksa fallback göster
    return _buildFallbackImage();
  }

  Widget _buildFallbackImage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[800]!, Colors.grey[900]!],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_creation_outlined,
            color: Colors.grey[400],
            size: 80,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              movie.title,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.year,
            style: TextStyle(color: Colors.grey[500], fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Arka plan film posteri
        _buildImage(),

        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.4, 0.7, 1.0],
            ),
          ),
        ),

        // Top right favorite button
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: movie.isFavorite ? Colors.red : Colors.white,
                size: 28,
              ),
            ),
          ),
        ),

        // Film bilgileri - alt kısım
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(
              20,
              40,
              20,
              MediaQuery.of(context).padding.bottom + 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Film başlığı
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Yıl ve süre
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        movie.rated,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      movie.year,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      movie.runtime,
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // IMDb puanı
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      movie.imdbRating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${movie.imdbVotes} oy)',
                      style: TextStyle(color: Colors.grey[300], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Film özeti
                Text(
                  movie.plot,
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 16,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Türler
                Text(
                  movie.genre,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
