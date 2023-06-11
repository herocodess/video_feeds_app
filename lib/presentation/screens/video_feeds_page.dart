import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/video_feeds_provider.dart';
import '../widgets/video_feed_item.dart';

class VideoFeedsPage extends ConsumerWidget {
  const VideoFeedsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final videoFeeds = ref.watch(videoFeedsProvider);

    return Scaffold(
      body: videoFeeds.when(
        data: (feeds) {
          log("got feeds : $feeds");
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: feeds.length,
            itemBuilder: (context, index) {
              final feed = feeds[index];
              return VideoFeedItem(feed: feed);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
