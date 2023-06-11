
import '../../data/models/feeds_model.dart';
import '../../data/repositories/video_repository.dart';

class GetVideoFeedsUseCase {
  final VideoRepository _videoRepository;

  GetVideoFeedsUseCase(this._videoRepository);

  Future<List<Feed>> execute() {
    return _videoRepository.getVideoFeedsFromAssets();
  }
}
