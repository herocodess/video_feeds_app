import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import '../models/feeds_model.dart';

abstract class VideoRepository {
  Future<List<Feed>> getVideoFeedsFromAssets();
}

class VideoRepositoryImpl implements VideoRepository {
  @override
  Future<List<Feed>> getVideoFeedsFromAssets() async {
    final jsonStr = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(jsonStr);
    final feeds = FeedsSimulationModel.fromJson(data);
    log("got here feeds After 3 ${feeds.contents}");

    return feeds.contents ?? [];
  }
}
