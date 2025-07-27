import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/util/helpers/image_helper.dart';
import '../../domain/entities/movie_entity.dart';

class SwipeableMovieCard extends StatelessWidget {
  final MovieEntity movie;
  final VoidCallback onFavoriteToggle;

  const SwipeableMovieCard({
    super.key,
    required this.movie,
    required this.onFavoriteToggle,
  });

  Widget _buildTextWithCustomOverflow(
    String text,
    TextStyle style, {
    int maxLines = 2,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(text: text, style: style);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: maxLines,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          final suffix = ' Daha Fazlası';
          final suffixSpan = TextSpan(
            text: suffix,
            style: style.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          );

          String truncatedText = text;
          while (textPainter.didExceedMaxLines && truncatedText.isNotEmpty) {
            truncatedText = truncatedText.substring(
              0,
              truncatedText.length - 1,
            );
            final newTextSpan = TextSpan(
              text: truncatedText + suffix,
              children: [suffixSpan],
            );
            textPainter.text = newTextSpan;
            textPainter.layout(maxWidth: constraints.maxWidth);
          }

          return RichText(
            text: TextSpan(
              text: truncatedText,
              style: style,
              children: [suffixSpan],
            ),
            maxLines: maxLines,
            overflow: TextOverflow.visible,
          );
        } else {
          return Text(text, style: style, maxLines: maxLines);
        }
      },
    );
  }

  Widget _buildNetworkImage(String url) {
    final httpsUrl = ImageHelper.convertToHttps(url);

    return Image.network(
      httpsUrl!,
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackImage();
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[900],
          child: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage() {
    // Önce poster URL'ini kontrol et
    if (ImageHelper.isValidImageUrl(movie.poster)) {
      return _buildNetworkImage(movie.poster);
    }

    // Images listesinden alternatif resim dene
    for (String imageUrl in movie.images) {
      if (ImageHelper.isValidImageUrl(imageUrl)) {
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
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildImage(),

        Positioned(
          bottom: mediaQuery.padding.bottom + 120,
          right: 20,
          child: GestureDetector(
            onTap: onFavoriteToggle,
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(82)),
                color: Colors.black.withValues(alpha: 0.6),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  width: 2,
                ),
              ),
              child: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: movie.isFavorite ? Colors.red : Colors.white,
                size: 24,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(
              mediaQuery.size.height * 0.05,
              mediaQuery.size.width * 0.02,
              mediaQuery.size.width * 0.1,
              mediaQuery.padding.bottom + 20,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/sin_icon.svg',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTextWithCustomOverflow(
                        movie.title,
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ) ??
                            const TextStyle(),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 2),

                      _buildTextWithCustomOverflow(
                        movie.plot,
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ) ??
                            const TextStyle(),
                        maxLines: 2,
                      ),
                      SizedBox(height: mediaQuery.size.height * 0.01),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
