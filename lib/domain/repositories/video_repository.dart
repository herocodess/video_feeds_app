import '../../data/models/feeds_model.dart';

abstract class VideoRepository {
  Future<List<Feed>> getVideoFeeds();
}

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<List<Feed>> getVideoFeeds() {
    // Implement fetching feeds from data layer repository
    return Future.delayed(const Duration(seconds: 2), () {
      return [
        Feed(
          thumbnailUrl: 'https://via.placeholder.com/150',
          videoUrl: 'assets/videos/video1.mp4',
          title: 'Video 1',
          duration: '0:30',
        ),
        Feed(
          thumbnailUrl: 'https://via.placeholder.com/150',
          videoUrl: 'assets/videos/video2.mp4',
          title: 'Video 2',
          duration: '0:45',
        ),
        Feed(
          thumbnailUrl: 'https://via.placeholder.com/150',
          videoUrl: 'assets/videos/video3.mp4',
          title: 'Video 3',
          duration: '1:00',
        ),
      ];
    });
  }
}
