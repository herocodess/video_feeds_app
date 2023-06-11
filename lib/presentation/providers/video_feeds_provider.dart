import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/feeds_model.dart';
import '../../data/providers/video_repository_provider.dart';
import '../../domain/usecases/get_video_feeds_usecase.dart';

final videoFeedsProvider = FutureProvider<List<Feed>>((ref) {
  final getVideoFeedsUseCase = ref.read(getVideoFeedsUseCaseProvider);
  return getVideoFeedsUseCase.execute();
});

final getVideoFeedsUseCaseProvider = Provider<GetVideoFeedsUseCase>((ref) => GetVideoFeedsUseCase(ref.read(videoRepositoryProvider),));
