import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/swipeable_movie_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadMovies());
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Son filme yaklaştığımızda daha fazla film yükle
    final state = context.read<HomeBloc>().state;
    if (state is HomeLoaded) {
      if (index >= state.movies.length - 2 && !state.hasReachedMax) {
        context.read<HomeBloc>().add(const LoadMoreMovies());
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeBloc>().add(const LoadMovies()),
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          if (state is HomeLoaded) {
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return SwipeableMovieCard(
                  movie: state.movies[index],
                  onFavoriteToggle: () {
                    // TODO: Favorite toggle implementation
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
