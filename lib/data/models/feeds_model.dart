class FeedsSimulationModel {
  bool? status;
  String? message;
  List<Feed>? contents;

  FeedsSimulationModel({this.status, this.message, this.contents});

  FeedsSimulationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['contents'] != null) {
      contents = <Feed>[];
      json['contents'].forEach((v) {
        contents!.add(Feed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feed {
  String? thumbnailUrl;
  String? videoUrl;
  String? title;
  String? duration;

  Feed({
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.title,
    required this.duration,
  });

  Feed.fromJson(Map<String, dynamic> json) {
    thumbnailUrl = json['thumbnailUrl'];
    videoUrl = json['videoUrl'];
    title = json['title'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnailUrl'] = thumbnailUrl;
    data['videoUrl'] = videoUrl;
    data['title'] = title;
    data['duration'] = duration;
    return data;
  }
}
