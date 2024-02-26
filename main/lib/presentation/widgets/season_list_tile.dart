import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/season.dart';

class SeasonListTile extends StatelessWidget {
  const SeasonListTile({
    super.key,
    required this.index,
    required this.season,
  });

  final int index;
  final Season season;

  @override
  Widget build(BuildContext context) {
    final voteAverage = season.voteAverage;
    final seasonNumber = season.seasonNumber;
    final airDate = season.airDate;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          "👉 ${season.name}",
          style: kHeading6,
        ),
        if (season.posterPath.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${season.posterPath}',
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        if (seasonNumber != null && seasonNumber != 0)
          Text("Season Number: $seasonNumber"),
        if (season.episodeCount != null)
          Text("Total Episodes: ${season.episodeCount}"),
        if (airDate != null)
          Text("Air Date: ${DateFormat("dd MMMM yyyy").format(airDate)}"),
        if (voteAverage != null && voteAverage != 0) ...{
          const SizedBox(height: 4),
          Row(
            children: [
              RatingBarIndicator(
                rating: voteAverage / 2,
                itemCount: 5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kMikadoYellow,
                ),
                itemSize: 24,
              ),
              Text('$voteAverage')
            ],
          ),
        },
        if (season.overview.isNotEmpty) ...{
          const SizedBox(height: 4),
          Text(season.overview),
        },
      ],
    );
  }
}
