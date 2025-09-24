import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movie/core/utils/utils.dart';
import 'package:test_movie/features/movie/domain/entities/movie_entity.dart';

class MovieFavoritesItemWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final Function(MovieEntity) onSelect;
  final Function(MovieEntity) onRemove;
  final Future<void> Function() onRefresh;

  const MovieFavoritesItemWidget({
    super.key,
    required this.movies,
    required this.onSelect,
    required this.onRemove,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final item = movies[index];
          return _buildItem(context, item);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, MovieEntity item) {
    String trimmedDescription =
        (item.description?.length ?? 0) > maxDescriptionLength
        ? '${item.description?.substring(0, maxDescriptionLength)}...'
        : item.description ?? '';

    return InkWell(
      onTap: () => onSelect(item),
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
                          child: const Icon(
                            Icons.image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: imageWidth,
                          height: imageHeight,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Container(
                        width: imageWidth,
                        height: imageHeight,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: imageHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                            ),
                            onPressed: () => onRemove(item),
                          ),
                        ],
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
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
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
    );
  }
}
