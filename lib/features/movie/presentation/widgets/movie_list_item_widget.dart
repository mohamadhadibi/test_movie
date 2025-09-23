import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:test_movie/core/utils/utils.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';
import 'package:test_movie/share/progressbar_widget.dart';
import 'package:test_movie/share/empty_indicator.dart';

class MovieListItemWidget extends StatefulWidget {
  final Function onLoadMore;
  final Function onRefresh;
  final Function onSelect;
  final bool? isClear;

  const MovieListItemWidget({
    super.key,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onSelect,
    this.isClear,
  });

  @override
  State<MovieListItemWidget> createState() => _MovieListItemWidget();
}

class _MovieListItemWidget extends State<MovieListItemWidget> {
  final PagingController<int, MovieEntity> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  Widget build(BuildContext context) {
    if (widget.isClear ?? false) _pagingController.refresh();
    return RefreshIndicator(

      onRefresh: () => Future.sync(() {
        widget.onRefresh();
        _pagingController.refresh();
      }),
      child: PagedListView<int, MovieEntity>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
          itemBuilder: _onBindView,
          newPageProgressIndicatorBuilder: (_) => const HorizontalProgressBar(),
          noItemsFoundIndicatorBuilder: getEmptyIndicator,
        ),
      ),
    );
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _onLoadMore(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Widget _onBindView(BuildContext context, MovieEntity item, int index) {
    String trimmedDescription = (item.description?.length ?? 0) > maxDescriptionLength
        ? '${item.description?.substring(0, maxDescriptionLength)}...'
        : item.description ?? '';

    return InkWell(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: (item.poster != null && item.poster!.isNotEmpty)
                    ? CachedNetworkImage(
                  imageUrl: item.poster!,
                  cacheKey: 'movie_${item.id}',
                  width: imageWidth,
                  height: imageHeight,
                  maxWidthDiskCache: 400,
                  memCacheHeight: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                  ),
                )
                    : Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: imageHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        trimmedDescription,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[600], size: 20),
                          const SizedBox(width: 4),
                          Text(
                            (item.rate ?? 0).toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () => widget.onSelect(item),
    );
  }

  Future<void> _onLoadMore(BuildContext context) async {
    var items = await widget.onLoadMore();
    if (items.length < 10) {
      _pagingController.appendLastPage(items);
    } else {
      _pagingController.appendPage(items, 0);
    }
  }
}