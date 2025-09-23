import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movie/app/resources/app_colors.dart';
import 'package:test_movie/app/resources/routs.dart';
import 'package:test_movie/core/utils/debouncer.dart';
import 'package:test_movie/features/movie/data/models/route_arguments.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/features/movie/presentation/pages/list/movie_list_cubit.dart';
import 'package:test_movie/features/movie/presentation/widgets/movie_list_item_widget.dart';
import 'package:test_movie/injection_container.dart';
import 'package:test_movie/share/failure_widget.dart';
import '/core/extentions/ext_failure.dart';
import '/generated/i18n.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final MovieListCubit _cubit = get<MovieListCubit>();
  final Debouncer onSearchDebouncer = Debouncer();
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<MovieListCubit, MovieListState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                _searchBoxWidget(),
                Expanded(child: _getResultBody(state)),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _getResultBody(MovieListState state) {
    if (state is StateError) {
      return FailureWidget(
        failure: state.failure.message(context),
        retry: state.onRetry,
      );
    }
    else {
      return MovieListItemWidget(
        onSelect: (MovieEntity movie) {
          if(movie.id != null) {
            _navigateToMovieInfo(movie.id!);
          }
        },
        onRefresh: _cubit.refreshList,
        onLoadMore: _cubit.getMovies,
        isClear: state is StateRefresh,
      );
    }
  }

  Widget _searchBoxWidget() {
    return Container(
      color: primary(),
      height: 96,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              CupertinoIcons.heart_fill,
              color: AppColors.white,
            ),
            onPressed: () => _navigateToFavorites(),
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.clear,
              color: AppColors.white,
            ),
            onPressed: () => _onClearClick(),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration.collapsed(
                  hintText: S.of(context).btn_search,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: AppColors.white),
                ),
                onChanged: (text) {
                  _cubit.searchText = text;
                  onSearchDebouncer.debounce(() => _cubit.search());
                },
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: AppColors.white),
                //autofocus: _cubit.allCategories.isNotEmpty,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onClearClick() {
    if (_cubit.searchText.isNotEmpty) {
      setState(() {
        searchController.clear();
        _cubit.searchText = '';
      });
      _cubit.refreshList();
    }
  }

  void _navigateToMovieInfo(int movieId) {
    Navigator.pushNamed(
      context,
      routeMovieInfo,
      arguments: MovieInfoPageArguments(
        movieId: movieId
      ),
    );
  }

  void _navigateToFavorites() {
    Navigator.pushNamed(
      context,
      routeMovieInfo,
      arguments: MovieInfoPageArguments(
          movieId: 0
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}

