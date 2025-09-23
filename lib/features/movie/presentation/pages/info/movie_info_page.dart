import 'package:flutter/material.dart';
import 'package:test_movie/features/movie/data/models/route_arguments.dart';

class MovieInfoPage extends StatefulWidget {
  final MovieInfoPageArguments params;
  const MovieInfoPage({super.key, required this.params});

  @override
  State<MovieInfoPage> createState() => _MovieInfoPageState();
}

class _MovieInfoPageState extends State<MovieInfoPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
