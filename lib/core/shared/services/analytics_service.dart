import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logPageView({required String pageName}) async {
    await _analytics.logEvent(
      name: 'page_view',
      parameters: {'page_name': pageName},
    );
  }

  Future<void> logLogin() async {
    await _analytics.logLogin();
  }

  Future<void> logSignUp() async {
    await _analytics.logSignUp(signUpMethod: 'email');
  }

  Future<void> logAddToFavorites({required String movieTitle}) async {
    await _analytics.logEvent(
      name: 'add_to_favorites',
      parameters: {'movie_title': movieTitle},
    );
  }

  Future<void> logMovieView({required String movieTitle}) async {
    await _analytics.logEvent(
      name: 'movie_view',
      parameters: {'movie_title': movieTitle},
    );
  }

  Future<void> logCustomEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: eventName, parameters: parameters);
  }
}
