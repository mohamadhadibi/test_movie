import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_movie/features/movie/data/models/route_arguments.dart';
import 'package:test_movie/features/movie/presentation/pages/info/movie_info_cubit.dart';
import 'package:test_movie/injection_container.dart';
import 'package:test_movie/share/progressbar_widget.dart';

class MovieInfoPage extends StatefulWidget {
  final MovieInfoPageArguments params;
  const MovieInfoPage({super.key, required this.params});

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  final MovieInfoCubit _cubit = get<MovieInfoCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit..getMovie(widget.params.movieId),
      child: BlocBuilder<MovieInfoCubit, MovieInfoState>(
        builder: (context, state) {
          const double imageHeight = 300;
          return Scaffold(
            appBar: AppBar(
              title: Text(_cubit.movie.title ?? ''),
              centerTitle: true,
            ),
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(onPressed: _cubit.addRemoveFavorite),
            body: (state is StateInitial)? HorizontalProgressBar():
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: _cubit.movie.poster ?? '',
                    width: double.infinity,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: double.infinity,
                      height: imageHeight,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 60, color: Colors.grey),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: double.infinity,
                      height: imageHeight,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _cubit.movie.title ?? '',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber[600], size: 24),
                            const SizedBox(width: 4),
                            Text(
                              (_cubit.movie.rate ?? 0).toStringAsFixed(1),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _cubit.movie.description ?? '',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
