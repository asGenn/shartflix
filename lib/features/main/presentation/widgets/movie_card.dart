import 'package:flutter/material.dart';

import '../../domain/entities/movie_entity.dart';

class MovieCard extends StatelessWidget {
  final MovieEntity movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Film posteri
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                movie.poster,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.movie,
                      color: Colors.white,
                      size: 48,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),

          // Film bilgileri
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Başlık ve yıl
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      movie.year,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Türü ve süre
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
                    const SizedBox(width: 8),
                    Text(
                      movie.runtime,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const Spacer(),
                    Icon(
                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.isFavorite ? Colors.red : Colors.grey[400],
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Türler
                Text(
                  movie.genre,
                  style: TextStyle(color: Colors.grey[300], fontSize: 14),
                ),
                const SizedBox(height: 8),

                // IMDb puanı
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.imdbRating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${movie.imdbVotes} oy)',
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Özet
                Text(
                  movie.plot,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
