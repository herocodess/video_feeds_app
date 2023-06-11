import 'package:riverpod/riverpod.dart';
import '../repositories/video_repository.dart';

final videoRepositoryProvider = Provider<VideoRepository>((ref) {
  return VideoRepositoryImpl();
});
